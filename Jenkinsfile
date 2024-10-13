pipeline {
    agent any

    environment {
        TF_DIR = 'terraform' // Directory where your Terraform files are located
        ANSIBLE_PLAYBOOK_DIR = 'ansible-playbook' 
        ANSIBLE_PLAYBOOK = 'mainplaybook.yml' // Corrected spelling of playbook
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
                dir(TF_DIR) {
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir(TF_DIR) {
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        script {
                            sh 'terraform apply -auto-approve tfplan'
                            instanceId = sh(script: "terraform output -json | jq -r '.instance_id.value'", returnStdout: true).trim()
                            instancePublicIp = sh(script: "terraform output -json | jq -r '.instance_public_ip.value'", returnStdout: true).trim()
                            echo "Instance ID: ${instanceId}"
                            echo "Instance Public IP: ${instancePublicIp}"
                        }
                    }
                }
            }
        }

        stage('Ansible Deploy') {
            steps {
                script {
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        // Create inventory file using instancePublicIp
                        writeFile file: 'inventory', text: "[ec2]\n${instancePublicIp}\n"
                        // Run Ansible playbook
                        sh 'ansible-playbook -i inventory ansible-playbook/mainplaybook.yml'
                    }
                }
            }
        }
    }
}
