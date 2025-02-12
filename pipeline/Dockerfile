FROM jenkins/jenkins
 
USER root
 
# Install python3
RUN apt-get update && apt-get install -y python3 python3-pip
 
# Install ansible
RUN python3 -m pip install ansible --break-system-packages
 
# Install Docker
RUN apt-get update -y

RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

RUN mkdir -p /etc/apt/keyrings

RUN  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update

RUN apt-get install -y docker-ce docker-ce-cli containerd.io

RUN usermod -aG docker jenkins

USER jenkins
