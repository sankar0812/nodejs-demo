pipeline {
    agent any 
    environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-hub-sankar')
    }
    stages { 
        stage('SCM Checkout') {
            steps {
            git 'https://github.com/sankar0812/nodejs-demo.git'
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
        stage('run container')  {
            steps {
                sh 'docker run -d --name web1 -v ssm_vol:/data -p 5000:3000 sankar0812/nodeapp:$BUILD_NUMBER'
            }
        }
}
post {
        always {
            sh 'docker logout'
        }
    }
}

