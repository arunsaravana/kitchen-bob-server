@Library('akpipeline1') _

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
          mycodecheckout(branch: props.scm.branch , scmUrl: props.scm.repo) 
        }
     }
      stage('build') {
         steps {
                mybuild()
       
                  }
        }
      stage('Junit Test') {
         steps {
                junittest(props.junitloc.testpath)
                   }
        }  
      stage('Sonar Analysis') {
         steps {
                         sonaranalysis(props.sonar.server, props.sonar.scanner, props.sonar.scannerproperties)
                   }
        } 
    
      stage ('Docker build') {
      steps {
        dockerbuild(props.dockerhub.hubuser, props.dockerhub.hubrepo, props.dockerhub.hubtag, props.CredId.dockercrid)
      }
    }
    
       stage ('Kube Deploy') {
      steps {
        kubeupdate(props.eks.eksregion, props.eks.ekscluster, props.CredId.awsid)
          }
    }  
    
      
   }
}
