[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > [Пошаговые инструкции](../index.md) > Серверы > Получить информацию о сервере

# Получить информацию о сервере

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервер.
  1. [Перейдите](https://console.yandex.cloud/link/baremetal) в сервис **BareMetal** и в открывшемся списке серверов выберите нужный сервер.

      На открывшейся странице доступны следующие сведения:

      * В блоке **Обзор** — общая информация о сервере, в т.ч. его имя, идентификатор, [статус](../../concepts/servers.md#server-status), [зона доступности](../../../overview/concepts/geo-scope.md) и [пул серверов](../../concepts/servers.md#server-pools).
      * В блоке **Ресурсы** — информация об аппаратной [конфигурации](../../concepts/server-configurations.md) сервера.
      * В блоке **Приложение Marketplace** — информация об установленной на сервере операционной системе.
      * В блоке **Сетевые интерфейсы**:
          * В разделе **Интерфейс 1** — информация о [публичной сети](../../concepts/public-network.md) сервера, в т.ч. идентификатор, тип и CIDR публичной подсети, адрес шлюза по умолчанию и [MAC-адреса](https://ru.wikipedia.org/wiki/MAC-адрес) сетевого интерфейса в публичной сети.
          * В разделе **Интерфейс 2** — информация о [приватной сети](../../concepts/private-network.md) сервера, в т.ч. о [приватной подсети](../../concepts/private-network.md#private-subnet), а также приватный IP-адрес и MAC-адреса сетевого интерфейса в приватной сети.

      * В блоке **Условия аренды** — информация об условиях аренды сервера, в т.ч. о периоде и сроке аренды, и ее автопродлении.
      * В блоках **Резервное копирование** и **Доступы** — информация о подключении сервера к [Yandex Cloud Backup](../../../backup/index.md) и публичный [SSH-ключ](../../../glossary/ssh-keygen.md) root-пользователя соответственно.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
   
   Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  Результат:
  
  ```text
  done (22m45s)
  id: ly52dtzdi55r********
  cloud_id: b1gia87mbaom********
  folder_id: b1g0ijbfaqsn********
  name: demo-baremetal-server
  description: My first BareMetal server
  zone_id: ru-central1-m
  hardware_pool_id: ru-central1-m4
  status: PROVISIONING
  os_settings:
    image_id: ly5vhn4lapev********
    ssh_public_key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQYnYYjAoj********
    storages:
      - partitions:
          - type: EXT3
            size_gib: "999"
            mount_point: /
          - type: EXT4
            size_gib: "499"
            mount_point: /root
        raid:
          type: RAID0
          disks:
            - id: ly5ual3jbnhr********
              type: HDD
              size_gib: "1862"
            - id: ly54qfjw55d4********
              type: HDD
              size_gib: "1862"
      - partitions:
          - type: EXT3
            size_gib: "999"
            mount_point: /boot
          - type: SWAP
            size_gib: "9"
        disk:
          id: ly5ojffpngul********
          type: HDD
          size_gib: "1862"
  network_interfaces:
    - id: ly5wbsiklrtd********
      mac_address: 00:25:90:92:fa:48
      private_subnet:
        private_subnet_id: ly5ztavbezrf********
    - id: ly5ygl4loyy6********
      mac_address: 00:25:90:92:fa:49
      public_subnet:
        public_subnet_id: ly5o6l7pxmk2********
  configuration_id: ly5lymxdltk3xitpkrmi
  created_at: "2025-07-06T21:53:46.186130Z"
  labels:
    env: test
  ```

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

    * длина — от 3 до 63 символов;
    * может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * первый символ — буква, последний — не дефис.

  * `zoneId` — идентификатор зоны доступности.
  * `hardwarePoolId` — идентификатор [пула](../../concepts/servers.md#server-pools) размещения сервера.
  * `status` — статус сервера. Возможные значения:
    * `ASSEMBLING` — сервер в [своей конфигурации](../../concepts/server-custom-configurations.md) собирается в дата-центре.
    * `PROVISIONING` — сервер готовится к предоставлению в аренду пользователю.
    * `RUNNING` — сервер включен и полностью доступен пользователю.
    * `STOPPING` — на сервере выключается электропитание.
    * `STOPPED` — сервер выключен.
    * `STARTING` — на сервере включается электропитание.
    * `RESTARTING` — сервер перезагружается.
    * `REINSTALLING` — на сервере переустанавливается операционная система.
    * `UPDATING` — происходит обновление настроек сервера или сети.
    * `MAINTENANCE` — сервер находится на техническом обслуживании.
    * `QUARANTINED` — сервер в [карантине](../../concepts/servers.md#quarantine) и недоступен пользователю по сети и через KVM-консоль.
    * `DELETING` — сервер удаляется.
    * `ERROR` — произошла ошибка, KVM-консоль недоступна. Обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

    Подробнее в разделе [Статусы серверов](../../concepts/servers.md#server-status).

  * `configurationId` — идентификатор [конфигурации сервера](../../concepts/server-configurations.md).
  * `osSettings` — (опционально) настройки операционной системы сервера. Будет пустым, если сервер создан без ОС.
  * `networkInterfaces` — сетевые интерфейсы, подключенные к серверу.
  * `disks` — диски, подключенные к серверу.
  * `createdAt` — время создания в формате RFC3339.  

{% endlist %}