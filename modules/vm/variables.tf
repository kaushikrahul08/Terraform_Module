variable "rg_name" {
    type = string
}

variable "location" {
    type = string
}

variable "vnet_name" {
    type = string
}

variable "address_space" {
    type = string
  }

variable "address_prefixes" {
  type = string
}
variable "subnet_name" {
}

variable "nic_name" {
    type = string
  
}
variable "ssh_public_key" {
  
}


variable "ip_config_name" {
}

variable "pri_ip_alloc" {
}

variable "vm_name" {
}

variable "vm_size" {
}

variable "admin_username" {
}

variable "disk_caching" {
}

variable "sa_type" {
}

variable "src_img_pub" {
}

variable "src_img_offer" {
}

variable "src_img_sku" {
}

variable "src_img_ver" {
}

variable "tags" {
  
}