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

	stage('Push to Docker Hub') {
	    steps {
		script {
		    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
		        // Taguer l'image avec le bon nom
		        sh "docker tag piplinefrontend_angular-app:latest uncledhafer/frontendprojectdevops:latest"
		        // Pousser l'image vers Docker Hub
		        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
		        sh "docker push uncledhafer/frontendprojectdevops:latest"
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

