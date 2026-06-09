# Восстановить диск с помощью образа

{% note info %}

Восстановить загрузочный диск существующей ВМ из снимка или образа невозможно. Но вы можете создать новую ВМ, чтобы восстановить загрузочный диск из снимка. Для восстановления загрузочного диска на существующей ВМ, используйте сервис [{{ backup-full-name }}](../../../backup/index.md).

{% endnote %}

Чтобы создать диск из [образа](../../concepts/image.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать диск.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.storage.button_create-disk }}**.
  1. Введите имя диска.

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Если требуется, укажите произвольное текстовое описание диска.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
  1. В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` и в появившемся списке выберите нужный образ. При необходимости воспользуйтесь фильтром.
  1. Задайте параметры диска: [тип диска](../../concepts/disk.md#disks_types), [размер диска](../../concepts/disk.md#maximum-disk-size), а также [размер блока](../../concepts/disk.md#maximum-disk-size).
  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.disk-form.section_encryption }}**:
     
       * Выберите опцию **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}**.
       * В поле **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** выберите [ключ](../../../kms/concepts/key.md), созданный ранее. Чтобы [создать](../../../kms/operations/key.md#create) новый ключ, нажмите кнопку **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.
     
       Для создания зашифрованного диска нужна [роль](../../../kms/security/index.md#kms-keys-user) `kms.keys.user` или выше.
     
       {% note warning %}
       
       Задать настройки шифрования можно только при создании диска. Шифрование диска нельзя будет отключить или изменить. Также нельзя будет включить шифрование для уже созданного диска.
       
       {% endnote %}
       
       Если деактивировать ключ, которым были зашифрованы диск, снимок или образ, доступ к данным будет приостановлен, пока ключ не будет снова активирован.
       
       {% note alert %}
       
       Если удалить ключ или его [версию](../../../kms/concepts/version.md), которыми были зашифрованы диск, снимок или образ, то доступ к данным будет безвозвратно потерян. Подробнее см. [Удаление версии ключа](../../../kms/concepts/version.md#version-distruct).
       
       {% endnote %}
  1. Если требуется, выберите [расписание](../../concepts/snapshot-schedule.md), по которому для диска будут автоматически создаваться снимки, или создайте его. Подробнее о настройках расписания см. в [инструкции](../snapshot-control/create-schedule.md).

      Создавать можно снимки сетевых [дисков](../../concepts/disk.md#disks_types) HDD, SSD и нереплицируемых SSD, а также сверхбыстрых сетевых хранилищ с тремя репликами (SSD).
      
      Для нереплицируемых SSD и сверхбыстрых сетевых хранилищ с тремя репликами (SSD) момент времени, когда фиксируется содержимое диска, не детерминирован.
      
      Для снимков с локальных дисков на [выделенных хостах](../../concepts/dedicated-host.md) используйте сервис [{{ backup-full-name }}](../../../backup/index.md) (поддерживает ОС Ubuntu, CentOS, CentOS Stream и Windows Server).

      При создании диска для него можно выбрать только одно расписание снимков. После создания диска вы сможете добавить к нему еще несколько расписаний по [инструкции](../disk-control/configure-schedule.md#add-schedule).
  1. (Опционально) Разверните блок **{{ ui-key.yacloud.compute.section_additional_7yvYG }}** и в поле **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** выберите нужное [поколение](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования, которое будет закреплено за создаваемым диском:

      * `{{ ui-key.yacloud.compute.hardware-gen1-v2-title_eSmBa }}` — поколение `Gen 1.2`.
      * `{{ ui-key.yacloud.compute.hardware-gen2-title_a2Gfq }}` — поколение `Gen 2`.
      * `{{ ui-key.yacloud.compute.hardware-gen1-v1-title_oK6qE }}` — поколение `Gen 1.1`.

      Если вы не зададите поколение оборудования, по умолчанию за диском будет закреплено то же поколение, что и за исходным образом.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.storage.button_create-disk }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания диска:

      ```bash
      yc compute disk create --help
      ```

  1. Получите список образов в каталоге по умолчанию:

      ```bash
      yc compute image list
      ```

      Результат:
      ```text
      +----------------------+------------+--------+----------------------+--------+
      |          ID          |    NAME    | FAMILY |     PRODUCT IDS      | STATUS |
      +----------------------+------------+--------+----------------------+--------+
      | fd8ool134m70******** | test-image |        | f2e3eaei7io3******** | READY  |
      | fd8u2d7plgpu******** | image-2    |        |                      | READY  |
      +----------------------+------------+--------+----------------------+--------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного образа.

  1. Создайте диск из выбранного образа:

      ```bash
      yc compute disk create \
        --name <имя_диска> \
        --source-image-name <имя_образа-источника> \
        --zone <зона_доступности> \
        --description <текстовое_описание_диска> \
        --hardware-generation-id <поколение_оборудования> \
        --hardware-features pci_topology=<топология_PCI> \
        --kms-key-id <идентификатор_ключа>
      ```

      Где:
      * `--name` — имя создаваемого диска. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `--source-image-name` — имя образа-источника. Вместо имени вы можете передать в команду идентификатор образа-источника в параметре `--source-image-id`.
      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой создается диск.
      * `--description` — текстовое описание создаваемого диска. Необязательный параметр.
      * `--hardware-generation-id` — [поколение](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования, закрепляемое за диском. Необязательный параметр. Возможные значения:

          * `legacy` — поколение `Gen 1`. При выборе этого поколения вы также можете задать топологию PCI в параметре `--hardware-features`.
          * `generation2` — поколение `Gen 2`. При выборе этого поколения задавать параметр `--hardware-features` не нужно.

          Если параметр не задан, за диском будет закреплено то же поколение оборудования, которое закреплено за образом-источником.
      * `--hardware-features` — дополнительные настройки для поколения `Gen 1`. Необязательный параметр. Возможные значения:

          * `pci_topology=v1` — выбор топологии `PCI_TOPOLOGY_V1`.
          * `pci_topology=v2` — выбор топологии `PCI_TOPOLOGY_V2`.

          Если за образом-источником закреплено поколение `Gen 2`, по умолчанию у создаваемого диска для параметра `--hardware-features` будет задано значение `pci_topology=v1`.

          Если за образом-источником закреплено поколение `Gen 1`, по умолчанию у создаваемого диска для параметра `--hardware-features` будет задано то же значение, что и у образа-источника.
      * `--kms-key-id` — идентификатор [симметричного ключа шифрования](../../../kms/concepts/key.md) {{ kms-full-name }} для создания зашифрованного диска. Необязательный параметр.

          Для создания зашифрованного диска нужна [роль](../../../kms/security/index.md#kms-keys-user) `kms.keys.user` или выше.
        
          {% note warning %}
          
          Задать настройки шифрования можно только при создании диска. Шифрование диска нельзя будет отключить или изменить. Также нельзя будет включить шифрование для уже созданного диска.
          
          {% endnote %}

          Если деактивировать ключ, которым были зашифрованы диск, снимок или образ, доступ к данным будет приостановлен, пока ключ не будет снова активирован.
          
          {% note alert %}
          
          Если удалить ключ или его [версию](../../../kms/concepts/version.md), которыми были зашифрованы диск, снимок или образ, то доступ к данным будет безвозвратно потерян. Подробнее см. [Удаление версии ключа](../../../kms/concepts/version.md#version-distruct).
          
          {% endnote %}

      Результат:

      ```text
      done (50s)
      id: epdoljps3ljd********
      folder_id: b1gt6g8ht345********
      created_at: "2025-06-23T17:25:56Z"
      name: first-disk
      description: my very first disk
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "21474836480"
      block_size: "4096"
      product_ids:
        - f2ercusam4no********
      status: READY
      source_image_id: fd8it9g4ui2l********
      disk_placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V2
      ```

      Подробнее о команде `yc compute disk create` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/disk/create.md).

  1. Получите список дисков в каталоге по умолчанию:

      ```bash
      {{ yc-compute }} disk list
      ```
      
      Результат:
      
      ```text
      +----------------------+--------------+-------------+-------------------+--------+----------------------+-----------------+-------------+
      |          ID          |     NAME     |    SIZE     |       ZONE        | STATUS |     INSTANCE IDS     | PLACEMENT GROUP | DESCRIPTION |
      +----------------------+--------------+-------------+-------------------+--------+----------------------+-----------------+-------------+
      | a7lqgbt0bb9s******** | first-disk   | 20401094656 |   {{ region-id }}-a   | READY  | a7lcvu28njbh******** |                 |             |
      | a7lv5j5hm1p1******** | second-disk  | 21474836480 |   {{ region-id }}-a   | READY  |                      |                 |             |
      +----------------------+--------------+-------------+-------------------+--------+----------------------+-----------------+-------------+
      ```

      Получите тот же список с большим количеством деталей в формате YAML:

      ```bash
      yc compute disk list --format yaml
      ```

      Результат:
      ```text
      - id: epdoljps3ljd********
        folder_id: b1gt6g8ht345********
        created_at: "2025-06-23T17:25:56Z"
        name: first-disk
        description: my very first disk
        type_id: network-hdd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2ercusam4no********
        status: READY
        source_image_id: fd8it9g4ui2l********
        disk_placement_policy: {}
        hardware_generation:
          legacy_features:
            pci_topology: PCI_TOPOLOGY_V2
      - id: epd8lmcncidv********
        folder_id: b1gt6g8ht345********
        created_at: "2025-06-23T06:32:26Z"
        name: second-disk
        type_id: network-ssd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2evcrm9ti79********
        status: READY
        source_image_id: fd80j21lmqar********
        instance_ids:
          - epdm2ene322e********
        disk_placement_policy: {}
        hardware_generation:
          legacy_features:
            pci_topology: PCI_TOPOLOGY_V1
      ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_disk`.

      Пример структуры конфигурационного файла:
     
      ```hcl
      resource "yandex_compute_disk" "my-disk" {
        name           = "<имя_диска>"
        zone           = "<зона_доступности>"
        image_id       = "<идентификатор_образа>"
        hardware_generation {
          legacy_features {
            pci_topology = "<топология_PCI>"
          }
        }
      }
      ```

      Где:
      * `name` — имя создаваемого диска. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой создается диск.
      * `image_id` — идентификатор образа, на основе которого вы создаете диск.
      * `hardware_generation` — блок настроек с описанием [поколения](../../concepts/hardware-generations.md#configurations) оборудования, закрепляемого за диском. Необязательный параметр. Включает в себя следующие блоки настроек:

          * `legacy_features` — блок настроек с описанием параметров при выборе поколения `Gen 1`:
          
              * `pci_topology` — выбор топологии PCI. Возможные значения:
          
                  * `PCI_TOPOLOGY_V1` — выбор топологии `PCI_TOPOLOGY_V1`.
                  * `PCI_TOPOLOGY_V2` — выбор топологии `PCI_TOPOLOGY_V2`.
          
              Использование блока `legacy_features` делает невозможным использование блока `generation2_features`.
          * `generation2_features` — блок настроек для выбора поколения `Gen 2`. При выборе поколения `Gen 2` задавать дополнительные настройки не требуется.
          
              Использование блока `generation2_features` делает невозможным использование блока `legacy_features`.

          {% note info %}

          Если блок `hardware_generation` не задан, за диском будет закреплено то же поколение оборудования, которое закреплено за образом-источником.

          {% endnote %}

      Более подробную информацию о ресурсе `yandex_compute_disk` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_disk).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  1. Получите список образов с помощью метода REST API [list](../../api-ref/Image/list.md) для ресурса [Image](../../api-ref/Image/index.md) или вызова gRPC API [ImageService/List](../../api-ref/grpc/Image/list.md).
  1. Создайте диск с помощью метода REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызова gRPC API [DiskService/Create](../../api-ref/grpc/Disk/create.md). В запросе укажите идентификатор образа-источника, а также при необходимости задайте нужное [поколение](../../concepts/hardware-generations.md#configurations) оборудования в [объекте `hardwareGeneration`](../../api-ref/Disk/create.md#yandex.cloud.compute.v1.HardwareGeneration) ([`hardware_generation`](../../api-ref/grpc/Disk/create.md#yandex.cloud.compute.v1.HardwareGeneration) при использовании gRPC API).

{% endlist %}

После создания диск перейдет в статус `CREATING`. Дождитесь, когда диск перейдет в статус `READY`, прежде чем его использовать.


#### См. также {#see-also}

* [Создать ВМ из пользовательского образа](../vm-create/create-from-user-image.md)
* [Подключить диск к ВМ и смонтировать разделы](../vm-control/vm-attach-disk.md)
* [{#T}](../../../backup/concepts/index.md)