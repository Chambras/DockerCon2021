FROM ubuntu:18.04

ARG TRRFRM_VRSN=0.15.3
ARG TFLINT_VERSION=0.28.1
ARG TFLINT_AZURERM=0.9.1
ARG PCKR_VRSN=1.7.2
ARG CHF_VRSN=4.13.3
ARG MVN_VRSN=3.6.3
ARG BNT_VRSN=18.04
ARG DTNTCR_VRSN=2.2
ARG NDJS_VRSN=12
ARG PNJDK_VRSN=8
ARG KBCTL_VRSN=1.21.0
ARG HLM_VRSN=3.5.4
ARG BDWLF_VRSN=1.6.0
ARG G_VRSN=1.16.3
ARG GH_VRSN=1.9.2
ARG PWRSHLL_VRSN=7.0.0

WORKDIR /tools

# Copy the current directory contents into the container at /tools
COPY . /tools

# groff is added so aws cli help would work properly.
# if not you get this error:
# Could not find executable named "groff"

RUN apt-get update && apt-get install -y \
  software-properties-common \
  apt-transport-https \
  wget \
  jq \
  unzip \
  tmux \
  tree \
  curl \
  vim \
  groff \
  python \
  python-pip \
  openjdk-${PNJDK_VRSN}-jdk

# Maven
RUN wget -q https://www-us.apache.org/dist/maven/maven-3/${MVN_VRSN}/binaries/apache-maven-${MVN_VRSN}-bin.zip \
  && unzip apache-maven-${MVN_VRSN}-bin.zip \
  && mv apache-maven-${MVN_VRSN}/ /opt/apache-maven/

# Packer
RUN wget -q https://releases.hashicorp.com/packer/${PCKR_VRSN}/packer_${PCKR_VRSN}_linux_amd64.zip \
  && unzip packer_${PCKR_VRSN}_linux_amd64.zip \
  && mv packer /usr/bin \
  && rm packer_${PCKR_VRSN}_linux_amd64.zip

# Terraform
RUN wget -q https://releases.hashicorp.com/terraform/${TRRFRM_VRSN}/terraform_${TRRFRM_VRSN}_linux_amd64.zip \
  && unzip terraform_${TRRFRM_VRSN}_linux_amd64.zip \
  && mv terraform /usr/bin \
  && wget -q https://github.com/wata727/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip \
  && unzip tflint_linux_amd64.zip \
  && mv tflint /usr/local/bin \
  && rm terraform_${TRRFRM_VRSN}_linux_amd64.zip \
  && rm tflint_linux_amd64.zip \
  && mkdir -p /root/.tflint.d/plugins \
  && wget -q https://github.com/terraform-linters/tflint-ruleset-azurerm/releases/download/v${TFLINT_AZURERM}/tflint-ruleset-azurerm_linux_amd64.zip \
  && unzip tflint-ruleset-azurerm_linux_amd64.zip -d ~/.tflint.d/plugins/ \
  && rm tflint-ruleset-azurerm_linux_amd64.zip

# Requirement to install dotnet core 2.2
RUN wget -q https://packages.microsoft.com/config/ubuntu/${BNT_VRSN}/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && add-apt-repository universe 

# Requirement to install git and ansible 
RUN add-apt-repository ppa:git-core/ppa \
  && add-apt-repository ppa:ansible/ansible

# Requirement to install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_${NDJS_VRSN}.x | bash -

RUN apt update && apt install -y \
  git \
  dotnet-sdk-${DTNTCR_VRSN} \
  nodejs \
  ansible

# Config Files
RUN mv Configs/bash/.bash_aliases /root/ \
  && mv Configs/bash/.bashrc /root/ \
  && mv Configs/bash/.profile /root/ \
  && mv Configs/bash/.banner.rc /root/ \
  && mv Configs/bash/.bashprompt.rc /root/ \
  && mv Configs/git/.gitconfig /root/ 

# Terraform Providers
RUN wget --quiet -i providers.txt \
  && unzip '*.zip' \
  && rm *.zip \
  && mkdir /root/.terraform.d \
  && mkdir /root/.terraform.d/plugin-cache \
  && mkdir /root/.terraform.d/plugin-cache/linux_amd64 \
  && mv terraform-provider-* /root/.terraform.d/plugin-cache/linux_amd64/ \
  && mv Configs/terraform/.terraformrc /root/

