# Nginx

Demo Ansible Playbook used at DockerCon2021 that deploys a Nginx server and a test web page.

## Project Structure

```ssh
.
├── LICENSE
├── README.md
├── ansible
│   └── nginxServer
│       ├── LICENSE
│       ├── README.md
│       ├── ansible.cfg
│       ├── hosts
│       ├── nginx_web.yml
│       └── roles
│           └── install
│               ├── defaults
│               │   └── main.yml
│               ├── files
│               │   └── Docker2021-logo.png
│               ├── handlers
│               │   └── main.yml
│               ├── tasks
│               │   └── main.yml
│               └── templates
│                   └── index.html.j2
```

## Requirements

### Platform Support

- RHEL 7.x
- CentOS 7.x

### Versions

- ansible 2.9.22

### Authentication

It uses key based authentication and it assumes you already have a key and you can configure the path using the _ansible_ssh_private_key_file_ variable in _`hosts`_ file.
You can create one using this command:

```ssh
ssh-keygen -t rsa -b 4096 -m PEM -C vm@mydomain.com -f ~/.ssh/vm_ssh
```

## Usage

Terraform uses the [local-exec provisioner](https://www.terraform.io/docs/language/resources/provisioners/local-exec.html) in order to execute this ansible playbook, but If you want to use separately, you can use these commands.

```ssh
ansible-playbook --syntax-check nginx_web.yml
ansible-playbook nginx_web.yml
```

## HOSTS file

The _`hosts`_ file is the inventory file where you need to provide the IPs of the servers that need to be configured. You can also configure the SSH Key to use, username and SSH port.

## Authors

Marcelo Zambrana
