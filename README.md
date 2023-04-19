# gcp-secret-Grant-Bayerle

# Terraform code for GCP secret

In current env there is three env is created dev, stage and prod.

***********************************************************************************************************************************************************************************

This Terraform configuration creates the folloeing GCP resources:

1. Secret resources in Google Cloud Platform (GCP). 

The resources include a Secret Manager secret.

**********************************************************************************************************************************************************************************

# Prerequisites
Terraform cloud account
GCP account and project
GCP Service Account with the necessary permissions to create Secret resources.

**********************************************************************************************************************************************************************************

**Commands to push Terrafrom code from local to Github:**

git add *

git commit -m “message”

git push

************************************************************************************************************************************************************************************

**Connect Github with terraform cloud:**

1. Create a new workspace in Terraform Cloud by clicking on the "New Workspace" button in the Terraform Cloud dashboard with name “**workspace_name**”.
2. Configure the "VCS Connection" settings by providing your GitHub personal access token (PAT)  to authenticate with your GitHub repository.
3. Choose the appropriate version control system (GitHub in our case) and select the repository (terraform) that contains the Terraform code.
4. In the "Queue Plan" section of the workspace settings, enable the "Auto-apply" feature if you want changes to be automatically applied after they are planned.
5. Save the workspace settings and wait for the Terraform Cloud workspace to synchronize with your GitHub repository.
6. Select the workspace and configure the workspace settings such as name, description, and Terraform version.
7. In the "Variables" tab of the workspace settings, add the following environment variables or input variables that Terraform code requires:
   GOOGLE_CREDENTIALS (This is used to make a connection between terraform cloud and GCP account)

8. In Version Control of workspace setting, select “**Always trigger runs**” in VCS Triggers field ******** and “**branch_name**” as VCS branch.
9. You can trigger a Terraform plan and apply by clicking on the "Queue Plan" button in the Terraform Cloud workspace. For the first terraform plan you need to trigger manually.
10. If you get any error terraform will show you logs regarding that.
11. You can check outputs of terraform code after applying in terraform tfstate files.

*************************************************************************************************************************************************************************************

After Implementation of above steps Github will connect with your terraform cloud workspace with particular github branch.

Currently we have 3 github branches dev, stage and prod. And 3 terraform workspaces for these 3 github branches.

Dev branch is connected with dev terraform workspace.
Stage branch is connected with stage terraform workspace.
Prod branch is connected with prod terraform workspace.