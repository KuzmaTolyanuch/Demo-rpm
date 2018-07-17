def server = Artifactory.server 'Art'
def uploadSpec = """{
  "files": [
    {
      "pattern": "target/*.jar",
      "target": "megamaven"
    }
 ]
}"""
node {
   def mvnHome
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/oleksandr-parshykov/megalab'
      // Get the Maven tool.
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.           
      mvnHome = tool 'M3'
   }
   stage('Build with mvn') {
      // Run the maven build
      if (isUnix()) {
         sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean install"
      } else {
         bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
         server.upload(uploadSpec)
      }
   }
   stage('Results') {
      junit '*/target/surefire-reports/TEST-*.xml'
      archive 'target/*.jar'
   }
   stage('Docker build') {
      def testImage = docker.build("java-image") 
      testImage.inside {
      sh 'make test'    
   }
}
