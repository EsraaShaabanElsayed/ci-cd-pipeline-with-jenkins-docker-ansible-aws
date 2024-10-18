### Terraform EC2 Provisioning in CI/CD Pipeline

The `terraform` folder contains code to provision an EC2 instance in AWS within the CI/CD pipeline. This instance serves as the infrastructure where Ansible deploys the application automatically.

#### Features
- **Integrated Pipeline Execution**: Terraform runs inside the Jenkins pipeline to provision infrastructure.
- **AWS Cloud Resources**: EC2 instance is created with necessary security configurations.
- **Seamless Ansible Deployment**: Once provisioned, Ansible deploys the application on the EC2 instance.

#### Usage
1. Ensure Terraform and AWS CLI are installed and configured.
2. Define AWS details in `variables.tf`.
3. Run the Jenkins pipeline to automate infrastructure provisioning and deployment.

#### Prerequisites
- Terraform CLI installed  
- AWS CLI configured with access credentials  
- Jenkins pipeline configured to trigger Terraform and Ansible jobs
