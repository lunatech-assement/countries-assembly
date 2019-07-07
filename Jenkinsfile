node(label:'docker'){

def img

try{
   stage('Scm Checkout'){
       checkout scm
   }
   
   stage('Build Docker Image'){
    // Here the tag is 1.0.2 same as jar, I did not use the dynamic taging as the jar is already given it is not building dynamically.
    img = docker.build('shah1992/countries-assembly:1.0.2')
   }
 
docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {

stage("Publish to Docker Hub") {
    println("inside Publish stage")
    img.push()
    } 
}

withAWS(credentials: 'aws-shahrukh', region: 'us-east-1') {
    stage("Task definition") {
    sh 'aws ecs register-task-definition --cli-input-json file://countries.json'
    } 

    stage('Create Service'){
        sh 'aws ecs create-service --cli-input-json file://countries-service.json'
    }
}
}
   catch(err) {
        currentBuild.result = 'FAILED'
        println(err.toString())
        println(err.getMessage())
    }
    finally {
        stage('Clean up') {
            cleanWs()
        }
    }



}