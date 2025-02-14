#!/bin/bash

echo "********************"
echo "*** Bulding jar ****"
echo "********************"

WORKSPACE=/home/jenkins/jenkins-docker-maven/jenkins_home/workspace/pipeline-maven-project

docker run --rm -v $WORKSPACE/java-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3-alpine "$@"
