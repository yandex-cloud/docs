---
title: Как изменить сервер в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете изменить имя или описание сервера в {{ baremetal-full-name }}.
---

# Изменить сервер

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервер.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Внесите изменения в конфигурацию сервера:

      * (Опционально) В поле **{{ ui-key.yacloud.baremetal.field_name_dFuVW }}** измените имя сервера. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * (Опционально) В поле **{{ ui-key.yacloud.baremetal.field_description_f2tds }}** добавьте или измените описание сервера.
      * (Опционально) В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** добавьте или измените [метки](../../../resource-manager/concepts/labels.md) сервера.
      * (Опционально) В блоке **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}** измените продолжительность периода аренды сервера.

          {% note info %}

          Изменения в настройке продолжительности периода аренды вступят в силу только по истечении текущего периода, на который был арендован сервер.

          {% endnote %}
      
      * (Опционально) В полях **{{ ui-key.yacloud.baremetal.field_subnet-id }}** и **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** измените [сетевые настройки](../../concepts/network.md) сервера.
      * (Опционально) В поле **{{ ui-key.yacloud.baremetal.servers.BandwidthRow.bandwidthTitle_wvZra }}** измените пакет [потребления трафика сервера](../../concepts/network-restrictions.md#bandwidth-for-pubic-network). Доступные пакеты потребления трафика:

          * `{{ ui-key.yacloud.baremetal.servers.BandwidthRow.plan10Tb_2BFQU }}`;
          * `{{ ui-key.yacloud.baremetal.servers.BandwidthRow.plan100Tb_4AB2b }}`.

          {% note info %}

          Возможность выбора пакетов трафика доступна только для конфигураций с публичным IP-адресом и сетевыми картами со скоростью соединения 10 Гбит/с и выше.

          После увеличения емкости подключения уменьшить ее можно будет не раньше, чем через 24 часа.

          {% endnote %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды для изменения сервера:

      ```bash
      yc baremetal server update --help
      ```

   1. Измените сервер:

      ```bash
      yc baremetal server update \
        --name <имя_сервера> \
        --new-name <новое_имя_сервера> \
        --description <новое_описание_сервера> \
        --network-interfaces private-subnet-id=<идентификатор_новой_приватной_подсети> \
        --network-interfaces public-subnet-id=<идентификатор_новой_публичной_подсети> \
        --labels <ключ_метки>=<значение_метки>
      ```

      Где:
      * `--name` — имя сервера.
      * `--new-name` — новое имя сервера. Необязательный параметр.
      * `--description` — новое описание сервера. Необязательный параметр.
      * `--network-interfaces` — новые сетевые настройки. Необязательный параметр. Возможные значения:
        
        * `private-subnet-id` — идентификатор новой [приватной подсети](../../concepts/network.md#private-subnet).
        * `public-subnet-id` — идентификатор новой [выделенной публичной подсети](../../concepts/network.md#public-subnet).

      * `--labels` — новые метки сервера. Необязательный параметр.

- API {#api}

  Чтобы изменить сервер, воспользуйтесь методом REST API [update](../../api-ref/Server/update.md) для ресурса [Server](../../api-ref/Server/index.md) или вызовом gRPC API [ServerService/Update](../../api-ref/grpc/Server/update.md).

{% endlist %}

## Пример {#example}

Измените имя, описание и сетевые настройки сервера:

{% list tabs group=instructions %}

- CLI {#cli}

   ```bash
     yc baremetal server update \
       --name demo-baremetal-server  \
       --new-name new-demo-baremetal-server  \
       --description "Updated BareMetal server" \
       --network-interfaces private-subnet-id=ly5rljahs3re******** \
       --network-interfaces public-subnet-id=ly5vr6tugxk7********
   ```

   Результат:

   ```bash
   id: ly52dtzdi55r********
   cloud_id: b1gia87mbaom********
   folder_id: b1g0ijbfaqsn********
   name: new-demo-baremetal-server
   description: Updated BareMetal server
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
   configuration_id: ly5lymxdltk3********
   created_at: "2025-07-06T21:53:46.186130Z"
   labels:
     env: test
   ```

- API {#api}

  ```bash
  curl -X PATCH \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '{
      "updateMask": "name,description,networkInterfaces",
      "name": "new-bm-server-test",
      "description": "Updated BareMetal server",
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
            "publicSubnetId": "ly52yjugkj57********"
          },
          "id": "ly5rmqqchyep********",
          "macAddress": "00:25:90:e9:49:99"
        }
      ]
    }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<идентификатор_сервера>"
  ```

  Где:
  * `<IAM-токен>` — IAM-токен для аутентификации.
  * `<идентификатор_сервера>` — идентификатор сервера, который нужно изменить. Чтобы узнать идентификатор, воспользуйтесь [инструкцией](get-info.md).
  * `updateMask` — список полей для обновления, разделенный запятыми. Будут изменены только указанные поля. Если поле указано в `updateMask`, но значение не передано в запросе, поле будет сброшено к значению по умолчанию.
  * `name` — новое имя сервера. Имя должно быть уникальным в рамках каталога.

    {% include [name-format](../../../_includes/name-format.md) %}

  * `description` — новое описание сервера.
  * `networkInterfaces[]` — новые сетевые настройки. Необязательный параметр. Возможные значения:
    * `privateSubnetId` — идентификатор новой [приватной подсети](../../concepts/network.md#private-subnet).
    * `publicSubnetId` — идентификатор новой [выделенной публичной подсети](../../concepts/network.md#public-subnet).
  
  Результат:

  ```bash
  {
    "done": false,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.UpdateServerMetadata",
      "serverId": "ly56xpblirh4********"
    },
    "id": "ly5k7jdyevbh********",
    "description": "Server update",
    "createdAt": "2025-12-07T20:03:43.637004Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-07T20:03:43.637004Z"
  }
  ```

  Отслеживайте статус операции по полю `done`.

{% endlist %}