# Создание {{ GP }}-кластера

Кластер {{ mgp-name }} состоит из хостов-мастеров, которые принимают запросы от клиента, и хостов-сегментов, которые обеспечивают обработку и хранение данных.

Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

Подробнее см. в разделе [{#T}](../concepts/index.md).

## Как создать кластер {{ mgp-name }} {#create-cluster}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер баз данных.
    1. Выберите сервис **{{ mgp-name }}**.
    1. Нажмите кнопку **Создать кластер**.
    1. Введите имя кластера. Оно должно быть уникальным в рамках каталога.
    1. (опционально) Введите описание кластера.
    1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
        * `PRODUCTION` — для стабильных версий ваших приложений.
        * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mgp-full-name }}. В Prestable-окружении раньше появляются новые функциональные возможности, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
    1. Выберите версию {{ GP }}.

    
    1. (Опционально) Выберите группы [выделенных хостов](../../compute/concepts/dedicated-host.md), на которых будет размещен кластер.
       
        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

    1. В блоке **Сетевые настройки**:
        * Выберите облачную сеть для размещения кластера.
        * В параметре **Группы безопасности** укажите [группу безопасности](../operations/connect.md#configuring-security-groups), которая содержит правила, разрешающие любой исходящий и входящий трафик по любому протоколу с любых IP-адресов.

            {% note alert %}

            Для корректной работы кластера {{ mgp-name }} необходимо, чтобы хотя бы в одной из его групп безопасности были правила, разрешающие любой входящий и исходящий трафик с любых IP-адресов.

            {% endnote %}


        * Выберите зону доступности и подсеть для размещения кластера. Чтобы создать новую подсеть, нажмите кнопку **Создать новую** рядом с нужной зоной доступности.
        * Выберите опцию **Публичный доступ**, чтобы подключаться к кластеру из интернета.

    1. Укажите настройки пользователя-администратора. Это специальный пользователь, который необходим для управления кластером и не может быть удален. Подробнее в разделе [{#T}](../concepts/cluster-users.md).

        * **Имя пользователя** — может содержать латинские буквы, цифры, дефис и нижнее подчеркивание, но не может начинаться с дефиса. Длина от 1 до 32 символов.

            {% note info %}

            Имена `admin`, `gpadmin`, `mdb_admin`, `mdb_replication`, `monitor`, `none`, `postgres`, `public`, `repl` зарезервированы для собственных нужд {{ mgp-name }}. Создавать пользователей с этими именами нельзя.

            {% endnote %}

        * **Пароль** — длина от 8 до 128 символов.

    1. При необходимости задайте дополнительные настройки кластера:

        * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
        * **Окно обслуживания** — настройки времени [технического обслуживания](../concepts/maintenance.md):

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
        * {% include [DataTransfer access](../../_includes/mdb/console/datatransfer-access.md) %}
        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

            {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * **Менеджер подключений** — режим работы и параметры [менеджера подключений](..//concepts/pooling.md):

            {% include [Pooling mode](../../_includes/mdb/mgp/pooling-mode.md) %}

    1. При необходимости задайте [настройки СУБД уровня кластера](../concepts/settings-list.md#dbms-cluster-settings).

    1. Укажите параметры хостов-мастеров на вкладке **Master**. Рекомендуемую конфигурацию см. в разделе [Расчет конфигурации кластера](calculate-specs.md#master).

        * [Класс хоста](../concepts/instance-types.md) — определяет технические характеристики виртуальных машин, на которых будут развернуты хосты-мастеры кластера.

        * В блоке **Хранилище**:
          * Выберите [тип диска](../concepts/storage.md).

            
            {% include [storages-step-settings](../../_includes/mdb/mgp/settings-storages.md) %}


    1. Укажите параметры хостов-сегментов на вкладке **Segment**. Рекомендуемую конфигурацию см. в разделе [Расчет конфигурации кластера](calculate-specs.md#segment).

        * Количество хостов-сегментов.
        * Количество сегментов на хост. Максимальное значение этого параметра зависит от класса хостов.
        * [Класс хоста](../concepts/instance-types.md) — определяет технические характеристики виртуальных машин, на которых будут развернуты хосты-сегменты кластера.
        * В блоке **Хранилище**:
           * Выберите [тип диска](../concepts/storage.md).

             
             {% include [storages-step-settings](../../_includes/mdb/mgp/settings-storages.md) %}
             

    1. Нажмите кнопку **Создать**.

- CLI

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
        {{ yc-mdb-gp }} cluster create <имя кластера> \
           --greenplum-version=<версия {{ GP }}: {{ versions.cli.str }}> \
           --environment=<окружение: PRESTABLE или PRODUCTION> \
           --network-name=<имя сети> \
           --user-name=<имя пользователя> \
           --user-password=<пароль пользователя> \
           --master-config resource-id=<класс хоста>,`
                          `disk-size=<объем хранилища, ГБ>,`
                          `disk-type=<тип диска> \
           --segment-config resource-id=<класс хоста>,`
                          `disk-size=<объем хранилища, ГБ>,`
                          `disk-type=<тип диска> \
           --zone-id=<зона доступности> \
           --subnet-id=<идентификатор подсети> \
           --assign-public-ip=<доступ к хостам через публичный IP-адрес: true или false> \
           --security-group-ids=<список идентификаторов групп безопасности> \
           --deletion-protection=<защита от удаления кластера: true или false>
        ```

        {% note info %}

        Имя кластера должно быть уникальным в каталоге. Оно может содержать латинские буквы, цифры, дефис и нижнее подчеркивание. Максимальная длина имени 63 символа.

        {% endnote %}

        Где:

        * `--greenplum-version` — версия {{ GP }}.
        * `--environment` — окружение:
            * `PRODUCTION` — для стабильных версий ваших приложений.
            * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ GP }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
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
        * `--assign-public-ip` — флаг, который указывается, если хостам требуется [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
        * `--security-group-ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).
        * `--deletion-protection` — защита от удаления кластера.


            {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Чтобы задать время начала резервного копирования, передайте нужное значение в формате `HH:MM:SS` в параметре `--backup-window-start`:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя кластера> \
           ...
           --backup-window-start=<время начала резервного копирования>
        ```

    
    1. Чтобы создать кластер, размещенный на группах [выделенных хостов](../../compute/concepts/dedicated-host.md), укажите через запятую их идентификаторы в параметре `--host-group-ids`:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя кластера> \
           ...
           --host-group-ids=<идентификаторы групп выделенных хостов>
        ```

        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


    1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), передайте нужное значение в параметре `--maintenance-window` при создании кластера:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя кластера> \
           ...
           --maintenance-window type=<тип технического обслуживания: anytime или weekly>,`
                               `day=<день недели для типа weekly>,`
                               `hour=<час дня для типа weekly>
        ```

        Где:

        * `type` — тип технического обслуживания:
            * `anytime` — в любое время.
            * `weekly` — по расписанию.
        * `day` — день недели для типа `weekly` в формате `DDD`. Например, `MON`.
        * `hour` — час дня по UTC для типа `weekly` в формате `HH`. Например, `21`.

    1. Чтобы разрешить доступ из [{{ datalens-full-name }}](../../datalens/concepts/index.md) или [{{ data-transfer-full-name }}](../../data-transfer/), передайте значение `true` в соответствующих параметрах при создании кластера:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя кластера> \
           ...
           --datalens-access=<доступ из {{ datalens-full-name }}: true или false> \
           --datatransfer-access=<доступ из {{ data-transfer-full-name }}: true или false>
        ```

- {{ TF }}

    {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Чтобы создать кластер:

    1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры. Если такой директории нет — создайте ее.

    
    1. Если у вас еще нет {{ TF }}, [установите его и создайте конфигурационный файл с настройками провайдера](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    2. Создайте конфигурационный файл с описанием [облачной сети](../../vpc/concepts/network.md#network) и [подсетей](../../vpc/concepts/network.md#subnet).

       Кластер размещается в облачной сети. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.

       Хосты кластера размещаются в подсетях выбранной облачной сети. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

       Пример структуры конфигурационного файла, в котором описывается облачная сеть с одной подсетью:

       ```hcl
       resource "yandex_vpc_network" "<имя сети в {{ TF }}>" { name = "<имя сети>" }
  
       resource "yandex_vpc_subnet" "<имя подсети в {{ TF }}>" {
         name           = "<имя подсети>"
         zone           = "<зона доступности>"
         network_id     = yandex_vpc_network.<имя сети в {{ TF }}>.id
         v4_cidr_blocks = ["<подсеть>"]
       }
       ```


    1. Создайте конфигурационный файл с описанием кластера и его хостов.

       Пример структуры конфигурационного файла:

       
       ```hcl
       resource "yandex_mdb_greenplum_cluster" "<имя кластера в {{ TF }}>" {
         name                = "<имя кластера>"
         environment         = "<окружение>"
         network_id          = yandex_vpc_network.<имя сети в {{ TF }}>.id
         zone                = "<зона доступности>"
         subnet_id           = yandex_vpc_subnet.<имя сети в {{ TF }}>.id
         assign_public_ip    = <получение публичного IP-адреса: true или false>
         deletion_protection = <защита от удаления кластера: true или false>
         version             = "<версия {{ GP }}>"
         master_host_count   = <количество хостов-мастеров: 1 или 2>
         segment_host_count  = <количество хостов-сегментов: от 2 до 32>
         segment_in_host     = <количество сегментов на хост>
  
         master_subcluster {
           resources {
             resource_preset_id = "<класс хоста>"
             disk_size          = <объем хранилища, ГБ>
             disk_type_id       = "<тип диска>"
           }
         }
  
         segment_subcluster {
           resources {
             resource_preset_id = "<класс хоста>"
             disk_size          = <объем хранилища, ГБ>
             disk_type_id       = "<тип диска>"
           }
         }
  
         user_name     = "<имя пользователя>"
         user_password = "<пароль>"
  
         security_group_ids = ["<список идентификаторов групп безопасности>"]
       }
       ```


       Включенная защита от удаления кластера не помешает подключиться вручную и удалить содержимое базы данных.

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mgp }}).

    1. Проверьте корректность файлов конфигурации {{ TF }}:

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- API

    Воспользуйтесь методом API [create](../api-ref/Cluster/create.md) и передайте в запросе:

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
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

{% endlist %}

## Примеры {#examples}

### Создание кластера {#create-example}

{% list tabs %}

- CLI

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
       --sqlserver-version={{ versions.cli.latest }} \
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
