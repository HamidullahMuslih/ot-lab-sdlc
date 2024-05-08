pipeline {
    agent any
    environment{
        dockerImage = ''
    }
    stages {
        stage('Build') {
            steps {
                sh "git clone https://github.com/HamidullahMuslih/ot-lab-sdlc/"
                sh "mvn clean package -Dmaven.test.skip=true"
            }
        }
        stage('Unit Test'){
            steps {
                sh "mvn --batch-mode -Dmaven.test.failure.ignore=true test"
            }
        }
        
        stage('Integration test'){
            steps{
                sh "mvn verify"
            }
        }
        
        stage('Static Analysis'){
            steps{
                sh "java -jar checkstyle-10.15.0-all.jar -o checkstyle_result.xml -f xml -c ./google_checks.xml ./src"
                recordIssues(
                    enabledForFailure: true, 
                    tools: [java(), checkStyle(pattern: 'checkstyle_result.xml', reportEncoding: 'UTF-8')]
                )
            }
        }
        
        stage('Docker build'){
            steps{
                withCredentials([string(credentialsId: 'DOCKER_LOGIN', variable: 'DOCKER_LOGIN')]) {
                    // sh 'docker build --no-cache -t $DOCKER_LOGIN/ot-lab-app ./'
                    script{
                        dockerImage = docker.build("$DOCKER_LOGIN/ot-lab-app")
                    }
                }
            }
        }
        stage('Docker push'){
            steps{
                withCredentials([string(credentialsId: 'DOCKER_LOGIN', variable: 'DOCKER_LOGIN'),
                string(credentialsId: 'DOCKER_PASSWORD', variable: 'DOCKER_PASSWORD')]) {
                    script{
                        docker.withRegistry( '', $DOCKER_PASSWORD) {
                            dockerImage.push()
                        }
                    }
                    // sh 'docker login -u "$DOCKER_LOGIN" -p "$DOCKER_PASSWORD"'
                    // sh 'docker push "$DOCKER_LOGIN"/ot-lab-app'
                }
            }
        }
    }
}
