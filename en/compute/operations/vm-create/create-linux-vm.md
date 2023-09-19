---
title: "Creating a Linux VM from a public image"
description: "Use this tutorial to create a Linux VM."
---

# Creating a VM from a public Linux image


{% list tabs %}

- Management console


   {% include [create-instance-via-console-linux](../../_includes_service/create-instance-via-console-linux.md) %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI create VM command:

      ```bash
      yc compute instance create --help
      ```

   1. [Prepare](../vm-connect/ssh.md#creating-ssh-keys) a key pair (public and private keys) for SSH access to the VM.
   1. Select a Linux-based public [image](../images-with-pre-installed-software/get-list.md) from {{ marketplace-full-name }}, e.g., [CentOS 7](/marketplace/products/yc/centos-7).

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
      | b0c6n43f9lgh3695v2k2 | default-{{ region-id }}-c | enpe3m3fa00udao8g5lg |                | {{ region-id }}-c | [10.130.0.0/24] |
      | e2l2da8a20b33g7o73bv | default-{{ region-id }}-b | enpe3m3fa00udao8g5lg |                | {{ region-id }}-b | [10.129.0.0/24] |
      | e9bnlm18l70ao30pvfaa | default-{{ region-id }}-a | enpe3m3fa00udao8g5lg |                | {{ region-id }}-a | [10.128.0.0/24] |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      ```

   1. Create a VM in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc compute instance create \
        --name first-instance \
        --zone {{ region-id }}-a \
        --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```

      Where:
      * `name`: VM name.

         {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) that corresponds to the selected subnet.
      * `subnet-name`: Name of the selected subnet.
      * `image-family`: [Image family](../../concepts/image.md#family), such as `centos-7`. This option allows you to install the latest version of the OS from the specified family.
      * `nat-ip-version=ipv4`: [Public IP address](../../../vpc/concepts/address.md#public-addresses). To create a VM without a public IP, disable this parameter.
      * `ssh-key`: Path to the public SSH key. The VM will automatically create a user named `yc-user` for this key.


   {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

- API

   Create a VM using the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource:
   1. [Prepare](../vm-connect/ssh.md#creating-ssh-keys) a key pair (public and private keys) for SSH access to the VM.
   1. Get an [{{ iam-full-name }} token](../../../iam/concepts/authorization/iam-token.md) used for authentication in the examples:

      
      * [Instructions](../../../iam/operations/iam-token/create.md) for users with a Yandex account.


      * [Guide](../../../iam/operations/iam-token/create-for-sa.md) for a [service account](../../../iam/concepts/users/service-accounts.md).
      * [Instructions](../../../iam/operations/iam-token/create-for-federation.md) for a federated account.
   1. [Get the ID](../../../resource-manager/operations/folder/get-id.md) of the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
   1. Get information about the [image](../../concepts/image.md) to create your VM from (image ID and minimum [disk](../../concepts/disk.md) size):
      * If you know the [image family](../../concepts/image.md#family), get information about the latest image in this family:

         ```bash
         export IAM_TOKEN=CggaATEVAgA...
         export FAMILY=ubuntu-1804
         curl -H "Authorization: Bearer ${IAM_TOKEN}" \
           "https://compute.{{ api-host }}/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"
         ```

      * To learn more about the image, see the [list of public images](../images-with-pre-installed-software/get-list.md).
   1. Get the [subnet](../../../vpc/concepts/network.md#subnet) and [availability zone](../../../overview/concepts/geo-scope.md) IDs. Specify the ID of the folder where the subnet was created in your request:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      export FOLDER_ID=b1gvmob95yysaplct532
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        "https://vpc.{{ api-host }}/vpc/v1/subnets?folderId=${FOLDER_ID}"
      {
        "subnets": [
         {
           "v4CidrBlocks": [
             "10.130.0.0/24"
           ],
           "id": "b0c6n43ftldh30l0vfg2",
           "folderId": "b1gvmob95yysaplct532",
           "createdAt": "2018-09-23T12:15:00Z",
           "name": "default-{{ region-id }}-a",
           "description": "Auto-created default subnet for zone {{ region-id }}-a",
           "networkId": "enpe3m3fagludao8aslg",
           "zoneId": "{{ region-id }}-a"
         },
         ...
        ]
      }
      ```

   1. Create a file `named body.json` with the body of the request to create a VM:

      ```json
      {
        "folderId": "b1gvmob95yysaplct532",
        "name": "instance-demo-no-pwauth",
        "zoneId": "{{ region-id }}-a",
        "platformId": "standard-v3",
        "resourcesSpec": {
          "memory": "2147483648",
          "cores": "2"
        },
        "metadata": {
          "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ssh-ed25519 AAAAB3N... user@example.com"
        },
        "bootDiskSpec": {
          "diskSpec": {
            "size": "2621440000",
            "imageId": "fd8rc75pn12fe3u2dnmb"
          }
        },
        "networkInterfaceSpecs": [
          {
            "subnetId": "b0c6n43ftldh30l0vfg2",
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
      * `name`: Name assigned to the VM upon creation.
      * `zoneId`: Availability zone that corresponds to the selected subnet.
      * `platformId`: [Platform](../../concepts/vm-platforms.md).
      * `resourceSpec`: Resources available to the VM. The values must match the selected platform.
      * `metadata`: In the metadata, provide the public key for VM access via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
      * `bootDiskSpec`: Boot disk settings. Specify the selected image's ID and disk size.

        {% include [id-info](../../../_includes/compute/id-info.md) %}

        The disk size must be not less than the minimum value specified in the image details.
      * `networkInterfaceSpecs`: [Network](../../../vpc/concepts/network.md#network) settings.
         * `subnetId`: ID of the selected subnet.
         * `primaryV4AddressSpec`: IP address to assign to the VM. To add a [public IP](../../../vpc/concepts/address.md#public-addresses) to your VM, specify:

            ```json
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
            ```

      Read more about the request body format in the [API reference](../../api-ref/Instance/create.md).
   1. Create a VM:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        https://compute.{{ api-host }}/compute/v1/instances
      ```

   {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {

        name                      = "linux-vm"
        allow_stopping_for_update = true
        platform_id               = "standard-v3"
        zone                      = "<availability_zone>"

        resources {
          cores  = "<number_of_vCPU_cores>"
          memory = "<amount_of_RAM_in_GB>"
        }

        boot_disk {
          initialize_params {
            image_id = "<image_ID>"
          }
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
      * `yandex_compute_instance`: Description of the VM:
         * `name`: VM name.
         * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
         * `platform_id`: [Platform](../../concepts/vm-platforms.md).
         * `zone`: ID of the [availability zone](../../../overview/concepts/geo-scope.md) that will host your VM.
         * `resources`: Number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
         * `boot_disk`: Boot [disk](../../concepts/disk.md) settings. Specify the ID of the selected [image](../../concepts/image.md). You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
         * `network_interface`: [Network](../../../vpc/concepts/network.md#network) settings. Specify the ID of the selected [subnet](../../../vpc/concepts/network.md#subnet). To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.
         * `metadata`: In the metadata, provide the public SSH key for accessing the VM. For more information, see [{#T}](../../concepts/vm-metadata.md).
      * `yandex_vpc_network`: Description of the cloud network.
      * `yandex_vpc_subnet`: Description of the subnet your VM will connect to.

      {% note info %}

      If you already have suitable resources, such as a cloud network and subnet, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

   {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../vm-connect/ssh.md)