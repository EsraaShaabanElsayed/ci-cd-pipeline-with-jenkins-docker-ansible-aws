pipeline {
    agent any

    environment {
        TF_DIR = 'terraform' // Directory where your Terraform files are located
        ANSIBLE_PLAYBOOK_DIR = 'ansible-playbook' 
        ANSIBLE_PLAYBOOK = 'palybook.yml' // Name of the Ansible playbook file
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

        stage('Terraform Apply') {
            steps {
                dir(TF_DIR) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Ansible Deploy') {
            steps {
                script {
                    sh 'ansible-playbook -i "ec2, ansible_ssh_host={{ lookup(\'terraform\', \'instance_public_ip\') }}" deploy.yml'
                }
            }
        }
    }

        
    post {
        // always {
        //     dir(TF_DIR) {
        //         sh 'terraform destroy -auto-approve'
        //     }
        // }
        // failure {
        //     echo 'Pipeline failed!'
        // }
        // success {
        //     echo 'Pipeline completed successfully!'
        // }
    }
}
