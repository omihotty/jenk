node{
  stage('SCM Checkout'){
    git 'https://github.com/omihotty/jenk.git'
  
  }
  stage('Compile-package'){
    def mvnHome = tool name: 'maven', type: 'maven'
    sh "${mvnHome}/bin/mvn package"
  
  }
  stage('Email Notification'){
     mail bcc: '', body: 'testing purpose only', cc: '', from: '', replyTo: '', subject: 'hi this is for test', to: 'omkar.saini@esteltelecom.com'
  
  }

}