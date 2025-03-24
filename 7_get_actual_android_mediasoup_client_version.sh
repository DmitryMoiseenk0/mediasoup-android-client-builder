#!/bin/bash

if [[ -d ./mediasoup-client-android ]]
then
    echo "Mediasoup-client-android exists"
else
    # Increase the Git buffer size to the largest individual file size of repo
    # https://confluence.atlassian.com/bitbucketserverkb/git-push-fails-fatal-the-remote-end-hung-up-unexpectedly-779171796.html
    git config --global http.postBuffer 157286400
    
    echo "Mediasoup-client-android downloading"
    git clone https://github.com/DmitryMoiseenk0/mediasoup-client-android.git
fi

cd $SCRIPT_DIR/mediasoup-client-android

echo "Checkout $VERSION_BRANCH in Mediasoup-client-android"

VERSION_BRANCH="version/$MEDIASOUP_ANDROID_CLIENT_VERSION_NAME"
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

git fetch

if [[ "$CURRENT_BRANCH" == "$VERSION_BRANCH" ]]
then
    echo "$VERSION_BRANCH Branch already exists"
else
    git checkout -fB $VERSION_BRANCH origin/$VERSION_BRANCH
fi