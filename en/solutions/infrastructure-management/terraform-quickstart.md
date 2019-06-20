# Getting started with Terraform

Terraform allows you to quickly create a cloud infrastructure in Yandex.Cloud. The infrastructure components are identified through configuration files that specify the required cloud resources and their parameters.

Configurations for Terraform are written to `.tf` files in HashiCorp Configuration Language (HCL).

To install and configure Terraform and create your first configuration:

1. [Install Terraform](#install-terraform)
1. [Configure Terraform ](#configure-terraform)
1. [Configure provider](#configure-provider)
1. [Prepare an infrastructure plan](#prepare-plan)
1. [Create resources](#create-resources)
1. [Delete resources](#delete-resources)

## 1. Install Terraform {#install-terraform}

Install Terraform:

{% list tabs %}

- macOS
  
  Install Terraform via [Homebrew](https://brew.sh):
  
  ```
  $ brew install terraform
  ```
  
- Windows/Linux
  
  Download Terraform installer and follow the [instructions](https://www.terraform.io/intro/getting-started/install.html).
  
{% endlist %}

## 2. Configure Terraform {#configure-terraform}

Create a new directory anywhere and with any name, for example, `yandex-cloud-terraform`. It will store configuration files and saved Terraform and infrastructure states.

To create resources in Yandex.Cloud via Terraform, create a `.tf` configuration file in the new directory, for instance, `example.tf`.

## 3. Configure provider {#configure-provider}

At the beginning of the configuration file, specify the provider settings.

~~~
provider "yandex" {
  token     = "OAuth_token"
  cloud_id  = "cloud-id"
  folder_id = "folder-id"
  zone      = "ru-central1-a"
}
~~~

* `provider`: the provider name.
* `token`: the OAuth token used to access Yandex.Cloud.
* `cloud_id`: ID of the cloud in use.
* `folder_id`: ID of the folder where Terraform will create cloud resources.
* `zone`: the availability zone where all cloud resources will be created by default.

After configuration is completed, save the file and run the `terraform init` command in the folder with the configuration file. This command initializes the providers specified in the `provider` field of the `.tf` files and allows you to work with the provider's resources and data sources.

## 4. Prepare an infrastructure plan {#prepare-plan}

By using Terraform in Yandex.Cloud, you can create any types of cloud resources: VMs, disks, images, etc. For more information about resources that can be created via Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

To create a resource, specify a set of required and optional parameters that define the resource properties. Such resource descriptions make up an infrastructure plan.

Two VMs, `terraform1` and `terraform2`, as well as the `network-1` cloud network with the `subnet-1` subnet will be created according to the plan.

The VMs will have a different number of cores and amount of RAM: 1 core and 2 GB of RAM for `terraform1` and 2 cores and 4 GB of RAM for `terraform2`. The VMs will automatically get public and private IP addresses from the `192.168.10.0/24` range in the `subnet-1` subnet located in the `ru-central1-a` availability zone and belonging to the `network-1` cloud network. The Ubuntu OS will be installed on the VMs and the public part of the key used to access the VMs via SSH will be stored on them.

Resource configurations are specified immediately after the provider's configuration:

~~~
provider "yandex" {
  token     = "OAuth_token"
  cloud_id  = "cloud-id"
  folder_id = "folder-id"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"

  resources {
    cores  = 1
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd87va5cc00gaq2f5qfb"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name = "terraform2"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd87va5cc00gaq2f5qfb"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = "${yandex_compute_instance.vm-1.network_interface.0.ip_address}"
}

output "internal_ip_address_vm_2" {
  value = "${yandex_compute_instance.vm-2.network_interface.0.ip_address}"
}


output "external_ip_address_vm_1" {
  value = "${yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}"
}

output "external_ip_address_vm_2" {
  value = "${yandex_compute_instance.vm-2.network_interface.0.nat_ip_address}"
}
~~~

## 5. Create resources {#create-resources}

After the configuration is completed, run the `terraform plan` command. If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If there are errors in the configuration, Terraform will point them out. This is a verification stage, so no resources will be created.

{% note alert %}

All resources created via Terraform are charged, therefore check the plan carefully.

{% endnote %}

If there are no errors in the configuration, run the `terraform apply` command. Terraform will ask you to confirm the resource creation: type `yes` in the terminal and press Enter. After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check the availability of the resources and their settings in the [management console](https://console.cloud.yandex.ru).

## 6. Delete resources {#delete-resources}

To delete all resources created via Terraform, run the `terraform destroy` command. After the command has been executed, the terminal will display a list of resources that will be deleted. Type `yes` to confirm them and press Enter.

