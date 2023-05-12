resource "google_compute_image" "fortinet" {
  name  = "fortinet-image"

  source_image = var.image

  guest_os_features {
    type = var.nictype
  }
}

# Randomize string to avoid duplication
resource "random_string" "random_name_post" {
  length           = 3
  special          = true
  override_special = ""
  min_lower        = 3
}

# Create log disk
resource "google_compute_disk" "logdisk" {
  name = "log-disk-${random_string.random_name_post.result}"
  size = 30
  type = "pd-standard"
  zone = var.zone
}


### VPC ###
resource "google_compute_network" "vpc_network" {
  name                    = "vpc-${random_string.random_name_post.result}"
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc_network2" {
  name                    = "vpc2-${random_string.random_name_post.result}"
  auto_create_subnetworks = false
}


### Public Subnet ###
resource "google_compute_subnetwork" "public_subnet" {
  name                     = "public-subnet-${random_string.random_name_post.result}"
  region                   = var.region
  network                  = google_compute_network.vpc_network.name
  ip_cidr_range            = var.public_subnet
  private_ip_google_access = true
}
### Private Subnet ###
resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet-${random_string.random_name_post.result}"
  region        = var.region
  network       = google_compute_network.vpc_network2.name
  ip_cidr_range = var.protected_subnet
}

# Firewall Rule External
resource "google_compute_firewall" "allow-fgt" {
  name    = "allow-fgt-${random_string.random_name_post.result}"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-fgt"]
}

# Firewall Rule Internal
resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal-${random_string.random_name_post.result}"
  network = google_compute_network.vpc_network2.name

  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-internal"]
}

resource "google_compute_firewall" "http_firewall" {
  name    = "allow-http-ingress"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allowing traffic from any source IP
}

resource "google_compute_firewall" "https_firewall" {
  name    = "allow-https-ingress"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allowing traffic from any source IP
}

# Create FGTVM compute instance
resource "google_compute_instance" "fortinet" {
  name           = "fortinet-${random_string.random_name_post.result}"
  machine_type   = var.machine
  zone           = var.zone
  can_ip_forward = "true"

  tags = ["allow-fgt", "allow-internal"]

  boot_disk {
    initialize_params {
      image = var.nictype == "VIRTIO_NET" ? google_compute_image.fortinet[0].self_link : var.image
    }
  }
  attached_disk {
    source = google_compute_disk.logdisk.name
  }
  network_interface {
    subnetwork = google_compute_subnetwork.public_subnet.name
    nic_type   = var.nictype
    access_config {
    }
  }


  network_interface {
    subnetwork = google_compute_subnetwork.private_subnet.name
    nic_type   = var.nictype
  }

  metadata = {
    #user-data = "${file(var.user_data)}"
    user-data = fileexists("${path.module}/${var.user_data}") ? "${file(var.user_data)}" : null
    #license   = "${file(var.license_file)}" #this is where to put the license file if using BYOL image
    license = fileexists("${path.module}/${var.license_file}") ? "${file(var.license_file)}" : null
    ssh-keys  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCV6qNVgLGnUL/8eVI8j9e+UEgnpxfbtogOWWcgMJt3ggBGplJndwbNaDfLdvLJasyQfWc0ePImfshUuAlYaOzRiiNeFWIouRdpJqbUWmHBBUGeDfgCVoe01yg/P7tKqR86qNbfJMZp2hC8i4i/aYdmkKeMHvHuXC5XuurhoHjizHTz+LdXMIWRk2F8P2oXS8qy0ZEkCpCiob/GKnd2Qry+ZHRxpAtLDHEs5BOn4Pqip4QmtJJGK+hKY1O41fkO21PwwGk2OmsakIbbUMRiAs+xdJCzUYkRM+WZAcJJEa0dg3vsLkxMgLiXrtznWTNgNCJXmMbhuGaXCOOeHO/a42v1"  # Replace with your SSH key content
  }
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
  scheduling {
    preemptible       = false
    automatic_restart = false
  }
}


