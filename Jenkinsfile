pipeline {
  agent any
  environment {
    IMAGE = "nourheneouertani/fleetman-webapp"
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build --build-arg BUILD_NUMBER=$BUILD_NUMBER -t $IMAGE:$BUILD_NUMBER .'
      }
    }
    stage('Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
          sh 'echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin'
          sh 'docker push $IMAGE:$BUILD_NUMBER'
        }
      }
    }
    stage('Deploy') {
      steps {
        sh 'sed "s#IMAGE_TAG#$IMAGE:$BUILD_NUMBER#" manifests/webapp.yaml | kubectl apply -f -'
        sh 'kubectl rollout status deployment/webapp --timeout=180s'
      }
    }
  }
  post {
    always {
      sh 'docker image prune -f'
    }
  }
}
