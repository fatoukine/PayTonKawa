 pipeline {
        
        agent any
        
        triggers {
            pollSCM 'H/5 * * * *' 
        }
        
        stages{
            stage("PayTonkawa checkout"){
                steps {
                    git branch: 'main', url: 'https://github.com/fatoukine/PayTonKawa.git'
                }
            }
        
     
        
          
            stage("PayTonkawa Clean"){
                steps {
                    dir ('PROJECT/'){
                        bat './mvnw clean'
                          
                    }
                }
            }
          
          
              stage("PayTonkawa Compile"){
                steps {
                    dir ('PROJECT/'){
                         bat './mvnw compile'
                          
                    }
                }
            }
          
          
            stage("PayTonkawa Test"){
                steps {
                    dir ('PROJECT/'){
                          bat './mvnw test'
                          
                    }
                }
            }
          
          
           stage("PayTonkawa Package"){
                steps {
                    dir ('PROJECT/'){
                         bat './mvnw package'
                          
                    }
                }
            }
          
          
           /*  stage("PayTonkawa Archive"){
                steps {
                    dir ('PROJECT/'){
                        bat 'rename target\\erphrense-0.0.1-SNAPSHOT.jar erphrense-%BUILD_NUMBER%.jar'
                        archiveArtifacts artifacts: 'target\\erphrense-*.jar', followSymlinks: false
                          
                    }
                }
            }*/
          
          
        }  
        
    }
