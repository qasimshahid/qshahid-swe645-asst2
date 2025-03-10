pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'qshahid/survey-app'
        REGISTRY_CREDENTIAL = 'dockerhub_credentials'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/qasimshahid/qshahid-swe645-asst2.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }
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
    post {
        always {
            cleanWs()
        }
    }
}
