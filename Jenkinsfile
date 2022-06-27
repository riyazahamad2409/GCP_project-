pipeline {
    agent any
    environment {
        PROJECT_ID = 'mineral-hangar-354512'
        CLUSTER_NAME = 'cluster-1'
        LOCATION = 'us-central1-c'
        CREDENTIALS_ID = 'Kubernetes'
    }
    stages {
        stage("Checkout code") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/riyaz-ahamadm92/java-projects.git']]])
            }
        }
	stage("Build") {
            steps {
                sh 'mvn clean install'
            }
        }
        stage("Build image") {
            steps {
                script {
                    myapp = docker.build("riyazahamadm92/gcp-project:${env.BUILD_ID}")
                }
            }
        }
        stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                            myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }        
    }
 }
