---
title: Как отказаться от аренды сервера в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете отказаться от аренды сервера в {{ baremetal-full-name }}.
---

# Отказаться от аренды сервера

После отказа от аренды сервер проработает до конца оплаченного периода, а затем будет удален.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.action_stop-prolongation-server }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.baremetal.action_stop-prolongation-server-dialog }}**.

- API {#api}

  Чтобы отказаться от аренды сервера, воспользуйтесь методом REST API [StopProlongation](../../api-ref/Server/stopProlongation.md) для ресурса [Server](../../api-ref/Server/index.md) или вызовом gRPC API [ServerService/StopProlongation](../../api-ref/grpc/Server/stopProlongation.md).

  Выполните команду:

  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '{}' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<идентификатор_сервера>:stopProlongation"
  ```

  Где:

  * `<IAM-токен>` — IAM-токен для аутентификации.
  * `<идентификатор_сервера>` — идентификатор сервера, который нужно изменить. Чтобы узнать идентификатор, воспользуйтесь [инструкцией](get-info.md).

  Результат:

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

  Отслеживайте статус операции по полю `done`.

{% endlist %}
