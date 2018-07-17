def server = Artifactory.server 'art'
def uploadSpec = """{
  "files": [
    {
      "pattern": "target/*.jar",
      "target": "demo"
    }
 ]
}"""
node {
   def mvnHome
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/KuzmaTolyanuch/demo.git'
      // Get the Maven tool.
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.           
      mvnHome = tool 'Maven-local'
   }
   stage('Build') {
      // Run the maven build
      if (isUnix()) {
         sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
      } else {
         bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
      }
   }
   stage('Build Results') {
      junit '**/target/surefire-reports/TEST-*.xml'
      archive 'target/*.jar'
      server.upload(uploadSpec)
   }
}
   stage('Docker image Build') {
      def testImage = docker.build("java-image") 
\\      testImage.inside {
\\      sh 'make test'    
   }
}
