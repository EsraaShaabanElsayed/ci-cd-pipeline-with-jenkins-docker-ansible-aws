# Docker Deployment on Ubuntu EC2

This Section contains an Ansible playbook for deploying a Docker container on an Ubuntu EC2 instance as part of a larger project. The playbook installs necessary dependencies, sets up a Python virtual environment, and manages Docker operations.

## Overview

This playbook is designed to automate the deployment of a Docker container for the **DEPI Pet Clinic** application. 

## Prerequisites

- Ansible installed on your local machine
- Access to an Ubuntu EC2 instance
- SSH key for connecting to the EC2 instance

## Files

- `deploy_docker_container.yml`: Ansible playbook for deploying the Docker container.
- `inventory.ini`: Ansible inventory file for specifying the EC2 instance.

## Variables

The following variables are defined in the playbook:

- `docker_image`: The Docker image to be used (default: `mohamedwaleed77/depi_petclinic:latest`)
- `container_name`: The name of the Docker container (default: `petclinic_app`)
- `host_port`: The port on the host to expose (default: `5000`)
- `container_port`: The port on which the container listens (default: `8080`)
- `venv_path`: The path for the Python virtual environment (default: `/opt/ansible-venv`)

Update the inventory.ini file with your EC2 instance details.





