pipeline {
    agent any

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

