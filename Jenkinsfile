pipeline {
//     agent { docker { image 'maven:3.9.6-eclipse-temurin-17-alpine' } }
    agent any
    tools {
        maven 'apache-maven-3.0.1'
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
//             agent { label 'default' }
//             steps {
//                 withCredentials([usernamePassword(credentialsId: 'e2xen-dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
//                     sh 'docker build -t e2xen/ot-lab3:latest .'
//                     sh 'docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}'
//                     sh 'docker push e2xen/ot-lab3:latest'
//                 }
//             }
            steps {
                script {
                    def dockerHome = tool 'docker'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"

                    def image = docker.build("e2xen/ot-lab3:latest")
                    image.push()
                }
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