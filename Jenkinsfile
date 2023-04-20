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
        stage("Integration Tests") {
            steps {
                // will run integration tests if any
                sh 'mvn verify'
            }
        }
        stage("Static Analysis") {
            steps {
                sh 'java -jar ~/checkstyle-10.9.3-all.jar -c ./sun_checks.xml src/'
            }
        }
        stage("Push to dockerhub") {
            steps {
                sh 'docker build -t arnoldedev/ot-lab-sdlc .'
                sh 'docker push arnoldedev/ot-lab-sdlc'
            }
        }
    }
}