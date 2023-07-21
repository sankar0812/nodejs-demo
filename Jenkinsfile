pipeline {
    agent any 
    environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-hub-sankar')
    }
    stages { 
        stage('SCM Checkout') {
            steps {
              sh 'https://github.com/sankar0812/nodejs-demo.git'
            }
        }
        stage('Build docker image') {
            steps {  
                sh 'docker build -t sankar0812/nodeapp:$BUILD_NUMBER .'
            }
        }
        stage('login to dockerhub') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('push image') {
            steps {
                sh 'docker push sankar0812/nodeapp:$BUILD_NUMBER'
            }
        }
}
post {
        always {
            sh 'docker logout'
        }
    }
}

