pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        echo 'Building a docker image'
        sh './build.sh'
      }
    }
    stage('test') {
      steps {
        echo 'Executing test cases'
      }
    }
    stage('deploy') {
      steps {
        echo 'Deployment is in progress'
        sh './deploy.sh'
      }
    }
  }
}
