@Library("Ansible shared Library") _

pipeline{
    agent {label 'local'}

    environment {
        API_URL = "http://10.82.17.17:8080"
    }

    stages{

        stage('Run ansible'){
            steps{
                ansible_playbook_init()
            }
        }

        stage('Source code'){
            steps{
                git url: 'https://github.com/pelthepu/todo-ui.git'
            }
        }

        stage('Ensure .env file'){
            steps{
                sh '''
                    if [ ! -f .env ]; then
                        echo "Creating .env file..."
                        touch .env
                    fi

                    if ! grep -q "REACT_APP_API_URL=" .env; then
                        echo "Adding API URL to .env"
                        echo "REACT_APP_API_URL=$API_URL" >> .env
                    else
                        echo "API URL already exists. Skipping..."
                    fi
                '''
            }
        }

        stage('Npm install'){
            steps{
                sh 'npm install'
            }
        }
    }
}