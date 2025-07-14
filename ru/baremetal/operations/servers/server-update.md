---
title: Как изменить сервер в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете изменить имя или описание сервера в {{ baremetal-full-name }}.
---

# Изменить сервер

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. При необходимости измените имя, описание, метки, продолжительность периода аренды и сетевые настройки сервера.

      {% note info %}

      Изменения в настройке продолжительности периода аренды вступят в силу только по истечении текущего периода, на который был арендован сервер.

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
        --network-interfaces private-subnet-id=ly5rljahs3re4gw7bf6l \
        --network-interfaces public-subnet-id=ly5vr6tugxk75fynutzt
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
    configuration_id: ly5lymxdltk3xitpkrmi
    created_at: "2025-07-06T21:53:46.186130Z"
    labels:
      env: test
    ```

 {% endlist %}