FROM ubuntu:latest

WORKDIR /root
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -qqy update && \
    apt-get -qqy upgrade && \
    apt-get -qqy --no-install-recommends install \
    software-properties-common build-essential \
    wget git unzip openjdk-8-jdk -qqy


ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre" \
    PATH=$PATH:$JAVA_HOME/bin
ARG SDK_VERSION=sdk-tools-linux-3859397
ARG ANDROID_BUILD_TOOLS_VERSION=27.0.3
ARG ANDROID_PLATFORM_VERSION="android-28"

ENV SDK_VERSION=$SDK_VERSION \
    ANDROID_BUILD_TOOLS_VERSION=$ANDROID_BUILD_TOOLS_VERSION \
    ANDROID_HOME=/root

RUN wget -O tools.zip https://dl.google.com/android/repository/${SDK_VERSION}.zip && \
    unzip tools.zip && rm tools.zip && \
    chmod a+x -R $ANDROID_HOME && \
    chown -R root:root $ANDROID_HOME

ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin

# https://askubuntu.com/questions/885658/android-sdk-repositories-cfg-could-not-be-loaded
RUN mkdir -p ~/.android && \
    touch ~/.android/repositories.cfg && \
    echo y | sdkmanager "platform-tools" && \
    echo y | sdkmanager "build-tools;$ANDROID_BUILD_TOOLS_VERSION" && \
    echo y | sdkmanager "platforms;$ANDROID_PLATFORM_VERSION" && \
    echo y | sdkmanager "ndk-bundle"

ENV PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools

RUN add-apt-repository ppa:longsleep/golang-backports && \
    apt-get update && \
    apt-get install -y golang-go 

RUN go get golang.org/x/mobile/cmd/gomobile
ENV PATH=$PATH:/root/go/bin
RUN gomobile version
