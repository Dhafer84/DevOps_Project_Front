pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Dhafer84/DevOps_Project_Front.git'
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

        stage('Test') {
            steps {
                script {
                    // Exécuter les tests unitaires
                    sh 'npm run test -- --watch=false'
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

