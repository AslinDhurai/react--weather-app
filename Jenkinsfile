pipeline {
    agent any
    environment {
        SONAR_SCANNER_OPTS = "-Xmx2048m"  // Increase scanner memory
    }
    stages {
        stage('Run Sonarqube') {
            environment {
                scannerHome = tool 'SonarQube'
            }
            steps {
                withSonarQubeEnv(credentialsId: 'SonarQube-ID', installationName: 'Sonar') {
                    sh """
                        ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.ce.timeout=1800 \  // 30min timeout
                        -Dsonar.scm.disabled=true \  // Disable SCM if not needed
                        -Dsonar.analysis.timeout=1800
                    """
                }
            }
        }
        stage("Quality Gate") {
            steps {
                timeout(time: 15, unit: 'MINUTES') {  // Reduced timeout
                    script {
                        def qg = waitForQualityGate(
                            abortPipeline: false,
                            credentialsId: 'SonarQube-ID'
                        )
                        if (qg.status != 'OK') {
                            error "Quality Gate failed: ${qg.status}"
                        }
                    }
                }
            }
        }
        // Other stages...
    }
}