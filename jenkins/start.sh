nohup java -jar /usr/share/jenkins/jenkins.war &
while [ $(curl -s http://localhost:8080/login | grep "Unlock";echo $?) -ne 0 ]
do
	sleep 10s
	echo "waiting for jenkins to be up..."
done
sleep 5s
export PASSWORD=$(cat /root/.jenkins/secrets/initialAdminPassword)
curl -u admin:$PASSWORD http://localhost:8080/jnlpJars/jenkins-cli.jar -o /tmp/jenkins-cli.jar
export PLUGINS="jdk-tool script-security command-launcher jackson2-api bouncycastle-api github-api structs workflow-step-api workflow-scm-step credentials apache-httpcomponents-client-4-api ssh-credentials jsch git-client scm-api display-url-api mailer workflow-api junit matrix-project git token-macro plain-credentials github pipeline-milestone-step jquery-detached ace-editor workflow-support workflow-cps pipeline-input-step pipeline-stage-step workflow-job pipeline-graph-analysis pipeline-rest-api handlebars momentjs pipeline-stage-view pipeline-build-step credentials-binding pipeline-model-api pipeline-model-extensions cloudbees-folder git-server workflow-cps-global-lib branch-api workflow-multibranch authentication-tokens docker-commons durable-task workflow-durable-task-step workflow-basic-steps docker-workflow pipeline-stage-tags-metadata pipeline-model-declarative-agent pipeline-model-definition workflow-aggregator ssh-slaves docker-java-api docker-plugin"
for i in $PLUGINS
do
java -jar /tmp/jenkins-cli.jar -s http://localhost:8080 -auth admin:$PASSWORD install-plugin http://ftp-nyc.osuosl.org/pub/jenkins/plugins/$i/latest/$i.hpi -deploy
done
java -jar /tmp/jenkins-cli.jar -s http://localhost:8080 -auth admin:$PASSWORD restart
while [ $(curl -s http://localhost:8080/login | grep "Unlock";echo $?) -ne 0 ]
do
	sleep 10s
	echo "restarting jenkins after deploying plugins..."
done
sleep 5s
echo "creating a credential in jenkins..."
cat /tmp/mysec.xml | java -jar /tmp/jenkins-cli.jar -s http://localhost:8080 -auth admin:$PASSWORD create-credentials-by-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "(global)"
rm -rf /tmp/mysec.xml
echo "creating firstjob"
java -jar /tmp/jenkins-cli.jar -s http://localhost:8080 -auth admin:$PASSWORD create-job firstjob < /tmp/sample.xml
tail -f /dev/null
