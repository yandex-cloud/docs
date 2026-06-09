# Переустановить операционную систему из образа Marketplace

Marketplace — это каталог предварительно настроенных образов операционных систем доступных для установки на серверы BareMetal.

Yandex BareMetal позволяет переустановить операционную систему сервера из публичного [образа Marketplace](../../concepts/images.md#marketplace-images). При переустановке вы можете выбрать любую доступную в Marketplace для серверов BareMetal операционную систему, а также перераспределить дисковое пространство, пересобрать RAID-массивы и перенастроить параметры доступа root-пользователя.

{% note warning %}

После переустановки операционной системы данные с дисков будут удалены. Конфигурация сервера не изменится.

{% endnote %}

Чтобы переустановить операционную систему сервера BareMetal:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится нужный сервер.
  1. Перейдите в сервис **BareMetal**.
  1. В строке с нужным сервером нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![ArrowsRotateLeft](../../../_assets/console-icons/arrows-rotate-left.svg) **Переустановить ОС**.
  1. В открывшемся окне:

      1. В блоке **Образ** выберите один из доступных образов ОС.
      1. (Опционально) В блоке **Диск** настройте разметку [дисков](../../concepts/disks/disk-types.md):
         
         1. Нажмите кнопку **Настроить разделы диска**.
         1. Укажите параметры разделов. Чтобы создать новый раздел, нажмите кнопку ![icon](../../../_assets/console-icons/plus.svg) **Добавить раздел**.
         
             Чтобы самостоятельно собрать [RAID](../../concepts/disks/raid.md)-массивы и настроить разделы дисков, нажмите кнопку **Разобрать RAID**.
         1. Нажмите кнопку **Сохранить**.

          Если не вносить изменений в разметку дисков, на сервере сохранятся заданные ранее настройки RAID-массивов и распределения дискового пространства.
      1. В блоке **Доступ**:

          1. В поле **Пароль** воспользуйтесь одним из вариантов создания пароля для root-пользователя:
          
              * Чтобы сгенерировать пароль для root-пользователя, выберите опцию `Новый пароль` и нажмите кнопку **Сгенерировать**.
          
                  {% note warning %}
                  
                  Этот вариант предусматривает ответственность пользователя за безопасность пароля. Сохраните сгенерированный пароль в надежном месте: он не сохраняется в Yandex Cloud, и после заказа сервера вы не сможете посмотреть его.
                  
                  {% endnote %}
          
              * Чтобы использовать пароль root-пользователя, сохраненный в [секрете](../../../lockbox/concepts/secret.md) Yandex Lockbox, выберите опцию `Секрет Lockbox`:
          
                  В полях **Имя**, **Версия** и **Ключ** выберите соответственно секрет, его версию и ключ, в которых сохранен ваш пароль.
                  
                  Если у вас еще нет секрета Yandex Lockbox, нажмите кнопку **Создать**, чтобы создать его.
          
                  Этот вариант позволяет вам как задать собственный пароль (тип секрета `Пользовательский`), так и использовать пароль, сгенерированный автоматически (тип секрета `Генерируемый`).
          
          1. В поле **Открытый SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
          
              Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
              
              1. Нажмите кнопку **Добавить ключ**.
              1. Задайте имя SSH-ключа.
              1. Выберите вариант:
              
                  * `Ввести вручную` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
                  * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
                  * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
                  
                    При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
              
              1. Нажмите кнопку **Добавить**.
              
              SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

      1. Нажмите кнопку **Переустановить** и дождитесь переустановки операционной системы сервера.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   1. Посмотрите описание команды для переустановки ОС:

      ```bash
      yc baremetal server reinstall --help
      ```

   1. Переустановите ОС:

      ```bash
      yc baremetal server reinstall \
        --name <имя_сервера> \
        --os-settings "image-id=<идентификатор_образа>,image-name=<имя_образа>,ssh-key-public=<содержимое_открытого_SSH-ключа>,ssh-key-user-id=<идентификатор_пользователя_SSH-ключа>,password-plain-text=<пароль_пользователя>,password-lockbox-secret={secret-id=<идентификатор_секрета>,version-id=<версия_секрета>,key=<ключ_секрета>}" \
        --storage "partition={type=<файловая_система>,size-gib=<размер_раздела>,mount-point=<точка_монтирования>},raid-type=<уровень RAID-массива>,disk={id=<номер_диска>,size-gib=<размер_диска>,type=<тип_диска>}"
      ```

      Где:
      * `--name` — имя сервера.
      * `--os-settings` — настройки операционной системы. Чтобы арендовать сервер без операционной системы, пропустите этот параметр. Возможные настройки:
        
        * `image-id` — идентификатор одного из доступных [публичных образов](../../concepts/images.md#marketplace-images) ОС в Yandex Cloud Marketplace.
        * `image-name` — имя одного из доступных публичных образов ОС в Yandex Cloud Marketplace.
        * `ssh-key-public` — содержимое открытого SSH-ключа. Пару SSH-ключей для подключения к серверу по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
        * `ssh-key-user-id` — идентификатор пользователя SSH-ключа.
        * `password-plain-text` — пароль root-пользователя.
        
          {% note warning %}
          
          Этот вариант предусматривает ответственность пользователя за безопасность пароля. Сохраните сгенерированный пароль в надежном месте: он не сохраняется в Yandex Cloud, и после заказа сервера вы не сможете посмотреть его.
          
          {% endnote %}
        
        * `password-lockbox-secret` — [секрет](../../../lockbox/concepts/secret.md) Yandex Lockbox:
          * `secret-id` — идентификатор секрета.
          * `version-id` — версия секрета.
          * `key` — ключ секрета.
      * `--storage` — настройки разметки [дисков](../../concepts/disks/disk-types.md). Необязательный параметр. Возможные настройки:
        
        * `partition` — раздел диска:
          
          * `type` — файловая система. Возможные значения: `Ext3`, `Ext4`, `Swap`, `Xfs`.
          * `size-gib` — размер раздела в гигабайтах.
          * `mount-point` — точка монтирования.
        
        * `disk` — диск:
          
          * `id` — номер диска.
          * `size-gib` — размер диска в гигабайтах.
          * `type` — тип диска
        * `raid-type` — [уровень RAID-массива](../../concepts/disks/raid.md#levels).

- API {#api}

  Чтобы переустановить операционную систему сервера, воспользуйтесь методом REST API [reinstall](../../api-ref/Server/reinstall.md) для ресурса [Server](../../api-ref/Server/index.md) или вызовом gRPC API [ServerService/Reinstall](../../api-ref/grpc/Server/reinstall.md).

{% endlist %}

## Пример {#example}

Переустановите операционную систему:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal server reinstall \
    --name demo-baremetal-server \
    --os-settings "image-id=ly5vtno2mjr3k4iuecur,password-plain-text=FDrxicR********,ssh-key-public=ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQ********"
  ```

  Результат:

  ```text
  done (22m47s)
  id: ly5u2442ulmz********
  cloud_id: b1gia87mbaom********
  folder_id: b1g0ijbfaqsn********
  name: demo-baremetal-server
  description: My first BareMetal server
  zone_id: ru-central1-m
  hardware_pool_id: ru-central1-m4
  status: RUNNING
  os_settings:
    image_id: ly5vtno2mjr3k4iuecur
    ssh_public_key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQYnYYjAoj********
    storages:
      - partitions:
          - type: EXT3
            size_gib: "9"
            mount_point: /boot
          - type: SWAP
            size_gib: "4"
          - type: EXT4
            mount_point: /
        raid:
          type: RAID10
          disks:
            - id: ly54aes2ecmb********
              type: HDD
              size_gib: "1862"
            - id: ly5nrgud6zrt********
              type: HDD
              size_gib: "1862"
            - id: ly5yf2ylmchh********
              type: HDD
              size_gib: "1862"
            - id: ly5loug77ciu********
              type: HDD
              size_gib: "1862"
  configuration_id: ly5lymxdltk3xitpkrmi
  created_at: "2025-07-09T07:23:39.323794Z"
  labels:
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

  * `osSettingsSpec` — настройки операционной системы. Чтобы арендовать сервер без операционной системы, пропустите этот параметр.
  Возможные настройки:
    * `imageId` — идентификатор одного из доступных [публичных образов](../../concepts/images.md#marketplace-images) ОС в Yandex Cloud Marketplace.
    * `storages[]` — настройки разметки дисков. Необязательный параметр. Возможные настройки:
      * `partitions[]` — раздел диска:
        * `type` — файловая система. Возможные значения: `EXT4`, `EXT3`, `SWAP`, `XFS`.
        * `sizeGib` — размер раздела в гигабайтах.
        * `mountPoint` — точка монтирования.
      * `disk` — настройки диска:
        * `id` — идентификатор диска.
        * `type` — тип диска. Возможные значения: `HDD`, `SSD`, `NVME`.
        * `sizeGib` — размер диска в гигабайтах.
      * `raid` — настройки RAID-массива:
        * `type` — тип RAID. Возможные значения: `RAID0`, `RAID1`, `RAID10`.
        * `disks[]` — массив дисков в RAID-конфигурации. Каждый диск содержит поля `id`, `type` и `sizeGib`.
    * `sshPublicKey` — содержимое открытого SSH-ключа. Пару SSH-ключей для подключения к серверу по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
    * `userSshId` — идентификатор пользователя SSH-ключа. Необязательный параметр.
    * `passwordPlainText` — пароль root-пользователя. Необязательный параметр.
  
      {% note warning %}
      
      Этот вариант предусматривает ответственность пользователя за безопасность пароля. Сохраните сгенерированный пароль в надежном месте: он не сохраняется в Yandex Cloud, и после заказа сервера вы не сможете посмотреть его.
      
      {% endnote %}
  
    * `passwordLockboxSecret` — [секрет](../../../lockbox/concepts/secret.md) Yandex Lockbox:
      * `secretId` — идентификатор секрета.
      * `versionId` — версия секрета.
      * `key` — ключ секрета.

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