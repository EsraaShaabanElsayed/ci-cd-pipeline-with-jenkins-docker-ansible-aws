pipeline {
    agent any

    environment {
        
        TF_DIR = 'terraform' // Directory where your Terraform files are located
        ANSIBLE_PLAYBOOK_DIR = 'ansible-playbook' 
        ANSIBLE_PLAYBOOK = "${ANSIBLE_PLAYBOOK_DIR}/mainplaybook.yml"
        INVENTORY_FILE = "${ANSIBLE_PLAYBOOK_DIR}/inventory"// Ansible inventory file
        SSH_CREDENTIALS_ID = 'ssh-for-ec2'


    
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'test-terraform', url: 'https://github.com/EsraaShaabanElsayed/ci-cd-pipeline-with-jenkins-docker-ansible-aws.git'
                sh 'ls'
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
        withCredentials([
                aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'),
                sshUserPrivateKey(credentialsId: 'aws-ec2-key-credential', keyFileVariable: 'SSH_KEY_PATH', passphraseVariable: '', usernameVariable: 'SSH_USER') 
            ])  {
                script {
                    // Apply Terraform changes
                    sh 'terraform apply -auto-approve tfplan'
                    
                    // Get the public IP of the instance
                    def instancePublicIp = sh(script: "terraform output -json | jq -r '.instance_public_ip.value'", returnStdout: true).trim()
                    echo "Instance Public IP: ${instancePublicIp}"
                    
        sh """
            pwd
            cd ../ansible-playbook/
            pwd
            touch   ${env.WORKSPACE}/ansible-playbook/inventory
            echo "[ec2]" > ${env.WORKSPACE}/ansible-playbook/inventory
            echo "${instancePublicIp}  ansible_user=${SSH_USER}  " >> ${env.WORKSPACE}/ansible-playbook/inventory
            """
    //sh "cat ${env.WORKSPACE}/ansible-playbook/inventory"
            
                }
            }
        }
    }
}



        

        stage('Ansible Deploy') {
            steps {
                script {
                    withCredentials([
                        aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        sshagent(['aws-ec2-key-credential']) {
                            dir("ansible-playbook") {
                                sh 'ansible-playbook -i inventory mainplaybook.yml'
                            }
                        }
                    }
                }
            }
        }
    
    
    
    }


}


