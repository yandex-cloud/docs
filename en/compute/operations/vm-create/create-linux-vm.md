# Creating a VM from a public Linux image

This section provides guidelines for creating a VM with a Linux OS. To create a Windows-based VM, follow the instructions [{#T}](create-windows-vm.md).

{% list tabs %}

- Management console

  {% include [create-instance-via-console-linux](../../_includes_service/create-instance-via-console-linux.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for creating a VM:

      ```
      $ yc compute instance create --help
      ```

  1. Prepare the key pair (public and private keys) for SSH access to the VM.
  1. Select a public [image](../images-with-pre-installed-software/get-list.md) based on a Linux OS (for example, CentOS 7).

      {% include [standard-images](../../../_includes/standard-images.md) %}
  1. Select a subnet:
      ```bash
      $ yc vpc subnet list
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      | b0c6n43f9lgh3695v2k2 | default-ru-central1-c | enpe3m3fa00udao8g5lg |                | ru-central1-c | [10.130.0.0/24] |
      | e2l2da8a20b33g7o73bv | default-ru-central1-b | enpe3m3fa00udao8g5lg |                | ru-central1-b | [10.129.0.0/24] |
      | e9bnlm18l70ao30pvfaa | default-ru-central1-a | enpe3m3fa00udao8g5lg |                | ru-central1-a | [10.128.0.0/24] |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      ```
  1. Create a VM in the default folder. Specify the following parameters:

      - `name`: VM name.

        {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      - `zone`: Availability zone that corresponds to the selected subnet.
      - `subnet-name`: Name of the selected subnet.
      - `image-family`: [Family of images](../../concepts/image.md#family), such as `centos-7`. This option lets you install the latest version of the operating system from the specified family.
      - Public IP. To create a VM without a public IP address, disable the `nat-ip-version=ipv4` option.
      - `ssh-key`: Path to the public SSH key. The user `yc-user` will be automatically created on the VM for this key.

      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
          --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
          --ssh-key ~/.ssh/id_rsa.pub
      ```

      This creates a VM named `first-instance`.
- API

  Create a VM using the method [Create](../../api-ref/Instance/create.md) for the resource `Instance`:

  1. Prepare the key pair (public and private keys) for SSH access to the VM.
  1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) for authenticating in the examples:
     * [Instructions](../../../iam/operations/iam-token/create.md) for users with a Yandex account.
     * [Instructions](../../../iam/operations/iam-token/create-for-sa.md) for a service account.
  1. [Get the ID](../../../resource-manager/operations/folder/get-id.md) of the folder.
  1. Get information about the image to create your virtual machine from (image ID and minimum disk size):
      * If you know the [image family](../../concepts/image.md#family), get information about the latest image in this family:
          ```bash
          $ export IAM_TOKEN=CggaATEVAgA...
          $ export FAMILY=ubuntu-1804
          $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
            "https://compute.api.cloud.yandex.net/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"
          ```
      * You can get information about the image from the [list of public images](../images-with-pre-installed-software/get-list.md).
  1. Get the subnet ID and availability zone ID. Specify the ID of the folder where the subnet was created in your request:

      ```bash
      $ export IAM_TOKEN=CggaATEVAgA...
      $ export FOLDER_ID=b1gvmob95yysaplct532
      $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        "https://vpc.api.cloud.yandex.net/vpc/v1/subnets?folderId=${FOLDER_ID}"
      {
       "subnets": [
        {
         "v4CidrBlocks": [
          "10.130.0.0/24"
         ],
         "id": "b0c6n43ftldh30l0vfg2",
         "folderId": "b1gvmob95yysaplct532",
         "createdAt": "2018-09-23T12:15:00Z",
         "name": "default-ru-central1-c",
         "description": "Auto-created default subnet for zone ru-central1-c",
         "networkId": "enpe3m3fagludao8aslg",
         "zoneId": "ru-central1-c"
        },
        ...
       ]
      }
      ```
  1. Create a file where the body contains your request for VM creation (for example, `body.json`). Specify the following parameters:

      * `folderId`: ID of the folder.
      * `name`: Name to be assigned to the VM when it's created.
      * `zoneId`: Availability zone that corresponds to the selected subnet.
      * `platformId`: The [platform](../../concepts/vm-platforms.md).
      * `resourceSpec`: Resources available to the VM. The values must match the selected platform.
      * `metadata`: In the metadata, pass the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
      * `bootDiskSpec`: Boot disk settings. Specify the ID of the selected image and disk size. The disk size must not be below the minimum value specified in the image details.
      * `networkInterfaceSpecs`: Network settings.
        * `subnetId`: ID of the selected subnet.
        * `primaryV4AddressSpec`: IP address to be assigned to the VM. To add a [public IP address](../../../vpc/concepts/address.md#public-addresses) to your virtual machine, specify:
            ```
            "primaryV4AddressSpec": {
                "oneToOneNatSpec": {
                  "ipVersion": "IPV4"
                }
              }
            ```

      Read more about the request body format in the [API reference](../../api-ref/Instance/create.md) API method.

      Example `body.json` file:
      ```json
      {
        "folderId": "b1gvmob95yysaplct532",
        "name": "instance-demo-no-pwauth",
        "zoneId": "ru-central1-c",
        "platformId": "standard-v1",
        "resourcesSpec": {
          "memory": "2147483648",
          "cores": "2",
        },
        "metadata": {
          "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ssh-rsa AAAAB3N... user@example.com"
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
  1. Create a virtual machine:

      ```bash
      $ export IAM_TOKEN=CggaATEVAgA...
      $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        https://compute.api.cloud.yandex.net/compute/v1/instances
      ```

- Terraform

  If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. In the configuration file, describe the parameters of resources that you want to create:

       {% note info %}

       If you already have suitable resources, such as a cloud network and subnet, you don't need to describe them again. Use their names and IDs in the appropriate parameters.

       {% endnote %}

     * `yandex_compute_instance`: Description of the [VM](../../concepts/vm.md):
       * `name`: VM name.
       * `platform_id`: The [platform](../../concepts/vm-platforms.md).
       * `resources`: The number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
       * `boot_disk`: Boot disk settings. Specify the ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
       * `network_interface`: Network settings. Specify the ID of the selected subnet. To automatically assign a public IP address to the VM, set `nat = true`.
       * `metadata`: In the metadata, pass the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet`: Description of the [subnet](../../../vpc/concepts/network.md#network) that the VM will be connected to.

     Example configuration file structure:

     ```
     resource "yandex_compute_instance" "vm-1" {
     
       name        = "linux-vm"
       platform_id = "standard-v2"
     
       resources {
         cores  = <number of vCPU cores>
         memory = <RAM in GB>
       }
     
       boot_disk {
         initialize_params {
           image_id = "<image ID>"
         }
       }
     
       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }
     
       metadata = {
         ssh-keys = "<user name>:<SSH key contents>"
       }
     }
     
     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }
     
     resource "yandex_vpc_subnet" "subnet-1" {
       name       = "subnet1"
       zone       = "<availability zone>"
       network_id = "${yandex_vpc_network.network-1.id}"
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  2. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     2. Run the check using the command:

        ```
        $ terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  3. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```
        $ terraform apply
        ```

     2. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in [management console]({{ link-console-main }}).

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### See also {#see-also}

- [{#T}](../vm-connect/ssh.md)

