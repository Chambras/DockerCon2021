# Docker Dev Environment

Docker File used during DockerCon 2021.
The purpose of this Docker file is to create a Development environment with a variatiry of tools and configurations.
It is meant to be easy to use and destroy specially if you want to test a new version or a preview version without having do mess up with your current development environment.

You can connect your VSCode to this Docker container using the VSCode remote extension and you should be able to develop using all these tools.

## Tools

- Terraform
- Terraform providers
  - azurerm
  - google
  - aws
  - random
  - null
  - local
  - template
- Packer
- ChefDK
- Ansible
- Apache Maven
- Dotnet core
- Git
- NodeJS
- npm
- Azure CLI
- GCloud CLI
- AWS CLI
- Wget
- Unzip
- Tmux
- Tree
- Curl
- Vim
  - badwolf.vim theme
- Python
- pip
- Open-JavaJDK
- Kubectl
- Helm
- DataBricks CLI
- go

## Configs

Along with installing all tools it also configures:

- .bash_aliases
- .gitconfig
- .terraformrc
- .databrickscfg
- .vimrc

It also sets and updates the following Environment Variables:

- M2_HOME
- MAVEN_HOME
- JAVA_HOME
- PATH
- ARM_TENANT_ID
- ARM_SUBSCRIPTION_ID
- ARM_CLIENT_ID
- ARM_CLIENT_CERTIFICATE_PATH
- ARM_CLIENT_CERTIFICATE_PEM_PATH
- ARM_CLIENT_CERTIFICATE_PASSWORD
- ARM_ENVIRONMENT
- GOOGLE_APPLICATION_CREDENTIALS

## Parameters

You can customize the versions you want to install using the following Docker arguments:

```ssh
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
```

They are set with some default values.

For terraform providers you can add and set the versions you want to use in `providers.txt` file.

## Requirements

Right now the Docker file uses an **Ubuntu** image and all the configurations are Ubuntu based. In the future I might think on supporting RedHat, CentOS and maybe Windows.

### Versions

- Docker version 20.10.6

## Project Structure

```ssh
.
├── Configs
│   ├── aws
│   │   ├── config
│   │   └── credentials
│   ├── bash
│   ├── databricks
│   ├── gcp
│   │   └── marcelocli.json
│   ├── git
│   │   ├── config.yml
│   │   └── hosts.yml
│   ├── terraform
│   └── vim
├── Dockerfile
├── LICENSE
├── README.md
└── providers.txt
```

## Build Container

```ssh
docker build -t personal/devEnvironment:latest .
```

## Run Container in interactive mode

```ssh
docker run -it --rm --name personalDev -t personal/devEnvironment:latest
```

## Authors

- Marcelo Zambrana
