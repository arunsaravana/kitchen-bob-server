@Library('akpipeline') _

pipeline {
   agent any
   stages {
     
     stage('SCM') {
        steps {
          mycodecheckout(branch: 'master' , scmUrl:'https://github.com/arunsaravana/kitchen-bob-server.git' ) 
        }
     }
      stage('build') {
         steps {
                mybuild()
       
                  }
        }
   }
}
