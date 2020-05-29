node{
  stage('SCM Checkout'){
    git 'https://github.com/omihotty/jenk.git'
  
  }
  stage('Compile-package'){
    def mvnHome = tool name: 'maven', type: 'maven'
    sh "${mvnHome}/bin/mvn package"
  
  }

}