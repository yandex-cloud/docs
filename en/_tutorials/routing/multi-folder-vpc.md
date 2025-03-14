# Connecting resources from different folders


In {{ yandex-cloud }}, you create network resources, e.g., cloud networks and subnets, in separate folders disconnected from each other and you often need to connect them. You can do it using the `Multi-folder VPC` method extending the scope of a {{ vpc-short-name }} network to multiple folders.

Depending on the selected {{ yandex-cloud }} tools, you can extend your network scope to other folders by:

* Moving subnets to other folders using the `management console (UI)` and `YC CLI`.
* Creating subnets in target folders with `YC CLI`.
* Creating subnets in target folders with `Terraform`.

Once you placed a subnet into the target folder, you can connect other folder resources to it, including VMs, {{ managed-k8s-name }} clusters, database hosts, load balancers, load testing agents, etc. As a result, you will have a network connecting resources from different folders.

In this tutorial, we will set up three VMs residing in different folders and connected by a shared network. We will create a cloud network in one of these folders and then extend its scope to other folders, thus connecting the resources located there.

{% note warning %}

You can only move subnets between folders within a single cloud.

{% endnote %}

In our example, we have a dev environment, including the CI/CD module with its components located in the `net-folder`. These components should be able to connect to other components located in **dev**, **stage**, and **prod** folders.

You can see this configuration in the picture below.

![Multi-folder VPC](../../_assets/tutorials/infrastructure-management/multi-folder-vpc/multi-folder-vpc.svg)

We are going to connect VMs residing in different subnets into one network. The VMs will be able to address each other by IP or FQDN addresses.

## Steps to follow {#order}

Depending on the selected tools, steps to create `Multi-folder VPC` may differ.

To create the test infrastructure and connect its resources:

