# Uploading {{ TF }} states to Object Storage

The instructions describe the steps for uploading a {{ TF }} state to [{{ objstorage-full-name }}](../../storage/).

A {{ TF }} state describes the current deployed infrastructure and is stored in files with the `.tfstate` extension. The state file is created after the infrastructure is deployed and can be immediately uploaded to {{ objstorage-name }}. The uploaded state file is updated as the infrastructure you created changes.

In this example, the saved state lets other users get the ID of one of the created subnets to connect a new VM to it.

To configure {{ TF }} state storage in {{ objstorage-name }} and use it to create new resources:

1. [Prepare your cloud](#before-you-begin).
{% if product == "yandex-cloud" %}1. [Required paid resources](#paid-resources).{% endif %}
1. [Install {{ TF }}](#install-terraform).
1. [Create a {{ TF }} configuration file](#configure-terraform).
1. [Configure a provider](#configure-provider).
1. [Create a service account and static access key](#create-service-account).
1. [Create a bucket](#create-service-account).
1. [Configure the backend](#set-up-backend).
1. [Deploy the configuration](#deploy).
1. [Check the saved state](#set-up-backend).
1. [Retrieve the state from the backend](#retrieve-state).

If you no longer need these resources, [delete them](#clear-out).

{{ TF }} and its providers are distributed under the [Mozilla Public License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

{% note alert %}

All resources created using {{ TF }} are chargeable. Please, make sure to check the configurations you are creating now.

{% endnote %}

In this scenario, you create three VMs with public IP addresses, a virtual network, and two subnets.

The cost of supporting this infrastructure includes:

* Data storage fees (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-storage)).
* A fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

{% endif %}

## Install {{ TF }} {#install-terraform}

{% include [terraform-install](../../_tutorials/terraform-install.md) %}

## Create a {{ TF }} configuration file {#configure-terraform}

1. Create a directory with any name, for example, `cloud-terraform`. It will store the {{ TF }} configuration files.
1. Create a configuration file with the `.tf` extension in this directory, for example, `example.tf`.

## Configure a provider {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/terraform-configure-provider.md) %}

## Create a service account and static access key {#create-service-account}

1. [Create a service account](../../iam/operations/sa/create.md) with the [`editor`](../../iam/concepts/access-control/roles.md#editor) role for the folder specified in the provider settings.
1. [Get a static access key](../../iam/operations/sa/create-access-key.md). Save the key ID and secret key: you will need them in the next steps.

## Create a bucket {#create-service-account}

[Create a bucket](../../storage/operations/buckets/create.md) with any name, for example, `terraform-object-storage-tutorial`. It stores the {{ TF }} state file.

## Configure the backend {#set-up-backend}

To save the {{ TF }} state in {{ objstorage-name }}, specify settings for the provider and backend:

{% if product == "yandex-cloud" %}

```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoint   = "{{ s3-storage-host }}"
    bucket     = "<bucket name>"
    region     = "{{ region-id }}"
    key        = "<path to state file in the bucket>/<state file name>.tfstate"
    access_key = "<static key ID>"
    secret_key = "<secret key>"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token     = "<OAuth or static key of the service account>"
  cloud_id  = "<cloud ID>"
  folder_id = "<folder ID>"
  zone      = "<default availability zone>"
}
```

{% endif %}

{% if product == "cloud-il" %}

```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoint   = "{{ s3-storage-host }}"
    bucket     = "<bucket name>"
    region     = "{{ region-id }}"
    key        = "<path to state file in the bucket>/<state file name>.tfstate"
    access_key = "<static key ID>"
    secret_key = "<secret key>"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  endpoint  = "{{ api-host }}:443"
  token     = "<static key of the service account>"
  cloud_id  = "<cloud ID>"
  folder_id = "<folder ID>"
  zone      = "<default availability zone>"
}
```

{% endif %}

To read more about the state storage backend, see the [{{ TF }} site](https://www.terraform.io/docs/backends/types/s3.html).

## Deploy the configuration {#deploy}

In this example, two VMs are created: `terraform1` and `terraform2`. They will be connected to `subnet-1` in the `{{ region-id }}-a` availability zone. The subnet be in the `network-1` cloud network.

The VMs have a different number of cores and amount of RAM: 1 core and 2 GB of RAM for `terraform1` and 2 cores and 4 GB of RAM for `terraform2`. The machines will automatically get public IP addresses and private IP addresses from the range `192.168.10.0/24` in `subnet-1`. The Ubuntu OS will be installed on the VMs and the public part of the key used to access the VMs via {% if lang == "ru" and audience != "internal" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %} will be stored on them.

1. Save the following configuration to `example.tf`:

   {% if product == "yandex-cloud" %}

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }

     backend "s3" {
       endpoint   = "{{ s3-storage-host }}"
       bucket     = "<bucket name>"
       region     = "{{ region-id }}"
       key        = "<path to the state file in the bucket>/<state file name>.tfstate"
       access_key = "<ID of the static key>"
       secret_key = "<secret key>"

       skip_region_validation      = true
       skip_credentials_validation = true
     }
   }

   provider "yandex" {
     token     = "<OAuth or static key of the service account>"
     cloud_id  = "<cloud ID>"
     folder_id = "<folder ID>"
     zone      = "{{ region-id }}-a"
   }

   resource "yandex_compute_image" "ubuntu_2004" {
     source_family = "ubuntu-2004-lts"
   }

   resource "yandex_compute_instance" "vm-1" {
     name = "terraform1"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       initialize_params {
         image_id = yandex_compute_image.ubuntu_2004.id
       }
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
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
         image_id = yandex_compute_image.ubuntu_2004.id
       }
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
     }
   }

   resource "yandex_vpc_network" "network-1" {
     name = "network1"
   }

   resource "yandex_vpc_subnet" "subnet-1" {
     name           = "subnet1"
     zone           = "{{ region-id }}-a"
     network_id     = yandex_vpc_network.network-1.id
     v4_cidr_blocks = ["192.168.10.0/24"]
   }

   output "internal_ip_address_vm_1" {
     value = yandex_compute_instance.vm-1.network_interface.0.ip_address
   }

   output "internal_ip_address_vm_2" {
     value = yandex_compute_instance.vm-2.network_interface.0.ip_address
   }

   output "external_ip_address_vm_1" {
     value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
   }

   output "external_ip_address_vm_2" {
     value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
   }

   output "subnet-1" {
     value = yandex_vpc_subnet.subnet-1.id
   }
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }

     backend "s3" {
       endpoint   = "{{ s3-storage-host }}"
       bucket     = "<bucket name>"
       region     = "{{ region-id }}"
       key        = "<path to the state file in the bucket>/<name of the state file>.tfstate"
       access_key = "<ID of the static key>"
       secret_key = "<secret key>"

       skip_region_validation      = true
       skip_credentials_validation = true
     }
   }

   provider "yandex" {
     endpoint  = "{{ api-host }}:443"
     token     = "<static key of the service account>"
     cloud_id  = "<cloud ID>"
     folder_id = "<folder ID>"
     zone      = "{{ region-id }}-a"
   }

   resource "yandex_compute_instance" "vm-1" {
     name = "terraform1"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       initialize_params {
         image_id = "fd87va5cc00gaq2f5qfb"
       }
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
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
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
     }
   }

   resource "yandex_vpc_network" "network-1" {
     name = "network1"
   }

   resource "yandex_vpc_subnet" "subnet-1" {
     name           = "subnet1"
     zone           = "{{ region-id }}-a"
     network_id     = yandex_vpc_network.network-1.id
     v4_cidr_blocks = ["192.168.10.0/24"]
   }

   output "internal_ip_address_vm_1" {
     value = yandex_compute_instance.vm-1.network_interface.0.ip_address
   }

   output "internal_ip_address_vm_2" {
     value = yandex_compute_instance.vm-2.network_interface.0.ip_address
   }

   output "external_ip_address_vm_1" {
     value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
   }

   output "external_ip_address_vm_2" {
     value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
   }

   output "subnet-1" {
     value = yandex_vpc_subnet.subnet-1.id
   }
   ```

   {% endif %}

1. Check the configuration using the `terraform plan` command.
1. Expand the configuration using the `terraform apply` command.

## Check the saved state {#set-up-backend}

Make sure that the state file is uploaded to {{ objstorage-name }}:

1. Open the [management console]({{ link-console-main }}) and select the folder with the bucket created.
1. Select **{{ objstorage-name }}**.
1. From the bucket list, select the bucket you saved the {{ TF }} state to.
1. Make sure that the state file is in the bucket.

## Retrieve the state from the backend {#retrieve-state}

You can request the {{ objstorage-name }} state saved in {{ TF }} from another configuration to expand the infrastructure you created.

Create another configuration and use the saved state to create another VM in one of the existing subnets:

1. Create the `remote-state` directory.
1. Go to the created directory and create the configuration file `remote-state.tf`:

   {% if product == "yandex-cloud" %}

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
   }

   provider "yandex" {
     token     = "<OAuth or static key of the service account>"
     cloud_id  = "cloud-id"
     folder_id = "folder-id"
     zone      = "{{ region-id }}-a"
   }

   data "terraform_remote_state" "vpc" {
     backend = "s3"
     config = {
       endpoint   = "{{ s3-storage-host }}"
       bucket     = "<bucket name>"
       region     = "{{ region-id }}"
       key        = "<path to state file in the bucket>/<name of the state file>.tfstate"
       access_key = "<ID of the static key>"
       secret_key = "<secret key>"

       skip_region_validation      = true
       skip_credentials_validation = true
     }
   }

   resource "yandex_compute_instance" "vm-3" {
     name = "terraform3"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       initialize_params {
         image_id = "fd87va5cc00gaq2f5qfb"
       }
     }

     network_interface {
       subnet_id = data.terraform_remote_state.vpc.outputs.subnet-1
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
     }
   }
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
   }

   provider "yandex" {
     endpoint  = "{{ api-host }}:443"
     token     = "<static key of the service account>"
     cloud_id  = "cloud-id"
     folder_id = "folder-id"
     zone      = "{{ region-id }}-a"
   }

   data "terraform_remote_state" "vpc" {
     backend = "s3"
     config = {
       endpoint   = "{{ s3-storage-host }}"
       bucket     = "<bucket name>"
       region     = "{{ region-id }}"
       key        = "<path to the state file in the bucket>/<name of the state file>.tfstate"
       access_key = "<ID of the static key>"
       secret_key = "<secret key>"

       skip_region_validation      = true
       skip_credentials_validation = true
     }
   }

   resource "yandex_compute_instance" "vm-3" {
     name = "terraform3"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       initialize_params {
         image_id = "fd87va5cc00gaq2f5qfb"
       }
     }

     network_interface {
       subnet_id = data.terraform_remote_state.vpc.outputs.subnet-1
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
     }
   }
   ```

   {% endif %}

1. Run the command `terraform init`.
1. Run the command `terraform plan`. The terminal displays the plan for creating the VM.
1. Run the command `terraform apply`.
1. Go to the management console and make sure you can see the virtual machine `vm-3` in the {{ compute-name }} section.

## Delete the resources you created {#clear-out}

To destroy the resources you created, run the command `terraform destroy`: start with the second configuration, and then proceed to the first.