# Output
output "FortiGate-NATIP" {
  value = google_compute_instance.fortinet.network_interface.0.access_config.0.nat_ip
}
output "FortiGate-InstanceName" {
  value = google_compute_instance.fortinet.name
}
output "FortiGate-Username" {
  value = "admin"
}
output "FortiGate-Password" {
  value = google_compute_instance.fortinet.instance_id
}

/*

####################################################################################

resource "google_compute_image" "fortinet" {
  name  = "fortinet-image"
  project      = var.project
  source_image = "https://www.googleapis.com/compute/v1/projects/${var.image_location}/global/images/${var.image}"
  guest_os_features {
    type = "MULTI_IP_SUBNET"
  }
}

# Randomize string to avoid duplication
resource "random_string" "random_name_post" {
  length           = 3
  special          = true
  override_special = ""
  min_lower        = 3
}

# Create log disk
resource "google_compute_disk" "logdisk" {
  name = "log-disk-${random_string.random_name_post.result}"
  size = 20
  type = "pd-ssd"
  zone = var.zone
}

### VPC ###
resource "google_compute_network" "vpc_network" {
  name                    = "vpc-${random_string.random_name_post.result}"
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc_network2" {
  name                    = "vpc2-${random_string.random_name_post.result}"
  auto_create_subnetworks = false
}

### Public Subnet ###
resource "google_compute_subnetwork" "public_subnet" {
  name                     = "public-subnet-${random_string.random_name_post.result}"
  region                   = var.region
  network                  = google_compute_network.vpc_network.name
  ip_cidr_range            = var.public_subnet
  private_ip_google_access = true
}
### Private Subnet ###
resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet-${random_string.random_name_post.result}"
  region        = var.region
  network       = google_compute_network.vpc_network2.name
  ip_cidr_range = var.protected_subnet
}

# Firewall Rule External
resource "google_compute_firewall" "allow-fgt" {
  name    = "allow-fgt-${random_string.random_name_post.result}"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-fgt"]
}

# Firewall Rule Internal
resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal-${random_string.random_name_post.result}"
  network = google_compute_network.vpc_network2.name

  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-internal"]
}


# Create FGTVM compute instance
resource "google_compute_instance" "fortinet" {
  name           = "fgtnat-${random_string.random_name_post.result}"
  machine_type   = var.machine
  zone           = var.zone
  can_ip_forward = "true"

  tags = ["allow-fgt", "allow-internal"]

  boot_disk {
    initialize_params {
      image = google_compute_image.fortinet.name
    }
  }
  attached_disk {
    source = google_compute_disk.logdisk.name
  }
  network_interface {
    subnetwork = google_compute_subnetwork.public_subnet.name
    nic_type   = var.nictype
    access_config {
    }
  }
  
  network_interface {
    subnetwork = google_compute_subnetwork.private_subnet.name
    nic_type   = var.nictype
  }
  
  metadata = {
    #user-data = "${file(var.user_data)}"
    user-data = fileexists("${path.module}/${var.user_data}") ? "${file(var.user_data)}" : null
    #license   = "${file(var.license_file)}" #this is where to put the license file if using BYOL image
    license = fileexists("${path.module}/${var.license_file}") ? "${file(var.license_file)}" : null
    ssh-keys  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCV6qNVgLGnUL/8eVI8j9e+UEgnpxfbtogOWWcgMJt3ggBGplJndwbNaDfLdvLJasyQfWc0ePImfshUuAlYaOzRiiNeFWIouRdpJqbUWmHBBUGeDfgCVoe01yg/P7tKqR86qNbfJMZp2hC8i4i/aYdmkKeMHvHuXC5XuurhoHjizHTz+LdXMIWRk2F8P2oXS8qy0ZEkCpCiob/GKnd2Qry+ZHRxpAtLDHEs5BOn4Pqip4QmtJJGK+hKY1O41fkO21PwwGk2OmsakIbbUMRiAs+xdJCzUYkRM+WZAcJJEa0dg3vsLkxMgLiXrtznWTNgNCJXmMbhuGaXCOOeHO/a42v1"  # Replace with your SSH key content
  }
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
  scheduling {
    preemptible       = false
    automatic_restart = false
  }
}




*/