//Test for checkin
catchError {
    node ('sl-vm') {  
		stage('checkout') {
			checkout scm
		}
		stage('zip') {
			bat "powershell.exe -command get-service"
		}
    }
}

// currentBuild.result is only set for failures so if it's null, set it to SUCCESS.
// Otherwise, the "back to normal" emails won't get sent after a failed build gets fixed.
// Jenkins bug: https://issues.jenkins-ci.org/browse/JENKINS-37171
node('sl-vm') {
    if (!currentBuild.result)
    {
        currentBuild.result = 'SUCCESS'
    }
}
