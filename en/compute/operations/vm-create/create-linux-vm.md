---
title: How to create a Linux VM from a public image
description: Use this tutorial to create a Linux VM.
---

# Creating a VM from a public Linux image

{% list tabs group=instructions %}

- Management console {#console}



  {% include [create-instance-via-console-linux](../../_includes_service/create-instance-via-console-linux.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../../cli/) command to create a [VM](../../concepts/vm.md):

     ```bash
     yc compute instance create --help
     ```

  1. [Prepare](../vm-connect/ssh.md#creating-ssh-keys) a key pair (public and private keys) for SSH access to the VM.
  1. Select a public Linux-based [image](../images-with-pre-installed-software/get-list.md) from [{{ marketplace-full-name }}](../../../marketplace/), e.g., [CentOS 7](/marketplace/products/yc/centos-7).

     {% include [standard-images](../../../_includes/standard-images.md) %}

  1. Select a [subnet](../../../vpc/concepts/network.md#subnet):

     ```bash
     yc vpc subnet list
     ```

     Result:

     ```text
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     | e9bnlm18l70a******** |   default-{{ region-id }}-a   | enpe3m3fa00u******** |                |   {{ region-id }}-a   | [10.128.0.0/24] |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     ```

  1. Create a VM in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute instance create \
       --name first-instance \
       --zone {{ region-id }}-a \
       --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
       --create-boot-disk image-folder-id=standard-images,image-family=centos-7,kms-key-id=<key_ID> \
       --ssh-key ~/.ssh/id_ed25519.pub
     ```

     Where:
     * `--name`: VM name. The naming requirements are as follows:

       {% include [name-format](../../../_includes/name-format.md) %}

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) matching the selected subnet.
     * `--network-interface`: VM [network interface](../../concepts/network.md) settings:
         * `subnet-name`: Name of the selected subnet.
         * `nat-ip-version=ipv4`: [Public IP address](../../../vpc/concepts/address.md#public-addresses). To create a VM without a public IP address, omit this parameter.

         {% include [add-several-net-interfaces-notice-cli](../../../_includes/compute/add-several-net-interfaces-notice-cli.md) %}

     * `--create-boot-disk`: VM boot disk settings:
         * `image-family`: [Image family](../../concepts/image.md#family), e.g., `centos-7`. This option allows you to install the latest version of the OS from the specified family.
         * `kms-key-id`: ID of the [{{ kms-short-name }} symmetric key](../../../kms/concepts/key.md) to create en encrypted boot disk. This is an optional parameter.

           {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}

           {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

           {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

     * `--ssh-key`: Path to the file with the [public SSH key](../vm-connect/ssh.md#creating-ssh-keys). The VM will automatically create a user named `yc-user` for this key.

         {% include [ssh-note](../../../_includes/compute/ssh-note.md) %}

         If you want to add multiple users with SSH keys to your VM at the same time, [specify](../../concepts/metadata/sending-metadata.md) these users' data in the `--metadata-from-file` parameter. You can also use metadata to [install additional software](./create-with-cloud-init-scripts.md) on a VM when creating it.

  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, define the parameters of the resources you want to create:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "<disk_name>"
       type     = "<disk_type>"
       zone     = "<availability_zone>"
       size     = "<disk_size>"
       image_id = "<image_ID>"
     }

     resource "yandex_compute_instance" "vm-1" {
       name                      = "linux-vm"
       allow_stopping_for_update = true
       platform_id               = "standard-v3"
       zone                      = "<availability_zone>"

       resources {
         cores  = "<number_of_vCPUs>"
         memory = "<RAM_in_GB>"
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk.id
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         ssh-keys = "<username>:<SSH_key_contents>"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name           = "subnet1"
       zone           = "<availability_zone>"
       v4_cidr_blocks = ["192.168.10.0/24"]
       network_id     = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Where:
     * `yandex_compute_disk`: Boot [disk](../../concepts/disk.md) description:
       * `name`: Disk name.
       * `type`: Disk type.
       * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) the disk will reside in.
       * `size`: Disk size in GB.
       * `image_id`: ID of the image to create the VM from. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).

         {% include [id-info](../../../_includes/compute/id-info.md) %}

     * `yandex_compute_instance`: VM description:
       * `name`: VM name.
       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id`: [Platform](../../concepts/vm-platforms.md).
       * `zone`: Availability zone the VM will reside in.
       * `resources`: Number of vCPUs and amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
       * `boot_disk`: Boot disk settings. Specify the disk ID. 
       * `network_interface`: VM [network interface](../../concepts/network.md) settings. Specify the ID of the selected [subnet](../../../vpc/concepts/network.md#subnet). To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.

           {% include [add-several-net-interfaces-notice-tf](../../../_includes/compute/add-several-net-interfaces-notice-tf.md) %}

       * `metadata`: In the metadata, provide the public SSH key for VM access. For more information, see [{#T}](../../concepts/vm-metadata.md).

           If you want to add multiple users with SSH keys to the VM at the same time, [specify](../../concepts/metadata/sending-metadata.md) these users' data in a file and provide it under `metadata`. You can also use metadata to [install additional software](./create-with-cloud-init-scripts.md) on a VM when creating it.
     * `yandex_vpc_network`: Cloud network description.
     * `yandex_vpc_subnet`: Description of the subnet to connect your VM to.

     {% note info %}

     If you already have suitable resources, such as a cloud network and subnet, you do not need to redefine them. Specify their names and IDs in the appropriate parameters.

     {% endnote %}

     For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

- API {#api}

  Create a VM using the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource:
  1. [Prepare](../vm-connect/ssh.md#creating-ssh-keys) a key pair (public and private keys) for SSH access to the VM.
  1. Get a [{{ iam-full-name }} token](../../../iam/concepts/authorization/iam-token.md) used for authentication in the examples:
     * [Guide](../../../iam/operations/iam-token/create.md) for users with a Yandex account.
     * [Guide](../../../iam/operations/iam-token/create-for-sa.md) for a [service account](../../../iam/concepts/users/service-accounts.md).
     * [Guide](../../../iam/operations/iam-token/create-for-federation.md) for a federated account.
  1. [Get the ID](../../../resource-manager/operations/folder/get-id.md) of the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Get info on the [image](../../concepts/image.md) to create your VM from, such as image ID and minimum [disk](../../concepts/disk.md) size:
     * If you know the [image family](../../concepts/image.md#family), get info on the latest image in that family:

       ```bash
       export IAM_TOKEN=CggaATEVAgA...
       export FAMILY=ubuntu-1804
       curl \
         --header "Authorization: Bearer ${IAM_TOKEN}" \
         "https://compute.{{ api-host }}/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"
       ```

     * You can get information on the image from the [list of public images](../images-with-pre-installed-software/get-list.md).
  1. Get the [subnet](../../../vpc/concepts/network.md#subnet) and [availability zone](../../../overview/concepts/geo-scope.md) IDs. In your request, specify the ID of the folder where the subnet was created:

     ```bash
     export IAM_TOKEN=CggaATEVAgA...
     export FOLDER_ID=b1gvmob95yys********
     curl \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       "https://vpc.{{ api-host }}/vpc/v1/subnets?folderId=${FOLDER_ID}"
     ```

     Result:

     ```
     {
       "subnets": [
        {
          "v4CidrBlocks": [
            "10.130.0.0/24"
          ],
          "id": "b0c6n43ftldh********",
          "folderId": "b1gvmob95yys********",
          "createdAt": "2018-09-23T12:15:00Z",
          "name": "default-{{ region-id }}-a",
          "description": "Auto-created default subnet for zone {{ region-id }}-a",
          "networkId": "enpe3m3faglu********",
          "zoneId": "{{ region-id }}-a"
        },
        ...
       ]
     }
     ```

  1. Create a file, e.g., `body.json`, with the body of the request to create a VM:

     ```json
     {
       "folderId": "b1gvmob95yys********",
       "name": "instance-demo-no-pwauth",
       "zoneId": "{{ region-id }}-a",
       "platformId": "standard-v3",
       "resourcesSpec": {
         "memory": "2147483648",
         "cores": "2"
       },
       "metadata": {
         "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ssh-ed25519 AAAAB3N... user@example.com"
       },
       "bootDiskSpec": {
         "diskSpec": {
           "size": "2621440000",
           "imageId": "fd8rc75pn12f********"
         }
       },
       "networkInterfaceSpecs": [
         {
           "subnetId": "b0c6n43ftldh********",
           "primaryV4AddressSpec": {
             "oneToOneNatSpec": {
               "ipVersion": "IPV4"
             }
           }
         }
       ]
     }
     ```

     Where:
     * `folderId`: Folder ID.
     * `name`: Name the VM will get when created.
     * `zoneId`: Availability zone matching the selected subnet.
     * `platformId`: [Platform](../../concepts/vm-platforms.md).
     * `resourceSpec`: Resources available to the VM. The values must match the selected platform.
     * `metadata`: In metadata, provide the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
     * `bootDiskSpec`: Boot disk settings. Specify the selected image ID and disk size.

       {% include [id-info](../../../_includes/compute/id-info.md) %}

       The disk size must not be less than the minimum value specified in the image info.
     * `networkInterfaceSpecs`: VM [network interface](../../concepts/network.md) settings.
       * `subnetId`: ID of the selected subnet.
       * `primaryV4AddressSpec`: IP address to assign to the VM. To add a [public IP address](../../../vpc/concepts/address.md#public-addresses) to your VM, specify the following:

         ```json
         "primaryV4AddressSpec": {
           "oneToOneNatSpec": {
             "ipVersion": "IPV4"
           }
         }
         ```
       To add multiple [network interfaces](../../concepts/network.md) to your VM, provide an array with the required number of objects containing network interface settings in the `networkInterfaceSpecs` parameter. You can add up to eight network interfaces to a single VM.

     For more information about the request body format, see the [API reference](../../api-ref/Instance/create.md).
  1. Create a VM:

     ```bash
     export IAM_TOKEN=CggaATEVAgA...
     curl \
       --request POST \
       --header "Content-Type: application/json" \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       --data '@body.json' \
       https://compute.{{ api-host }}/compute/v1/instances
     ```

  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../vm-connect/ssh.md)