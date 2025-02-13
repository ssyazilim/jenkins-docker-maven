#!/bin/bash

echo simple-java-app > /tmp/.auth
echo $BUILD_TAG >> /tmp/.auth
echo $PASS >> /tmp/.auth

scp -i /opt/java-deploy /tmp/.auth java-user@159.146.116.95:/tmp/.auth
scp -i /opt/java-deploy ./jenkins/deploy/publish.sh java-user@159.146.116.95:/tmp/publish.sh
ssh -i /opt/java-deploy java-user@159.146.116.95 "chmod +x /tmp/publish.sh && /tmp/publish.sh"
