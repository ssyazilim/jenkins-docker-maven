#!/bin/bash

IMAGE="simple-java-app"

echo "************************"
echo "*** Login the account **"
echo "************************"

docker login -u davidmashadow -p $PASS

echo "************************"
echo "**** Push the Image ****"
echo "************************"

docker tag $IMAGE:$BUILD_TAG davidmashadow/$IMAGE:$BUILD_TAG
docker push davidmashadow/$IMAGE:$BUILD_TAG
