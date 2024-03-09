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
        label "jenkins-ssh-agent-docker"
    }

    stages {
        stage('Git Checkout') {
            steps {
                git 'https://github.com/Suraj01Dev/Stock_Screener_UI'
            }
            

        }
        stage('Installing Python Dependencies') {
            steps {
                        sh '''
                        pip3 install streamlit pandas requests
                        '''
            }

        }
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
                            def scannerHome = tool name: 'sonarqube-scanner-latest'
                            withSonarQubeEnv('sonarqube-scanner') {
                                sh "echo $pwd"
                                sh "${scannerHome}/bin/sonar-scanner"
                            }
                        }
                    }
                    }
            }
        stage("Quality gate") {
                    steps {
                        waitForQualityGate abortPipeline: true
                    }
                }
        
        stage("Docker Build and Push"){
            steps{
                script{
                    docker.withRegistry('', DOCKER_PASS){
                        docker_image=docker.build "$IMAGE_NAME"
                    }

                    docker.withRegistry('', DOCKER_PASS){
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push("latest")

                    }
                }

            }
        }



    }
}


