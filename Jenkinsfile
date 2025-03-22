pipeline {
    agent {
        kubernetes {
            yamlFile 'jenkins-pod.yaml'  // Uses your existing pod template
            defaultContainer 'build'     // Default to the build container
        }
    }
    environment {
        AWS_DEFAULT_REGION = 'your-aws-region' // e.g., us-west-1
        // Add AWS credentials here if using Jenkins credentials store
        // AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        // AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }
    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/teciedesk/terraform-aws-eks-jenkins-pipeline.git'
            }
        }

        stage('Terraform Format & Validate') {
            steps {
                container('build') {
                    sh '''
                    echo "Formatting Terraform files..."
                    terraform fmt -check
                    terraform validate
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                container('build') {
                    sh '''
                    echo "Initializing Terraform..."
                    terraform init
                    terraform plan -out=tfplan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: "Apply Terraform changes?" // Manual approval
                container('build') {
                    sh '''
                    terraform apply -auto-approve tfplan
                    '''
                }
            }
        }

        stage('Kubernetes Deployment') {
            steps {
                container('build') {
                    sh '''
                    echo "Deploying Kubernetes resources..."
                    kubectl apply -f k8s/jenkins-deployment.yaml
                    '''
                }
            }
        }

        stage('Post-Deployment') {
            steps {
                container('build') {
                    sh '''
                    echo "Listing deployed services..."
                    kubectl get svc -n jenkins
                    '''
                }
            }
        }

    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs.'
        }
    }
}
