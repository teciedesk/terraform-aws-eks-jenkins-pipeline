FROM jenkins/inbound-agent:latest

USER root

# Install necessary tools
RUN apt-get update && \
    apt-get install -y wget unzip curl && \
    wget https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip && \
    unzip terraform_1.0.11_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_1.0.11_linux_amd64.zip && \
    terraform -version

# Optional: Install AWS CLI, kubectl, Helm, etc.
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws && \
    aws --version

USER jenkins
