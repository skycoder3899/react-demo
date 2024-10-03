pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_IMAGE = 'yourdockerhubusername/react-demo'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/yourusername/your-react-app.git', branch: 'main'
            }
        }
        
        stage('Install Dependencies') {
            steps {
                script {
                    def nodejs = tool name: 'NodeJS 14', type: 'NodeJSInstallation'
                    env.PATH = "${nodejs}/bin:${env.PATH}"
                }
                sh 'yarn install'
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
