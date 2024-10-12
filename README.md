# Automated Deployment Pipeline Project
This project demonstrates a continuous integration and continuous deployment (CI/CD) pipeline for deploying a sample web application using Jenkins, Docker, and Ansible. The pipeline ensures that code changes are automatically tested, built, and deployed to a cloud environment, streamlining the deployment process and improving efficiency.

# Project Overview
The primary goal of this project is to automate the deployment process of a sample application by setting up a CI/CD pipeline. This pipeline covers everything from code integration, testing, and containerization to deployment and cloud setup.

# Key Technologies
Jenkins: Manages pipeline stages for continuous integration and automation.
Docker: Containerizes the application and manages its deployment.
Ansible: Automates configuration and deployment steps.
GitHub: Source control management for the application code.
Cloud Environment (Optional): AWS is used to host the final application.
Application
This project utilizes a pet clinic application as the deployment sample. The project source code is stored in a GitHub repository, where Jenkins detects changes and initiates the pipeline.

# Pipeline Workflow
Code Build (Continuous Integration):

1-Jenkins is triggered upon new commits.

2-Jenkins pulls the latest code from the repository, builds a Docker image, and runs unit tests.

3-Push to Docker Registry:

The Docker image is pushed to Docker Hub or a private registry for deployment.
Automated Deployment (Continuous Delivery):

4-Ansible playbooks are utilized to deploy the Docker image to a cloud server, where the application is configured and launched.
Optional Kubernetes Integration:

# Key Deliverables
Functional Jenkins and Docker setup.

Jenkins jobs for building, testing, and containerizing the application.

Ansible playbooks for deployment automation.

Comprehensive documentation of the CI/CD pipeline.

# Project Flow Diagram

![Untitled Diagram drawio](https://github.com/user-attachments/assets/a51f8932-21d6-46d7-b5d8-9622dcf9b069)
