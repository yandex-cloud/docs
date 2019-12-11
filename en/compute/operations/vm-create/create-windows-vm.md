# Creating a VM from a Windows public image

This section provides guidelines on how to create a VM with the Windows OS. To create a Linux-based VM, follow the instructions [{#T}](create-linux-vm.md).

To create a VM:

{% list tabs %}

- Management console

  {% include [create-instance-via-console-windows](../../_includes_service/create-instance-via-console-windows.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {% include [create-instance-via-cli-windows](../../_includes_service/create-instance-via-cli-windows.md) %}

- API

  Create a VM using the method [Create](../../api-ref/Instance/create.md) for the resource `Instance`:

  1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) for authenticating in the examples:
     * [Instructions](../../../iam/operations/iam-token/create.md) for users with a Yandex account.
     * [Instructions](../../../iam/operations/iam-token/create-for-sa.md) for a service account.

  1. [Get the ID](../../../resource-manager/operations/folder/get-id.md) of the folder.

  1. Get information about the image to create your virtual machine from (image ID and minimum disk size):
      * If you know the [image family](../../concepts/image.md#family), get information about the latest image in this family:

          ```bash
          $ export IAM_TOKEN=CggaATEVAgA...
          $ export FAMILY=windows-2016-gvlk
          $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
            "https://compute.api.cloud.yandex.net/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"

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
           "description": "Windows Server 2016 Datacenter is a operating system for virtualized private cloud environments. This version is activated with GVLK. Website and documentation: https://www.microsoft.com/en-us/cloud-platform/windows-server",
           "family": "windows-2016-gvlk",
           "storageSize": "26344423424",
           "minDiskSize": "26843545600",
           "status": "READY"
          }
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

      * `metadata`: In the [metadata](../../concepts/vm-metadata.md) `user-data` property, you need to pass the script with the administrator password, for example:

          ```json
          "metadata": {
            "user-data": "#ps1\nnet user Administrator Passw0rd"
          },
          ```

          {% include [include](../../../_includes/compute/password-requirements.md) %}

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

      Read more about the request body format in the [API reference](../../api-ref/Instance/create.md).

      Example `body.json` file:

      ```json
      {
        "folderId": "b1gvmob95yysaplct532",
        "name": "instance-demo-no-pwauth",
        "zoneId": "ru-central1-c",
        "platformId": "standard-v1",
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
        https://compute.api.cloud.yandex.net/compute/v1/instances
      ```

{% endlist %}

{% include [initialization-windows-vm](../../../_includes/initialization-windows-vm.md) %}

When a VM is being created, it is assigned an IP address and FQDN. You can use this data to access the VM via RDP.

You can make a public IP address static. Learn more in [{#T}](../vm-control/vm-set-static-ip.md).

#### See also

- [{#T}](../vm-connect/rdp.md)

