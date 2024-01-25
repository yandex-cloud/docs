# Создание {{ GP }}-кластера

[Кластер](../../glossary/cluster.md) {{ mgp-name }} состоит из хостов-мастеров, которые принимают запросы от клиента, и хостов-сегментов, обеспечивающих обработку и хранение данных.

Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

Подробнее см. в разделе [{#T}](../concepts/index.md).

## Как создать кластер {{ mgp-name }} {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер баз данных.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Введите имя кластера. Оно должно быть уникальным в рамках каталога.
    1. (Опционально) Введите описание кластера.
    1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
        * `PRODUCTION` — для стабильных версий ваших приложений.
        * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
    1. Выберите версию {{ GP }}.

    
    1. (Опционально) Выберите группы [выделенных хостов](../../compute/concepts/dedicated-host.md), на которых будет размещен кластер.
       
        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}**:
        * Выберите облачную сеть для размещения кластера.
        * В параметре **{{ ui-key.yacloud.mdb.forms.field_security-group }}** укажите [группу безопасности](../operations/connect.md#configuring-security-groups), которая содержит правила, разрешающие любой исходящий и входящий трафик по любому протоколу с любых IP-адресов.

            {% note alert %}

            Для корректной работы кластера {{ mgp-name }} необходимо, чтобы хотя бы в одной из его групп безопасности были правила, разрешающие любой входящий и исходящий трафик с любых IP-адресов.

            {% endnote %}


        * Выберите зону доступности и подсеть для размещения кластера. Чтобы создать новую подсеть, нажмите кнопку **{{ ui-key.yacloud.common.label_create-new_female }}** рядом с нужной зоной доступности.
        * Выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, чтобы подключаться к кластеру из интернета.

    1. (Опционально) Для кластера с версией {{ GP }} 6.25 и выше включите опцию **{{ ui-key.yacloud.greenplum.section_cloud-storage }}**.

        Она активирует [расширение {{ YZ }}](https://github.com/yezzey-gp/yezzey/) от {{ yandex-cloud }}. Оно применяется, чтобы [выгрузить таблицы AO и AOCO](../tutorials/yezzey.md) с дисков кластера {{ mgp-name }} в холодное хранилище {{ objstorage-name }}. Так данные хранятся в служебном бакете в сжатом и зашифрованном виде. Это [более экономичный способ хранения](../../storage/pricing.md).

        Эту опцию нельзя отключить после сохранения настроек кластера.

        
        {% note info %}

        Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md) и не тарифицируется.

        {% endnote %}


    1. Укажите настройки пользователя-администратора. Это специальный пользователь, который необходим для управления кластером и не может быть удален. Подробнее в разделе [{#T}](../concepts/cluster-users.md).

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — может содержать латинские буквы, цифры, дефис и нижнее подчеркивание, но не может начинаться с дефиса. Длина от 1 до 32 символов.

            {% note info %}

            Имена `admin`, `gpadmin`, `mdb_admin`, `mdb_replication`, `monitor`, `none`, `postgres`, `public`, `repl` зарезервированы для собственных нужд {{ mgp-name }}. Создавать пользователей с этими именами нельзя.

            {% endnote %}

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — длина от 8 до 128 символов.

    1. При необходимости задайте дополнительные настройки кластера:

        * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
        * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../concepts/maintenance.md):

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
        * {% include [DataTransfer access](../../_includes/mdb/console/datatransfer-access.md) %}
        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

            {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. (Опционально) Задайте режим работы и параметры [менеджера подключений](../concepts/pooling.md) в блоке **{{ ui-key.yacloud.mdb.forms.section_pooler }}**:

        {% include [Pooling mode](../../_includes/mdb/mgp/pooling-mode.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.greenplum.section_background-activities }}** измените параметры [регламентных операций технического обслуживания](../concepts/maintenance.md#regular-ops):

        {% include [background activities](../../_includes/mdb/mgp/background-activities-console.md) %}

    1. Укажите параметры хостов-мастеров на вкладке **{{ ui-key.yacloud.greenplum.section_resource-master }}**. Рекомендуемую конфигурацию см. в разделе [Расчет конфигурации кластера](calculate-specs.md#master).

        * [{{ ui-key.yacloud.mdb.forms.section_resource }}](../concepts/instance-types.md) — определяет технические характеристики виртуальных машин, на которых будут развернуты хосты-мастеры кластера.

        * В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
          * Выберите [тип диска](../concepts/storage.md).

            
            {% include [storages-step-settings](../../_includes/mdb/mgp/settings-storages.md) %}


    1. Укажите параметры хостов-сегментов на вкладке **{{ ui-key.yacloud.greenplum.section_resource-segment }}**. Рекомендуемую конфигурацию см. в разделе [Расчет конфигурации кластера](calculate-specs.md#segment).

        * Количество хостов-сегментов.
        * Количество сегментов на хост. Максимальное значение этого параметра зависит от класса хостов.
        * [Класс хоста](../concepts/instance-types.md) — определяет технические характеристики виртуальных машин, на которых будут развернуты хосты-сегменты кластера.
        * В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
           * Выберите [тип диска](../concepts/storage.md).

             
             {% include [storages-step-settings](../../_includes/mdb/mgp/settings-storages.md) %}
             

    1. При необходимости задайте [настройки СУБД уровня кластера](../concepts/settings-list.md#dbms-cluster-settings).

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать кластер:

    
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
                          `disk-type=<тип_диска> \
           --segment-config resource-id=<класс_хоста>,`
                          `disk-size=<объем_хранилища_ГБ>,`
                          `disk-type=<тип_диска> \
           --zone-id=<зона_доступности> \
           --subnet-id=<идентификатор_подсети> \
           --assign-public-ip=<публичный_доступ_к_хостам> \
           --security-group-ids=<список_идентификаторов_групп_безопасности> \
           --deletion-protection=<защита_от_удаления_кластера>
        ```

        {% note info %}

        Имя кластера должно быть уникальным в каталоге. Оно может содержать латинские буквы, цифры, дефис и нижнее подчеркивание. Максимальная длина имени 63 символа.

        {% endnote %}

        Где:

        * `--greenplum-version` — версия {{ GP }}: {{ versions.cli.str }}.
        * `--environment` — окружение:
            * `PRODUCTION` — для стабильных версий ваших приложений.
            * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
        * `--network-name` — [имя сети](../../vpc/concepts/network.md#network).
        * `--user-name` — имя пользователя. Может содержать латинские буквы, цифры, дефис и нижнее подчеркивание, но должно начинаться с буквы, цифры или нижнего подчеркивания. Длина от 1 до 32 символов.
        * `--user-password` — пароль. Длина от 8 до 128 символов.
        * `--master-config` и `--segment-config` — конфигурация хостов-мастеров и хостов-сегментов:
            * `resource-id` — [класс хоста](../concepts/instance-types.md).
            * `disk-size` — объем хранилища в гигабайтах.
            * `disk-type` — [тип диска](../concepts/storage.md):
                * `network-hdd`;
                * `network-ssd`;
                * `local-ssd`;
                * `network-ssd-nonreplicated`.

        * `--zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `--subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.
        * `--assign-public-ip` — флаг, который указывается, если для хостов нужен [публичный доступ](../concepts/network.md#public-access-to-a-host): `true` или `false`.
        * `--security-group-ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).
        * `--deletion-protection` — защита от удаления кластера: `true` или `false`.


            {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Чтобы задать время начала резервного копирования, передайте нужное значение в формате `HH:MM:SS` в параметре `--backup-window-start`:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя_кластера> \
           ...
           --backup-window-start=<время_начала_резервного_копирования>
        ```

    
    1. Чтобы создать кластер, размещенный на группах [выделенных хостов](../../compute/concepts/dedicated-host.md), укажите через запятую их идентификаторы в параметре `--host-group-ids`:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя_кластера> \
           ...
           --host-group-ids=<идентификаторы_групп_выделенных_хостов>
        ```

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

    1. Чтобы разрешить доступ из [{{ datalens-full-name }}](../../datalens/concepts/index.md) или [{{ data-transfer-full-name }}](../../data-transfer/), передайте значение `true` в соответствующих параметрах при создании кластера:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя_кластера> \
           ...
           --datalens-access=<доступ_из_datalens> \
           --datatransfer-access=<доступ_из_data_transfer>
        ```

        Где:

        * `--datalens-access` — доступ из {{ datalens-full-name }}: true или false.
        * `--datatransfer-access` — доступ из {{ data-transfer-full-name }}: true или false.
        
- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Чтобы создать кластер:

    1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры. Если такой директории нет — создайте ее.

    
    1. {% include [terraform-install](../../_includes/terraform-install.md) %}

    2. Создайте конфигурационный файл с описанием [облачной сети](../../vpc/concepts/network.md#network) и [подсетей](../../vpc/concepts/network.md#subnet).

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
         assign_public_ip    = <публичный_доступ_к_хостам_кластера>
         deletion_protection = <защита_от_удаления_кластера>
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
  
         user_name     = "<имя_пользователя>"
         user_password = "<пароль>"
  
         security_group_ids = ["<список_идентификаторов_групп_безопасности>"]
       }
       ```


       Где:

       * `assign_public_ip` — публичный доступ к хостам кластера: true или false.
       * `deletion_protection` — защита от удаления кластера: true или false.
       * `version` — версия {{ GP }}.
       * `master_host_count` — количество хостов-мастеров: 1 или 2.
       * `segment_host_count` — количество хостов-сегментов: от 2 до 32.
       * `disk_size` — объем хранилища в гигабайтах.

       Включенная защита от удаления кластера не помешает подключиться вручную и удалить содержимое базы данных.

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mgp }}).

    1. Проверьте корректность файлов конфигурации {{ TF }}:

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- API {#api}

    Чтобы создать кластер, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
    * Имя кластера в параметре `name`.
    * Окружение кластера в параметре `environment`.
    * Версию {{ GP }} в параметре `config.version`.
    * Имя пользователя в параметре `userName`.
    * Пароль пользователя в параметре `userPassword`.
    * Идентификатор сети в параметре `networkId`.

    
    * Идентификаторы [групп безопасности](../concepts/network.md#security-groups) в параметре `securityGroupIds`.


    * Конфигурацию хостов-мастеров в параметре `masterConfig`.
    * Конфигурацию хостов-сегментов в параметре `segmentConfig`.

    При необходимости передайте дополнительные настройки кластера:

    * Настройки публичного доступа в параметре `assignPublicIp`.
    * Настройки окна резервного копирования в параметре `config.backupWindowStart`.
    * Настройки доступа из [{{ datalens-full-name }}](../../datalens/concepts/index.md) в параметре `config.access.dataLens`.
    * Настройки доступа из [{{ data-transfer-full-name }}](../../data-transfer/) в параметре `config.access.dataTransfer`.
    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.
    * [Настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings) в параметре `configSpec.greenplumConfig_<версия>`.
    * Настройки [регламентных операций технического обслуживания](../concepts/maintenance.md#regular-ops) в параметре `configSpec.backgroundActivities.analyzeAndVacuum`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

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
    * С защитой от случайного удаления кластера.


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
       --deletion-protection=true
    ```


{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
