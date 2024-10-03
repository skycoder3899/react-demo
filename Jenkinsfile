pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_IMAGE = 'skycoder3899/react-demo'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/skycoder3899/react-demo.git', branch: 'main'
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh 'npm cache clean --force' // Clean up the npm cache
                sh 'rm -rf node_modules' // Clean up node_modules
                sh 'npm install'
                sh 'npm audit fix --force' // Attempt to resolve vulnerabilities
                sh '''
                    if ! command -v yarn &> /dev/null
                    then
                        echo "Yarn not found. Installing..."
                        npm install -g yarn
                    fi
                '''
            }
        }

        stage('Build React App') {
            steps {
                // If yarn exists, use it to build. Otherwise, fallback to npm run build
                sh '''
                    if command -v yarn &> /dev/null
                    then
                        yarn build
                    else
                        npm run build
                    fi
                '''
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