1. [Get your cloud ready](#prepare-cloud).
1. [Create folders](#create-folders).
1. [Create a {{ vpc-short-name }} cloud network with subnets](#create-vpc).
1. [Move the subnets](#move-subnets).
1. [Create VM instances](#create-vms).
1. [Check the connectivity](#check-connectivity).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using public IP addresses and outgoing traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

### Configure access permissions {#roles}

Configure [access rights for the folder](../../resource-manager/operations/folder/set-access-bindings.md):

* To create networks and manage subnets, assign the `vpc.admin` or the `vpc.privateAdmin`, `vpc.publicAdmin`, and `vpc.securityGroups.admin` roles to the service account or user.
* To create and manage VMs, assign the `vpc.user` and `compute.admin` roles for the folder to the service account or user.

For granular network access management, use [security groups](../../vpc/concepts/security-groups.md).

## Create folders {#create-folders}

1. Create the `net-folder`, `dev-folder`, and `prod-folder` folders:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and click ![Create icon](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
     1. Specify the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) name: `net-folder`.
     1. Disable **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}** to create your network and subnets manually.
     1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

     Similarly, create `dev-folder` and `prod-folder`.

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% note info %}

     To create resources with CLI, [get authenticated](../../cli/operations/authentication/service-account.md#auth-as-sa) under a [service account](../../iam/concepts/users/service-accounts.md) with the `admin` [role](../../iam/concepts/access-control/roles.md) for the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).

     {% endnote %}

     1. Read the `create folder` command description:

        ```bash
        yc resource-manager folder create --help
        ```

     1. Create the `net-folder`, `dev-folder`, and `prod-folder` cloud folders:

        ```bash
        yc resource-manager folder create --name net-folder
        yc resource-manager folder create --name dev-folder
        yc resource-manager folder create --name prod-folder
        ```

   - {{ TF }} {#tf}

     1. {% include [terraform-install](../../_includes/terraform-install.md) %}

     1. Specify the {{ yandex-cloud }} Terraform provider configuration:

         ```hcl
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

     1. Specify input variables:

        ```hcl
        variable "cloud_id" {
          description = "YC cloud-id. Taken from environment variable."
        }
        ```

     1. Specify your target cloud folders:

        ```hcl
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

        1. When asked to confirm the changes, enter `yes` and wait for the operation to complete.

   - API {#api}

     Use the [create](../../resource-manager/api-ref/Folder/create.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/) resource or the [FolderService/Create](../../resource-manager/api-ref/grpc/Folder/create.md) gRPC API call.

   {% endlist %}

## Create a {{ vpc-short-name }} cloud network with subnets {#create-vpc}

In `net-folder`, create the `shared-net` network and three subnets with the following settings:

| Subnet name | Prefix | Availability zone | Target folder |
| --- | --- | --- | --- |
| `subnet-a` | `10.1.11.0/24` | `{{ region-id }}-a` | `net-folder` |
| `subnet-b` | `10.1.12.0/24` | `{{ region-id }}-b` | `dev-folder` |
| `subnet-d` | `10.1.13.0/24` | `{{ region-id }}-d` | `prod-folder` |

1. Create a [cloud network](../../vpc/concepts/network.md):

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), navigate to `net-folder`.
     1. In the list of services, select **{{ vpc-name }}**.
     1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
     1. Specify the network name: `shared-net`.
     1. Disable [Create subnets](../../vpc/operations/subnet-create.md) to create subnets manually.
     1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

   - CLI {#cli}

     1. Read the description of the `network create` command:

        ```bash
        yc vpc network create --help
        ```

     1. Create the `shared-net` cloud network in `net-folder`.

        ```bash
        yc vpc network create --folder-name net-folder --name shared-net
        ```

   - {{ TF }} {#tf}

     1. Specify your target network:

        ```hcl
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

     1. Enter `yes` to confirm changes.

     1. Wait for the operation to complete.

   - API {#api}

     Use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.

   {% endlist %}

1. Create [subnets](../../vpc/concepts/network.md#subnet) named `subnet-a`, `subnet-b`, and `subnet-d` in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` [availability zones](../../overview/concepts/geo-scope.md), respectively:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), navigate to `net-folder`.
     1. In the list of services, select **{{ vpc-name }}**.
     1. Click `shared-net`.
     1. Click **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
     1. Specify the subnet name: `subnet-a`, `subnet-b`, or `subnet-d`.
     1. Select the availability zone from the drop-down list: `{{ region-id }}-a`, `{{ region-id }}-b`, or `{{ region-id }}-d`, respectively.
     1. Specify the subnet CIDR: `10.1.11.0` as IP address and `24` as subnet mask. For more information about IP address ranges, see [Cloud networks and subnets](../../vpc/concepts/network.md).
     1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

   - CLI {#cli}

     1. Read the `subnet create` command description:

        ```bash
        yc vpc subnet create --help
        ```

     1. Create subnets in the target folders:

        ```bash
        yc vpc subnet create --folder-name net-folder --name subnet-a \
          --network-name shared-net --zone {{ region-id }}-a --range 10.1.11.0/24

        yc vpc subnet create --folder-name dev-folder --name subnet-b \
          --network-name shared-net --zone {{ region-id }}-b --range 10.1.12.0/24

        yc vpc subnet create --folder-name prod-folder --name subnet-d \
          --network-name shared-net --zone {{ region-id }}-d --range 10.1.13.0/24
        ```

     1. Check the new subnet status:

        ```bash
        yc vpc subnet list --folder-name net-folder
        yc vpc subnet list --folder-name dev-folder
        yc vpc subnet list --folder-name prod-folder
        ```

   - {{ TF }} {#tf}

     1. Specify your target subnets:

        ```hcl
        resource "yandex_vpc_subnet" "subnet_a" {
          folder_id      = yandex_resourcemanager_folder.net_folder.id
          name           = "subnet-a"
          description    = "NET folder subnet"
          v4_cidr_blocks = ["10.1.11.0/24"]
          zone           = "{{ region-id }}-a"
          network_id     = yandex_vpc_network.shared_net.id
        }

        resource "yandex_vpc_subnet" "subnet_b" {
          folder_id      = yandex_resourcemanager_folder.dev_folder.id
          name           = "subnet-b"
          description    = "DEV folder subnet"
          v4_cidr_blocks = ["10.1.12.0/24"]
          zone           = "{{ region-id }}-b"
          network_id     = yandex_vpc_network.shared_net.id
        }

        resource "yandex_vpc_subnet" "subnet_d" {
          folder_id      = yandex_resourcemanager_folder.prod_folder.id
          name           = "subnet-d"
          description    = "PROD folder subnet"
          v4_cidr_blocks = ["10.1.13.0/24"]
          zone           = "{{ region-id }}-d"
          network_id     = yandex_vpc_network.shared_net.id
        }
        ```

     1. Run the following commands:

        ```bash
        export TF_VAR_cloud_id=$(yc config get cloud-id)
        export YC_TOKEN=$(yc iam create-token)
        terraform apply
        ```

     1. When asked to confirm the changes, enter `yes` and wait for the operation to complete.

   - API {#api}

     Use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

   {% endlist %}

## Move the subnets {#move-subnets}

[Move](../../vpc/operations/subnet-move.md) `subnet-b` to `dev-folder`:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to `net-folder`.
  1. In the list of services, select **{{ vpc-name }}**.
  1. Click `shared-net`.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to `subnet-b` and select **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.
  1. Select `dev-folder` from the drop-sown list.
  1. Click **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.

- CLI {#cli}

  1. Read the `subnet move` command description:

     ```bash
     yc vpc subnet move --help
     ```

  1. Move the subnet:

     ```bash
     yc vpc subnet move subnet-b \
       --destination-folder-name dev-folder
     ```

- API {#api}

  Use the [move](../../vpc/api-ref/Subnet/move.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/) resource or the [SubnetService/Move](../../vpc/api-ref/grpc/Subnet/move.md) gRPC API call.

{% endlist %}

Similarly, move `subnet-d` to `prod-folder`:

## Create VMs {#create-vms}

Create [VMs](../../compute/concepts/vm.md) with the following settings:

| VM name | Folder | Availability zone | Subnet |
| --- | --- | --- | --- |
| `net-vm` | `net-folder` | `{{ region-id }}-a` | `subnet-a` |
| `dev-vm` | `dev-folder` | `{{ region-id }}-b` | `subnet-b` |
| `prod-vm` | `prod-folder` | `{{ region-id }}-d` | `subnet-d` |

{% list tabs group=instructions %}

- Management console {#console}

  Create the Linux-based `net-vm` VM in `net-folder`:

  1. In the [management console]({{ link-console-main }}), select `net-folder`.
  1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, type `Ubuntu 22.04 LTS` and select a public [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `subnet-a`.
      * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, leave `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign your VM a random external IP address from the {{ yandex-cloud }} pool or if you reserved a static IP address, select it from the list.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify your VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify the username: `ycuser`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `net-vm`.
  1. Leave all other settings unchanged and click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Similarly, create `dev-vm` and `prod-vm` in the respective folders.

  {% note info %}

  When you create a VM, the system will assign it a public and private IP addresses Save them so you will be able to access the VM and test its connectivity.

  {% endnote %}

- CLI {#cli}

  1. Create the `vm-init.tpl` VM metadata template file:

     ```bash
     #cloud-config

     datasource:
       Ec2:
         strict_id: false
     ssh_pwauth: yes
     users:
       - name: "${USER_NAME}"
         sudo: ALL=(ALL) NOPASSWD:ALL
         shell: /bin/bash
         ssh_authorized_keys:
           - "${USER_SSH_KEY}"
     ```

  1. Generate a VM metadata file:

     ```bash
     export USER_NAME=ycuser
     export USER_SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
 
     envsubst < vm-init.tpl > vm-config.txt
     ```

  1. Create VMs:

     ```bash
     yc compute instance create --name=net-vm --hostname=net-vm \
       --zone={{ region-id }}-a \
       --platform=standard-v3 \
       --cores=2 --memory=4G --core-fraction=100 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
       --network-interface subnet-name=subnet-a,ipv4-address=auto,nat-ip-version=ipv4 \
       --metadata-from-file user-data=vm-config.txt

     yc compute instance create --name=dev-vm --hostname=dev-vm \
       --zone={{ region-id }}-b \
       --platform=standard-v3 \
       --cores=2 --memory=4G --core-fraction=100 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
       --network-interface subnet-name=subnet-b,ipv4-address=auto,nat-ip-version=ipv4 \
       --metadata-from-file user-data=vm-config.txt

     yc compute instance create --name=prod-vm --hostname=prod-vm \
       --zone={{ region-id }}-d \
       --platform=standard-v3 \
       --cores=2 --memory=4G --core-fraction=100 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
       --network-interface subnet-name=subnet-d,ipv4-address=auto,nat-ip-version=ipv4 \
       --metadata-from-file user-data=vm-config.txt
     ```

     {% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

  1. Save the new VMs’ public IPs as you will need them later:

     ```bash
     NET_VM_IP=$(yc compute instance get net-vm --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
     DEV_VM_IP=$(yc compute instance get dev-vm --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
     PROD_VM_IP=$(yc compute instance get prod-vm --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
     ```

- {{ TF }} {#tf}

  1. Specify input variables:

     ```hcl
     variable "user_name" {
       description = "VM User Name"
       default     = "ycuser"
     }
   
     variable "user_ssh_key_path" {
       description = "User's SSH public key file"
       default     = "~/.ssh/id_rsa.pub"
     }
     ```

  1. Create the `vm-init.tpl` VM metadata template file:

     ```hcl
     #cloud-config
   
     datasource:
       Ec2:
         strict_id: false
     ssh_pwauth: yes
     users:
       - name: "${USER_NAME}"
         sudo: ALL=(ALL) NOPASSWD:ALL
         shell: /bin/bash
         ssh_authorized_keys:
           - "${USER_SSH_KEY}"
     ```

  1. Describe your target VMs:

     ```hcl
     # =================
     # Compute Resources
     # =================
     data "yandex_compute_image" "vm_image" {
       family = "ubuntu-2204-lts"
     }

     resource "yandex_compute_disk" "boot-disk-1" {
       name     = "boot-disk-1"
       type     = "network-hdd"
       zone     = "{{ region-id }}-a"
       size     = "20"
       image_id = yandex_compute_image.vm_image.id
     }

     resource "yandex_compute_disk" "boot-disk-2" {
       name     = "boot-disk-2"
       type     = "network-hdd"
       zone     = "{{ region-id }}-b"
       size     = "20"
       image_id = yandex_compute_image.vm_image.id
     }

     resource "yandex_compute_disk" "boot-disk-3" {
       name     = "boot-disk-3"
       type     = "network-hdd"
       zone     = "{{ region-id }}-d"
       size     = "20"
       image_id = yandex_compute_image.vm_image.id
     }

     resource "yandex_compute_instance" "net_vm" {
       folder_id   = yandex_resourcemanager_folder.net_folder.id
       name        = "net-vm"
       hostname    = "net-vm"
       platform_id = "standard-v3"
       zone        = "{{ region-id }}-a"
       resources {
         cores  = 2
         memory = 4
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk-1.id
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
       zone        = "{{ region-id }}-b"
       resources {
         cores  = 2
         memory = 4
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk-2.id
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
       zone        = "{{ region-id }}-d"
       resources {
         cores  = 2
         memory = 4
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk-3.id
       }

       network_interface {
         subnet_id = yandex_vpc_subnet.subnet_d.id
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

  1. When asked to confirm the changes, enter `yes` and wait for the operation to complete.

- API {#api}

  To create a VM, use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Compute Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}

## Check your resources connectivity {#check-connectivity}

1. Connect to the `net-vm` VM over SSH:

   ```bash
   ssh ycuser@<net-vm_public_IP_address>
   ```

1. Check whether you can connect to `dev-vm`:

   ```bash
   ping -c3 <net-vm_internal_IP_address>
   ```

   Result:

   ```text
   PING 10.127.20.4 (10.127.20.4) 56(84) bytes of data.
   64 bytes from 10.127.20.4: icmp_seq=1 ttl=61 time=7.45 ms
   64 bytes from 10.127.20.4: icmp_seq=2 ttl=61 time=5.61 ms
   64 bytes from 10.127.20.4: icmp_seq=3 ttl=61 time=5.65 ms
   --- 10.127.20.4 ping statistics ---
   3 packets transmitted, 3 received, 0% packet loss, time 2003ms
   rtt min/avg/max/mdev = 5.613/6.235/7.446/0.855 ms
   ```

1. Similarly, check the connection to `prod-vm`.

1. Connect to `dev-vm` over SSH and use **ping** to check the IP connectivity between `dev-vm`, `net-vm`, and `prod-vm`.

1. Connect to `prod-vm` over SSH and use **ping** to check the IP connectivity between `prod-vm`, `net-vm`, and `dev-vm`.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete VMs](../../compute/operations/vm-control/vm-delete.md): `net-vm`, `dev-vm`, and `prod-vm`.
