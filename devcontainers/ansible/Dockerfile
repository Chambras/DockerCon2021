FROM ubuntu:18.04

ARG TRRFRM_VRSN=0.15.3
ARG TFLINT_VERSION=0.28.1
ARG TFLINT_AZURERM=0.9.1
ARG BNT_VRSN=18.04
ARG BDWLF_VRSN=1.6.0
ARG GH_VRSN=1.9.2

WORKDIR /tools

# Copy the current directory contents into the container at /tools
COPY . /tools

RUN apt-get update && apt-get install -y \
  software-properties-common \
  apt-transport-https \
  wget \
  jq \
  unzip \
  tmux \
  tree \
  curl \
  vim 

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

# Requirement to install git and ansible 
RUN add-apt-repository ppa:git-core/ppa \
  && add-apt-repository ppa:ansible/ansible

RUN apt update && apt install -y \
  git \
  ansible

# Config Files
RUN mv Configs/bash/.bash_aliases /root/ \
  && mv Configs/bash/.bashrc /root/ \
  && mv Configs/bash/.profile /root/ \
  && mv Configs/bash/.banner.rc /root/ \
  && mv Configs/bash/.bashprompt.rc /root/ 

# Terraform Providers
RUN wget --quiet -i providers.txt \
  && unzip '*.zip' \
  && rm *.zip \
  && mkdir /root/.terraform.d \
  && mkdir /root/.terraform.d/plugin-cache \
  && mkdir /root/.terraform.d/plugin-cache/linux_amd64 \
  && mv terraform-provider-* /root/.terraform.d/plugin-cache/linux_amd64/ \
  && mv Configs/terraform/.terraformrc /root/

# Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash 

# Vim Theme
RUN wget https://github.com/sjl/badwolf/archive/v${BDWLF_VRSN}.zip \
  && unzip v${BDWLF_VRSN}.zip \
  && mkdir /root/.vim \
  && mkdir /root/.vim/colors \
  && cp badwolf-${BDWLF_VRSN}/colors/badwolf.vim /root/.vim/colors/ \
  && cp Configs/vim/.vimrc /root/ \
  && rm v${BDWLF_VRSN}.zip \
  && rm -r badwolf-${BDWLF_VRSN}

# GitHub CLI
RUN wget -q https://github.com/cli/cli/releases/download/v${GH_VRSN}/gh_${GH_VRSN}_linux_amd64.deb \
  && dpkg -i gh_${GH_VRSN}_linux_amd64.deb \
  && rm gh_${GH_VRSN}_linux_amd64.deb

WORKDIR /root

#Doing some cleaning
RUN  rm -r /tools/  \
  && rm -rf /var/lib/apt/lists/*

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
