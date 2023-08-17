# Setting up networking between resources in different folders

In {{ yandex-cloud }}, network resources, such as cloud network and subnets, are usually created in a single resource cloud folder that is not linked to resources in other cloud folders. When deploying resources in {{ yandex-cloud }}, it is often necessary to ensure networking between resources residing in different folders. One of the ways to do that is to use the `Multi-folder VPC` method that extends the scope of an individual {{ vpc-short-name }} network to multiple rather than one folder.

Depending on the selected {{ yandex-cloud }} management interface, a network's scope is extended to other folders by:
* Moving subnets to different cloud folders: `management console (UI)`.
* Creating subnets in target folders: `YC CLI`.
* Creating subnets in target folders: `Terraform`.

After that, you can connect different resources to the subnets hosted in target folders, such as VMs, {{ managed-k8s-name }} clusters, database hosts, load balancers, load testing agents, and other resources residing in these folders. As a result, your network will ensure connectivity between resources in different folders.

This guide provides an example of how to create an infrastructure consisting of three VM instances, each residing in a different folder. These instances are connected via a shared internal network. Network connectivity between cloud resources hosted in different folders is established by creating a cloud network in one of these folders and then extending its scope to other folders. This way, a single-folder network is sort of extended to multiple folders, which allows connecting required resources to `extended subnets` residing in these folders.

{% note warning %}

You can only move subnets between folders within a single cloud.

{% endnote %}

For example, the development environment includes the CI/CD module whose components are hosted in the `net-folder`. This module should enable networking between the **dev**, **stage**, and **prod** components residing in their folders.

This solution pattern is shown below.

![Multi-folder VPC](../../_assets/tutorials/infrastructure-management/multi-folder-vpc/multi-folder-vpc.svg)

This will set up networking between VMs from different environments (folders) connected to different subnets in one network. Moreover, all VMs will be able to communicate with one another both by IPs and their FQDNs (over DNS).

## Steps to follow {#order}

Depending on the select management interface, steps to create a `Multi-folder VPC` may differ.

To create a test infrastructure and enable networking between resources:

1. [Prepare your cloud](#prepare-cloud).
1. [Create folders without a {{ vpc-short-name }} network](#create-folders).
1. [Create a {{ vpc-short-name }} cloud network with subnets](#create-vpc).
1. [Move the subnets](#move-subnets). For the management console only.
1. [Create VM instances](#create-vms).
1. [Check the networking](#check-connectivity).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of this infrastructure includes:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using public IP addresses and outgoing traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


### Set up access rights {#roles}

Set up [access rights for the folder](../../resource-manager/operations/folder/set-access-bindings.md):

* To create networks and manage subnets, assign to the service account or user the `vpc.admin` service role or the `vpc.privateAdmin`, `vpc.publicAdmin`, and `vpc.securityGroups.admin` service roles.
* To create and manage VMs in the folder, assign the `vpc.user` and `compute.admin` service roles.

Network access is differentiated by [security groups](../../vpc/concepts/security-groups.md).

## Create folders without a {{ vpc-short-name }} network {#create-folders}

1. Create a folder named `net-folder`:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and click ![Create icon](../../_assets/create.png) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
      1. Enter the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) name: `net-folder`.
      1. Enter a description of the folder if needed.
      1. Disable **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}** to create your network and subnets manually.
      1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

      Similarly, create two more folders without the {{ vpc-short-name }} network, naming them as `dev-folder` and `prod-folder`.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% note info %}

      To create resources using the CLI, [authenticate](../../cli/operations/authentication/service-account.md#auth-as-sa) using the [service account](../../iam/concepts/users/service-accounts.md) having the `admin` [role](../../iam/concepts/access-control/roles.md) for the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).

      {% endnote %}

      1. See a description of the create folder command:

         ```bash
         yc resource-manager folder create --help
         ```

      1. Create cloud folders named `net-folder`, `dev-folder`, and `prod-folder`:

         ```bash
         yc resource-manager folder create --name net-folder
         yc resource-manager folder create --name dev-folder
         yc resource-manager folder create --name prod-folder
         ```

   - Terraform

      1. If you do not have {{ TF }} yet, [set up and configure](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) it.


      1. Specify the {{ yandex-cloud }} Terraform provider configuration:

         ```
         # ==================================
         # Terraform & Provider Configuration
         # ==================================
         terraform {
          required_providers {
              yandex = {
                source  = "yandex-cloud/yandex"
                version = "~> 0.92.0"
              }
          }
         }
         ```

      1. Describe the input variables:

         ```
         variable "cloud_id" {
           description = "YC cloud-id. Taken from environment variable."
         }
         ```

      1. Describe the targets (cloud folders):

         ```
         # ========
         # Folders
         # ========
         resource "yandex_resourcemanager_folder" "net_folder" {
           cloud_id = var.cloud_id
           name     = "net-folder"
         }

         resource "yandex_resourcemanager_folder" "dev_folder" {
           cloud_id = var.cloud_id
           name     = "dev-folder"
         }

         resource "yandex_resourcemanager_folder" "prod_folder" {
           cloud_id = var.cloud_id
           name     = "prod-folder"
         }
         ```

      1. Create the required infrastructure:

         1. Run the following commands:

            ```bash
            export TF_VAR_cloud_id=$(yc config get cloud-id)
            export YC_TOKEN=$(yc iam create-token)
            terraform apply
            ```

         1. Confirm the resources have been updated and wait for the operation to complete.

   - API

      To create a folder, use:
      * The [create](https://cloud.yandex.ru/docs/resource-manager/api-ref/Folder/create) (`REST API`) method for the [Folder](https://cloud.yandex.ru/docs/resource-manager/api-ref/Folder/) resource.
      * The [FolderService/Create](https://cloud.yandex.ru/docs/resource-manager/api-ref/grpc/folder_service#Create) (`gRPC API`) call.

   {% endlist %}


## Create a {{ vpc-short-name }} cloud network with subnets {#create-vpc}

In `net-folder`, create a network named `shared-net`, with three subnets that have the following parameters:

| Subnet name | Prefix | Availability zone | Target folder |
| --- | --- | --- | --- |
| subnet-a | 10.1.11.0/24 | {{ region-id }}-a | net-folder |
| subnet-b | 10.1.12.0/24 | {{ region-id }}-b | dev-folder |
| subnet-c | 10.1.13.0/24 | {{ region-id }}-c | prod-folder |


1. Create a network:

   {% list tabs %}

   - Management console

      To create a [cloud network](../../vpc/concepts/network.md):
      1. In the [management console]({{ link-console-main }}), go to `net-folder`.
      1. In the list of services, select **{{ vpc-name }}**.
      1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
      1. Enter the network name: `shared-net`.
      1. Add a network description if needed.
      1. Disable [Create subnets](../../vpc/operations/subnet-create.md) to create subnets manually.
      1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

   - CLI

      To create a [cloud network](../../vpc/concepts/network.md):
      1. See the description of the CLI command for creating a cloud network:

         ```
         yc vpc network create --help
         ```

      1. Create a cloud network named `shared-net` in `net-folder`:

         ```
         yc vpc network create --folder-name net-folder --name shared-net
         ```

   - Terraform

      1. Describe the target (cloud network):

         ```
         # =============
         # VPC Resources
         # =============
         resource "yandex_vpc_network" "shared_net" {
           folder_id = yandex_resourcemanager_folder.net_folder.id
           name      = "shared-net"
         }
         ```

      1. Run the following commands:

         ```bash
         export TF_VAR_cloud_id=$(yc config get cloud-id)
         export YC_TOKEN=$(yc iam create-token)
         terraform apply
         ```

      1. Confirm the resources have been updated.

      1. Wait for the operation to complete.

   - API

      To create a cloud network, use:
      * The [create](https://cloud.yandex.ru/docs/vpc/api-ref/Network/create) (`REST API`) method for the [Network](https://cloud.yandex.ru/docs/vpc/api-ref/Network/) resource
      * The [NetworkService/Create](https://cloud.yandex.ru/docs/vpc/api-ref/grpc/network_service#Create) (`gRPC API`) call

   {% endlist %}

1. Create the `subnet-a` network in the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md):

   {% list tabs %}

   - Management console

      To create a [subnet](../../vpc/concepts/network.md#subnet):
      1. In the [management console]({{ link-console-main }}), go to `net-folder`.
      1. In the list of services, select **{{ vpc-name }}**.
      1. Click the name of the `shared-net` cloud network.
      1. Click **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
      1. Enter the subnet name: `subnet-a`.
      1. Add a network description if needed.
      1. Select the `{{ region-id }}-a` availability zone from the drop-down list.
      1. Enter the subnet CIDR: the IP address `10.1.11.0` and mask `24`. For more information about subnet IP address ranges, see [Cloud networks and subnets](../../vpc/concepts/network.md).
      1. Click **Create subnet**.

      Similarly, create `subnet-b` and `subnet-с` in **net-folder**.


   - CLI

      To create a [subnet](../../vpc/concepts/network.md#subnet):

      1. See the description of the CLI command for creating a subnet:

         ```
         yc vpc subnet create --help
         ```

      1. Create subnets in the target folders:

         ```
         yc vpc subnet create --folder-name net-folder --name subnet-a \
           --network-name shared-net --zone {{ region-id }}-a --range 10.1.11.0/24

         yc vpc subnet create --folder-name dev-folder --name subnet-b \
           --network-name shared-net --zone {{ region-id }}-b --range 10.1.12.0/24

         yc vpc subnet create --folder-name prod-folder --name subnet-c \
           --network-name shared-net --zone {{ region-id }}-c --range 10.1.13.0/24
         ```

      1. Check the state of the created subnets:

         ```
         yc vpc subnet list --folder-name net-folder
         yc vpc subnet list --folder-name dev-folder
         yc vpc subnet list --folder-name prod-folder
         ```

   - Terraform

      1. Describe the targets (cloud subnets):

         ```
         resource "yandex_vpc_subnet" "subnet_a" {
           folder_id      = yandex_resourcemanager_folder.net_folder.id
           name           = "subnet-a"
           description    = "NET folder subnet"
           v4_cidr_blocks = ["10.1.11.0/24"]
           zone           = "ru-central1-a"
           network_id     = yandex_vpc_network.shared_net.id
         }

         resource "yandex_vpc_subnet" "subnet_b" {
           folder_id      = yandex_resourcemanager_folder.dev_folder.id
           name           = "subnet-b"
           description    = "DEV folder subnet"
           v4_cidr_blocks = ["10.1.12.0/24"]
           zone           = "ru-central1-b"
           network_id     = yandex_vpc_network.shared_net.id
         }

         resource "yandex_vpc_subnet" "subnet_c" {
           folder_id      = yandex_resourcemanager_folder.prod_folder.id
           name           = "subnet-c"
           description    = "PROD folder subnet"
           v4_cidr_blocks = ["10.1.13.0/24"]
           zone           = "ru-central1-c"
           network_id     = yandex_vpc_network.shared_net.id
         }
         ```


      1. Run the following commands:

         ```bash
         export TF_VAR_cloud_id=$(yc config get cloud-id)
         export YC_TOKEN=$(yc iam create-token)
         terraform apply
         ```

      1. Confirm the resources have been updated and wait for the operation to complete.

   - API

      To create a subnet, use:
      * The [create](https://cloud.yandex.ru/docs/vpc/api-ref/Subnet/create) (`REST API`) method for the [Subnet](https://cloud.yandex.ru/docs/vpc/api-ref/Subnet/) resource.
      * The [SubnetService/Create](https://cloud.yandex.ru/docs/vpc/api-ref/grpc/subnet_service#Create) (`gRPC API`) call.

   {% endlist %}


## Move the subnets. For the management console only. {#move-subnets}

Move `subnet-b` to `dev-folder`.

{% list tabs %}

- Management console

   To move a subnet to another folder:

   1. In the [management console]({{ link-console-main }}), go to `net-folder`.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Click the name of the `shared-net` cloud network.
   1. Click ![image](../../_assets/options.svg) in the line of `subnet-b` and select **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.
   1. Select `dev-folder` in the drop-down list.
   1. Click **Move**.

   Move `subnet-b` to `prod-folder` in the same way.

{% endlist %}


## Create VMs {#create-vms}

Create VMs with the following parameters:

| VM name | Folder | Availability zone | Subnet |
| --- | --- | --- | --- |
| net-vm | net-folder | {{ region-id }}-a | subnet-a |
| dev-vm | dev-folder | {{ region-id }}-b | subnet-b |
| prod-vm | prod-folder | {{ region-id }}-c | subnet-c |

{% list tabs %}

- Management console

   Create a Linux VM named `net-vm` in `net-folder`:

   1. In the [management console]({{ link-console-main }}), select `net-folder`.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Enter the name: `net-vm`.
      * Select an availability zone `{{ region-id }}-a`.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select Ubuntu 20.04.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the `subnet-a` subnet.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
      * Enter the `ycuser` username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection yourself.
   1. Leave all the other settings as they are and click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   Similarly, create VMs named `dev-vm` and `prod-vm` in the respective folders.

   {% note info %}

   A public and private IP addresses are assigned to the VM at creation. Write them down, as you will need them to access the VM and check networking with other VMs.

   {% endnote %}

- CLI

   1. Describe a template for VM metadata in a separate `vm-init.tpl` file:

      ```
      #cloud-config

      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: yes
      users:
        - name: "${USER_NAME}"
          sudo: ALL=(ALL) NOPASSWD:ALL
          shell: /bin/bash
          ssh-authorized-keys:
            - "${USER_SSH_KEY}"
      ```

   1. Generate a metadata file to deploy the VM:

      ```bash
      export USER_NAME=ycuser
      export USER_SSH_KEY=$(cat ~/.ssh/id_rsa.pub)

      envsubst < vm-init.tpl > vm-config.txt
      ```

   1. Create VMs:

      ```bash
      yc compute instance create --name=net-vm --hostname=net-vm \
        --zone=ru-central1-a \
        --platform=standard-v3 \
        --cores=2 --memory=4G --core-fraction=100 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
        --network-interface subnet-name=subnet-a,ipv4-address=auto,nat-ip-version=ipv4 \
        --metadata-from-file user-data=vm-config.txt

      yc compute instance create --name=dev-vm --hostname=dev-vm \
        --zone=ru-central1-b \
        --platform=standard-v3 \
        --cores=2 --memory=4G --core-fraction=100 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
        --network-interface subnet-name=default-ru-central1-b,ipv4-address=auto,nat-ip-version=ipv4 \
        --metadata-from-file user-data=vm-config.txt

      yc compute instance create --name=prod-vm --hostname=prod-vm \
        --zone=ru-central1-c \
        --platform=standard-v3 \
        --cores=2 --memory=4G --core-fraction=100 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
        --network-interface subnet-name=default-ru-central1-c,ipv4-address=auto,nat-ip-version=ipv4 \
        --metadata-from-file user-data=vm-config.txt
      ```

   1. Save the VM public IPs to use them later:

      ```
      NET_VM_IP=$(yc compute instance get net-vm --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
      DEV_VM_IP=$(yc compute instance get dev-vm --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
      PROD_VM_IP=$(yc compute instance get prod-vm --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
      ```

- Terraform

   1. Describe the input variables:

      ```
      variable "user_name" {
        description = "VM User Name"
        default     = "ycuser"
      }

      variable "user_ssh_key_path" {
        description = "User's SSH public key file"
        default     = "~/.ssh/id_rsa.pub"
      }
      ```

   1. Describe a template for VM metadata in a separate `vm-init.tpl` file:

      ```
      #cloud-config

      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: yes
      users:
        - name: "${USER_NAME}"
          sudo: ALL=(ALL) NOPASSWD:ALL
          shell: /bin/bash
          ssh-authorized-keys:
            - "${USER_SSH_KEY}"
      ```

   1. Describe the targets (VMs):

      ```
      # =================
      # Compute Resources
      # =================
      data "yandex_compute_image" "vm_image" {
        family = "ubuntu-2204-lts"
      }

      resource "yandex_compute_instance" "net_vm" {
        folder_id   = yandex_resourcemanager_folder.net_folder.id
        name        = "net-vm"
        hostname    = "net-vm"
        platform_id = "standard-v3"
        zone        = "ru-central1-a"
        resources {
          cores  = 2
          memory = 4
        }

        boot_disk {
          initialize_params {
            image_id = data.yandex_compute_image.vm_image.id
          }
        }

        network_interface {
          subnet_id = yandex_vpc_subnet.subnet_a.id
          nat       = true
        }

        metadata = {
          user-data = templatefile("vm-init.tpl", {
            USER_NAME    = var.user_name
            USER_SSH_KEY = file(var.user_ssh_key_path)
          })
        }
      }

      resource "yandex_compute_instance" "dev_vm" {
        folder_id   = yandex_resourcemanager_folder.dev_folder.id
        name        = "dev-vm"
        hostname    = "dev-vm"
        platform_id = "standard-v3"
        zone        = "ru-central1-b"
        resources {
          cores  = 2
          memory = 4
        }

        boot_disk {
          initialize_params {
            image_id = data.yandex_compute_image.vm_image.id
          }
        }

        network_interface {
          subnet_id = yandex_vpc_subnet.subnet_b.id
          nat       = true
        }

        metadata = {
          user-data = templatefile("vm-init.tpl", {
            USER_NAME    = var.user_name
            USER_SSH_KEY = file(var.user_ssh_key_path)
          })
        }
      }

      resource "yandex_compute_instance" "prod_vm" {
        folder_id   = yandex_resourcemanager_folder.prod_folder.id
        name        = "prod-vm"
        hostname    = "prod-vm"
        platform_id = "standard-v3"
        zone        = "ru-central1-c"
        resources {
          cores  = 2
          memory = 4
        }

        boot_disk {
          initialize_params {
            image_id = data.yandex_compute_image.vm_image.id
          }
        }

        network_interface {
          subnet_id = yandex_vpc_subnet.subnet_c.id
          nat       = true
        }

        metadata = {
          user-data = templatefile("vm-init.tpl", {
            USER_NAME    = var.user_name
            USER_SSH_KEY = file(var.user_ssh_key_path)
          })
        }
      }

      # =======
      # Outputs
      # =======
      output "NET-vm" {
        value = yandex_compute_instance.network_vm.network_interface.0.nat_ip_address
      }

      output "DEV-vm" {
        value = yandex_compute_instance.dev_vm.network_interface.0.nat_ip_address
      }

      output "PROD-vm" {
        value = yandex_compute_instance.prod_vm.network_interface.0.nat_ip_address
      }
      ```

   1. Run the following commands:

      ```bash
      export TF_VAR_cloud_id=$(yc config get cloud-id)
      export YC_TOKEN=$(yc iam create-token)
      terraform apply
      ```

   1. Confirm the resources have been updated and wait for the operation to complete.

- API

   To create a VM, use:
   * The [create](https://cloud.yandex.ru/docs/compute/api-ref/Instance/create) (`REST API`) method for the [Compute Instance](https://cloud.yandex.ru/docs/compute/api-ref/Instance/) resource.
   * The [InstanceService/Create](https://cloud.yandex.ru/docs/compute/api-ref/grpc/instance_service#Create) (`gRPC API`) call.

{% endlist %}

## Check networking between the resources {#check-connectivity}

1. Connect to `net-vm` over SSH:

   ```bash
   ssh ycuser@<net-vm_public_IP_address>
   ```

1. Check IP connectivity to `dev-vm` inside the VPC:

   ```bash
   ping -с3 <dev-vm_internal_IP_address>
   ```

   Result:

   ```
   PING 10.127.20.4 (10.127.20.4) 56(84) bytes of data.
   64 bytes from 10.127.20.4: icmp_seq=1 ttl=61 time=7.45 ms
   64 bytes from 10.127.20.4: icmp_seq=2 ttl=61 time=5.61 ms
   64 bytes from 10.127.20.4: icmp_seq=3 ttl=61 time=5.65 ms
   --- 10.127.20.4 ping statistics ---
   3 packets transmitted, 3 received, 0% packet loss, time 2003ms
   rtt min/avg/max/mdev = 5.613/6.235/7.446/0.855 ms
   ```

1. Similarly, check IP connectivity to `prod-vm` inside the VPC.

1. Connect to `dev-vm` over SSH and check IP connectivity to `net-vm` and `prod-vm` via a **ping**.

1. Connect to `prod-vm` over SSH and check IP connectivity to `net-vm` and `dev-vm` via a **ping**.


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete](../../compute/operations/vm-control/vm-delete.md) `net-vm`, `dev-vm`, and `prod-vm`.