# Chef
RUN wget --quiet https://packages.chef.io/files/stable/chefdk/${CHF_VRSN}/ubuntu/${BNT_VRSN}/chefdk_${CHF_VRSN}-1_amd64.deb \ 
  && dpkg -i chefdk_${CHF_VRSN}-1_amd64.deb \ 
  && rm chefdk_${CHF_VRSN}-1_amd64.deb

# Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash 

# AWS CLI
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
  && unzip awscli-bundle.zip \
  && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
  && rm awscli-bundle.zip \
  && mkdir /root/.aws \
  && mv Configs/aws/config /root/.aws/ \
  && mv Configs/aws/credentials /root/.aws/

# GCP CLI
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  apt-get update -y && apt-get install google-cloud-sdk -y \
  && mkdir /root/.gcp \
  && mv Configs/gcp/marcelocli.json /root/.gcp/ 

# Kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KBCTL_VRSN}/bin/linux/amd64/kubectl \
  && chmod +x kubectl \
  && mv kubectl /usr/local/bin/kubectl

# Helm
RUN wget -q https://get.helm.sh/helm-v${HLM_VRSN}-linux-amd64.tar.gz \
  && tar -xvf helm-v${HLM_VRSN}-linux-amd64.tar.gz \
  && mv linux-amd64/helm /usr/local/bin/ \
  && rm helm-v${HLM_VRSN}-linux-amd64.tar.gz \
  && rm -r linux-amd64/

# Databricks CLI
RUN pip install databricks-cli \
  && mv Configs/databricks/.databrickscfg /root/

# Vim Theme
RUN wget https://github.com/sjl/badwolf/archive/v${BDWLF_VRSN}.zip \
  && unzip v${BDWLF_VRSN}.zip \
  && mkdir /root/.vim \
  && mkdir /root/.vim/colors \
  && cp badwolf-${BDWLF_VRSN}/colors/badwolf.vim /root/.vim/colors/ \
  && cp Configs/vim/.vimrc /root/ \
  && rm v${BDWLF_VRSN}.zip \
  && rm -r badwolf-${BDWLF_VRSN}

# go
RUN wget -q https://dl.google.com/go/go${G_VRSN}.linux-amd64.tar.gz \
  && tar -C /opt -xzf go${G_VRSN}.linux-amd64.tar.gz \
  && rm go${G_VRSN}.linux-amd64.tar.gz

# Powershell
RUN wget -q https://github.com/PowerShell/PowerShell/releases/download/v${PWRSHLL_VRSN}/powershell-lts_${PWRSHLL_VRSN}-1.ubuntu.${BNT_VRSN}_amd64.deb \
  && dpkg -i powershell-lts_${PWRSHLL_VRSN}-1.ubuntu.${BNT_VRSN}_amd64.deb \
  && rm powershell-lts_${PWRSHLL_VRSN}-1.ubuntu.${BNT_VRSN}_amd64.deb

# GitHub CLI
RUN wget -q https://github.com/cli/cli/releases/download/v${GH_VRSN}/gh_${GH_VRSN}_linux_amd64.deb \
  && dpkg -i gh_${GH_VRSN}_linux_amd64.deb \
  && mkdir /root/.config/gh \
  && mv Configs/git/config.yml /root/.config/gh/ \
  && mv Configs/git/hosts.yml /root/.config/gh/ \
  && rm gh_${GH_VRSN}_linux_amd64.deb

WORKDIR /root

#Doing some cleaning
RUN  rm -r /tools/  \
  && rm -rf /var/lib/apt/lists/*

ENV M2_HOME "/opt/apache-maven"
ENV MAVEN_HOME "/opt/apache-maven"
ENV JAVA_HOME "/usr/lib/jvm/java-11-openjdk-amd64"
ENV PATH "${M2_HOME}/bin:${JAVA_HOME}/bin:/opt/go/bin:${PATH}"

# Setting Azure related Environment variables
ENV ARM_TENANT_ID ""
ENV ARM_SUBSCRIPTION_ID ""
ENV ARM_CLIENT_ID ""
ENV ARM_CLIENT_CERTIFICATE_PATH ""
ENV ARM_CLIENT_CERTIFICATE_PEM_PATH ""
ENV ARM_CLIENT_CERTIFICATE_PASSWORD ""
ENV ARM_CLIENT_SECRET ""
ENV ARM_ENVIRONMENT public
ENV DEV_ENVIRONMENT "Demo-Staging"


ENV GOOGLE_APPLICATION_CREDENTIALS "~/.gcp/marcelocli.json"
