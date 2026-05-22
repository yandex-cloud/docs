---
title: How to cancel a server lease in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to cancel a server lease in {{ baremetal-full-name }}.
---

# Canceling a server lease

After canceling the lease, the server will remain active until the paid period ends, after which it will be automatically deleted.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.baremetal.action_stop-prolongation-server }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.baremetal.action_stop-prolongation-server-dialog }}**.

- API {#api}

  To cancel a server lease, use the [StopProlongation](../../api-ref/Server/stopProlongation.md) REST API method for the [Server](../../api-ref/Server/index.md) resource or the [ServerService/StopProlongation](../../api-ref/grpc/Server/stopProlongation.md) gRPC API call.

  Run this command:

  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM_token>" \
    -d '{}' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<server_ID>:stopProlongation"
  ```

  Where:

  * `<IAM_token>`: IAM token used for authentication.
  * `<server_ID>`: ID of the server you want to update. To find out the ID, follow [this guide](get-info.md).

  Result:

  ```bash
  {
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.ServerSetProlongationMetadata",
      "serverId": "ly56xpblirh4********"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.Server",
      "osSettings": {
        "storages": [
          {
            "partitions": [
              {
                "type": "EXT3",
                "sizeGib": "8",
                "mountPoint": "/boot"
              },
              {
                "type": "SWAP",
                "sizeGib": "3"
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
        "sshPublicKey": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMYMj0PbB7ObhwL0z3y+vN0BfNKw********"
      },
      "id": "ly56xpblirh4********",
      "cloudId": "b1gia87mbaom********",
      "folderId": "b1g07hj5r6i4********",
      "name": "baremetal-server",
      "description": "New BareMetal server",
      "zoneId": "ru-central1-m",
      "hardwarePoolId": "ru-central1-m4",
      "status": "RUNNING",
      "configurationId": "ly5fcdnlzp7j********",
      "createdAt": "2025-12-07T19:09:42.520760Z"
    },
    "id": "ly5qkpfcxlpn********",
    "description": "Server set prolongation non renewal",
    "createdAt": "2025-12-08T08:04:20.893300Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-08T08:04:20.893300Z"
  }
  ```

  Follow the status of the operation by the `done` field.

{% endlist %}
