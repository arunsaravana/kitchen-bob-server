@Library('akpipeline') _

pipeline {
   agent any
   stages{
     
     stage('SCM') {
        step {
          mycodecheckout(branch: 'master' , scmUrl:'https://github.com/arunsaravana/kitchen-bob-server.git' ) 
        }
     }
      
   }
}
