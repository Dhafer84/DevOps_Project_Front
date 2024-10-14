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

        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker ici, remplacez ceci par votre commande de construction
                    sh 'docker build -t piplinefrontend_angular-app:latest .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        // Taguer l'image avec le bon nom
                        sh "docker tag piplinefrontend_angular-app:latest ${DOCKER_IMAGE}:latest"
                        // Se connecter à Docker Hub
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
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

