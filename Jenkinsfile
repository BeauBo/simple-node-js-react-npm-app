pipeline {
  agent {
    docker {
      image 'node:6-alpine'
      args'-p 3000:3000'
    }
  }

  environment {
    CI = 'true'
  }

  parameters {
    booleanParam(defaultValue: true, description: 'Auto deploy when build is successful', name: 'autoDeploy')
    string(defaultValue: 'ap-south-1', description: 'AWS Region', name: 'region')
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '2', artifactNumToKeepStr: '5'))
  }

  stages {
    stage('Build') {
      when {
        expression { params.autoDeploy }
      }
      steps {
        sh 'npm install'
      }
    }
    stage('Test') {
      when {
        expression { params.autoDeploy }
      }
      steps {
        sh './jenkins/scripts/test.sh'
      }
    }
    stage('Deploy') {
      when {
        expression { params.autoDeploy }
      }
      steps {
        sh './jenkins/scripts/deliver.sh'
        input message: 'Finished using the web site? (Click "Proceed" to continue)'
        sh './jenkins/scripts/kill.sh'
      }
    }
  }
}