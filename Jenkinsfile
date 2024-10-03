pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_IMAGE = 'skycoder3899/react-demo'
    }

    tools {
        nodejs 'NodeJS 14'  // Specify NodeJS installation here
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/skycoder3899/react-demo.git', branch: 'main'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'yarn install'  // No need to specify node path if tools is used
            }
        }

        stage('Build React App') {
            steps {
                sh 'yarn build'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Docker Login') {
            steps {
                sh 'docker login -u $DOCKER_CREDENTIALS_USR -p $DOCKER_CREDENTIALS_PSW'
            }
        }

        stage('Docker Push') {
            steps {
                sh 'docker push $DOCKER_IMAGE'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
