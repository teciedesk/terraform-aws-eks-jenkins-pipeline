pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: eks-jenkins-agent
spec:
  containers:
  - name: eks-jenkins-agent
    image: jenkins/inbound-agent:3299.v0d0d06908537-1
    command:
    - cat
    tty: true
    volumeMounts:
    - name: docker-sock
      mountPath: /var/run/docker.sock
  volumes:
  - name: docker-sock
    hostPath:
      path: /var/run/docker.sock
"""
    }
  }

  environment {
    AWS_REGION = 'us-west-1'
  }

  stages {
    stage('Initialize') {
      steps {
        container('eks-jenkins-agent') {
          script {
            sh '''
              echo "Installing wget & unzip..."
              apt-get update && apt-get install -y wget unzip

              echo "Terraform not found, installing..."
              wget https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip
              unzip terraform_1.0.11_linux_amd64.zip
              mv terraform /usr/local/bin/
              terraform version
            '''
          }
        }
      }
    }

    stage('Terraform Init') {
      steps {
        container('eks-jenkins-agent') {
          sh 'terraform init'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        container('eks-jenkins-agent') {
          sh 'terraform plan'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        container('eks-jenkins-agent') {
          sh 'terraform apply -auto-approve'
        }
      }
    }

  }
}
