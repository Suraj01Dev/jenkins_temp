pipeline {
    environment{
        APPNAME="stock_screener_ui"
        RELEASE="1.0.0"
        DOCKER_USER="suraj01dev"
        DOCKER_PASS="dockerhub"
        IMAGE_NAME="${DOCKER_USER}"+"/"+"${APPNAME}"
        IMAGE_TAG="${RELEASE}"+"-"+"${BUILD_NUMBER}"
    }

    agent {
        label "node1"
    }
    stages {

        stage('Testing Script') {
            steps {
                        sh '''
                        bash test.sh
                        '''
            }

        }

    stage('SonarQube Code Analysis') {
                    steps {
                        dir("${WORKSPACE}"){
                        // Run SonarQube analysis for Python
                        script {
                            def scannerHome = tool name: 'sonar_scanner'
                            withSonarQubeEnv('sonar_server') {
                                sh "echo $pwd"
                                sh "${scannerHome}/bin/sonar-scanner"
                            }
                        }
                    }
                    }
            }
        
            }

}


