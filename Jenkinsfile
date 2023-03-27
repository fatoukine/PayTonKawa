pipeline {
    agent any
 
    environment {
        PATH = "C:/Users/adama/Desktop/MSPR_ERP/flutter/bin"
    }

    stages{
        stage('Paytonkawa checkout') { 
            steps {
                git branch:'develop',url:'https://github.com/fatoukine/PayTonKawa.git'
                }

        }

        stage('Paytonkawa clean') {
                steps {
                   dir ('PROJECT/'){
                    bat 'flutter clean'
                  }
                } 
         }

        stage('Paytonkawa dependencies') {
            steps {
               dir ('PROJECT/'){
                bat 'flutter pub get'
            }
          }  
        }

        stage('Paytonkawa test') {
            steps {
                dir('PROJECT/lib/'){
                       bat 'flutter test'
                    }
            }
        }

        stage('Paytonkawa package') {
              steps {
                  dir ('PROJECT/'){
                   bat 'flutter build apk --release'
                }
              }  
        }

        stage('Paytonkawa archive') {
            steps {
               dir ('PROJECT/'){
                bat 'mv build/app/outputs/flutter-apk/app-release.apk apk-payetonkawa-$BUILD_NUMBER.apk'
                archiveArtifacts artifacts: 'apk-payetonkawa-*.apk', followSymlinks: false

             }
          } 
        }  

    }
  }
