# Creating a VM from a Windows public image


This section provides guidelines on how to create a VM with the Windows OS. To create a Linux-based VM, follow the instructions [{#T}](create-linux-vm.md).

{% include [ms-licensing-personal-data](../../../_includes/ms-licensing-personal-data.md) %}

{% list tabs %}

- Management console

   {% include [create-instance-via-console-windows](../../_includes_service/create-instance-via-console-windows.md) %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   {% include [create-instance-via-cli-windows](../../_includes_service/create-instance-via-cli-windows.md) %}

- API

   Create a VM using the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource:

   1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) used for authentication in the examples:
      * [Instructions](../../../iam/operations/iam-token/create.md) for users with a Yandex account.
      * [Instructions](../../../iam/operations/iam-token/create-for-sa.md) for a service account.
   1. [Get the ID](../../../resource-manager/operations/folder/get-id.md) of the folder.
   1. Get information about the image to create your virtual machine from (image ID and minimum disk size):
      * If you know the [image family](../../concepts/image.md#family), retrieve information on this family's latest image:
         ```bash
         $ export IAM_TOKEN=CggaATEVAgA...
         $ export FAMILY=windows-2016-gvlk
         $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
           "https://compute.{{ api-host }}/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"

         {
          "productIds": [
           "f2eu62v659or2tqv28l0"
          ],
          "os": {
           "type": "WINDOWS"
          },
          "id": "fd85s1nlcavgdpc16hj3",
          "folderId": "standard-images",
          "createdAt": "2019-04-30T10:53:56Z",
          "name": "windows-2016-gvlk-1556619485",
          "description": "Windows Server 2016 Datacenter is a operating system for virtualized private cloud environments. This version is activated with GVLKs. Website and documentation: https://www.microsoft.com/en-us/cloud-platform/windows-server",
          "family": "windows-2016-gvlk",
          "storageSize": "26344423424",
          "minDiskSize": "26843545600",
          "status": "READY"
         }
         ```
      * To learn more about the image, see the [list of public images](../images-with-pre-installed-software/get-list.md).
   1. Get the subnet ID and availability zone ID. Specify the ID of the folder where the subnet was created in your request:

      ```bash
      $ export IAM_TOKEN=CggaATEVAgA...
      $ export FOLDER_ID=b1gvmob95yysaplct532
      $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
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
   1. Create a file where the body contains your request for VM creation (for example, `body.json`). Specify the following parameters:

      * `folderId`: ID of the folder.
      * `name`: Name to be assigned to the VM when it's created.
      * `zoneId`: Availability zone that corresponds to the selected subnet.
      * `platformId`: The [platform](../../concepts/vm-platforms.md).
      * `resourceSpec`: Resources available to the VM. The values must match the selected platform.
      * `metadata`: In the [metadata's](../../concepts/vm-metadata.md) `user-data` property, you need to pass the script with the administrator password, for example:

         ```json
         "metadata": {
           "user-data": "#ps1\nnet user Administrator Passw0rd"
         },
         ```

         {% include [include](../../../_includes/compute/password-requirements.md) %}

      * `bootDiskSpec`: Boot disk settings. Specify the ID of the selected image and disk size. The disk size must not be below the minimum value specified in the image details.
      * `networkInterfaceSpecs`: Network settings.
         * `subnetId`: ID of the selected subnet.
         * `primaryV4AddressSpec`: IP address to be assigned to the VM. To add a [public IP](../../../vpc/concepts/address.md#public-addresses) to your VM, please specify:
            ```
            "primaryV4AddressSpec": {
                "oneToOneNatSpec": {
                  "ipVersion": "IPV4"
                }
              }
            ```

      Read more about the request body format in the [API reference](../../api-ref/Instance/create.md).

      Example `body.json` file:
      ```json
      {
        "folderId": "b1gvmob95yysaplct532",
        "name": "instance-demo-no-pwauth",
        "zoneId": "{{ region-id }}-a",
        "platformId": "standard-v3",
        "resourcesSpec": {
          "memory": "4294967296",
          "cores": "2",
        },
        "metadata": {
          "user-data": "#ps1\nnet user Administrator Passw0rd"
        },
        "bootDiskSpec": {
          "diskSpec": {
            "size": "26843545600",
            "imageId": "fd85s1nlcavgdpc16hj3"
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
        https://compute.{{ api-host }}/compute/v1/instances
      ```

- Terraform

   If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
         * `metadata`: In the [metadata's](../../concepts/vm-metadata.md) in the `user-data` parameter, pass the script with the administrator password.
      * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).
      * `yandex_vpc_subnet`: Description of [subnet](../../../vpc/concepts/network.md#subnet) your virtual machine will connect to.

      Example configuration file structure:

      ```
      resource "yandex_compute_instance" "vm-1" {

        name        = "windows-vm"
        platform_id = "standard-v3"

        resources {
          cores  = <number of vCPU cores>
          memory = <RAM amount, GB>
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
          user-data = "#ps1\nnet user Administrator <admin password>"
        }
      }

      resource "yandex_vpc_network" "network-1" {
        name = "network1"
      }

      resource "yandex_vpc_subnet" "subnet-1" {
        name       = "subnet1"
        zone       = "<availability zone>"
        network_id = "${yandex_vpc_network.<network name>.id}"
      }
      ```

      For more information about resources that you can create with Terraform, please see the [provider documentation]({{ tf-provider-link }}/).

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

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}

{% include [initialization-windows-vm](../../../_includes/initialization-windows-vm.md) %}

The administrator password you entered when creating the VM is saved as clear-text metadata, which is why we recommend [resetting it](../vm-control/vm-reset-password.md).

You can make a public IP address static. For more information, see [{#T}](../vm-control/vm-set-static-ip.md).

#### See also {#see-also}

- [{#T}](../vm-connect/rdp.md)
