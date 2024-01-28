pipeline {
  agent {
    docker {
      image 'maven:3-alpine'
      args '-v C:\\store\\work\\maven\\local\\repo:/root/.m2'
    }

  }
  stages {
    stage('Build') {
      agent {
        docker {
          image 'maven:3-alpine'
        }

      }
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }

  }
}