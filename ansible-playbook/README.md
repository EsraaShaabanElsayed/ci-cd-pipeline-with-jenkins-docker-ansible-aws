# Ansible Playbook for Deploying Spring PetClinic Application

## Overview

This Ansible playbook automates the deployment of the Spring PetClinic application on an AWS EC2 instance. It includes tasks for installing Java and Tomcat, as well as deploying the application's WAR file.

## Prerequisites

Before you run the playbook, ensure you have the following:

- An AWS account with EC2 permissions.
- A running EC2 instance (Ubuntu) where the application will be deployed.
- SSH key pair to access your EC2 instance.
- Ansible installed on your local machine.
- The WAR file for the Spring PetClinic application.

## Project Structure
ansible-playbook/ ├── inventory # Inventory file listing the target AWS EC2 instances ├── roles/ # Directory containing Ansible roles │ ├── install-java/ # Role for installing Java on Ubuntu EC2 │ │ └── tasks/ # Tasks for Java installation │ ├── install-tomcat/ # Role for installing Tomcat on EC2 │ │ └── tasks/ # Tasks for Tomcat installation │ ├── config-tomcat/ # Role for configuring Tomcat on EC2 │ │ ├── tasks/ # Tasks for Tomcat configuration │ │ ├── templates/ # Jinja2 templates for Tomcat configuration (if any) │ │ └── handlers/ # Handlers for notifying changes in Tomcat configuration │ └── deploy-app/ # Role for deploying the WAR file on EC2 │ └── tasks/ # Tasks for deploying the application └── main-playbook.yml # The main Ansible playbook that installs Java, Tomcat, configures Tomcat, and deploys the application
playbook.yml # Main Ansible playbook inventory # Inventory file for Ansible sample.war # WAR file for the Spring PetClinic application

## Configuration

1. **Update the inventory file**: Modify the `inventory` file to include your EC2 instance's IP address.

    ```ini
    [aws_instance]
    instance-ip ansible_ssh_user=ubuntu ansible_ssh_private_key_file=path/to/key-file.pem
    ```

2. **Place the WAR file**: Ensure the `sample.war` file is in the root directory of this repository.

## Usage

To run the playbook, follow these steps:

1. **SSH into your EC2 instance** (optional):
   ```bash
   ssh -i path/to/key.pem ubuntu@instance-ip
Run the Ansible playbook:
 ```bash
  ansible-playbook -i inventory playbook.yml
```
**Verification

***After running the playbook, you can verify the deployment by visiting:
```
 http://insance-ip:8080/warfile-name
```
