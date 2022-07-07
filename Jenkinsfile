pipeline {
    agent any
    tools {
        maven 'Maven' 
    }
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
                   sh "mvn clean package"
	    }
        }
	stage("Nexus push") {
		steps {
			nexusArtifactUploader artifacts: [[artifactId: 'jetty-maven-plugin', classifier: '', file: 'target/hello-world-war-1.0.1.war', type: 'WAR']], credentialsId: 'nexus-credentials', groupId: 'org.mortbay.jetty', nexusUrl: '34.125.152.152:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-hello-hosted', version: '1.0.2'
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
        stage('Deploy to GKE') {
            steps{
                sh "sed -i 's/tagversion/${env.BUILD_ID}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }
    }    
}
    
 
