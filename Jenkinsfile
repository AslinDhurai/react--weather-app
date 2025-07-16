pipeline {
    agent any
    tools {
        dockerTool 'Docker'
    }
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
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                } 
            }
        }
        stage('Docker Build') {
            steps {
                echo 'Building..'
                sh 'docker build -t aslindhurai/weather:latest .'
            }
        }
         stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh 'docker push aslindhurai/weather:latest'
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'Trivy --version'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
