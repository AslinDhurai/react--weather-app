pipeline {
    agent any
    // environment {
    //     AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
    //     AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    // }

    stages {
        stage('Run Sonarqube') {
                steps {
                withSonarQubeEnv(credentialsId: 'SonarQube-ID', installationName: 'Sonar') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        stage("SonarQube Quality Gate Check") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    def qg = waitForQualityGate()
                    if (qg.status != 'OK') {
                        error "Pipeline aborted due to quality gate failure: ${qg.status}"
                    }
                }
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
