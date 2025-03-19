pipeline {
    agent any

    environment {
        AWS_REGION = 'us-west-1' // Update to your desired AWS region
        AWS_CREDENTIALS = credentials('aws-credentials-id') // Jenkins credentials ID for AWS
    }

    stages {
        stage('Initialize') {
            steps {
                script {
                    // Install Terraform if not already installed
                    sh '''
                    if ! command -v terraform &> /dev/null
                    then
                        echo "Terraform not found, installing..."
                        wget https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip
                        unzip terraform_1.0.11_linux_amd64.zip
                        sudo mv terraform /usr/local/bin/
                    else
                        echo "Terraform is already installed."
                    fi
                    '''
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize Terraform
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Generate Terraform plan
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply Terraform plan
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }

    post {
        always {
            // Clean up workspace
            cleanWs()
        }
    }
}
