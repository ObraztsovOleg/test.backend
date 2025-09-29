def onDistrib(app, distr) {
    withMaven(jdk: 'openjdk-17', maven: 'Maven 3.8.4', mavenSettingsConfig: 'settings') {
        sh """
            mvn clean install -U -P build-config,spring
            touch test-db.zip
            touch pom-test.xml sdk-test.txt
        """

    env.CHECK_ENV_STEP = "check"
    
    if(!app.sonarSkip?.toBoolean()) {
            sh """
                mvn sonar:sonar -Dsonar.projectKey=test.app.backend -Dsonar.host.url=https://sberworks.ru/sonar -Dsonar.login=9e396cf430a5278f26e81f350d6cd19136f686b2 -Dsonar.branch.name=${SONAR_BRANCH} --errors
                mv target/sonar ./
            """
        }
        distr.addSdkMvn ("pom-test.xml", "sdk-test.txt")
        distr.addDB ('test-db.zip')
        distr.addBH ("target/*.war")
        distr.addBH ("mod/module_test/*")
        distr.addConf("target/conf/*")

        sh 'mvn clean'
    }
}

return wrapJenkinsfile(this)
