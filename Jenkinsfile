pipeline {
//     agent { docker { image 'maven:3.9.6-eclipse-temurin-17-alpine' } }
    agent any
    tools {
        maven 'apache-maven'
    }
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
        stage("docker-build") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'e2xen-dockerhub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh 'docker build -t e2xen/ot-lab3:latest .'
                    sh 'docker login -u $USER -p $PASS'
                    sh 'docker push e2xen/ot-lab3:latest'
                }
            }
        }
        stage("deploy") {
            agent { label 'deploy' }
            steps {
                sh 'docker pull e2xen/ot-lab3:latest'
                sh 'docker stop container || true'
                sh 'docker rm -f container || true'
                sh 'docker run -p 8080:8080 -d --name container e2xen/ot-lab3:latest'
            }
        }
    }
    post {
        always {
            recordIssues(
                enabledForFailure: true, aggregatingResults: true,
                tools: [java(), checkStyle(pattern: '**/checkstyle-result.xml', reportEncoding: 'UTF-8')],
                qualityGates: [[threshold: 1000, type: 'TOTAL', criticality: 'FAILURE']]
            )
        }
    }
}