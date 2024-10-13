pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'Docker' // ID des credentials configurés
        DOCKER_IMAGE = "uncledhafer/frontendprojectdevops"  // Nom de l'image sans version
    }

    stages {
        stage('Import Project from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/Dhafer84/DevOps_Project_Front.git'
                echo 'Téléchargement du projet...'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Construire l'image Docker
                    sh 'docker-compose build'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Authentifier Docker Hub
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"

                        // Taguer l'image
                        sh "docker tag devops_project_front:latest ${DOCKER_IMAGE}:latest"

                        // Pousser l'image vers Docker Hub
                        sh "docker push ${DOCKER_IMAGE}:latest"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Lancer l'application avec Docker Compose
                    sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline finished successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

