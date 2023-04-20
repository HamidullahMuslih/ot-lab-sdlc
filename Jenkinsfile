pipeline {
    agent { label 'jenkins-agent-1' }
    tools {
        maven '3.9.1'
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn compile'
            }
        }
        stage("Unit Test") {
            steps {
                sh 'mvn test'
            }
        }
    }
}