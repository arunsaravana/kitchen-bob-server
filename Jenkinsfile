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
      stage('Sonar Analysis') {
         steps {
                sonaranalysis()
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
    
       stage ('Kube Deploy') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: props.CredId.awsid , secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
        kubeupdate(props.eks.eksregion, props.eks.ekscluster)
        } 
      }
    }  
    
      
   }
}
