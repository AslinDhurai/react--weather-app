pipeline {
    agent any
    // environment {
    //     AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
    //     AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    // }

    stages {
        stage('Run Sonarqube') {
                environment {
                    scannerHome = tool 'SonarQube';
                }
                steps {
                withSonarQubeEnv(credentialsId: 'SonarQube-ID', installationName: 'Sonar') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        stage("SonarQube Quality Gate Check") {
            steps {
                 script {
                    def qualityGate = waitForQualityGate(abortPipeline: false, credentialsId: 'SonarQube-ID')
                    if (qualityGate.status != 'OK') {
                        echo "❌ Quality Gate failed: ${qualityGate.status}"
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
