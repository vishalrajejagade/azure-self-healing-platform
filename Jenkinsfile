pipeline {
    agent any

    environment {
        ARM_USE_MSI         = 'true'
        ARM_SUBSCRIPTION_ID = 'a5012daf-0e54-4dd6-8520-d4804ca7f2ab'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Azure Managed Identity Auth') {
            steps {
                sh 'az login --identity && az account show --query "{name:name, id:id}" -o table'
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan -out=tfplan -no-color'
                }
            }
        }

        stage('Production Approval Gate') {
            steps {
                input message: 'Review Terraform Plan output. Approve deployment to Azure?', ok: 'Deploy'
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Post-Deploy Health Check') {
            steps {
                sh 'python3 scripts/health_check.py'
            }
        }
    }

    post {
        success {
            echo 'CI/CD Pipeline succeeded: Infrastructure validated and IIS endpoint healthy.'
        }
        failure {
            echo 'CI/CD Pipeline failed: Inspect Terraform plan or health check logs.'
        }
    }
}
