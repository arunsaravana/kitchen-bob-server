@Library('akpipeline') _

def loadValuesYaml(){
def props = readYaml (file: 'template.yml')
return props;
 }

pipeline {
   agent any
   stages {
      
     stage ('Prepare') {
     steps {
        script {
                props = loadValuesYaml()
                println props.getClass()
     }
    }
  }
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
