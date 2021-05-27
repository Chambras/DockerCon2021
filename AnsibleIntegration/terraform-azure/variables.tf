variable "location" {
  type        = string
  default     = "eastus2"
  description = "Location where the resoruces are going to be created."
}

variable "suffix" {
  type        = string
  default     = "MZV"
  description = "To be added at the beginning of each resource."
}

variable "mainRGName" {
  type        = string
  default     = "MZVMainNetwork"
  description = "Main Resource Group Name."
}

variable "devVMRGName" {
  type        = string
  default     = "devVM"
  description = "Dev VMs Resource Group Name."
}

variable "tags" {
  type = map(any)
  default = {
    "Environment" = "Demo"
    "Project"     = "DockerCon2021"
    "BillingCode" = "Internal"
    "Customer"    = "Docker"
  }
}

## Networking variables
variable "mainVNetName" {
  type        = string
  default     = "MZVMain"
  description = "Main VNet name."
}

variable "publicSubnetName" {
  type        = string
  default     = "public"
  description = "Public subname."
}

## Security variables
variable "sgName" {
  type        = string
  default     = "HTTPSSH_SG"
  description = "Default Security Group Name to be applied by default to VMs and subnets."
}

variable "sourceIPs" {
  type        = list(any)
  default     = ["173.66.216.193"]
  description = "Public IPs to allow inboud communications."
}

## Storage
variable "mainSA" {
  type        = string
  default     = "mzvmzvmainstoragelogs"
  description = "VM Logs Storage Account."
}

## VM
variable "vmUserName" {
  type        = string
  default     = "webAdmin"
  description = "Username to be added to the VM."
}

variable "sshKeyPath" {
  type        = string
  default     = "~/.ssh/vm_ssh.pub"
  description = "Public SSH Key to use when creating the VM."
  sensitive   = true
}

variable "sshPrvtKeyPath" {
  type        = string
  default     = "~/.ssh/vm_ssh"
  description = "Private SSH Key to use when creating the VM."
  sensitive   = false
}

variable "vmsku" {
  type        = string
  default     = "18.04-LTS"
  description = "Default VM SKU to be used in the VM."
}
