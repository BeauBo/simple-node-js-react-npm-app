env.TARGET_ENV = env.BRANCH_NAME == 'master' ? 'production' : 'integration'


pipeline {
  agent any

  environment {
    AWESOME_ENV=getAWESOMEEnv(env.TARGET_ENV)
  }

  parameters {
    booleanParam(defaultValue: env.TARGET_ENV == 'integration', description: 'Auto deploy when build is successful', name: 'autoDeploy')
    string(defaultValue: 'us-east-1', description: 'AWS Region', name: 'region')
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
    stage('Docker') {
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

def getAWESOMEEnv(env) {
  env
}