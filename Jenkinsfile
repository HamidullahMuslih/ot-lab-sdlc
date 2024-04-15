pipeline {
    agent { docker { image 'maven:3.9.6-eclipse-temurin-17-alpine' } }
    stages {
        stage('build') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }
        stage('unit-tests') {
            steps {
                sh 'mvn test'
            }
        }
        stage('integration-tests') {
            steps {
                sh 'mvn integration-test'
            }
        }
        stage('generate-report') {
            steps {
                sh 'mvn site'
            }
        }
    }
    post {
        always {
            recordIssues(
                enabledForFailure: true, aggregatingResults: true,
                tools: [java(), checkStyle(pattern: '**/checkstyle-result.xml', reportEncoding: 'UTF-8')]
            )
        }
    }
}