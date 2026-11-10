---
title: Как переустановить ОС на сервере {{ baremetal-name }} из образа {{ marketplace-short-name }}
description: Следуя данной инструкции, вы сможете переустановить операционную систему сервера {{ baremetal-full-name }} из образа {{ marketplace-short-name }}.
---

# Переустановить операционную систему из образа {{ marketplace-short-name }}

{{ marketplace-short-name }} — это каталог предварительно настроенных образов операционных систем доступных для установки на серверы {{ baremetal-name }}.

{{ baremetal-full-name }} позволяет переустановить операционную систему сервера из публичного [образа {{ marketplace-short-name }}](../../concepts/images.md#marketplace-images). При переустановке вы можете выбрать любую доступную в {{ marketplace-short-name }} для серверов {{ baremetal-name }} операционную систему, а также перераспределить дисковое пространство, пересобрать RAID-массивы и перенастроить параметры доступа root-пользователя.

{% note warning %}

После переустановки операционной системы данные с дисков будут удалены. Конфигурация сервера не изменится.

{% endnote %}

Чтобы переустановить операционную систему сервера {{ baremetal-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный сервер.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![ArrowsRotateLeft](../../../_assets/console-icons/arrows-rotate-left.svg) **{{ ui-key.yacloud.baremetal.action_reinstall-server-os-menu }}**.
  1. В открывшемся окне:

      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите один из доступных образов ОС.
      1. {% include [server-lease-step8](../../../_includes/baremetal/instruction-steps/server-lease-step8.md) %}

          Если не вносить изменений в разметку дисков, на сервере сохранятся заданные ранее настройки RAID-массивов и распределения дискового пространства.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_reinstall-server-os }}** и дождитесь переустановки операционной системы сервера.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для переустановки ОС:

     ```bash
     yc baremetal v2 server reinstall --help
     ```

  1. {% include [server-lease-cli-image-list](../../../_includes/baremetal/instruction-steps/server-lease-cli-image-list.md) %}

  1. Переустановите ОС:

     ```bash
     yc baremetal v2 server reinstall \
       --id <идентификатор_сервера> \
       --os-settings '{
         image-id="<идентификатор_образа>",
         ssh-key=ssh-public-key-text="<содержимое_открытого_SSH-ключа>",
         password=password-plain-text="<пароль_пользователя>",
         storages=[{
           partitions=[{
             type=<файловая_система>,
             size-bytes=<размер_раздела_в_байтах>,
             mount-point="<точка_монтирования>"
           }],
           storage-type=raid={
             type=<уровень_RAID-массива>,
             disks=[{id="<номер_диска>",size-bytes=<размер_диска_в_байтах>,type=<тип_диска>}]
           }
         }]
       }'
     ```

     Где:
     * `--id` — идентификатор сервера. Чтобы узнать его, [получите информацию о сервере](./get-info.md).
     * {% include [server-lease-cli-os](../../../_includes/baremetal/instruction-steps/server-lease-cli-os.md) %}
     * {% include [server-lease-cli-storage](../../../_includes/baremetal/instruction-steps/server-lease-cli-storage.md) %}

- API {#api}

  Чтобы переустановить операционную систему сервера, воспользуйтесь методом REST API [reinstall](../../api-ref/Server/reinstall.md) для ресурса [Server](../../api-ref/Server/index.md) или вызовом gRPC API [ServerService/Reinstall](../../api-ref/grpc/Server/reinstall.md).

{% endlist %}

## Пример {#example}

Переустановите операционную систему:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal v2 server reinstall \
    --id ly52dtzdi55r******** \
    --os-settings '{
      image-id="ly5vtno2mjr3********",
      ssh-key=ssh-public-key-text="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQ********",
      password=password-lockbox-secret={secret-id="e6qmvglkitn6********",version-id="e6qquvv4kh8e********",key="password"}
    }' \
    --format yaml
  ```

  Пример результата:

  ```yaml
  server_id: ly52dtzdi55r********
  cloud_id: b1gia87mbaom********
  folder_id: b1g0ijbfaqsn********
  name: demo-baremetal-server
  description: My first BareMetal server
  hardware_pool_id: ru-central1-m4
  state: RUNNING
  os_settings:
    image_id: ly5vtno2mjr3********
    ssh_public_key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQYnYYjAoj********
  network_interfaces:
    - network_interface_id: ly5wbsiklrtd********
      mac_address: 00:25:90:92:fa:48
      private_interface:
        native_subnet_id: ly5ztavbezrf********
    - network_interface_id: ly5ygl4loyy6********
      mac_address: 00:25:90:92:fa:49
      public_interface:
        native_subnet_id: ly5o6l7pxmk2********
  stock_configuration_id: ly5lymxdltk3********
  create_time: "2025-07-06T21:53:46.186130Z"
  annotations:
    env: test
  ```

- API {#api}

  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '{
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
      "sshPublicKey": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMYMj0PbB7ObhwL0z3y+vN0BfNK********",
      "passwordLockboxSecret": {
        "secretId": "e6q44i0gmlrh********",
        "versionId": "e6q3ba84ur0a********",
        "key": "password"
      }
     }
    }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<идентификатор_сервера>:reinstall"
  ```

  Где:

  * `<идентификатор_сервера>` — идентификатор сервера, который нужно изменить. Чтобы узнать идентификатор, воспользуйтесь [инструкцией](get-info.md).

  {% include [ossettingsspec-api-legend](../../../_includes/baremetal/ossettingsspec-api-legend.md) %}

  Результат:

  ```bash
  {
    "done": false,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.ReinstallServerMetadata",
      "serverId": "ly56xpblirh4********"
    },
    "id": "ly5ryflh7v5p********",
    "description": "Server reinstall",
    "createdAt": "2025-12-07T20:47:23.928014Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-07T20:47:23.928014Z"
  }
  ```

  Отслеживайте статус операции по полю `done`.

{% endlist %}
