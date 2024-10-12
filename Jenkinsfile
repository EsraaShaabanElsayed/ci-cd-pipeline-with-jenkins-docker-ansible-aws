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
                dir(TF_DIR) { // Changed to use TF_DIR variable
                 withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
   

                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir(TF_DIR) { // Changed to use TF_DIR variable
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }

        stage('Ansible Deploy') {
            steps {
                script {
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        // Corrected to use ANSIBLE_PLAYBOOK_DIR and fix the syntax for the ansible-playbook command
                        sh "ansible-playbook -i ${INVENTORY_FILE} ${ANSIBLE_PLAYBOOK_DIR}/${ANSIBLE_PLAYBOOK} --extra-vars=\"ec2_host={{ lookup('terraform', 'instance_public_ip') }}\""
                    }
                }
            }
        }
    }
}
