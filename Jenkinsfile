pipeline {
    agent any

    environment {
        SS_KEY = credentials('ec2-key')
        TF_DIR = 'terraform' // Directory where your Terraform files are located
        ANSIBLE_PLAYBOOK_DIR = 'ansible-playbook' 
        ANSIBLE_PLAYBOOK = "${ANSIBLE_PLAYBOOK_DIR}/mainplaybook.yml"
        INVENTORY_FILE = "${ANSIBLE_PLAYBOOK_DIR}/inventory"// Ansible inventory file
       
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
            withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                script {
                    // Apply Terraform changes
                    sh 'terraform apply -auto-approve tfplan'
                    
                    // Get the public IP of the instance
                    def instancePublicIp = sh(script: "terraform output -json | jq -r '.instance_public_ip.value'", returnStdout: true).trim()
                    
                    // Log the instance public IP
                    echo "Instance Public IP: ${instancePublicIp}"
                    sh"pwd"
                    sh "ls -al"
                    // Write the inventory file for Ansible
        sh """
        
        cd ../ansible-playbook/
        touch inventory
        echo "[ec2]" > ansible-playbook/inventory
        echo "${instancePublicIp} ansible_ssh_private_key_file=${SS_KEY} ansible_user=ubuntu" >> ansible-playbook/inventory
    """
    sh "cat ansible-playbook/inventory"
                     //sh "cat ${INVENTORY_FILE}"
                    
                    // Output the contents of the inventory file for verification
                 //   sh "cat ${INVENTORY_FILE}"
                }
            }
        }
    }
}



        

        stage('Ansible Deploy') {
            steps {
                script {
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
        
                
                    sh "ls -al"
                    sh "cat ${INVENTORY_FILE}"
                    echo "SSH Key: ${SS_KEY}"

                    // Run the Ansible playbook
                    sh "ansible-playbook -i ${INVENTORY_FILE} ${ANSIBLE_PLAYBOOK} -vvv"
        
                    
                }
                }
            }
        }
    }

}
