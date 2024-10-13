pipeline {
    agent any
    triggers {
        pollSCM('0 * * * *') // every 1 hour
    }
    environment {
        REPO_NAME= "ci-cd-pipeline-with-jenkins-docker-ansible-aws" //because it's very long
        REPO_URL = "https://github.com/EsraaShaabanElsayed/ci-cd-pipeline-with-jenkins-docker-ansible-aws.git"
        
        IMG_NAME="petclinic-tomcat:latest"
        DOCKER_HUB_USR="mohamedwaleed77"
        DOCKER_REPO_NAME="mohamedwaleed77/depi_petclinic:latest"
        DOCKER_HUB_TOKEN=credentials('dockerhub')
        NOTI_EMAIL= "example@gmail.com"
    }

    stages {
        stage('Checkout') {
            steps {
                    git url: "${REPO_URL}", branch: 'main' 
                    sh 'pwd ; ls -la'
            }
        }

        stage('Build') {
            steps {
                    sh './autobuild.sh'
                    //sh "echo ${DOCKER_HUB_TOKEN} | docker login -u ${DOCKER_HUB_USR} --password-stdin" 
                    //sh "docker tag ${IMG_NAME} ${DOCKER_REPO_NAME}"
                    //sh "docker push ${DOCKER_REPO_NAME}"
                    
                
            }
        }

        stage('Testing') {
            steps {
                sh 'docker compose up -d && sleep 60'
                dir("test_scripts") {
                    sh './tests.sh'
                }
            }
        }
        stage('Deployment') {
            steps {
                dir("ansible-playbook") {
                    sh 'ansible-playbook -i inventory playbook.yml' 
                }  
            }
        }
    }


    post {
        success {
            echo 'Deployment succeeded!'
            mail to:  "${NOTI_EMAIL}",
                 subject: "SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                 body: "Good news! Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' has succeeded.\nCheck it here: ${env.BUILD_URL}"
        }

        failure {
            echo 'Deployment failed!'
            mail to:  "${NOTI_EMAIL}",
                 subject: "FAILURE: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                 body: "Unfortunately, Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' has failed.\nCheck it here: ${env.BUILD_URL}"
        }
        always{
            script{
                 sh 'docker compose down'
                 sh 'rm -rf target && sudo rm -rf savedata_mw'
            }
        }
    }
}               


