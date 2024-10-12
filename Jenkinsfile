pipeline {
    agent any

    environment {
        TF_DIR = 'terraform' // Directory where your Terraform files are located
        ANSIBLE_PLAYBOOK_DIR = 'ansible-playbook' 
        ANSIBLE_PLAYBOOK = 'playbook.yml' // Corrected spelling of playbook
        INVENTORY_FILE = 'inventory' // Ansible inventory file
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'test-terraform', url: 'https://github.com/EsraaShaabanElsayed/ci-cd-pipeline-with-jenkins-docker-ansible-aws.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir(TF_DIR) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir(TF_DIR) { // Changed to use TF_DIR variable
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS']]) {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir(TF_DIR) { // Changed to use TF_DIR variable
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS']]) {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }

        stage('Ansible Deploy') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS']]) {
                        // Corrected to use ANSIBLE_PLAYBOOK_DIR and fix the syntax for the ansible-playbook command
                        sh "ansible-playbook -i ${INVENTORY_FILE} ${ANSIBLE_PLAYBOOK_DIR}/${ANSIBLE_PLAYBOOK} --extra-vars=\"ec2_host={{ lookup('terraform', 'instance_public_ip') }}\""
                    }
                }
            }
        }
    }
}
