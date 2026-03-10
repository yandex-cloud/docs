---
title: How to lease a {{ baremetal-full-name }} server in a stock configuration
description: Follow this guide to lease a {{ baremetal-full-name }} server in one of its stock configurations.
---

# Leasing a stock configuration server

You can lease a [{{ baremetal-name }} server](../../concepts/servers.md) in one of the [stock configurations](../../concepts/server-configurations.md#standard).

However, if you need a server with some non-standard hardware specifications, you can [configure](./custom-server-lease.md) one yourself.

To lease a server in a stock configuration:

{% list tabs group=instructions %}

- Management console {#console}

  1. {% include [server-lease-step1](../../../_includes/baremetal/instruction-steps/server-lease-step1.md) %}
  1. {% include [server-lease-step2](../../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. {% include [server-lease-step3](../../../_includes/baremetal/instruction-steps/server-lease-step3.md) %}
  1. In the server configuration window that opens, do the following:

      1. {% include [server-lease-step4](../../../_includes/baremetal/instruction-steps/server-lease-step4.md) %}
      1. {% include [server-lease-step5](../../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
      1. {% include [server-lease-step6](../../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}
      1. {% include [server-lease-step7-bm](../../../_includes/baremetal/instruction-steps/server-lease-step7-bm.md) %}
      1. {% include [server-lease-step8](../../../_includes/baremetal/instruction-steps/server-lease-step8.md) %}
      1. {% include [server-lease-step9-bm](../../../_includes/baremetal/instruction-steps/server-lease-step9-bm.md) %}
      1. {% include [server-lease-step10-bm](../../../_includes/baremetal/instruction-steps/server-lease-step10-bm.md) %}
      1. If you are installing an OS from a {{ marketplace-short-name }} public image, specify server access settings under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

      1. Optionally, enable server backup in [{{ backup-full-name }}](../../../backup/index.yaml):

          {% include [server-lease-step11](../../../_includes/baremetal/instruction-steps/server-lease-step11.md) %}

          For more information, see [{#T}](../../../backup/operations/backup-baremetal/lease-server-with-backup.md).
      1. {% include [server-lease-step12](../../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}
      1. {% include [server-lease-step13](../../../_includes/baremetal/instruction-steps/server-lease-step13.md) %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. {% include [server-lease-cli-step1](../../../_includes/baremetal/instruction-steps/server-lease-cli-step1.md) %}

   1. {% include [server-lease-cli-step2](../../../_includes/baremetal/instruction-steps/server-lease-cli-step2.md) %}

   1. {% include [server-lease-cli-step3](../../../_includes/baremetal/instruction-steps/server-lease-cli-step3.md) %}

      Where:
      * {% include [server-lease-cli-pool-id](../../../_includes/baremetal/instruction-steps/server-lease-cli-pool-id.md) %}
      * {% include [server-lease-cli-configuration](../../../_includes/baremetal/instruction-steps/server-lease-cli-configuration.md) %}
      * {% include [server-lease-cli-storage](../../../_includes/baremetal/instruction-steps/server-lease-cli-storage.md) %}
      * {% include [server-lease-cli-os](../../../_includes/baremetal/instruction-steps/server-lease-cli-os.md) %}

        {% include [server-lease-step7-iso](../../../_includes/baremetal/instruction-steps/server-lease-step7-iso.md) %}

      * {% include [server-lease-cli-rental-period](../../../_includes/baremetal/instruction-steps/server-lease-cli-rental-period.md) %}

        {% include [server-lease-step6-period](../../../_includes/baremetal/instruction-steps/server-lease-step6-period.md) %}

      * {% include [server-lease-cli-network](../../../_includes/baremetal/instruction-steps/server-lease-cli-network.md) %}

          {% note warning %}

          {% include [public-subnet-no-dhcp](../../../_includes/baremetal/public-subnet-no-dhcp.md) %}

          {% endnote %}

      {% include [server-lease-cli-general](../../../_includes/baremetal/instruction-steps/server-lease-cli-general.md) %}

- API {#api}

  To lease a server, use the [create](../../api-ref/Server/create.md) REST API method for the [Server](../../api-ref/Server/index.md) resource or the [ServerService/Create](../../api-ref/grpc/Server/create.md) gRPC API call.

{% endlist %}

Once you lease a server, you can install or reinstall the OS at any time using either a {{ marketplace-name }} public image or your own custom ISO. For more information, see [{#T}](./reinstall-os-from-marketplace.md) and [{#T}](./reinstall-os-from-own-image.md).

## Example {#example}

Lease a server with a public OS image:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal server create \
    --hardware-pool-id ru-central1-m4 \
    --configuration-id ly5lymxdltk3******** \
    --storage "partition={type=EXT3,size-gib=1000,mount-point=/},partition={type=EXT4,size-gib=500,mount-point=/root},raid-type=RAID0,disk={id=1,size-gib=1862,type=HDD},disk={id=2,size-gib=1862,type=HDD}" \
    --storage "partition={type=EXT3,size-gib=1000,mount-point=/boot},partition={type=SWAP,size-gib=10},disk={id=3,size-gib=1862,type=HDD}" \
    --os-settings "image-id=ly5vhn4lapev********,ssh-key-public=ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQYnYYjAoj********,password-lockbox-secret={secret-id=e6qmvglkitn6********,version-id=e6qquvv4kh8e********,key=password}" \
    --rental-period-id 1-day \
    --network-interfaces private-subnet-id=ly5ztavbezrf******** \
    --network-interfaces public-subnet-id=ly5o6l7pxmk2********* \
    --name demo-baremetal-server \
    --description "My first BareMetal server" \
    --labels env=test
  ```

  {% include [server-lease-cli-result](../../../_includes/baremetal/instruction-steps/server-lease-cli-result.md) %}

- API {#api}

  ```bash
  curl -X POST \
   -H "Content-Type: application/json" \
   -H "Authorization: Bearer <IAM_token>" \
   -d '{
     "folderId": "b1g07hj5r6i4********",
     "name": "bm-test-server",
     "description": "New Test Baremetal Server",
     "hardwarePoolId": "ru-central1-m3",
     "configurationId": "ly5fcdnlzp7j********",
     "rentalPeriodId": "1-day",
     "networkInterfaces": [
       {
         "privateSubnet": {
           "privateSubnetId": "ly52xefxa2hi********"
         }
       },
       {
         "publicSubnet": {
           "publicSubnetId": "ly52yjugkj57********"
         }
       }
     ],
     "osSettingsSpec": {
       "imageId": "ly5vyzcggvci********",
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
             "type": "RAID10",
             "disks": [
               {
                 "id": "1",
                 "type": "HDD",
                 "sizeGib": "1862"
               },
               {
                 "id": "2",
                 "type": "HDD",
                 "sizeGib": "1862"
               },
               {
                 "id": "3",
                 "type": "HDD",
                 "sizeGib": "1862"
               },
               {
                 "id": "4",
                 "type": "HDD",
                 "sizeGib": "1862"
               }
             ]
           }
         }
       ],
       "sshPublicKey": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMYMj0PbB7ObhwL0********",
       "passwordLockboxSecret": {
         "secretId": "e6q44i0gmlrh********",
         "versionId": "e6q3ba84ur0a********",
         "key": "password"
       }
     },
     "labels": {
       "key": "bms"
     }
   }' \
   "POST https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<server_ID>"
  ```

  Where:
  * `folderId`: ID of the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your server.
  * `name`: Server name. The name must be unique within the folder.

    {% include [name-format](../../../_includes/name-format.md) %}

  * `description`: Server description. This is an optional parameter.
  * `labels`: Resource labels in `key:value` format. This is an optional parameter.
  * `hardwarePoolId`: ID of the [pool](../../concepts/servers.md#server-pools) to lease a server from.
  * `configurationId`: [Server configuration](../../concepts/server-configurations.md) ID.
  * `rentalPeriodId`: Server lease period. The possible values are `1-day`, `1-month`, `3-months`, `6-months` or `1-year`.
  * `networkInterfaces[]`: Network interfaces:
    * `id`: Network interface ID. It is not specified when creating a server.
    * `privateSubnetId`: [Private subnet](../../concepts/private-network.md#private-subnet) ID.
    * `publicSubnetId`: [Dedicated public subnet](../../concepts/public-network.md#public-subnet) ID. This is an optional parameter.

      {% note warning %}

      {% include [public-subnet-no-dhcp](../../../_includes/baremetal/public-subnet-no-dhcp.md) %}

      {% endnote %}

  {% include [ossettingsspec-api-legend](../../../_includes/baremetal/ossettingsspec-api-legend.md) %}

  Result:

  ```bash
  {
    "id": "e0q5abc123def4********",
    "description": "Server create",
    "createdAt": "2025-12-14T18:03:38.240Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-14T18:03:38.240Z",
    "done": true,
    "metadata": {
      "serverId": "ly56xpblirh4********"
    },
    "response": {
      "id": "ly56xpblirh4********",
      "cloudId": "b1g07hj5r6i4********",
      "folderId": "b1g07hj5r6i4********",
      "name": "bm-test-server",
      "description": "New Test Baremetal Server",
      "zoneId": "ru-central1",
      "hardwarePoolId": "ru-central1-m3",
      "status": "PROVISIONING",
      "osSettings": {
        "imageId": "ly5vyzcggvci********",
        "sshPublicKey": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMYMj0PbB7ObhwL0z3********",
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
              "type": "RAID10",
              "disks": [
                {
                  "id": "1",
                  "type": "HDD",
                  "sizeGib": "1862"
                },
                {
                  "id": "2",
                  "type": "HDD",
                  "sizeGib": "1862"
                },
                {
                  "id": "3",
                  "type": "HDD",
                  "sizeGib": "1862"
                },
                {
                  "id": "4",
                  "type": "HDD",
                  "sizeGib": "1862"
                }
              ]
            }
          }
        ]
      },
      "networkInterfaces": [
        {
          "id": "e0q5abc123def4********",
          "macAddress": "00:1a:4b:23:*:*",
          "ipAddress": "192.168.*.*",
          "privateSubnet": {
            "privateSubnetId": "ly52xefxa2hi********"
          }
        },
        {
          "id": "e0q5abc123def4********",
          "macAddress": "00:1a:4b:23:*:*",
          "ipAddress": "93.158.*.*",
          "publicSubnet": {
            "publicSubnetId": "ly52yjugkj57********"
          }
        }
      ],
      "configurationId": "ly5fcdnlzp7j********",
      "disks": [
        {
          "id": "1",
          "type": "HDD",
          "sizeGib": "1862"
        },
        {
          "id": "2",
          "type": "HDD",
          "sizeGib": "1862"
        },
        {
          "id": "3",
          "type": "HDD",
          "sizeGib": "1862"
        },
        {
          "id": "4",
          "type": "HDD",
          "sizeGib": "1862"
        }
      ],
      "createdAt": "2025-12-14T18:03:38.240Z",
      "labels": {
        "key": "bms"
      }
    }
  }
  ```

  Follow the status of the operation by the `done` field.

{% endlist %}

#### See also {#see-also}

* [{#T}](./custom-server-lease.md)