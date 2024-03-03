pipeline {
    agent any
    environment {
        // Add the Terraform installation path to the system PATH
        PATH = "E:\\terraform\\Terraform;$PATH"
    }
    stages {
        stage('git') {
            steps {
                git branch: 'main', credentialsId: '64338209-c2d5-4594-a04d-6672d7838d12', url: 'https://github.com/joel2500/Terraform.git'
            }
        }
        stage('Terraform Validate') {
            steps {
                dir('QA') {
                bat 'terraform validate'
              }
            }
        }
        stage('Terraform Init') {
            steps {
                dir('QA') {
                bat 'terraform init'
              }
            }
        } 
        stage('Terraform Plan') {
            steps {
                dir('QA') {
                bat 'terraform plan'
              }
            }
        }
        // stage('Terraform apply') {
        //     steps {
        //         dir('QA') {
        //         bat 'terraform apply'
        //       }
        //     }
        // }                                
    }
}
post {
    always {
        // Additional post-build actions or notifications
        emailext body: 'The Terraform build has completed. Status: ${currentBuild.result}', subject: 'Terraform Build Notification', to: 'joelstephen00@gmail.com'
    }
}

