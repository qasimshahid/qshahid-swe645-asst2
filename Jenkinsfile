// Author: Qasim Shahid
// Jenkinsfile for the survey app
// First ,it will clone the code from GitHub
// Then it will build a Docker image and push it to Docker Hub
// Then it will deploy the new image to our Kubernetes cluster
// All credentials are stored in Jenkins credentials store (required to make this work)

pipeline {
    agent any
    // Set up our Docker info and credentials
    environment {
        DOCKER_IMAGE = 'qshahid/survey-app'
        REGISTRY_CREDENTIAL = 'dockerhub_credentials'
    }
    stages {
        // First, grab our code from GitHub
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/qasimshahid/qshahid-swe645-asst2.git'
            }
        }

        // Build a Docker image with a unique tag based on build number
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }

        // Push our image to Docker Hub
        // We push it twice - once with build number and once as 'latest'
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', REGISTRY_CREDENTIAL) {
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }

        // Deploy everything to our Kubernetes cluster
        // Apply our configs and force a restart to pick up new image
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withKubeConfig([credentialsId: 'kubeconfig_credentials']) {
                        sh 'kubectl apply -f deployment.yaml'
                        sh 'kubectl apply -f service.yaml'
                        sh 'kubectl rollout restart deployment/survey-app-deployment'
                    }
                }
            }
        }
    }

    // Clean up our workspace after we're done
    post {
        always {
            cleanWs()
        }
    }
}
