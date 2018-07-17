def server = Artifactory.server 'art'
def uploadSpec = """{
  "files": [
    {
      "pattern": "target/*.jar",
      "target": "demo/${BUILD_ID}"
    }
 ]
}"""
node {
   def mvnHome
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/KuzmaTolyanuch/Demo-rpm'
      // Get the Maven tool.
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.           
      mvnHome = tool 'Maven-local'
   }
   stage('Build') {
      // Run the maven build
      if (isUnix()) {
         sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean install"
      } else {
         bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
         server.upload(uploadSpec)
      }
   }
   stage('Docker build') {
     docker.withRegistry('http://192.168.100.10:5000') {
     def DockerImage = docker.build("java-app")
   }
   stage('Push container to Registry')
        DockerImage.push()
   }
}
