# Перенести виртуальную машину в другую зону доступности

При создании виртуальной машины можно выбрать, в какой из [зон доступности](../../../overview/concepts/geo-scope.md) {{ yandex-cloud }} она будет размещена.

Перенести существующую ВМ в другую зону доступности можно путем создания копии ВМ в нужной зоне доступности с помощью снимков дисков.

Также вы можете перенести ВМ из зон `{{ region-id }}-a` и `{{ region-id }}-b` в зону `{{ region-id }}-d` с помощью специальной команды [CLI](../../../cli/cli-ref/compute/cli-ref/instance/relocate.md).


{% note warning %}

Чтобы контролировать ход миграции и избежать возможных сложностей при переносе, используйте для миграции [снимки дисков](../disk-control/create-snapshot.md) или резервные копии из сервиса [{{ backup-name }}](../../../backup/operations/backup-vm/create.md). Так вы сами определяете, в какой момент выключать ВМ в исходной зоне доступности, и в какой момент она появится в конечной зоне доступности. ВМ в исходной зоне доступности может продолжать работать, пока вы не убедитесь, что созданная из снимка ВМ в новой зоне доступности работает корректно. Подробные рекомендации см. в разделе [{#T}](../../../overview/concepts/zone-migration.md).

Сейчас миграция ВМ и дисков с помощью команды `yc compute instance relocate` возможна только в зону `{{ region-id }}-d` из любой другой зоны.

{% endnote %}


{% note warning %}

В зоне `{{ region-id }}-d` не поддерживаются ВМ на [платформе](../../concepts/vm-platforms.md) Intel Broadwell. Чтобы перенести ВМ с такой платформы в зону `{{ region-id }}-d`, вы можете:

* Сделать снимок диска и создать из него новую ВМ в зоне `{{ region-id }}-d` на другой платформе.
* Остановить ВМ, изменить платформу и переместить ВМ командой `yc compute instance relocate`.

{% endnote %}

## Перенести ВМ с помощью снимков дисков {#relocate-snapshots}

Чтобы перенести ВМ в другую зону доступности с помощью снимков дисков, создайте копию этой ВМ в нужной зоне доступности и затем удалите исходную ВМ.

### Создайте снимок каждого из дисков виртуальной машины {#create-snapshot}

#### Подготовьте диски {#prepare-disks}

Снимок диска содержит только те данные, которые были записаны на диск в момент создания снимка. Если диск подключен к работающей виртуальной машине, то кеш приложений и операционной системы не попадет в снимок.

Чтобы обеспечить целостность данных снимка:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Остановите все операции записи на диск в приложениях.

  1. Запишите кеш операционной системы на диск:

      ```bash
      sync
      ```

  1. Заморозьте файловую систему:

      ```bash
      sudo fsfreeze --freeze <точка_монтирования>
      ```
      Где `--freeze` — параметр для заморозки файловой системы. Вместо `<точка_монтирования>` укажите каталог, к которому подключена файловая система. Например: `/mnt/vdc2`.

  1. Создайте снимок по инструкции [ниже](#create).

  1. Разморозьте файловую систему:

      ```bash
      sudo fsfreeze --unfreeze <точка_монтирования>
      ```
      Где `--unfreeze` — параметр для разморозки файловой системы. Вместо `<точка_монтирования>` укажите каталог, к которому подключена файловая система. Например: `/mnt/vdc2`.

- Другие ОС {#other}

  1. Остановите виртуальную машину (см. раздел [{#T}](vm-stop-and-start.md#stop)).
  1. Дождитесь, когда статус машины изменится на `STOPPED`.

{% endlist %}

#### Создайте снимки {#create}

Чтобы [создать](../disk-control/create-snapshot.md) снимок диска:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится диск.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. В строке с диском нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.disks.button_action-snapshot }}**.
  1. Введите имя снимка. Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Если требуется, укажите произвольное текстовое описание снимка.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команд CLI для создания снимков:

      ```bash
      yc compute snapshot create --help
      ```

  1. Выберите диск, снимок которого необходимо создать. Получить список дисков в каталоге по умолчанию можно с помощью команды:

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

  1. Создайте снимок в каталоге по умолчанию:

      ```bash
      yc compute snapshot create \
        --name first-snapshot \
        --description "my first snapshot via CLI" \
        --disk-id fhm4aq4hvq5g******** \
        --hardware-generation-id <поколение_оборудования> \
        --hardware-features pci_topology=<топология_PCI>
      ```

      Где:
      * `--name` — имя создаваемого снимка. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `--description` — описание создаваемого снимка. Необязательный параметр.
      * `--disk-id` — идентификатор диска, для которого вы создаете снимок. Вместо идентификатора вы можете передать в команду имя диска в параметре `--disk-name`.
      * `--hardware-generation-id` — [поколение](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования, закрепляемое за снимком. Необязательный параметр. Возможные значения:

          * `legacy` — поколение `Gen 1`. При выборе этого поколения вы также можете задать топологию PCI в параметре `--hardware-features`.
          * `generation2` — поколение `Gen 2`. При выборе этого поколения задавать параметр `--hardware-features` не нужно.

          Если параметр не задан, за снимком будет закреплено то же поколение оборудования, которое закреплено за диском-источником.
      * `--hardware-features` — дополнительные настройки для поколения `Gen 1`. Необязательный параметр. Возможные значения:

          * `pci_topology=v1` — выбор топологии `PCI_TOPOLOGY_V1`.
          * `pci_topology=v2` — выбор топологии `PCI_TOPOLOGY_V2`.

          Если за диском-источником закреплено поколение `Gen 2`, по умолчанию у создаваемого снимка для параметра `--hardware-features` будет задано значение `pci_topology=v1`.

          Если за диском-источником закреплено поколение `Gen 1`, по умолчанию у создаваемого снимка для параметра `--hardware-features` будет задано то же значение, что и у диска-источника.

      Результат:

      ```text
      done (19s)
      id: fd81qi89ldop********
      folder_id: b1gt6g8ht345********
      created_at: "2025-06-23T09:56:04Z"
      name: first-snapshot
      description: my first snapshot via CLI
      storage_size: "3116367872"
      disk_size: "21474836480"
      product_ids:
        - f2evcrm9ti79********
      status: READY
      source_disk_id: epd8lmcncidv********
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V2
      ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_snapshot`.

     Пример структуры конфигурационного файла:
     
     ```hcl
     resource "yandex_compute_snapshot" "snapshot-1" {
       name           = "disk-snapshot"
       source_disk_id = "<идентификатор_диска>"
       hardware_generation {
         legacy_features {
           pci_topology = "<топология_PCI>"
         }
       }
     }
     ```

      Где:
      * `name` — имя создаваемого снимка. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `source_disk_id` — идентификатор диска, для которого вы создаете снимок.
      * `hardware_generation` — блок настроек с описанием [поколения](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования, закрепляемого за снимком. Необязательный параметр. Включает в себя следующие блоки настроек:

          * `legacy_features` — блок настроек с описанием параметров при выборе поколения `Gen 1`:
          
              * `pci_topology` — выбор топологии PCI. Возможные значения:
          
                  * `PCI_TOPOLOGY_V1` — выбор топологии `PCI_TOPOLOGY_V1`.
                  * `PCI_TOPOLOGY_V2` — выбор топологии `PCI_TOPOLOGY_V2`.
          
              Использование блока `legacy_features` делает невозможным использование блока `generation2_features`.
          * `generation2_features` — блок настроек для выбора поколения `Gen 2`. При выборе поколения `Gen 2` задавать дополнительные настройки не требуется.
          
              Использование блока `generation2_features` делает невозможным использование блока `legacy_features`.

          {% note info %}

          Если блок `hardware_generation` не задан, за снимком будет закреплено то же поколение оборудования, которое закреплено за диском-источником.

          {% endnote %}

     Более подробную информацию о ресурсе `yandex_compute_snapshot` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_snapshot).

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

  1. Получите список дисков с помощью метода REST API [list](../../api-ref/Disk/list.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызова gRPC API [DiskService/List](../../api-ref/grpc/Disk/list.md).
  1. Создайте снимок с помощью метода REST API [create](../../api-ref/Snapshot/create.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md) или вызова gRPC API [SnapshotService/Create](../../api-ref/grpc/Snapshot/create.md). В запросе укажите идентификатор диска-источника, а также при необходимости задайте нужное [поколение](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования в [объекте `hardwareGeneration`](../../api-ref/Snapshot/create.md#yandex.cloud.compute.v1.HardwareGeneration) ([`hardware_generation`](../../api-ref/grpc/Snapshot/create.md#yandex.cloud.compute.v1.HardwareGeneration) при использовании gRPC API).

{% endlist %}

Аналогичным образом создайте снимки всех дисков.

### Создайте виртуальную машину в другой зоне доступности с дисками из снимков {#create-vm}

Чтобы [создать](../vm-create/create-from-snapshots.md) виртуальную машину в другой зоне доступности с дисками из снимков:

{% list tabs group=instructions %}

- Консоль управления {#console}

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvgn27iqhtcqzygof3?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=Z7J5OwC8oJM&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=3&pp=iAQB).



  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}**.
      * Нажмите значок ![image](../../../_assets/console-icons/pencil.svg) и в открывшемся окне выберите **{{ ui-key.yacloud.common.create }}**.
      * В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` и в списке ниже выберите нужный снимок диска. При необходимости воспользуйтесь фильтром.
      * Задайте имя создаваемого загрузочного диска.
      * Выберите [тип диска](../../concepts/disk.md#disks_types).
      * Задайте нужные размер диска и размер блока.
      * (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional_vt356 }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}**, если вы хотите автоматически удалять этот диск при удалении ВМ.
      * Нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. Добавьте дополнительный [диск](../../concepts/disk.md):

      * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
      * В открывшемся окне выберите **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}** → `Создать новый`.
      * В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}`.
      * Задайте имя создаваемого диска.
      * Выберите [тип диска](../../concepts/disk.md#disks_types).
      * Задайте нужные размер диска и размер блока.
      * (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional_vt356 }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}**, если вы хотите автоматически удалять этот диск при удалении ВМ.
      * Нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. (Опционально) Чтобы [зашифровать](../../concepts/encryption.md) загрузочный или дополнительный диск, в блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** справа от имени диска нажмите значок ![image](../../../_assets/console-icons/pencil.svg) и задайте параметры шифрования для диска:
     
     * Выберите опцию **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}**.
     * В поле **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** выберите [ключ](../../../kms/concepts/key.md), которым вы хотите зашифровать диск. Чтобы [создать](../../../kms/operations/key.md#create) новый ключ, нажмите кнопку **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.
     
     Для создания зашифрованного диска нужна [роль](../../../kms/security/index.md#kms-keys-user) `kms.keys.user` или выше.
     
     {% note warning %}
     
     Задать настройки шифрования можно только при создании диска. Шифрование диска нельзя будет отключить или изменить. Также нельзя будет включить шифрование для уже созданного диска.
     
     {% endnote %}
     
     Если деактивировать ключ, которым были зашифрованы диск, снимок или образ, доступ к данным будет приостановлен, пока ключ не будет снова активирован.
     
     {% note alert %}
     
     Если удалить ключ или его [версию](../../../kms/concepts/version.md), которыми были зашифрованы диск, снимок или образ, то доступ к данным будет безвозвратно потерян. Подробнее см. [Удаление версии ключа](../../../kms/concepts/version.md#version-distruct).
     
     {% endnote %}
  1. (Опционально) Подключите [файловое хранилище](../../concepts/filesystem.md):
     
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
     
         * В открывшемся окне выберите **Файловое хранилище** и в появившемся списке выберите хранилище, которое требуется подключить.
     
         * Нажмите кнопку **Добавить файловое хранилище**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите одну из готовых конфигураций или создайте свою. Чтобы создать свою конфигурацию:
     
     * Перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}**.
     * Выберите [платформу](../../concepts/vm-platforms.md).
     * Укажите [гарантированную долю](../../concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
     * При необходимости включите [программно ускоренную сеть](../../concepts/software-accelerated-network.md).
     * При необходимости сделайте ВМ [прерываемой](../../concepts/preemptible-vm.md).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
     
     * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../../vpc/concepts/network.md#network) из списка.
     
         * У каждой сети должна быть как минимум одна [подсеть](../../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
         * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:
     
             * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
             * (Опционально) Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**, чтобы автоматически создать подсети во всех зонах доступности.
             * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.
     
     * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите способ назначения адреса:
     
         * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}. В этом случае можно включить [защиту от DDoS-атак](../../../vpc/ddos-protection/index.md) при помощи опции ниже.
         * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` — чтобы выбрать публичный IP-адрес из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [{#T}](../../../vpc/operations/set-static-ip.md).
         * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` — чтобы не назначать публичный IP-адрес.
     
     * Выберите [подходящие группы безопасности](../../../vpc/concepts/security-groups.md):
     
         * Чтобы подключаться к виртуальной машине по `SSH`, группа безопасности должна разрешать входящий сетевой трафик по протоколам `TCP` и `UDP` на порт `22`.
     
         * Чтобы подключаться к виртуальной машине по `RDP`, группа безопасности должна разрешать входящий сетевой трафик по протоколам `TCP` и `UDP` на порт `3389`.
         
         Если оставить поле пустым, виртуальной машине будет автоматически назначена [группа безопасности по умолчанию](../../../vpc/concepts/security-groups.md#default-security-group), позволяющая подключаться к ВМ по `SSH` и `RDP`.
     
     * Разверните блок **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** и в поле **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** выберите способ назначения внутренних адресов:
     
         * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` — чтобы назначить случайный IP-адрес из пула адресов, доступных в выбранной подсети.
         * `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}` — чтобы задать внутренний IP-адрес ВМ вручную.
         * При необходимости включите опцию **{{ ui-key.yacloud.common.field_ddos-protection-provider }}**. Опция доступна, если ранее в настройках публичного адреса вы выбрали автоматический способ назначения адреса.
     
     * (Опционально) Создайте записи для ВМ в [зоне DNS](../../../dns/concepts/dns-zone.md):
     
         * Разверните блок **{{ ui-key.yacloud.dns.label_dns-internal-settings }}** и нажмите **{{ ui-key.yacloud.dns.button_add-record }}**.
         * Укажите зону, FQDN и время жизни записи. При указании FQDN для зоны доступна опция `{{ ui-key.yacloud.dns.label_auto-select-zone }}`.
           Вы можете добавить несколько записей во [внутренние зоны](../../../dns/concepts/dns-zone.md) DNS. Подробнее см. [Интеграция Cloud DNS с Compute Cloud](../../../dns/concepts/compute-integration.md).
         * Чтобы создать еще одну запись, нажмите кнопку **{{ ui-key.yacloud.dns.button_add-record }}**.
     
     Если вы хотите добавить на ВМ дополнительный [сетевой интерфейс](../../concepts/network.md), нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.label_add-network-interface }}** и в появившемся блоке настроек нового интерфейса повторите действия, описанные выше в этом шаге. На одну ВМ можно добавить до восьми сетевых интерфейсов.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
     
     * Выберите **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**, чтобы [подключаться](../vm-connect/os-login.md) к создаваемой ВМ и управлять доступом к ней с помощью [{{ oslogin }}](../../../organization/concepts/os-login.md) в {{ org-full-name }}.
     
         Используя {{ oslogin }}, вы сможете подключаться к ВМ по SSH-ключам и SSH-сертификатам с помощью стандартного SSH-клиента или [интерфейса командной строки {{ yandex-cloud }}](../../../cli/quickstart.md). {{ oslogin }} позволяет ротировать SSH-ключи, используемые для доступа к ВМ, и является наиболее [безопасным](../../../security/domains/iaas-checklist.md#vm-security) вариантом доступа.
     
     * Если доступ по {{ oslogin }} вам не подходит, выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:
     
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
     
             {% note alert %}
     
             Не используйте логин `root` или другие [имена, зарезервированные ОС](https://github.com/canonical/subiquity/blob/main/reserved-usernames). Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
     
             {% endnote %}
     
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
           
           Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
           
           1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
           1. Задайте имя SSH-ключа.
           1. Выберите вариант:
           
               * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
               * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
               * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
               
                 При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
           
           1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
           
           SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
     
     Если вы хотите добавить на ВМ одновременно нескольких пользователей с SSH-ключами, [задайте](../../concepts/metadata/sending-metadata.md) данные этих пользователей в блоке **{{ ui-key.yacloud.common.metadata }}**. С помощью метаданных вы также можете [установить дополнительное ПО](../vm-create/create-with-cloud-init-scripts.md) на ВМ при ее создании.
     
     В публичных образах Linux, предоставляемых {{ yandex-cloud }}, возможность подключения по протоколу SSH с использованием логина и пароля по умолчанию отключена.
  1. (Опционально) Включите опцию **{{ ui-key.yacloud.compute.components.BackupSection.section_backup_1MXwy }}** и в поле **{{ ui-key.yacloud.backup.title_select-vm-backup-policies-row }}** выберите или создайте [политику резервного копирования](../../../backup/concepts/policy.md), чтобы автоматически создавать резервные копии ВМ с помощью сервиса [{{ backup-name }}](../../../backup/index.md).
     
     Чтобы создать новую ВМ с подключением к {{ backup-name }}, вашему аккаунту должна быть назначена [роль](../../../backup/security/index.md#backup-user) `backup.user` или выше на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы создаете ВМ.
     
     {% note info %}
     
     Если у вашего аккаунта нет назначенной роли `backup.user` или выше, вы можете подключить ВМ к {{ backup-name }} с помощью [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), которому назначена такая роль. 
     
     Для этого разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** выберите подходящий сервисный аккаунт. При необходимости [создайте](../../../iam/operations/sa/create.md) новый сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../../backup/security/index.md#backup-user) `backup.user`.
     
     {% endnote %}
     
     {% note tip %}
     
     Установка агента {{ backup-name }} является ресурсоемкой операцией. Если вы хотите использовать ВМ в минимально возможной конфигурации или, например, ВМ с [уровнем производительности vCPU](../../concepts/performance-levels.md) ниже 100%, рекомендуем на время установки агента {{ backup-name }} увеличить ресурсы ВМ.
     
     {% endnote %}
     
     Подробнее читайте в разделе [{#T}](../../../backup/concepts/vm-connection.md). 
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

      {% note info %}
      
      Имя виртуальной машины используется для генерации [внутреннего FQDN](../../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
      
      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:
     
     * (Опционально) Выберите или создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
     * (Опционально) Разрешите доступ к [серийной консоли](../../concepts/serial-console.md).
     * (Опционально) Чтобы настроить поставку [системных метрик Linux](../../../monitoring/operations/unified-agent/linux_metrics.md) и дополнительных метрик ваших приложений, в блоке **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}** включите опцию **{{ ui-key.yacloud.compute.instances.create.unified-agent }}** и выберите:
       * **{{ monitoring-full-name }}** — [установить агент](../../../monitoring/concepts/data-collection/unified-agent/index.md) для сбора дополнительных метрик ВМ и приложений.
       * **{{ managed-prometheus-name }}** — [установить и настроить агент](../../../monitoring/operations/prometheus/ingestion/prometheus-agent.md) для сбора дополнительных метрик ВМ и приложений в формате {{ prometheus-name }}:
          * Выберите или создайте воркспейс, в котором будут храниться метрики.
          * (Опционально) Опишите в формате JSON [параметры поставки](../../../monitoring/operations/prometheus/ingestion/prometheus-agent.md) собственных метрик.
     * (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_placement }}** выберите [группу размещения](../../concepts/placement-groups.md) ВМ.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Виртуальная машина появится в списке. При создании виртуальной машине назначаются [IP-адрес](../../../vpc/concepts/address.md) и [имя хоста](../../../vpc/concepts/address.md#fqdn) (FQDN).

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания виртуальной машины:

      ```
      yc compute instance create --help
      ```

  1. Подготовьте снимки нужных дисков, см. раздел [{#T}](../disk-control/create-snapshot.md).
  1. Получите список снимков в каталоге по умолчанию:

      ```bash
      yc compute snapshot list
      ```
      
      Результат:
      
      ```text
      +----------------------+-----------------+----------------------+--------+----------------------------+
      |          ID          |       NAME      |     PRODUCT IDS      | STATUS |        DESCRIPTION         |
      +----------------------+-----------------+----------------------+--------+----------------------------+
      | fd8rlt1u2rf0l******* | first-snapshot  | f2ecl5vhsftd******** | READY  | my first snapshot via CLI  |
      | fhmolt1u2rf0******** | second-snapshot | f2eclmol5lps******** | READY  | my second snapshot via CLI |
      +----------------------+-----------------+----------------------+--------+----------------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужных снимков.
  1. Создайте виртуальную машину в каталоге по умолчанию:

      ```
      yc compute instance create \
        --name first-instance \
        --zone {{ region-id }}-a \
        --public-ip \
        --create-boot-disk snapshot-name=first-snapshot,kms-key-id=<идентификатор_ключа> \
        --create-disk snapshot-name=second-snapshot,kms-key-id=<идентификатор_ключа> \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```

      Где:

      * `--name` — имя ВМ. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

          {% note info %}
          
          Имя виртуальной машины используется для генерации [внутреннего FQDN](../../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
          
          {% endnote %}

      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md).
      * `--public-ip` — подключение публичного IP-адреса. Чтобы создать виртуальную машину без публичного IP-адреса, исключите этот флаг.
      * `--create-boot-disk` — настройки загрузочного диска ВМ:

          * `snapshot-name` — имя снимка диска.
          * `kms-key-id` — идентификатор [симметричного ключа {{ kms-short-name }}](../../../kms/concepts/key.md) для создания зашифрованного загрузочного диска. Необязательный параметр.

            Для создания зашифрованного диска нужна [роль](../../../kms/security/index.md#kms-keys-user) `kms.keys.user` или выше.

            {% note warning %}
            
            Задать настройки шифрования можно только при создании диска. Шифрование диска нельзя будет отключить или изменить. Также нельзя будет включить шифрование для уже созданного диска.
            
            {% endnote %}

            Если деактивировать ключ, которым были зашифрованы диск, снимок или образ, доступ к данным будет приостановлен, пока ключ не будет снова активирован.
            
            {% note alert %}
            
            Если удалить ключ или его [версию](../../../kms/concepts/version.md), которыми были зашифрованы диск, снимок или образ, то доступ к данным будет безвозвратно потерян. Подробнее см. [Удаление версии ключа](../../../kms/concepts/version.md#version-distruct).
            
            {% endnote %}

      * `--create-disk` — настройки дополнительного диска:

          * `snapshot-name` — имя снимка диска.
          * `kms-key-id` — идентификатор [симметричного ключа {{ kms-short-name }}](../../../kms/concepts/key.md) для создания зашифрованного диска. Необязательный параметр.

      * `--ssh-key` — путь к файлу с [публичным SSH-ключом](../vm-connect/ssh.md#creating-ssh-keys). Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.

          При создании ВМ из публичного образа [{{ marketplace-full-name }}]({{ link-cloud-marketplace }}) обязательно передавайте в ВМ SSH-ключ, поскольку доступ по протоколу SSH с использованием логина и пароля для таких образов по умолчанию отключен.

      Команда создаст виртуальную машину именем `first-instance` в зоне `{{ region-id }}-a`, с публичным IP и дисками из снимков.

      Если вы хотите добавить на ВМ несколько [сетевых интерфейсов](../../concepts/network.md), задайте параметр `--network-interface` необходимое количество раз. На одну ВМ можно добавить до восьми сетевых интерфейсов.

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md).

{% endlist %}

### Удалите исходную виртуальную машину {#delete-vm}

Чтобы [удалить](vm-delete.md) исходную виртуальную машину:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. В строке с нужной ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.delete }}**.

     Чтобы удалить несколько виртуальных машин, выделите нужные ВМ в списке и нажмите кнопку **{{ ui-key.yacloud.common.delete }}** в нижней части экрана.

  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_delete }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления ВМ:

     ```bash
     yc compute instance delete --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance list
     ```
     
     Результат:
     ```text
     +----------------------+-----------------+---------------+---------+----------------------+
     |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
     +----------------------+-----------------+---------------+---------+----------------------+
     | fhm0b28lgfp4******** | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
     | fhm9gk85nj7g******** | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
     +----------------------+-----------------+---------------+---------+----------------------+
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.
  1. Удалите ВМ:

     ```bash
     yc compute instance delete first-instance
     ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Если вы создавали ВМ с помощью {{ TF }}, вы можете удалить ее:
  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.
  1. Удалите ресурсы с помощью команды:

     ```bash
     terraform destroy
     ```

     {% note alert %}

     {{ TF }} удалит все ресурсы, созданные в текущей конфигурации: кластеры, сети, подсети, ВМ и т. д.

     {% endnote %}

  1. Введите слово `yes` и нажмите **Enter**.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/Instance/delete.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Delete](../../api-ref/grpc/Instance/delete.md).

{% endlist %}

## Перенести ВМ в зону {{ region-id }}-d с помощью специальной команды {#relocate-command}

С помощью специальной команды CLI можно перенести виртуальную машину только в зону доступности `{{ region-id }}-d`. В таком случае у ВМ сохраняются идентификатор и метаданные. Вместе с ВМ в новую зону доступности будут перенесены и все подключенные к ней диски.

{% note info %}

Продолжительность операции переноса в другую зону доступности зависит от размера дисков виртуальной машины. Перенос диска размером 100 ГБ занимает больше 10 минут.

{% endnote %}

{% list tabs group=instructions %}


- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для переноса виртуальной машины в другую зону доступности:

      ```bash
      yc compute instance relocate --help
      ```

  1. Получите список всех подсетей в каталоге по умолчанию:

      ```bash
      yc vpc subnet list
      ```

      Результат:

      ```text
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      | e2l5iit0t6dr******** | default-{{ region-id }}-b | enpnohfm8jb5******** |                | {{ region-id }}-b | [10.129.0.0/24] |
      | e9b2ljn7h9pj******** | default-{{ region-id }}-a | enpnohfm8jb5******** |                | {{ region-id }}-a | [10.128.0.0/24] |
      | fl8in4sila9i******** | default-{{ region-id }}-d | enpnohfm8jb5******** |                | {{ region-id }}-d | [10.130.0.0/24] |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      ```

  1. Получите список всех групп безопасности в каталоге по умолчанию:

      ```bash
      yc vpc sg list
      ```

      Результат:

      ```text
      +----------------------+---------------------------------+--------------------------------+----------------------+
      |          ID          |              NAME               |          DESCRIPTION           |      NETWORK-ID      |
      +----------------------+---------------------------------+--------------------------------+----------------------+
      | enpagmu40nj5******** | my-sg-group                     |                                | enpnohfm8jb5******** |
      | enpe9n88cell******** | default-sg-enpnohfm8jb5******** | Default security group for     | enpnohfm8jb5******** |
      |                      |                                 | network                        |                      |
      +----------------------+---------------------------------+--------------------------------+----------------------+
      ```

  1. Получите список всех виртуальных машин в каталоге по умолчанию:

      ```bash
      yc compute instance list
      ```

      Результат:

      ```text
      +----------------------+---------+---------------+---------+--------------+-------------+
      |          ID          |  NAME   |    ZONE ID    | STATUS  | EXTERNAL IP  | INTERNAL IP |
      +----------------------+---------+---------------+---------+--------------+-------------+
      | epdi9vnr8i6n******** | my-vm-1 | {{ region-id }}-b | RUNNING | 84.201.166.2 | 10.129.0.31 |
      | epdjhkhtqjfp******** | my-vm-2 | {{ region-id }}-d | RUNNING |              | 10.130.0.6  |
      +----------------------+---------+---------------+---------+--------------+-------------+
      ```

  1. Получите список [сетевых интерфейсов](../../concepts/network.md) нужной ВМ, указав ее идентификатор:

     ```bash
     yc compute instance get <идентификатор_ВМ>
     ```

     Результат:

     ```yml
     ...
     network_interfaces:
       - index: "0"
         mac_address: d0:0d:12:4f:ef:b4
         subnet_id: e2l5iit0t6dr********
         primary_v4_address:
           address: 10.129.0.31
           one_to_one_nat:
             address: 84.201.166.2
             ip_version: IPV4
     ...
     ```

  1. Перенесите нужную виртуальную машину в другую зону доступности:

      ```bash
      yc compute instance relocate <идентификатор_ВМ> \
        --destination-zone-id {{ region-id }}-d \
        --network-interface subnet-id=<идентификатор_подсети>,security-group-ids=<идентификатор_группы_безопасности>
      ```

      Где:

      * `<идентификатор_ВМ>` — идентификатор ВМ, которую требуется перенести в другую зону доступности.
      * `--destination-zone-id` — идентификатор [зоны доступности](../../../overview/concepts/geo-scope.md). Поддерживается только `{{ region-id }}-d`.
      * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:
          * `subnet-id` — идентификатор подсети, соответствующей зоне доступности, в которую требуется перенести ВМ.
          * `security-group-ids` — идентификатор [группы безопасности](../../../vpc/concepts/security-groups.md), которую требуется привязать к переносимой ВМ. К одной ВМ можно привязать одновременно несколько групп безопасности, в этом случае передайте их идентификаторы через запятую в формате `[id1,id2]`.

          Если у ВМ несколько сетевых интерфейсов, задайте параметр `--network-interface` необходимое количество раз (для каждого сетевого интерфейса).

      Подробнее о команде `yc compute instance relocate` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/relocate.md).

      Если вы переносите ВМ с [диском в группе размещения](../../concepts/disk-placement-group.md), используйте команду:

      ```bash
      yc compute instance relocate <идентификатор_ВМ> \
        --destination-zone-id {{ region-id }}-d \
        --network-interface subnet-id=<идентификатор_подсети>,security-group-ids=<идентификатор_группы_безопасности> \
        --boot-disk-placement-group-id <идентификатор_группы_размещения_дисков> \
        --boot-disk-placement-group-partition <номер_раздела> \
        --secondary-disk-placement disk-name=<имя_диска>,disk-placement-group-id=<идентификатор_группы_размещения_дисков>,disk-placement-group-partition=<номер_раздела>
      ```

      Где:

      * `--boot-disk-placement-group-id` — идентификатор группы размещения дисков.
      * `--boot-disk-placement-group-partition` — номер раздела в группе размещения дисков со стратегией [размещения разделами](../../concepts/disk-placement-group.md#partition).
      * `--secondary-disk-placement` — политика размещения для дополнительных дисков. Параметры:

        * `disk-name` — имя диска.
        * `disk-placement-group-id` — идентификатор группы размещения дисков, в которую необходимо поместить диск.
        * `disk-placement-group-partition` — номер раздела в группе размещения дисков.

      Подробнее о команде `yc compute instance relocate` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/relocate.md).

  Обратите внимание, что при подключении [сетевых интерфейсов](../../concepts/network.md) ВМ к новым подсетям изменится адресация. Если для сетевых интерфейсов ВМ требуется указать внутренние IP-адреса, используйте свойство `ipv4-address=<внутренний_IP-адрес>`, если публичные IP-адреса — свойство `nat-address=<публичный_IP-адрес>` параметра `network-interface`. В остальном установка параметров сетевых интерфейсов при переносе ВМ в другую зону доступности аналогична установке таких параметров при создании ВМ.

{% endlist %}

{% note info %}

Если на диски ВМ активно ведется запись, их перенос может завершиться ошибкой. В таком случае остановите запись на диски или выключите виртуальную машину и повторно запустите перенос.

{% endnote %}

### Примеры {#examples}

#### Перенос ВМ в другую зону {#jump-from-a-to-d}

В этом примере ВМ `my-vm-1` переносится из зоны доступности `{{ region-id }}-b` в зону доступности `{{ region-id }}-d`.

```bash
yc compute instance relocate epdi9vnr8i6n******** \
  --destination-zone-id {{ region-id }}-d \
  --network-interface subnet-id=fl8in4sila9i********,security-group-ids=enpagmu40nj5********
```

Результат:

```text
done (1m28s)
id: epdi9vnr8i6n********
folder_id: b1g0ijbfaqsn********
created_at: "2025-11-04T18:44:29Z"
name: my-vm-1
zone_id: {{ region-id }}-d
platform_id: standard-v3
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "50"
status: RUNNING
metadata_options:
  gce_http_endpoint: ENABLED
  aws_v1_http_endpoint: ENABLED
  gce_http_token: ENABLED
  aws_v1_http_token: DISABLED
boot_disk:
  mode: READ_WRITE
  device_name: epdkl5gn20gv********
  auto_delete: true
  disk_id: epdkl5gn20gv********
network_interfaces:
  - index: "0"
    mac_address: d0:0d:12:4f:ef:b4
    subnet_id: fl8in4sila9i********
    primary_v4_address:
      address: 10.130.0.8
    security_group_ids:
      - enpagmu40nj5********
serial_port_settings:
  ssh_authorization: OS_LOGIN
gpu_settings: {}
fqdn: my-vm-1.{{ region-id }}.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}
hardware_generation:
  legacy_features:
    pci_topology: PCI_TOPOLOGY_V1
application: {}
```

#### Перенос ВМ с дисками в группе размещения {#jump-with-disk-placement-group}

В этом примере ВМ `my-vm-1` с двумя дисками в группе размещения переносится из зоны доступности `{{ region-id }}-b` в зону доступности `{{ region-id }}-d`.

```bash
yc compute instance relocate epd6qtn128k1******** \
  --destination-zone-id {{ region-id }}-d \
  --network-interface \
    subnet-id=fl8glc5v0lqj********,security-group-ids=enp1gjh3q042******** \
  --boot-disk-placement-group-id fv4pfmor782v******** \
  --boot-disk-placement-group-partition 1 \
  --secondary-disk-placement \
    disk-name=disk-two,fv4pfmor782v********,disk-placement-group-partition=2
```

Результат:

```text
done (9m0s)
id: epd6qtn128k1********
folder_id: b1gmit33ngp3********
created_at: "2023-12-07T19:30:20Z"
name: my-vm-1
zone_id: {{ region-id }}-d
platform_id: standard-v3
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
status: RUNNING
metadata_options:
  gce_http_endpoint: ENABLED
  aws_v1_http_endpoint: ENABLED
  gce_http_token: ENABLED
  aws_v1_http_token: DISABLED
boot_disk:
  mode: READ_WRITE
  device_name: epdeqrm6g38j********
  auto_delete: true
  disk_id: epdeqrm6g38j********
secondary_disks:
  - mode: READ_WRITE
    device_name: epdi54snn7t6********
    disk_id: epdi54snn7t6********
network_interfaces:
  - index: "0"
    mac_address: d0:0d:6d:76:e1:12
    subnet_id: fl8glc5v0lqj********
    primary_v4_address:
      address: 10.130.0.12
    security_group_ids:
      - enp1gjh3q042********
gpu_settings: {}
fqdn: my-vm-1.{{ region-id }}.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}
```