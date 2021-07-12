pipeline {
    agent any

    stages {
        stage('Example Initialization') {
            echo "Running ${env.BUILD_TAG} on ${env.JENKINS_URL}"
            if (env.BRANCH_NAME == 'main') {
                echo 'executed on main branch'
            } else {
                echo "executed on branch ${env.BRANCH_NAME}"
            }
        }
        stage('Build') {
            steps {
                sh './gradlew assemble'
            }
        }
        stage('Test') {
            steps {
                sh './gradlew test'
            }
        }
        stage('Build Docker image') {
            steps {
                sh './gradlew docker'
            }
        }
        stage('Push Docker image') {
            environment {
                DOCKER_HUB_LOGIN = credentials('docker-hub')
            }
            steps {
                sh 'docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW'
                sh './gradlew dockerPush'
            }
        }
        stage('Example Parallel Stages') {
            when {
                branch 'main'
            }
            parallel {
                stage('Parallel A') {
                    steps {
                        echo "Parallel A"
                    }
                }
                stage('Parallel B') {
                    steps {
                        echo "Parallel B"
                    }
                }
                stage('Parallel C') {
                    stages {
                        stage('Nested 1') {
                            steps {
                                echo "In stage Nested 1 within Parallel C"
                            }
                        }
                        stage('Nested 2') {
                            steps {
                                echo "In stage Nested 2 within Parallel C"
                            }
                        }
                    }
                }
            }
        }
        stage('Example Deploy 1') {
            when {
                allof {
                    branch 'main'
                    environment name: 'DEPLOY_TO', value: 'production'
                }
            }
            steps {
                echo 'Deploying'
            }
        }
        stage('Example Deploy 2') {
            when {
                expression { BRANCH_NAME ==~ /(main|production|staging)/ }
                anyOf {
                    environment name: 'DEPLOY_TO', value: 'production'
                    environment name: 'DEPLOY_TO', value: 'staging'
                }
            }
            steps {
                echo 'Deploying'
            }
        }
    }
}