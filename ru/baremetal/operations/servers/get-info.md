---
title: Как получить информацию о сервере {{ baremetal-full-name }}
description: 'Следуя данной инструкции, вы сможете получить информацию о настройках сервера {{ baremetal-full-name }}: конфигурация сервера, сетевые настройки, операционная система и другие данные.'
---

# Получить информацию о сервере

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервер.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** и в открывшемся списке серверов выберите нужный сервер.

      На открывшейся странице доступны следующие сведения:

      * В блоке **{{ ui-key.yacloud.common.overview }}** — общая информация о сервере, в т.ч. его имя, идентификатор, [статус](../../concepts/servers.md#server-status), [зона доступности](../../../overview/concepts/geo-scope.md) и [пул серверов](../../concepts/servers.md#server-pools).
      * В блоке **{{ ui-key.yacloud.baremetal.title_section-resources }}** — информация об аппаратной [конфигурации](../../concepts/server-configurations.md) сервера.
      * В блоке **{{ ui-key.yacloud.baremetal.title_section-server-marketplace-app }}** — информация об установленной на сервере операционной системе.
      * В блоке **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** — информация о [публичной сети](../../concepts/public-network.md) сервера, в т.ч. идентификатор, тип и CIDR публичной подсети, адрес шлюза по умолчанию и [MAC-адреса](https://ru.wikipedia.org/wiki/MAC-адрес) сетевого интерфейса в публичной сети.
      * В блоке **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}** — информация о [приватной сети](../../concepts/private-network.md) сервера, в т.ч. о [приватной подсети](../../concepts/private-network.md#private-subnet), а также приватный IP-адрес и MAC-адреса сетевого интерфейса в приватной сети.
      * В блоке **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}** — информация об условиях аренды сервера, в т.ч. о периоде и сроке аренды, и ее автопродлении.
      * В блоках **{{ ui-key.yacloud.baremetal.title_section-backup }}** и **{{ ui-key.yacloud.baremetal.title_section-accesses }}** — информация о подключении сервера к [{{ backup-full-name }}](../../../backup/index.yaml) и публичный [SSH-ключ](../../../glossary/ssh-keygen.md) root-пользователя соответственно.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды для получения информации о сервере:

      ```bash
      yc baremetal server get --help
      ```

   1. Получите информацию о сервере:

      ```bash
      yc baremetal server get <имя_или_идентификатор_сервера>
      ```

- API {#api}

  Чтобы получить информацию о сервере, воспользуйтесь методом REST API [get](../../api-ref/Server/get.md) для ресурса [Server](../../api-ref/Server/index.md) или вызовом gRPC API [ServerService/Get](../../api-ref/grpc/Server/get.md).

{% endlist %}

## Пример {#example}

Получите информацию о сервере:

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
   -H "Authorization: Bearer <IAM-токен>" \
   -d '{}' \
   "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<идентификатор_сервера>"
  ```

  Где:

  * `<IAM-токен>` — IAM-токен для аутентификации.
  * `<идентификатор_сервера>` — идентификатор сервера.

  Результат:

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

  Где:

  * `id` — идентификатор сервера.
  * `cloudId` — идентификатор облака.
  * `folderId` — идентификатор каталога.
  * `name` — имя сервера.

    {% include [name-format](../../../_includes/name-format.md) %}

  * `zoneId` — идентификатор зоны доступности.
  * `hardwarePoolId` — идентификатор [пула](../../concepts/servers.md#server-pools) размещения сервера.
  * `status` — статус сервера. Возможные значения:
    * `PROVISIONING` — сервер ожидает выделения из пула оборудования.
    * `RUNNING` — сервер работает нормально.
    * `STOPPED` — сервер остановлен.
    * `ERROR` — сервер столкнулся с проблемой и не может работать.
    * `DELETING` — сервер удаляется.
    * `REINSTALLING` — переустанавливается операционная система сервера.
  * `configurationId` — идентификатор [конфигурации сервера](../../concepts/server-configurations.md).
  * `osSettings` — (опционально) настройки операционной системы сервера. Будет пустым, если сервер создан без ОС.
  * `networkInterfaces` — сетевые интерфейсы, подключенные к серверу.
  * `disks` — диски, подключенные к серверу.
  * `createdAt` — время создания в формате RFC3339.  

{% endlist %}