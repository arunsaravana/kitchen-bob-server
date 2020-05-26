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
      stage ('Docker build') {
      steps {
        withCredentials([usernamePassword(
            credentialsId: props.CredId.dockercrid,
            usernameVariable: "Username",
            passwordVariable: "Password"
        )]) {
        dockerbuild(props.dockerhub.hubuser, props.dockerhub.hubrepo, props.dockerhub.hubtag)
        }
      }
    }     
      
   }
}
