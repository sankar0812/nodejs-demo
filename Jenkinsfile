pipeline {
    agent any 
    environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-hub-sankar')
    PATH="${env.WORKSPACE}/build-dir:${env.PATH}"
    }
    stages { 
        stage('SCM Checkout') {
            steps {
               git 'https://github.com/sankar0812/nodejs-demo.git'
            }
        }
        stage('Delete Docker Image') {
            steps {
                def previousBuildNumber = currentBuild.number - 1
                // Use double-quotes for string interpolation
                sh "docker rmi -f sankar0812/nodeapp:$previousBuildNumber"
            }
        }
        stage('Delete docker container') {
            steps {  
                sh 'docker rm -f web1'
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
                sh 'docker run -d --name web1 -p 3000:3000 sankar0812/nodeapp:$BUILD_NUMBER'
            }
        }
}
post {
        always {
            sh 'docker logout'
        }
    }
}

