pipeline {
    agent any
    environment {
        TF_VAR_environment = 'dev'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform init'
                sh 'terraform plan -out=tfplan'
            }
        }
        stage('Dev') {
            steps {
                input message: 'Approve Dev', ok: 'Deploy'
                sh 'terraform apply -auto-approve tfplan'
            }
        }
        stage('QA') {
            steps {
                input message: 'Approve QA', ok: 'Deploy'
                echo 'Running QA tests'
            }
        }
        stage('UAT') {
            steps {
                input message: 'Approve UAT', ok: 'Deploy'
                echo 'Running UAT tests'
            }
        }
        stage('Prod') {
            steps {
                input message: 'Approve Prod', ok: 'Deploy'
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
}
