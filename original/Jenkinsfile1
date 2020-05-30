node{
  stage('SCM Checkout'){
    git 'https://github.com/omihotty/jenk.git'
  
  }
  stage('Compile-package'){
    def mvnHome = tool name: 'maven', type: 'maven'
    sh "${mvnHome}/bin/mvn package"
  
  }
  stage('Email Notification'){
     emailext body: 'this is only for testing purpose', subject: 'Hi this is for testing purpose', to: 'singh.88omkar@gmail.com'
  
  }

}