---
title: Как арендовать сервер в {{ baremetal-full-name }} в стандартной конфигурации
description: Следуя данной инструкции, вы сможете арендовать сервер в {{ baremetal-full-name }} в одной из стандартных конфигураций.
---

# Арендовать сервер в готовой конфигурации

Вы можете арендовать [сервер {{ baremetal-name }}](../../concepts/servers.md) в одной из [готовых конфигураций](../../concepts/server-configurations.md#standard).

Если же ваша задача требует от сервера каких-то нетиповых аппаратных характеристик, вы можете сами [сконфигурировать](./custom-server-lease.md) ваш сервер.

Чтобы арендовать сервер в стандартной конфигурации:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. {% include [server-lease-step1](../../../_includes/baremetal/instruction-steps/server-lease-step1.md) %}
  1. {% include [server-lease-step2](../../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. {% include [server-lease-step3](../../../_includes/baremetal/instruction-steps/server-lease-step3.md) %}
  1. В открывшемся окне с настройками конфигурации сервера:

      1. {% include [server-lease-step4](../../../_includes/baremetal/instruction-steps/server-lease-step4.md) %}
      1. {% include [server-lease-step5](../../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
      1. {% include [server-lease-step6](../../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}
      1. {% include [server-lease-step7-bm](../../../_includes/baremetal/instruction-steps/server-lease-step7-bm.md) %}
      1. {% include [server-lease-step8](../../../_includes/baremetal/instruction-steps/server-lease-step8.md) %}
      1. {% include [server-lease-step9-bm](../../../_includes/baremetal/instruction-steps/server-lease-step9-bm.md) %}
      1. {% include [server-lease-step10-bm](../../../_includes/baremetal/instruction-steps/server-lease-step10-bm.md) %}
      1. Если вы устанавливаете на сервер операционную систему из публичного образа в {{ marketplace-short-name }}, в блоке **{{ ui-key.yacloud.baremetal.title_server-access }}** задайте параметры доступа к серверу:

          {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

      1. (Опционально) Включите резервное копирование сервера в [{{ backup-full-name }}](../../../backup/index.yaml):

          {% include [server-lease-step11](../../../_includes/baremetal/instruction-steps/server-lease-step11.md) %}

          Подробнее см. в инструкции [{#T}](../../../backup/operations/backup-baremetal/lease-server-with-backup.md).
      1. {% include [server-lease-step12](../../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}
      1. {% include [server-lease-step13](../../../_includes/baremetal/instruction-steps/server-lease-step13.md) %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. {% include [server-lease-cli-step1](../../../_includes/baremetal/instruction-steps/server-lease-cli-step1.md) %}

   1. {% include [server-lease-cli-step2](../../../_includes/baremetal/instruction-steps/server-lease-cli-step2.md) %}

   1. {% include [server-lease-cli-step3](../../../_includes/baremetal/instruction-steps/server-lease-cli-step3.md) %}

      Где:
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

  Чтобы арендовать сервер, воспользуйтесь методом REST API [create](../../api-ref/Server/create.md) для ресурса [Server](../../api-ref/Server/index.md) или вызовом gRPC API [ServerService/Create](../../api-ref/grpc/Server/create.md).

{% endlist %}

После того как вы арендуете сервер, вы в любой момент сможете установить или переустановить на нем операционную систему из публичного образа в {{ marketplace-name }} или из собственного ISO-образа. Подробнее см. в инструкциях [{#T}](./reinstall-os-from-marketplace.md) и [{#T}](./reinstall-os-from-own-image.md).

## Пример {#example}

Арендуйте сервер с публичным образом ОС:

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
   -H "Authorization: Bearer <IAM-токен>" \
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
   "POST https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<идентификатор_сервера>"
  ```

  Где:
  * `folderId` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан сервер.
  * `name` — имя сервера. Имя должно быть уникальным в рамках каталога.

    {% include [name-format](../../../_includes/name-format.md) %}

  * `description` — описание сервера. Необязательный параметр.
  * `labels` — метки ресурса в формате `ключ:значение`. Необязательный параметр.
  * `hardwarePoolId` — идентификатор [пула](../../concepts/servers.md#server-pools), из которого будет арендован сервер.
  * `configurationId` — идентификатор [конфигурации сервера](../../concepts/server-configurations.md).
  * `rentalPeriodId` — период аренды сервера. Возможные значения: `1-day`, `1-month`, `3-months`, `6-months` или `1-year`.
  * `networkInterfaces[]` — сетевые интерфейсы:
    * `id` — идентификатор сетевого интерфейса. Не указывается при создании сервера.
    * `privateSubnetId` — идентификатор [приватной подсети](../../concepts/network.md#private-subnet).
    * `publicSubnetId` — идентификатор [выделенной публичной подсети](../../concepts/network.md#public-subnet). Необязательный параметр.

      {% note warning %}

      {% include [public-subnet-no-dhcp](../../../_includes/baremetal/public-subnet-no-dhcp.md) %}

      {% endnote %}

  {% include [ossettingsspec-api-legend](../../../_includes/baremetal/ossettingsspec-api-legend.md) %}

  Результат:

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

  Отслеживайте статус операции по полю `done`.

{% endlist %}

#### См. также {#see-also}

* [{#T}](./custom-server-lease.md)