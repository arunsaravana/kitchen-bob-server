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
// Checkout the Code From SCM    
     stage('SCM') {
        steps {
          mycodecheckout(branch: props.scm.branch , scmUrl: props.scm.repo) 
        }
     }
// Build the WAR file    
      stage('build') {
         steps {
                mybuild()
       
                  }
        }
     stage('JaCoCo') {
            steps {
                echo 'Code Coverage'
                jacoco(
               classPattern: '**/build/classes',
               sourcePattern: 'src/main/java',
               exclusionPattern: 'src/test*'
                )
            }
        }
 // Junit Test    
      stage('Junit Test') {
         steps {
                junittest(props.junitloc.testpath)
                   }
        }  
// Sonar Analysis
      stage('Sonar Analysis') {
         steps {
                         sonaranalysis(props.sonar.server, props.sonar.scanner, props.sonar.scannerproperties)
                   }
        } 
// Docker Build   
      stage ('Docker build') {
      steps {
        dockerbuild(props.dockerhub.hubuser, props.dockerhub.hubrepo, props.dockerhub.hubtag, props.CredId.dockercrid)
      }
    }
 // Kubernetes Deployment
       stage ('Kube Deploy') {
      steps {
        kubeupdate(props.eks.eksregion, props.eks.ekscluster, props.CredId.awsid)
          }
    }  
    
      
   }
}
