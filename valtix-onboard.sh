#!/bin/zsh
# Syntax:
  # Terraform Plan: ./valtix-onboard.sh plan
  # Terraform Apply: ./valtix-onboard.sh apply
  # Terraform Destroy: ./valtix-onboard.sh destroy

# Initialize Terraform
terraform init

# Specify the list of Terraform Workspace (Profile - AWS Account) names
workspace_names=(
account1-us-east-1
)

# Check for action and set to plan if not specified
action=$1
if [ "$action" = "" ]; then
  action="plan"
fi

# Loop over each Terraform Workspace and perform action
for x in ${workspace_names[@]}; do
  terraform workspace new $x
  terraform workspace select $x
  terraform $action -var-file $x.tfvars $2
done

# Set the Terraform Workspace back to default
terraform workspace select default