# Создание кластера {{ GP }}


[Кластер](../../glossary/cluster.md) {{ mgp-name }} состоит из хостов-мастеров, которые принимают запросы от клиента, и хостов-сегментов, обеспечивающих обработку и хранение данных.

Подробнее см. в разделе [{#T}](../concepts/index.md).


## Создать кластер {#create-cluster}


Для создания кластера {{ mgp-name }} нужна роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль [{{ roles.mgp.editor }} или выше](../security/index.md#roles-list). О том, как назначить роль, см. [документацию {{ iam-name }}](../../iam/operations/roles/grant.md).


{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы создать кластер {{ mgp-name }}:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер баз данных.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Введите имя кластера. Оно должно быть уникальным в рамках каталога.
    1. (Опционально) Введите описание кластера.
    1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
        * `PRODUCTION` — для стабильных версий ваших приложений.
        * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
    1. Выберите версию {{ GP }}.

    
    1. (Опционально) Чтобы разместить хосты-мастеры или хосты-сегменты на выделенных хостах, выберите группы [выделенных хостов](../../compute/concepts/dedicated-host.md). Можно назначить группы на один из видов хостов {{ GP }} либо сразу на оба.

        Группа выделенных хостов должна быть предварительно [создана](../../compute/operations/dedicated-host/create-host-group.md) в сервисе {{ compute-full-name }}.

        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите:

        * [Облачную сеть](../../vpc/concepts/network.md#network) для размещения кластера.

        * [Группы безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.

        * [Зону доступности](../../overview/concepts/geo-scope.md) и [подсеть](../../vpc/concepts/network.md#subnet) для размещения кластера. Чтобы создать новую подсеть, нажмите **{{ ui-key.yacloud.mdb.forms.label_add-subnetwork }}** в списке подсетей.

           {% include [zone-cannot-be-changed](../../_includes/mdb/mgp/zone-cannot-be-changed.md) %}

           {% include [zone-d-disk-restrictions](../../_includes/mdb/ru-central1-d-local-ssd.md) %}

        
        * Опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, чтобы подключаться к кластеру из интернета.


    1. (Опционально) Включите опцию **{{ ui-key.yacloud.greenplum.section_cloud-storage }}**.

        Она включает [гибридное хранилище](../concepts/hybrid-storage.md). Гибридное хранилище нельзя отключить после сохранения настроек кластера.

        {% include [hybrid-storage-description](../../_includes/mdb/mgp/hybrid-storage-description.md) %}

        
        {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


    1. Укажите реквизиты пользователя-администратора. Это специальный пользователь, который необходим для управления кластером и не может быть удален. Подробнее см. в разделе [Пользователи и роли](../concepts/cluster-users.md).

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — может содержать латинские буквы, цифры, дефис и подчеркивание, но не может начинаться с дефиса. Длина от 1 до 32 символов.

            {% include [reserved-usernames-note](../../_includes/mdb/mgp/reserved-usernames-note.md) %}

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — длина от 8 до 128 символов.

    1. При необходимости задайте дополнительные настройки кластера:

        * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
        * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../concepts/maintenance.md):

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        
        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — выберите существующий сервисный аккаунт для доступа к сервисам {{ yandex-cloud }} или создайте новый.
        * **{{ ui-key.yacloud.logging.field_logging }}** — опция включает логирование операций в кластере. За хранение логов взимается плата в соответствии с тарифами {{ cloud-logging-full-name }}. Для записи логов [назначьте](../../iam/operations/sa/assign-role-for-sa.md) выбранному сервисному аккаунту роль `logging.writer`.

          Если вы включили опцию, настройте параметры логирования:

          * Укажите место записи логов:

             * **{{ ui-key.yacloud.common.folder }}** — логи будут записываться в лог-группу по умолчанию выбранного каталога.
             * **{{ ui-key.yacloud.logging.label_group }}** — логи будут записываться в новую или выбранную из списка [лог-группу](../../logging/concepts/log-group.md).

          * Выберите, какие логи записывать:

             * **Логи командного центра** — опция включает запись логов [командного центра](../concepts/command-center.md).
             * **Логи Greenplum** — опция включает запись логов {{ GP }}. Уровень логирования можно задать с помощью параметра [Log min messages](../concepts/settings-list.md#setting-log-min-messages) в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**.


        
        * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
        * {% include [Query access](../../_includes/mdb/console/query-access.md) %}
        * {% include [WebSQL access](../../_includes/mdb/console/websql-access.md) %}



        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

            {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. (Опционально) Задайте режим работы и параметры [менеджера подключений](../concepts/pooling.md) в блоке **{{ ui-key.yacloud.mdb.forms.section_pooler }}**:

        {% include [Pooling mode](../../_includes/mdb/mgp/pooling-mode.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.greenplum.section_background-activities }}** измените параметры [регламентных операций технического обслуживания](../concepts/maintenance.md#regular-ops):

        {% include [background activities](../../_includes/mdb/mgp/background-activities-console.md) %}

    1. Укажите параметры хостов-мастеров на вкладке **{{ ui-key.yacloud.greenplum.section_resource-master }}**. Рекомендуемую конфигурацию см. в разделе [Расчет конфигурации кластера](../concepts/calculate-specs.md#master).

        * [{{ ui-key.yacloud.mdb.forms.section_resource }}](../concepts/instance-types.md) — определяет технические характеристики виртуальных машин, на которых будут развернуты хосты-мастеры кластера.

        * В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** выберите [тип диска](../concepts/storage.md) и укажите его размер. Доступные типы диска [зависят](../concepts/storage.md) от выбранного класса хостов.

          {% include [warn-storage-resize](../../_includes/mdb/mgp/warn-storage-resize.md) %}

    1. Укажите параметры хостов-сегментов на вкладке **{{ ui-key.yacloud.greenplum.section_resource-segment }}**. Рекомендуемую конфигурацию см. в разделе [Расчет конфигурации кластера](../concepts/calculate-specs.md#segment).

        * Количество хостов-сегментов.
        * [Количество сегментов на хост](../concepts/index.md). Максимальное значение этого параметра зависит от класса хостов.

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * [Класс хоста](../concepts/instance-types.md) — определяет технические характеристики виртуальных машин, на которых будут развернуты хосты-сегменты кластера.
        * В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** выберите [тип диска](../concepts/storage.md) и укажите его размер. Доступные типы диска [зависят](../concepts/storage.md) от выбранного класса хостов.

           {% include [warn-storage-resize](../../_includes/mdb/mgp/warn-storage-resize.md) %}

           * Выберите размер хранилища.

    1. При необходимости задайте [настройки СУБД уровня кластера](../concepts/settings-list.md#dbms-cluster-settings).

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать кластер {{ mgp-name }}:

    
    1. Проверьте, есть ли в каталоге подсети для хостов кластера:

        ```bash
        yc vpc subnet list
        ```

        Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.


    1. Посмотрите описание команды CLI для создания кластера:

        ```bash
        {{ yc-mdb-gp }} cluster create --help
        ```

    1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

        
        ```bash
        {{ yc-mdb-gp }} cluster create <имя_кластера> \
           --greenplum-version=<версия_Greenplum> \
           --environment=<окружение> \
           --network-name=<имя_сети> \
           --user-name=<имя_пользователя> \
           --user-password=<пароль_пользователя> \
           --master-config resource-id=<класс_хоста>,`
                          `disk-size=<объем_хранилища_ГБ>,`
                          `disk-type=<network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
           --segment-config resource-id=<класс_хоста>,`
                          `disk-size=<объем_хранилища_ГБ>,`
                          `disk-type=<network-ssd-nonreplicated|local-ssd> \
           --zone-id=<зона_доступности> \
           --subnet-id=<идентификатор_подсети> \
           --assign-public-ip=<разрешить_публичный_доступ_к_хостам_кластера> \
           --security-group-ids=<список_идентификаторов_групп_безопасности> \
           --deletion-protection
        ```

        {% note info %}

        Имя кластера должно быть уникальным в каталоге. Оно может содержать латинские буквы, цифры, дефис и подчеркивание. Максимальная длина имени 63 символа.

        {% endnote %}

        Где:

        * `--greenplum-version` — версия {{ GP }}: {{ versions.cli.str }}.
        * `--environment` — окружение:
            * `PRODUCTION` — для стабильных версий ваших приложений.
            * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
        * `--network-name` — [имя сети](../../vpc/concepts/network.md#network).
        * `--user-name` — имя пользователя. Может содержать латинские буквы, цифры, дефис и подчеркивание, но должно начинаться с буквы, цифры или подчеркивания. Длина от 1 до 32 символов.
        * `--user-password` — пароль. Длина от 8 до 128 символов.
        * `--master-config` и `--segment-config` — конфигурация хостов-мастеров и хостов-сегментов:
            * `resource-id` — [класс хоста](../concepts/instance-types.md).

                {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

            * `disk-size` — объем хранилища в гигабайтах.
            * `disk-type` — [тип диска](../concepts/storage.md):
                * `network-hdd` (только для хостов-мастеров);
                * `network-ssd` (только для хостов-мастеров);
                * `local-ssd`;
                * `network-ssd-nonreplicated`.

        * `--zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `--subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.
        * `--assign-public-ip` — флаг, который указывается, если для хостов нужен [публичный доступ](../concepts/network.md#public-access-to-a-host): `true` или `false`.
        * `--security-group-ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).
        * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}


            {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Чтобы задать время начала резервного копирования, передайте нужное значение в формате `HH:MM:SS` в параметре `--backup-window-start`:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя_кластера> \
           ...
           --backup-window-start=<время_начала_резервного_копирования>
        ```

    
    1. (Опционально) Чтобы создать кластер, размещенный на группах [выделенных хостов](../../compute/concepts/dedicated-host.md), укажите через запятую их идентификаторы в параметрах `--master-host-group-ids` и `--segment-host-group-ids`:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя_кластера> \
           ...
           --master-host-group-ids=<идентификаторы_групп_выделенных_хостов_для_хостов-мастеров> \
           --segment-host-group-ids=<идентификаторы_групп_выделенных_хостов_для_хостов-сегментов>
        ```

        Вы можете назначить группы на один из видов хостов {{ GP }} либо сразу на оба.

        Группа выделенных хостов должна быть предварительно [создана](../../compute/operations/dedicated-host/create-host-group.md) в сервисе {{ compute-full-name }}.

        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


    1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), передайте нужное значение в параметре `--maintenance-window` при создании кластера:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя_кластера> \
           ...
           --maintenance-window type=<тип_технического_обслуживания>,`
                               `day=<день_недели>,`
                               `hour=<час_дня> \
        ```

        Где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    
    1. Чтобы разрешить доступ к кластеру из разных сервисов, передайте значение `true` в соответствующих параметрах при создании кластера:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя_кластера> \
           ...
           --datalens-access=<разрешить_доступ_из_{{ datalens-name }}> \
           --yandexquery-access=<разрешить_доступ_из_Yandex_Query> \
           --websql-access=<разрешить_доступ_из_{{ websql-name }}>
        ```

        Доступные сервисы:

        * `--datalens-access` — [{{ datalens-full-name }}](../../datalens/concepts/index.md);
        * `--yandexquery-access` — [{{ yq-full-name }}](../../query/concepts/index.md);
        * `--websql-access` — [{{ websql-full-name }}](../../websql/concepts/index.md).



    
    1. Чтобы включить [передачу логов в сервис {{ cloud-logging-full-name }}](mgp-to-cloud-logging.md), укажите параметры при создании кластера:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя_кластера> \
           ...
           --service-account <идентификатор_сервисного_аккаунта> \
           --log-enabled \
           --log-command-center-enabled \
           --log-greenplum-enabled \
           --log-pooler-enabled \
           --log-folder-id <идентификатор_каталога>
        ```

        Где:

        * `--service-account` — идентификатор сервисного аккаунта.
        * `--log-enabled` — включает передачу логов.
        * `--log-command-center-enabled` — передача логов [командного центра](../concepts/command-center.md).
        * `--log-greenplum-enabled` — передача логов {{ GP }}.
        * `--log-pooler-enabled` — передача логов [менеджера подключений](../concepts/pooling.md).
        * `--log-folder-id` — идентификатор каталога, лог-группу которого нужно использовать.
        * `--log-group-id` — идентификатор лог-группы, в которую будут записываться логи.

            Укажите только одну из настроек: `--log-folder-id` либо `--log-group-id`.


- {{ TF }} {#tf}

  
  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}


  Чтобы создать кластер {{ mgp-name }}:

  1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры. Если такой директории нет — создайте ее.

  
  1. {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Создайте конфигурационный файл с описанием [облачной сети](../../vpc/concepts/network.md#network) и [подсетей](../../vpc/concepts/network.md#subnet).

      Кластер размещается в облачной сети. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.

      Хосты кластера размещаются в подсетях выбранной облачной сети. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

      Пример структуры конфигурационного файла, в котором описывается облачная сеть с одной подсетью:

      ```hcl
      resource "yandex_vpc_network" "<имя_сети_в_{{ TF }}>" { name = "<имя_сети>" }
      resource "yandex_vpc_subnet" "<имя_подсети_в_{{ TF }}>" {
        name           = "<имя_подсети>"
        zone           = "<зона_доступности>"
        network_id     = yandex_vpc_network.<имя_сети_в_{{ TF }}>.id
        v4_cidr_blocks = ["<подсеть>"]
      }
      ```


  1. Создайте конфигурационный файл с описанием кластера и его хостов.

      Пример структуры конфигурационного файла:

      
      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<имя_кластера_в_{{ TF }}>" {
        name                = "<имя_кластера>"
        environment         = "<окружение>"
        network_id          = yandex_vpc_network.<имя_сети_в_{{ TF }}>.id
        zone                = "<зона_доступности>"
        subnet_id           = yandex_vpc_subnet.<имя_подсети_в_{{ TF }}>.id
        assign_public_ip    = <разрешить_публичный_доступ_к_хостам_кластера>
        deletion_protection = <защитить_кластер_от_удаления>
        version             = "<версия_Greenplum>"
        master_host_count   = <количество_хостов_мастеров>
        segment_host_count  = <количество_хостов_сегментов>
        segment_in_host     = <количество_сегментов_на_хост>
        master_subcluster {
          resources {
            resource_preset_id = "<класс_хоста>"
            disk_size          = <объем_хранилища_ГБ>
            disk_type_id       = "<тип_диска>"
          }
        }
        segment_subcluster {
          resources {
            resource_preset_id = "<класс_хоста>"
            disk_size          = <объем_хранилища_ГБ>
            disk_type_id       = "<тип_диска>"
          }
        }

        access {
          data_lens    = <разрешить_доступ_из_{{ datalens-name }}>
          yandex_query = <разрешить_доступ_из_Yandex_Query>
        }

        user_name     = "<имя_пользователя>"
        user_password = "<пароль>"

        security_group_ids = ["<список_идентификаторов_групп_безопасности>"]
      }
     ```




      Где:

      * `assign_public_ip` — публичный доступ к хостам кластера: `true` или `false`.
      * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

          {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

      * `version` — версия {{ GP }}.
      * `master_host_count` — количество хостов-мастеров: 2.
      * `segment_host_count` — количество хостов-сегментов: от 2 до 32.
      * `segment_in_host` — [количество сегментов на хост](../concepts/index.md). Максимальное значение этого параметра зависит от класса хостов.

          {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

      
      * `access.data_lens` — доступ к кластеру из сервиса [{{ datalens-full-name }}](../../datalens/concepts/index.md): `true` или `false`.

      * `access.yandex_query` — доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md): `true` или `false`.



      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mgp }}).

  
  1. (Опционально) Чтобы разместить хосты-мастеры или хосты-сегменты на выделенных хостах, укажите группы [выделенных хостов](../../compute/concepts/dedicated-host.md):

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<имя_кластера_в_{{ TF }}>" {
        ...
        master_host_group_ids = [<идентификаторы_групп_выделенных_хостов_для_хостов-мастеров>]
        segment_host_group_ids = [<идентификаторы_групп_выделенных_хостов_для_хостов-сегментов>]
        ...
      }
      ```

      Вы можете назначить группы на один из двух видов хостов {{ GP }} либо сразу на оба.

      Группа выделенных хостов должна быть предварительно [создана](../../compute/operations/dedicated-host/create-host-group.md) в сервисе {{ compute-full-name }}.

      {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

  1. Чтобы включить [передачу логов в сервис {{ cloud-logging-full-name }}](mgp-to-cloud-logging.md), укажите параметры:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<имя_кластера_в_{{ TF }}>" {
        ...
        service_account_id="<идентификатор_сервисного_аккаунта>"
        logging {
          enabled                = <включить_передачу_логов>
          command_center_enabled = <передавать_логи_Yandex_Command_Center>
          greenplum_enabled      = <передавать_логи_{{ GP }}>
          pooler_enabled         = <передавать_логи_менеджера_подключений>
          folder_id              = "<идентификатор_каталога>"
        }
      }
      ```

      Где:

      * `service_account_id` — идентификатор сервисного аккаунта.
      * `logging` — настройки передачи логов:

          * `enabled` — включение передачи логов: `true` или `false`.
          * `command_center_enabled` — передача логов [командного центра](../concepts/command-center.md): `true` или `false`.
          * `greenplum_enabled` — передача логов {{ GP }}: `true` или `false`.
          * `pooler_enabled` — передача логов [менеджера подключений](../concepts/pooling.md): `true` или `false`.
          * `folder_id` — идентификатор каталога, лог-группу которого нужно использовать.
          * `log_group_id` — идентификатор лог-группы, в которую будут записываться логи.

              Укажите только одну из настроек: `folder_id` либо `log_group_id`.


  1. Проверьте корректность файлов конфигурации {{ TF }}:

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте кластер:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        
        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "config": {
            "version": "<версия_{{ GP }}>",
            "access": {
              "dataLens": <разрешить_доступ_из_{{ datalens-name }}>,
              "yandexQuery": <разрешить_доступ_из_Yandex_Query>
            },
            "zoneId": "<зона_доступности>",
            "subnetId": "<идентификатор_подсети>",
            "assignPublicIp": <разрешить_публичный_доступ_к_хостам_кластера>
          },
          "masterConfig": {
            "resources": {
              "resourcePresetId": "<класс_хостов>",
              "diskSize": "<размер_хранилища_в_байтах>",
              "diskTypeId": "<тип_диска>"
            }
          },
          "segmentConfig": {
            "resources": {
              "resourcePresetId": "<класс_хостов>",
              "diskSize": "<размер_хранилища_в_байтах>",
              "diskTypeId": "<тип_диска>"
            }
          },
          "masterHostCount": "<количество_хостов-мастеров>",
          "segmentHostCount": "<количество_хостов-сегментов>",
          "segmentInHost": "<количество_сегментов_на_хост>",
          "userName": "<имя_пользователя>",
          "userPassword": "<пароль_пользователя>",
          "networkId": "<идентификатор_сети>",
          "securityGroupIds": [
              "<идентификатор_группы_безопасности_1>",
              "<идентификатор_группы_безопасности_2>",
              ...
              "<идентификатор_группы_безопасности_N>"
          ],
          "deletionProtection": <защитить_кластер_от_удаления>,
          "configSpec": {
            "pool": {
              "mode": "<режим_работы>",
              "size": "<количество_клиентских_соединений>",
              "clientIdleTimeout": "<время_ожидания_клиента>"
            }
          },
          "cloudStorage": {
            "enable": <использовать_гибридное_хранилище>
          },
          "masterHostGroupIds": [
            "string"
          ],
          "segmentHostGroupIds": [
            "string"
          ],
          "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": "<включить_передачу_логов>",
            "commandCenterEnabled": "<передавать_логи_Yandex_Command_Center>",
            "greenplumEnabled": "<передавать_логи_{{ GP }}>",
            "poolerEnabled": "<передавать_логи_менеджера_подключений>",
            "folderId": "<идентификатор_каталога>"
          }
        }
        ```




        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
        * `config` — настройки кластера:

            * `version` — версия {{ GP }}.

            
            * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

                * `dataLens` — [{{ datalens-full-name }}](../../datalens/index.yaml): `true` или `false`.
                * `yandexQuery` — [{{ yq-full-name }}](../../query/concepts/index.md): `true` или `false`.



            * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
            * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).
            * `assignPublicIp` — публичный доступ к хостам кластера: `true` или `false`.

        * `masterConfig.resources`, `segmentConfig.resources` — конфигурация хостов-мастеров и хостов-сегментов кластера:

            * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
            * `diskSize` — размер диска в байтах;
            * `diskTypeId` — [тип диска](../concepts/storage.md).

        * `masterHostCount` — количество хостов-мастеров: `1` или `2`.
        * `segmentHostCount` — количество хостов-сегментов: от `2` до `32`.
        * `segmentInHost` — [количество сегментов на хост](../concepts/index.md). Максимальное значение этого параметра зависит от класса хостов.

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `userName` — имя пользователя.
        * `userPassword` — пароль пользователя.
        * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

        
        * `securityGroupIds` — идентификаторы [групп безопасности](../concepts/network.md#security-groups).


        * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`.

            {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

        * `configSpec.pool` — настройки [менеджера подключений](../concepts/pooling.md):

            * `mode` — режим работы: `SESSION` или `TRANSACTION`.
            * `size` — количество клиентских соединений.
            * `clientIdleTimeout` — время неактивности клиентского соединения в секундах, после которого соединение разрывается.

        * `cloudStorage.enable` — использование гибридного хранилища в кластерах с версией {{ GP }} 6.25 и выше. Установите значение `true`, чтобы включить в кластере [расширение {{ YZ }}](https://github.com/yezzey-gp/yezzey/) от {{ yandex-cloud }}. Оно применяется, чтобы [выгрузить таблицы AO и AOCO](../tutorials/yezzey.md) с дисков кластера {{ mgp-name }} в холодное хранилище {{ objstorage-full-name }}. Так данные хранятся в служебном бакете в сжатом и зашифрованном виде. Это [более экономичный способ хранения](../../storage/pricing.md).

            Гибридное хранилище нельзя отключить после сохранения настроек кластера.

            
            {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


        
        * `masterHostGroupIds` и `segmentHostGroupIds` — (опционально) идентификаторы групп [выделенных хостов](../../compute/concepts/dedicated-host.md) для хостов-мастеров и хостов-сегментов.

            Группа выделенных хостов должна быть предварительно [создана](../../compute/operations/dedicated-host/create-host-group.md) в сервисе {{ compute-full-name }}.

            {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

        * `serviceAccountId` — идентификатор сервисного аккаунта.
        * `logging` — настройки [передачи логов в сервис {{ cloud-logging-full-name }}](mgp-to-cloud-logging.md):

            * `enabled` — включение передачи логов: `true` или `false`.
            * `commandCenterEnabled` — передача логов [командного центра](../concepts/command-center.md): `true` или `false`.
            * `greenplumEnabled` — передача логов {{ GP }}: `true` или `false`.
            * `poolerEnabled` — передача логов [менеджера подключений](../concepts/pooling.md): `true` или `false`.
            * `folderId` — идентификатор каталога, лог-группу которого нужно использовать.
            * `logGroupId` — идентификатор лог-группы, в которую будут записываться логи.

                Укажите только одну из настроек: `folderId` либо `logGroupId`.


    1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters' \
            --data "@body.json"
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        
        ```json
        {
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "config": {
            "version": "<версия_{{ GP }}>",
            "access": {
              "data_lens": <разрешить_доступ_из_{{ datalens-name }}>,
              "yandex_query": <разрешить_доступ_из_Yandex_Query>
            },
            "zone_id": "<зона_доступности>",
            "subnet_id": "<идентификатор_подсети>",
            "assign_public_ip": <разрешить_публичный_доступ_к_хостам_кластера>
          },
          "master_config": {
            "resources": {
              "resource_preset_id": "<класс_хостов>",
              "disk_size": "<размер_хранилища_в_байтах>",
              "disk_type_id": "<тип_диска>"
            }
          },
          "segment_config": {
            "resources": {
              "resource_preset_id": "<класс_хостов>",
              "disk_size": "<размер_хранилища_в_байтах>",
              "disk_type_id": "<тип_диска>"
            }
          },
          "master_host_count": "<количество_хостов-мастеров>",
          "segment_host_count": "<количество_хостов-сегментов>",
          "segment_in_host": "<количество_сегментов_на_хост>",
          "user_name": "<имя_пользователя>",
          "user_password": "<пароль_пользователя>",
          "network_id": "<идентификатор_сети>",
          "security_group_ids": [
              "<идентификатор_группы_безопасности_1>",
              "<идентификатор_группы_безопасности_2>",
              ...
              "<идентификатор_группы_безопасности_N>"
          ],
          "deletion_protection": <защитить_кластер_от_удаления>
          "config_spec": {
            "pool": {
              "mode": "<режим_работы>",
              "size": "<количество_клиентских_соединений>",
              "client_idle_timeout": "<время_ожидания_клиента>"
            }
          },
          "cloud_storage": {
            "enable": <использовать_гибридное_хранилище>
          },
          "master_host_group_ids": [
            "string"
          ],
          "segment_host_group_ids": [
            "string"
          ],
          "service_account_id": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": "<включить_передачу_логов>",
            "command_center_enabled": "<передавать_логи_Yandex_Command_Center>",
            "greenplum_enabled": "<передавать_логи_{{ GP }}>",
            "pooler_enabled": "<передавать_логи_менеджера_подключений>",
            "folder_id": "<идентификатор_каталога>"
          }
        }
        ```




        Где:

        * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
        * `config` — настройки кластера:

            * `version` — версия {{ GP }}.

            
            * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

                * `data_lens` — [{{ datalens-full-name }}](../../datalens/index.yaml): `true` или `false`.
                * `yandex_query` — [{{ yq-full-name }}](../../query/concepts/index.md): `true` или `false`.



            * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
            * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).
            * `assign_public_ip` — публичный доступ к хостам кластера: `true` или `false`.

        * `master_config.resources`, `segment_config.resources` — конфигурация хостов-мастеров и хостов-сегментов кластера:

            * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
            * `disk_size` — размер диска в байтах;
            * `disk_type_id` — [тип диска](../concepts/storage.md).

        * `master_host_count` — количество хостов-мастеров: `1` или `2`.
        * `segment_host_count` — количество хостов-сегментов: от `2` до `32`.
        * `segment_in_host` — [количество сегментов на хост](../concepts/index.md). Максимальное значение этого параметра зависит от класса хостов.

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `user_name` — имя пользователя.
        * `user_password` — пароль пользователя.
        * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

        
        * `security_group_ids` — идентификаторы [групп безопасности](../concepts/network.md#security-groups).


        * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

            {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

        * `config_spec.pool` — настройки [менеджера подключений](../concepts/pooling.md):

            * `mode` — режим работы: `SESSION` или `TRANSACTION`.
            * `size` — количество клиентских соединений.
            * `client_idle_timeout` — время неактивности клиентского соединения в секундах, после которого соединение разрывается.

        * `cloud_storage.enable` — использование гибридного хранилища в кластерах с версией {{ GP }} 6.25 и выше. Установите значение `true`, чтобы включить в кластере [расширение {{ YZ }}](https://github.com/yezzey-gp/yezzey/) от {{ yandex-cloud }}. Оно применяется, чтобы [выгрузить таблицы AO и AOCO](../tutorials/yezzey.md) с дисков кластера {{ mgp-name }} в холодное хранилище {{ objstorage-full-name }}. Так данные хранятся в служебном бакете в сжатом и зашифрованном виде. Это [более экономичный способ хранения](../../storage/pricing.md).

            Гибридное хранилище нельзя отключить после сохранения настроек кластера.

            
            {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


        
        * `master_host_group_ids` и `segment_host_group_ids` — (опционально) идентификаторы групп [выделенных хостов](../../compute/concepts/dedicated-host.md) для хостов-мастеров и хостов-сегментов.

            Группа выделенных хостов должна быть предварительно [создана](../../compute/operations/dedicated-host/create-host-group.md) в сервисе {{ compute-full-name }}.

            {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

        * `service_account_id` — идентификатор сервисного аккаунта.
        * `logging` — настройки [передачи логов в сервис {{ cloud-logging-full-name }}](mgp-to-cloud-logging.md):

            * `enabled` — включение передачи логов: `true` или `false`.
            * `command_center_enabled` — передача логов [командного центра](../concepts/command-center.md): `true` или `false`.
            * `greenplum_enabled` — передача логов {{ GP }}: `true` или `false`.
            * `pooler_enabled` — передача логов [менеджера подключений](../concepts/pooling.md): `true` или `false`.
            * `folder_id` — идентификатор каталога, лог-группу которого нужно использовать.
            * `log_group_id` — идентификатор лог-группы, в которую будут записываться логи.

                Укажите только одну из настроек: `folder_id` либо `log_group_id`.


    1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Create \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Создать копию кластера {#duplicate}

Вы можете создать кластер {{ GP }}, который будет обладать настройками созданного ранее кластера. Для этого конфигурация исходного кластера {{ GP }} импортируется в {{ TF }}. В результате вы можете либо создать идентичную копию, либо взять за основу импортированную конфигурацию и внести в нее изменения. Использовать импорт удобно, если исходный кластер {{ GP }} обладает множеством настроек и нужно создать похожий на него кластер.

Чтобы создать копию кластера {{ GP }}:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "old" { }
        ```

    1. Запишите идентификатор первоначального кластера {{ GP }} в переменную окружения:

        ```bash
        export GREENPLUM_CLUSTER_ID=<идентификатор_кластера>
        ```

        Идентификатор можно запросить вместе со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Импортируйте настройки первоначального кластера {{ GP }} в конфигурацию {{ TF }}:

        ```bash
        terraform import yandex_mdb_greenplum_cluster.old ${GREENPLUM_CLUSTER_ID}
        ```

    1. Получите импортированную конфигурацию:

        ```bash
        terraform show
        ```

    1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
    1. Расположите файл в новой директории `imported-cluster`.
    1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер:

        * Укажите новое имя кластера в строке `resource` и параметре `name`.
        * Удалите параметры `created_at`, `health`, `id`, `status`, `master_hosts` и `segment_hosts`.
        * Добавьте параметр `user_password`.
        * Если в блоке `maintenance_window` указано значение параметра `type = "ANYTIME"`, удалите параметр `hour`.
        * (Опционально) Внесите дополнительные изменения, если вам нужна не идентичная, а кастомизированная копия.

    1. В директории `imported-cluster` [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).

    1. В этой же директории [настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Поместите конфигурационный файл в директорию `imported-cluster` и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Проверьте корректность файлов конфигурации {{ TF }}:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Примеры {#examples}

### Создание кластера {#create-example}

{% list tabs group=instructions %}

- CLI {#cli}

    Создайте кластер {{ mgp-name }} с тестовыми характеристиками:

    
    * С именем `gp-cluster`.
    * Версии `{{ versions.cli.latest }}`.
    * В окружении `PRODUCTION`.
    * В сети `default`.
    * С пользователем `user1`.
    * С паролем `user1user1`.
    * С хостами-мастерами и хостами-сегментами:

        * Класса `s2.medium`.
        * С хранилищем на локальных SSD-дисках (`local-ssd`) объемом 100 ГБ.

    * В зоне доступности `{{ region-id }}-a`, в подсети `{{ subnet-id }}`.
    * С публичным доступом к хостам.
    * В группе безопасности `{{ security-group }}`.
    * С защитой от непреднамеренного удаления.


    Выполните следующую команду:

    
    ```bash
    {{ yc-mdb-gp }} cluster create \
       --name=gp-cluster \
       --greenplum-version={{ versions.cli.latest }} \
       --environment=PRODUCTION \
       --network-name=default \
       --user-name=user1 \
       --user-password=user1user1 \
       --master-config resource-id=s2.medium,`
                      `disk-size=100,`
                      `disk-type=local-ssd \
       --segment-config resource-id=s2.medium,`
                       `disk-size=100,`
                       `disk-type=local-ssd \
       --zone-id={{ region-id }}-a \
       --subnet-id={{ subnet-id }} \
       --assign-public-ip=true \
       --security-group-ids={{ security-group }} \
       --deletion-protection
    ```


{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
