
pipeline {
    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    environment {
        IMAGE_NAME = 'react-nginx-app'
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Building branch: ${env.BRANCH_NAME}"
                checkout scm
            }
        }

        stage('Check Files') {
            steps {
                sh '''
                    echo "Checking application files"
                    ls -la
                    test -f Dockerfile
                '''
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    def safeBranch = env.BRANCH_NAME
                        .toLowerCase()
                        .replaceAll(/[^a-z0-9_.-]/, '-')

                    env.IMAGE_TAG = "${safeBranch}-${env.BUILD_NUMBER}"
                }

                sh '''
                    docker build \
                      -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Verify Docker Image') {
            steps {
                sh '''
                    docker image inspect \
                      ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }

        stage('Main Branch Message') {
            when {
                branch 'main'
            }
            steps {
                echo 'This is the main branch.'
                echo 'Production deployment can be configured here.'
            }
        }
    }

    post {
        success {
            echo "Build successful for ${env.BRANCH_NAME}"
        }

        failure {
            echo "Build failed for ${env.BRANCH_NAME}"
        }

        always {
            echo 'Pipeline execution completed.'
        }
    }
}
