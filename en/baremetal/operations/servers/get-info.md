---
title: How to get {{ baremetal-full-name }} server information
description: 'Follow this guide to get information about the {{ baremetal-full-name }} server settings: server configuration, network settings, operating system, and other data.'
---

# Getting information about a server

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the server belongs to.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** and, in the list of servers that opens, select the one you need.

      The page offers the following information:

      * Under **{{ ui-key.yacloud.common.overview }}**, general information about the server, including its name, ID, [status](../../concepts/servers.md#server-status), [availability zone](../../../overview/concepts/geo-scope.md), and [server pool](../../concepts/servers.md#server-pools).
      * Under **{{ ui-key.yacloud.baremetal.title_section-resources }}**, information about the server's hardware [configuration](../../concepts/server-configurations.md).
      * Under **{{ ui-key.yacloud.baremetal.title_section-server-marketplace-app }}**, information about the operating system installed on the server.
      * Under **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}**, information about the server's [public network](../../concepts/public-network.md), including the ID, type, and CIDR of the public subnet, default gateway address, and [MAC address](https://en.wikipedia.org/wiki/MAC_address) of the network interface in the public network.
      * Under **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}**, information about the server's [private network](../../concepts/private-network.md), including the [private subnet](../../concepts/private-network.md#private-subnet), as well as the private IP and MAC address of the network interface in the private network.
      * Under **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}**, information about the terms of server lease, including lease period/duration and auto-renewal.
      * Under **{{ ui-key.yacloud.baremetal.title_section-backup }}** and **{{ ui-key.yacloud.baremetal.title_section-accesses }}**, information about the server's connection to [{{ backup-full-name }}](../../../backup/index.yaml) and public SSH key of the root user, respectively.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the command for getting information about a server:

      ```bash
      yc baremetal server get --help
      ```

   1. Get information about the server:

      ```bash
      yc baremetal server get <server_name_or_ID>
      ```

- API {#api}

  To get information about a server, use the [get](../../api-ref/Server/get.md) REST API method for the [Server](../../api-ref/Server/index.md) resource or the [ServerService/Get](../../api-ref/grpc/Server/get.md) gRPC API call.

{% endlist %}

## Example {#example}

Get information about the server:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal server get demo-baremetal-server
  ```

  {% include [server-lease-cli-result](../../../_includes/baremetal/instruction-steps/server-lease-cli-result.md) %}

- API {#api}

  ```bash
  curl -X GET \
   -H "Content-Type: application/json" \
   -H "Authorization: Bearer <IAM_token>" \
   -d '{}' \
   "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<server_ID>"
  ```

  Where:

  * `<IAM_token>`: IAM token used for authentication.
  * `<server_ID>`: Server ID.

  Result:

  ```json
  {
    "osSettings": {
      "storages": [
        {
          "partitions": [
            {
              "type": "EXT3",
              "sizeGib": "9",
              "mountPoint": "/boot"
            },
            {
              "type": "SWAP",
              "sizeGib": "4"
            },
            {
              "type": "EXT4",
              "mountPoint": "/"
            }
          ],
          "raid": {
            "disks": [
              {
                "id": "ly536lgz5cdo********",
                "type": "HDD",
                "sizeGib": "1862"
              },
              {
                "id": "ly55nr77qcgq********",
                "type": "HDD",
                "sizeGib": "1862"
              },
              {
                "id": "ly57e5ouat4r********",
                "type": "HDD",
                "sizeGib": "1862"
              },
              {
                "id": "ly5g77vbnavh********",
                "type": "HDD",
                "sizeGib": "1862"
              }
            ],
            "type": "RAID10"
          }
        }
      ],
      "imageId": "ly5vyzcggvci********",
      "sshPublicKey": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMYMj0PbB7ObhwL0z3y+vN0BfNKwLm0u7DWw4D********"
    },
    "networkInterfaces": [
      {
        "privateSubnet": {
          "privateSubnetId": "ly55shvlzvy4********"
        },
        "id": "ly5j33j44gtc********",
        "macAddress": "00:25:90:e9:49:98"
      },
      {
        "publicSubnet": {
          "publicSubnetId": "ly5bss2zvuae********"
        },
        "id": "ly5rmqqchyep********",
        "macAddress": "00:25:90:e9:49:99"
      }
    ],
    "id": "ly56xpblirh4********",
    "cloudId": "b1gia87mbaom********",
    "folderId": "b1g07hj5r6i4********",
    "name": "bm-server-test",
    "zoneId": "ru-central1-m",
    "hardwarePoolId": "ru-central1-m4",
    "status": "PROVISIONING",
    "configurationId": "ly5fcdnlzp7j********",
    "createdAt": "2025-12-07T19:09:42.520760Z"
  }
  ```

  Where:

  * `id`: Server ID.
  * `cloudId`: Cloud ID.
  * `folderId`: Folder ID.
  * `name`: Server name.

    {% include [name-format](../../../_includes/name-format.md) %}

  * `zoneId`: Availability zone ID.
  * `hardwarePoolId`: Server [pool](../../concepts/servers.md#server-pools) ID.
  * `status`: Server status. The possible values are:
    * `PROVISIONING`: Server is waiting to be allocated from the hardware pool.
    * `RUNNING`: Server is running normally.
    * `STOPPED`: Server is stopped.
    * `ERROR`: Server encountered an issue and is unavailable.
    * `DELETING`: Server deletion is in progress.
    * `REINSTALLING`: Reinstalling server OS.
  * `configurationId`: [Server configuration](../../concepts/server-configurations.md) ID.
  * `osSettings`: Server OS settings. This is an optional field. It will be empty if the server is created without an OS.
  * `networkInterfaces`: Network interfaces connected to the server.
  * `disks`: Disks connected to the server.
  * `createdAt`: Creation time in RFC3339 format.  

{% endlist %}