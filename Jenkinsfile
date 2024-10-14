pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'Docker' // ID des credentials configurés
        DOCKER_IMAGE = "uncledhafer/frontendprojectdevops" // Nom de l'image sans version
        PACKAGE_JSON_PATH = 'package.json' // Chemin vers votre package.json
    }

    stages {
        stage('Import Project from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/Dhafer84/DevOps_Project_Front.git'
                echo 'Téléchargement du projet...'
            }
        }

        stage('Get Version') {
            steps {
                script {
                    // Récupérer la version depuis package.json
                    def json = readJSON file: PACKAGE_JSON_PATH
                    env.VERSION = json.version
                    echo "Version de l'application : ${env.VERSION}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build --build-arg VERSION=${env.VERSION} -t piplinefrontend_angular-app:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        // Taguer l'image avec le bon nom et la version
                        sh "docker tag piplinefrontend_angular-app:latest ${DOCKER_IMAGE}:${env.VERSION}" // Tag avec la version
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                        // Pousser l'image vers Docker Hub
                        sh "docker push ${DOCKER_IMAGE}:${env.VERSION}" // Pousser avec la version
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose down --volumes --remove-orphans || true' // Étape de nettoyage
                    sh 'docker-compose up --build -d' // Construire et lancer
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

