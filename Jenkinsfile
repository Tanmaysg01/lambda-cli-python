pipeline { 

    agent any 

    environment { 

        AWS_ACCOUNT_ID = "875716031392" 

        AWS_DEFAULT_REGION = "us-east-1" 

        AWS_ACCESS_KEY_ID = credentials("AWS_ACCESS_KEY_ID") 

        AWS_SECRET_ACCESS_KEY = credentials("AWS_SECRET_ACCESS_KEY") 

    } 

    stages { 

        stage('checkout') { 

            steps { 

                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Tanmaysg01/ecr-docker.git']]) 

            } 

        } 

    stage("init") { 

            steps { 

                sh "terraform init" 

            } 

        } 

         

    stage("plan") { 

            steps { 

                sh "terraform plan" 

            } 

        } 

         

    stage("apply") { 

            steps { 

                sh "terraform apply --auto-approve" 

            } 

        } 
     stage("Logging") { 

             steps { 

                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'aws-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) { 

                    sh 'echo $AWS_ACCESS_KEY_ID' 

                    sh 'echo $AWS_SECRET_ACCESS_KEY' 

                
                } 

            } 
        }
    
     stage("Lambda") {
            
            steps {
                sh '''
                    aws lambda create-function --function-name lambda-cli-function \
                    --zip-file fileb://hello.zip --handler hello.handler --runtime python3.8 \
                    --role arn:aws:iam::875716031392:role/lambda-ex
                  '''
            }
     }