# Author: Qasim Shahid
# Here are some common commands that you will need when setting up your EC2 instances. 
# Do not execute this file on its own, rather copy and paste the commands that you need.

# Updating everything 
sudo apt-get update
sudo apt-get upgrade

# Install docker on your EC2 instance (Ubuntu)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install kubectl on your EC2 instance (Ubuntu)
sudo snap install kubectl --classic

# Deploy rancher
sudo docker run --privileged -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher


# For Jenkins, you will need Java
sudo apt update
sudo apt install fontconfig openjdk-17-jre

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

# You need to get these plugins: 
# - Kubernetes CLI
# - Github
# - Docker CLI

sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

# To get the password for Jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# For issues with docker build on jenkins
sudo usermod -a -G docker jenkins
sudo systemctl restart jenkins


