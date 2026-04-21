---
title: Как создать кластер {{ CH }}
description: Следуя данной инструкции, вы сможете создать кластер {{ CH }} с одним или несколькими хостами базы данных.
---

# Создание кластера {{ CH }}


Кластер {{ CH }} состоит из одного или нескольких хостов базы данных. Если кластер состоит из нескольких хостов, между ними можно настроить [репликацию](../concepts/replication.md). Для репликации используется один из [сервисов координации](../concepts/coordination-system.md): {{ CK }} или {{ ZK }}.

Подробнее о том, какой сервис координации выбрать, читайте в разделе [{#T}](../concepts/coordination-system.md#coordination-system-selection).

{% include [note-pricing-zk-ck](../../_includes/mdb/mch/note-pricing-zk-ck.md) %}


Подключениями к БД кластера управляет сервис {{ connection-manager-name }}. Вместе с кластером автоматически создаются:

* [Подключение {{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) с информацией о соединении с БД.

* [Секрет {{ lockbox-name }}](../../metadata-hub/concepts/secret.md), в котором хранится пароль пользователя — владельца БД.

Подключение и секрет создаются для каждого нового пользователя БД. Чтобы увидеть все подключения, на странице кластера выберите вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**. Для просмотра информации о подключении требуется роль `connection-manager.viewer`.

Использование сервиса {{ connection-manager-name }} и секретов, созданных с его помощью, не тарифицируется.



## Роли для создания кластера {#roles}

Для создания кластера {{ mch-name }} нужна роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль [{{ roles.mch.editor }}](../security.md#managed-clickhouse-editor) или выше.

Если вы хотите привязать сервисный аккаунт к кластеру (например, для [работы с {{ objstorage-full-name }}](s3-access.md)), вашему аккаунту в {{ yandex-cloud }} нужна роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.

О назначении ролей читайте в [документации {{ iam-full-name }}](../../iam/operations/roles/grant.md).


## Создать кластер с {{ CK }} {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvcndvjbwofzyjljsq?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=M_RXJfOoEFE&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=4&pp=iAQB).



  Чтобы создать кластер {{ mch-name }} с сервисом координации {{ CK }}:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Введите имя кластера в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
      * `PRODUCTION` — для стабильных версий ваших приложений.
      * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
  1. Выберите [версию {{ CH }}](../concepts/update-policy.md), которую будет использовать кластер {{ mch-name }}, из выпадающего списка **{{ ui-key.yacloud.mdb.forms.base_field_version }}**. Для большинства кластеров рекомендуется выбрать самую новую LTS-версию.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**:

      * Выберите платформу, тип виртуальной машины и класс хостов — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты БД. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных экземпляров.

      
      * Выберите [тип диска](../concepts/storage.md).

        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


      * Выберите размер диска, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [Резервные копии](../concepts/backup.md).

      * (Опционально) Задайте настройки [автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) {{ CH }}:

        {% include [disk-size-autoscaling-console](../../_includes/mdb/mch/disk-size-autoscaling-console.md) %}

        Настройки автоматического увеличения размера хранилища, заданные для {{ CH }}, применяются ко всем существующим шардам. При добавлении нового шарда значения настройки берутся с самого старого шарда.

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}**:
      
      * Укажите параметры хостов БД, создаваемых вместе с кластером. Чтобы изменить настройки хоста, нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg) в строке с его номером:

        * **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_zone }}** — выберите [зону доступности](../../overview/concepts/geo-scope.md).

        
        * **{{ ui-key.yacloud.mdb.hosts.dialog.field_subnetworks }}** — укажите [подсеть](../../vpc/concepts/network.md#subnet) в выбранной зоне доступности.

        * **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** — разрешите [доступ](connect/index.md) к хосту из интернета.


        * Если для кластера включено [шардирование](../concepts/sharding.md) и хостов больше, чем шардов, выберите шард.

        Чтобы добавить хосты в кластер, нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.

      * Выберите [сервис координации](../concepts/coordination-system.md) **{{ ui-key.yacloud.clickhouse.cluster.value_coordination-service-separated-clickhouse-keeper }}** или **{{ ui-key.yacloud.clickhouse.cluster.value_coordination-service-embedded-clickhouse-keeper }}**.

        {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

  1. Если был выбран сервис координации **{{ ui-key.yacloud.clickhouse.cluster.value_coordination-service-separated-clickhouse-keeper }}**, задайте следующие настройки:
      
      * В блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-resource }}** выберите платформу, тип виртуальной машины и [класс хоста](../concepts/instance-types.md).
      * В блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-disk }}** выберите [тип диска](../concepts/storage.md), размер хранилища и при необходимости задайте настройки [автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) {{ CK }}.
      * В блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-hosts }}** при необходимости измените настройки автоматически добавленных хостов {{ CK }}.
        
        Чтобы изменить настройки хоста, нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg) в строке нужного хоста и укажите:
          
        * **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_zone }}** — выберите [зону доступности](../../overview/concepts/geo-scope.md).

        
        * **{{ ui-key.yacloud.mdb.hosts.dialog.field_subnetworks }}** — выберите [подсеть](../../vpc/concepts/network.md#subnet) в выбранной зоне доступности.

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**:

      * Если вы хотите управлять пользователями кластера через SQL, в поле **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** выберите из выпадающего списка **{{ ui-key.yacloud.common.enabled }}** и укажите пароль пользователя `admin`. Управление пользователями через другие интерфейсы при этом станет недоступно.

        В противном случае выберите **{{ ui-key.yacloud.common.disabled }}**.


      * Если вы хотите управлять базами данных через SQL, в поле **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}** выберите из выпадающего списка **{{ ui-key.yacloud.common.enabled }}**. Управление базами данных через другие интерфейсы при этом станет недоступно. Поле неактивно, если управление пользователями через SQL выключено.

        В противном случае выберите **{{ ui-key.yacloud.common.disabled }}**.

        {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

      * Укажите имя пользователя.

        {% include [user-name-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

      
      * Укажите пароль пользователя:

        * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}** — выберите, чтобы ввести свой пароль. Длина пароля — от 8 до 128 символов.

        * **{{ ui-key.yacloud.component.password-input.label_button-generate }}** — выберите, чтобы сгенерировать пароль с помощью сервиса {{ connection-manager-name }}.

        Чтобы увидеть пароль, после создания кластера выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Для просмотра паролей требуется роль `lockbox.payloadViewer`.


      * Укажите имя БД. Имя базы может содержать латинские буквы, цифры и подчеркивание. Максимальная длина имени 63 символа. Запрещено создание базы данных с именем `default`.

      * Выберите движок базы данных: 
      
        * `Atomic` (по умолчанию) — поддерживает неблокирующие операции `DROP TABLE` и `RENAME TABLE`, а также атомарные операции `EXCHANGE TABLES`.
        * `Replicated` — поддерживает репликацию метаданных таблиц между всеми репликами базы данных. При этом набор таблиц и их схемы будут одинаковыми для всех реплик.

          Доступен только в [реплицированных](../concepts/replication.md) кластерах.

        Движок задается при создании базы данных и не может быть изменен для этой базы.

      * При необходимости включите для кластера [гибридное хранилище](../concepts/storage.md#hybrid-storage-features).

        {% note warning %}

        Эту опцию невозможно выключить.

        {% endnote %}

      * При необходимости задайте [настройки СУБД](../concepts/settings-list.md#server-level-settings). Их также можно задать позднее.

        Через интерфейсы {{ yandex-cloud }} можно управлять ограниченным набором настроек. С помощью SQL-запросов можно [установить настройки {{ CH }} на уровне запроса](change-query-level-settings.md).

  1. При необходимости задайте сервисные настройки кластера:

      {% include [mch-extra-settings](../../_includes/mdb/mch/extra-settings-web-console.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ mch-name }} со встроенным сервисом координации {{ CK }}:

  
  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

      ```bash
      yc vpc subnet list
      ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.


  1. Посмотрите описание команды CLI для создания кластера:

      ```bash
      {{ yc-mdb-ch }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

      
      ```bash
      {{ yc-mdb-ch }} cluster create \
        --name <имя_кластера> \
        --environment <окружение> \
        --network-name <имя_сети> \
        --host type=<тип_хоста>,`
             `zone-id=<зона_доступности>,`
             `subnet-id=<идентификатор_подсети>,`
             `assign-public-ip=<публичный_доступ_к_хосту> \
        --clickhouse-resource-preset <класс_хоста> \
        --clickhouse-disk-type <тип_диска> \
        --clickhouse-disk-size <размер_хранилища_ГБ> \
        --embedded-keeper true \
        --user name=<имя_пользователя>,password=<пароль_пользователя> \
        --database name=<имя_базы_данных> \
        --security-group-ids <список_идентификаторов_групп_безопасности> \
        --websql-access=<доступ_из_WebSQL> \
        --deletion-protection
      ```

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано две и более подсетей.


      Где:

      * `--environment` — окружение кластера: `prestable` или `production`.
      * `--host` — параметры хоста:
        * `type` — тип хоста: `clickhouse`.
        * `zone-id` — зона доступности.

        
        * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

          {% include [mch-public-access-sg](../../_includes/mdb/mch/note-public-access-sg-rule.md) %}


        Для каждого хоста необходимо указать отдельный флаг `--host`.

        
        {% include [zk-hosts-details](../../_includes/mdb/mch/api/zk-hosts-details.md) %}


      * `--clickhouse-resource-preset` — [класс хоста](../concepts/instance-types.md) {{ CH }}.
      * `--clickhouse-disk-type` — [тип диска](../concepts/storage.md) {{ CH }}.
      * `--clickhouse-disk-size` — размер хранилища {{ CH }} в ГБ.
      * `--embedded-keeper` — использование встроенного [сервиса координации](../concepts/coordination-system.md) {{ CK }}: `true` или `false`.

        {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

      * `--user` — содержит имя (`name`) и пароль (`password`) пользователя {{ CH }}.

        {% include [user-name-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

        Длина пароля — от 8 до 128 символов.

        
        {% note info %}

        Пароль также можно сгенерировать с помощью сервиса {{ connection-manager-name }}. Для этого измените команду и задайте параметры пользователя таким образом:

        ```bash
          --user name=<имя_пользователя>,generate-password=true
        ```

        Чтобы увидеть пароль, в [консоли управления]({{ link-console-main }}) выберите созданный кластер, перейдите на вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Для просмотра паролей требуется роль `lockbox.payloadViewer`.

        {% endnote %}


      
      * `--security-group-ids` — идентификаторы групп безопасности через запятую.
        
          {% include [note-sg](../../_includes/mdb/mch/note-sg.md) %}
      

      * `--websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}. Значение по умолчанию — `false`.

      * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

      Пользователями и базами данных в кластере можно управлять через SQL.

      {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

      1. Чтобы включить [режим управления пользователями через SQL](./cluster-users.md#sql-user-management):

         * задайте значение `true` для параметра `--enable-sql-user-management`;
         * задайте пароль для пользователя `admin` в параметре `--admin-password`.

         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --enable-sql-user-management true \
           --admin-password "<пароль_пользователя_admin>"
         ```


      1. Чтобы включить [режим управления базами данных через SQL](./databases.md#sql-database-management):

         * задайте значение `true` для параметров `--enable-sql-user-management` и `--enable-sql-database-management`;
         * задайте пароль для пользователя `admin` в параметре `--admin-password`.

         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --enable-sql-user-management true \
           --enable-sql-database-management true \
           --admin-password "<пароль_пользователя_admin>"
         ```

      
      1. Чтобы зашифровать диск [пользовательским ключом KMS](../../kms/concepts/key.md), передайте параметр `--disk-encryption-key-id <идентификатор_ключа_KMS>`.

         Подробнее о шифровании дисков читайте в разделе [Хранилище](../concepts/storage.md#disk-encryption).

      1. Чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md), передайте параметр `--serverless-access`. Подробнее о настройке доступа читайте в документации [{{ sf-name }}](../../functions/operations/database-connection.md).


      1. Чтобы разрешить доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md), передайте параметр `--yandexquery-access=true`. Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).


      1. Чтобы задать [настройки гибридного хранилища](../concepts/storage.md#hybrid-storage-settings):

         * Включите гибридное хранилище, задав значение `true` для параметра `--cloud-storage`.

            {% include [Hybrid Storage cannot be switched off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}

         * Передайте настройки гибридного хранилища в соответствующих параметрах:

            {% include [Hybrid Storage settings CLI](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

         ```bash
         {{ yc-mdb-ch }} cluster create \
            ...
            --cloud-storage=true \
            --cloud-storage-data-cache=<хранение_файлов> \
            --cloud-storage-data-cache-max-size=<объем_памяти_в_байтах> \
            --cloud-storage-move-factor=<доля_свободного_места> \
            --cloud-storage-prefer-not-to-merge=<слияние_кусков_данных>
           ...
         ```

         Где:
         * `--cloud-storage-data-cache` — хранение файлов в кластерном хранилище: `true` или `false`.
         * `--cloud-storage-prefer-not-to-merge` — отключает слияние кусков данных в кластерном и объектном хранилищах: `true` или `false`.

      1. Чтобы задать настройки автоматического увеличения размера хранилища {{ CH }}, используйте флаг `--disk-size-autoscaling`:
        
         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --disk-size-autoscaling clickhouse-disk-size-limit=<максимальный_размер_хранилища_ГБ>,`
                                  `clickhouse-planned-usage-threshold=<порог_для_планового_увеличения_в_процентах>,`
                                  `clickhouse-emergency-usage-threshold=<порог_для_незамедлительного_увеличения_в_процентах>
           ...
         ```

         Где:
         
         * `clickhouse-disk-size-limit` — максимальный размер хранилища {{ CH }}, в гигабайтах.
         * `clickhouse-planned-usage-threshold` — порог заполнения хранилища {{ CH }} в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
           
           Допустимые значения: от `0` до `100`.
         
         * `clickhouse-emergency-usage-threshold` — порог заполнения хранилища {{ CH }} в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
           
           Допустимые значения: от `0` до `100`.
         
         {% note warning %}
                  
         * Если заданы оба порога для {{ CH }}, значение `clickhouse-emergency-usage-threshold` должно быть не меньше `clickhouse-planned-usage-threshold`.
         
         * При использовании `clickhouse-planned-usage-threshold` необходимо настроить [окно технического обслуживания](../concepts/maintenance.md).
         
         {% endnote %}
         
         Настройки автоматического увеличения размера хранилища, заданные для {{ CH }}, применяются ко всем существующим шардам. При добавлении нового шарда значения настройки берутся с самого старого шарда. Эти значения не сохраняются в конфигурации {{ CH }} и не отображаются при выводе команды `{{ yc-mdb-ch }} cluster get`. 
                  
         Чтобы посмотреть информацию о конкретном шарде, включая настройки автоматического увеличения размера хранилища, используйте команду: 
                  
         ```bash
         {{ yc-mdb-ch }} shards get <имя_шарда> --cluster-id <идентификатор_кластера>
         ```
         Идентификатор кластера можно получить [со списком кластеров](cluster-list.md#list-clusters) в каталоге.
         
         Имя шарда можно получить [со списком шардов](shards.md#list-shards) в кластере.
      
      1. Чтобы настроить [окно технического обслуживания](../concepts/maintenance.md), используйте флаг `--maintenance-window`:
         
         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --maintenance-window type=<тип_технического_обслуживания>,`
                               `hour=<час_дня>,`
                               `day=<день_недели>
           ...
         ```
         
         Где `--maintenance-window` — настройки окна технического обслуживания:

         * `type` — тип окна технического обслуживания. Допустимые значения:
           
           * `anytime` (по умолчанию) — в любое время.
           * `weekly` — по расписанию. Для этого значения необходимо передать параметры `hour` и `day`.
        
         * `hour` — час дня по UTC. Допустимые значения: от `1` до `24`.
         * `day` — день недели. Допустимые значения: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.


- {{ TF }} {#tf}
  
  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы создать кластер {{ mch-name }} со встроенным сервисом координации {{ CK }}:

    1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры. Если такой директории нет — создайте ее.

    1. {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Создайте конфигурационный файл с описанием [облачной сети](../../vpc/concepts/network.md#network) и [подсетей](../../vpc/concepts/network.md#subnet).
        * Сеть — описание [облачной сети](../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.
        * Подсети — описание [подсетей](../../vpc/concepts/network.md#network), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

        Пример структуры конфигурационного файла, в котором описывается облачная сеть с одной подсетью:

        ```hcl
        resource "yandex_vpc_network" "<имя_сети_в_{{ TF }}>" {
          name = "<имя_сети>"
        }

        resource "yandex_vpc_subnet" "<имя_подсети_в_{{ TF }}>" {
          name           = "<имя_подсети>"
          zone           = "<зона_доступности>"
          network_id     = yandex_vpc_network.<имя_сети_в_{{ TF }}>.id
          v4_cidr_blocks = ["<подсеть>"]
        }
        ```

    1. Создайте конфигурационный файл с описанием ресурсов кластера, которые необходимо создать:

       * Кластер базы данных — описание кластера и его хостов. Здесь же при необходимости:
          * Задайте [настройки СУБД на уровне сервера](../concepts/settings-list.md#server-level-settings). Их также можно указать позднее.
          * Включите защиту кластера от непреднамеренного удаления.

             {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

       * База данных — описание БД кластера.
       * Пользователь — описание пользователя кластера. Здесь же при необходимости задайте [настройки СУБД на уровне пользователя](../concepts/settings-list.md#dbms-user-settings). Их также можно указать позднее.

          Через интерфейсы {{ yandex-cloud }} можно управлять ограниченным набором настроек. С помощью SQL-запросов можно [установить настройки {{ CH }} на уровне запроса](change-query-level-settings.md).

       Пример структуры конфигурационного файла, в котором описывается кластер из трех хостов {{ CH }}:

       ```hcl
       resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
         name                = "<имя_кластера>"
         environment         = "<окружение>"
         network_id          = yandex_vpc_network.<имя_сети_в_{{ TF }}>.id
         security_group_ids  = ["<список_идентификаторов_групп_безопасности>"]
         embedded_keeper     = true
         deletion_protection = <защита_кластера_от_удаления>

         clickhouse {
           resources {
             resource_preset_id = "<класс_хоста>"
             disk_type_id       = "<тип_диска>"
             disk_size          = <размер_хранилища_ГБ>
           }
         }

         host {
           type             = "CLICKHOUSE"
           zone             = "<зона_доступности>"
           subnet_id        = yandex_vpc_subnet.<имя_подсети_в_{{ TF }}>.id
           assign_public_ip = <публичный_доступ_к_хосту>
         }

         host {
           type             = "CLICKHOUSE"
           zone             = "<зона_доступности>"
           subnet_id        = yandex_vpc_subnet.<имя_подсети_в_{{ TF }}>.id
           assign_public_ip = <публичный_доступ_к_хосту>
         }

         host {
           type             = "CLICKHOUSE"
           zone             = "<зона_доступности>"
           subnet_id        = yandex_vpc_subnet.<имя_подсети_в_{{ TF }}>.id
           assign_public_ip = <публичный_доступ_к_хосту>
         }

         lifecycle {
           ignore_changes = [database, user]
         }
       }

       resource "yandex_mdb_clickhouse_database" "<имя_БД>" {
         cluster_id = yandex_mdb_clickhouse_cluster.<имя_кластера>.id
         name       = "<имя_БД>"
       }

       resource "yandex_mdb_clickhouse_user" "<имя_пользователя>" {
         cluster_id = yandex_mdb_clickhouse_cluster.<имя_кластера>.id
         name       = "<имя_пользователя>"
         password   = "<пароль_пользователя>"
         permission {
           database_name = yandex_mdb_clickhouse_database.<имя_БД>.name
         }
         settings {
           <имя_параметра_1> = <значение_1>
           <имя_параметра_2> = <значение_2>
           ...
         }
       }
       ```

       Где:

       * `--embedded-keeper` — использование встроенного [сервиса координации](../concepts/coordination-system.md) {{ CK }}: `true` или `false`.

          {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

       * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

       * `host` — описание хоста `CLICKHOUSE`.
       
          * `assign_public_ip` — публичный доступ к хосту {{ CH }}: `true` или `false`.

            {% include [mch-public-access-sg](../../_includes/mdb/mch/note-public-access-sg-rule.md) %}
          
          {% include [zk-hosts-details](../../_includes/mdb/mch/api/zk-hosts-details.md) %}

       * `lifecycle.ignore_changes` — устраняет конфликты ресурсов при операциях с пользователями и базами данных, созданными с помощью отдельных ресурсов.

       Для пользователя указываются:

       * `name`и `password`— имя и пароль пользователя {{ CH }}.

          {% include [user-name](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

          Длина пароля — от 8 до 128 символов.

          
          {% note info %}

          Пароль также можно сгенерировать с помощью сервиса {{ connection-manager-name }}. Для этого вместо `password = "<пароль_пользователя>"` укажите `generate_password = true`.

          Чтобы увидеть пароль, в [консоли управления]({{ link-console-main }}) выберите созданный кластер, перейдите на вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Для просмотра паролей требуется роль `lockbox.payloadViewer`.

          {% endnote %}


       * `permission` — список БД, к которым пользователь должен иметь доступ.

       1. {% include [Maintenance window](../../_includes/mdb/mch/terraform/maintenance-window.md) %}

       1. Чтобы разрешить доступ из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}, добавьте блок `access` с нужными вам настройками:

          ```hcl
          resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
            ...
            access {
              data_lens    = <доступ_из_{{ datalens-name }}>
              metrika      = <доступ_из_Метрики_и_AppMetrika>
              serverless   = <доступ_из_Cloud_Functions>
              yandex_query = <доступ_из_Yandex_Query>
              web_sql      = <выполнение_SQL-запросов_из_консоли_управления>
            }
            ...
          }
          ```

          Где:

          * `data_lens` — доступ из {{ datalens-name }}: `true` или `false`.
          * `metrika` — доступ из Метрики и AppMetrika: `true` или `false`.
          * `serverless` — доступ из {{ sf-name }}: `true` или `false`.
          * `yandex_query` — доступ из {{ yq-full-name }}: `true` или `false`.
          * `web_sql` — выполнение SQL-запросов из консоли управления: `true` или `false`.

       1. Пользователями и базами данных в кластере можно управлять через SQL.

          {% include notitle [SQL Management can't be switched off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

          *  {% include notitle [Enable SQL user management with Terraform](../../_includes/mdb/mch/terraform/sql-management-users.md) %}

          * {% include notitle [Enable SQL database management with Terraform](../../_includes/mdb/mch/terraform/sql-management-databases.md) %}

       1. Чтобы зашифровать диск [пользовательским ключом KMS](../../kms/concepts/key.md), добавьте параметр `disk_encryption_key_id`:

          ```hcl
          resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
            ...
            disk_encryption_key_id = <идентификатор_ключа_KMS>
            ...
          }
          ```

          Подробнее о шифровании дисков читайте в разделе [Хранилище](../concepts/storage.md#disk-encryption).

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, читайте в [документации провайдера]({{ tf-provider-mch }}).

    1. Проверьте корректность файлов конфигурации {{ TF }}:

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}


- REST API {#api}

    Чтобы создать кластер {{ mch-name }} со встроенным сервисом координации {{ CK }}:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое (в примере приведены не все доступные параметры):

            
            ```json
            {
              "folderId": "<идентификатор_каталога>",
              "name": "<имя_кластера>",
              "environment": "<окружение>",
              "networkId": "<идентификатор_сети>",
              "securityGroupIds": [
                "<идентификатор_группы_безопасности_1>",
                "<идентификатор_группы_безопасности_2>",
                ...
                "<идентификатор_группы_безопасности_N>"
              ],
              "configSpec": {
                "version": "<версия_{{ CH }}>",
                "embeddedKeeper": true,
                "clickhouse": {
                  "resources": {
                    "resourcePresetId": "<класс_хостов_{{ CH }}>",
                    "diskSize": "<размер_хранилища_в_байтах>",
                    "diskTypeId": "<тип_диска>"
                  },
                  "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergencyUsageThreshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "access": {
                  "dataLens": <доступ_из_{{ datalens-name }}>,
                  "webSql": <выполнение_SQL-запросов_из_консоли_управления>,
                  "metrika": <доступ_из_Метрики_и_AppMetrika>,
                  "serverless": <доступ_из_Cloud_Functions>,
                  "dataTransfer": <доступ_из_Data_Transfer>,
                  "yandexQuery": <доступ_из_Yandex_Query>
                },
                "cloudStorage": {
                  "enabled": <использование_гибридного_хранилища>,
                  "moveFactor": "<доля_свободного_места>",
                  "dataCacheEnabled": <временное_хранение_файлов>,
                  "dataCacheMaxSize": "<максимальный_объем_памяти_для_хранения_файлов>",
                  "preferNotToMerge": <отключение_слияния_кусков_данных>
                },
                "adminPassword": "<пароль_пользователя_admin>",
                "sqlUserManagement": <управление_пользователями_через_SQL>,
                "sqlDatabaseManagement": <управление_базами_данных_через_SQL>
              },
              "databaseSpecs": [
                {
                  "name": "<имя_базы_данных>",
                  "engine": "<движок_базы_данных>"
                },
                { <аналогичный_набор_настроек_для_базы_данных_2> },
                { ... },
                { <аналогичный_набор_настроек_для_базы_данных_N> }
              ],
              "userSpecs": [
                {
                  "name": "<имя_пользователя>",
                  "password": "<пароль_пользователя>",
                  "permissions": [
                    {
                      "databaseName": "<имя_базы_данных>"
                    }
                  ]
                },
                { <аналогичный_набор_настроек_для_пользователя_2> },
                { ... },
                { <аналогичный_набор_настроек_для_пользователя_N> }
              ],
              "hostSpecs": [
                {
                  "zoneId": "<зона_доступности>",
                  "type": "<тип_хоста>",
                  "subnetId": "<идентификатор_подсети>",
                  "assignPublicIp": <публичный_доступ_к_хосту>,
                  "shardName": "<имя_шарда>"
                },
                { <аналогичный_набор_настроек_для_хоста_2> },
                { ... },
                { <аналогичный_набор_настроек_для_хоста_N> }
              ],
              "deletionProtection": <защита_кластера_от_удаления>,
              "maintenanceWindow": {
                "weeklyMaintenanceWindow": {
                  "day": "<день_недели>",
                  "hour": "<час_дня>"
                }
              }
            }
            ```


            Где:

            * `name` — имя кластера.
            * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
            * `networkId` — идентификатор [сети](../../vpc/concepts/network.md), в которой будет размещен кластер.

            
            * `securityGroupIds` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в виде массива строк. массив Каждая строка — идентификатор группы безопасности.

                {% include [note-sg](../../_includes/mdb/mch/note-sg.md) %}


            * `configSpec` — конфигурация кластера:

                * `version` — версия {{ CH }}: {{ versions.api.str }}.
                * `embeddedKeeper` — использование встроенного [сервиса координации](../concepts/coordination-system.md) {{ CK }}: `true` или `false`.

                    {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

                * `clickhouse` — конфигурация {{ CH }}:

                    * `resources.resourcePresetId` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
                    * `resources.diskSize` — размер диска в байтах.
                    * `resources.diskTypeId` — [тип диска](../concepts/storage.md).
                    * `diskSizeAutoscaling` — настройки автоматического увеличения размера хранилища {{ CH }}:
                      
                      {% include [disk-size-autoscaling-rest-ch](../../_includes/mdb/mch/disk-size-autoscaling-rest-ch.md) %}

                * `access` — настройки, которые разрешают доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}:

                    {% include [rest-access-settings](../../_includes/mdb/mch/api/rest-access-settings.md) %}

                * `cloudStorage` — настройки [гибридного хранилища](../concepts/storage.md#hybrid-storage-features):

                    {% include [rest-cloud-storage-settings](../../_includes/mdb/mch/api/rest-cloud-storage-settings.md) %}

                * `sql...` и `adminPassword` — группа настроек для управления пользователями и базами данных через SQL:

                    * `adminPassword` — пароль пользователя `admin`.
                    * `sqlUserManagement` — режим [управления пользователями через SQL](./cluster-users.md#sql-user-management): `true` или `false`.
                    * `sqlDatabaseManagement` — режим [управления базами данных через SQL](./databases.md#sql-database-management): `true` или `false`. Необходимо, чтобы был включен режим управления пользователями через SQL.


                    {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

            * `databaseSpecs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной базе данных и имеет следующую структуру: 
              
                * `name` — имя базы данных.
                * `engine` — движок базы данных. Возможные значения:
                  
                  {% include [database-engine-api](../../_includes/mdb/mch/database-engine-api.md) %}

            * `userSpecs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

                {% include [rest-user-specs](../../_includes/mdb/mch/api/rest-user-specs.md) %}

            * `hostSpecs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

                * `type` — тип хоста: `CLICKHOUSE`.
                * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).

                
                * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


                * `shardName` — имя [шарда](../concepts/sharding.md). Эта настройка имеет смысл только для хостов типа `CLICKHOUSE`.

                
                * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

                   {% include [mch-public-access-sg](../../_includes/mdb/mch/note-public-access-sg-rule.md) %}

                {% include [zk-hosts-details](../../_includes/mdb/mch/api/zk-hosts-details.md) %}


            * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

            * `maintenanceWindow` — настройки окна технического обслуживания:
              
                * `weeklyMaintenanceWindow.day` — день недели. Допустимые значения: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
                * `weeklyMaintenanceWindow.hour` — час дня по UTC. Допустимые значения: от `1` до `24`.
              
            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters' \
              --data '@body.json'
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#responses).

- gRPC API {#grpc-api}

    Чтобы создать кластер {{ mch-name }} со встроенным сервисом координации {{ CK }}:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое (в примере приведены не все доступные параметры):

            
            ```json
            {
              "folder_id": "<идентификатор_каталога>",
              "name": "<имя_кластера>",
              "environment": "<окружение>",
              "network_id": "<идентификатор_сети>",
              "security_group_ids": [
                "<идентификатор_группы_безопасности_1>",
                "<идентификатор_группы_безопасности_2>",
                ...
                "<идентификатор_группы_безопасности_N>"
              ],
              "config_spec": {
                "version": "<версия_{{ CH }}>",
                "embedded_keeper": true,
                "clickhouse": {
                  "resources": {
                    "resource_preset_id": "<класс_хостов_{{ CH }}>",
                    "disk_size": "<размер_хранилища_в_байтах>",
                    "disk_type_id": "<тип_диска>"
                  },
                  "disk_size_autoscaling": {
                    "planned_usage_threshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergency_usage_threshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "access": {
                  "data_lens": <доступ_из_{{ datalens-name }}>,
                  "web_sql": <выполнение_SQL-запросов_из_консоли_управления>,
                  "metrika": <доступ_из_Метрики_и_AppMetrika>,
                  "serverless": <доступ_из_Cloud_Functions>,
                  "data_transfer": <доступ_из_Data_Transfer>,
                  "yandex_query": <доступ_из_Yandex_Query>
                },
                "cloud_storage": {
                  "enabled": <использование_гибридного_хранилища>,
                  "move_factor": "<доля_свободного_места>",
                  "data_cache_enabled": <временное_хранение_файлов>,
                  "data_cache_max_size": "<максимальный_объем_памяти_для_хранения_файлов>",
                  "prefer_not_to_merge": <отключение_слияния_кусков_данных>
                },
                "admin_password": "<пароль_пользователя_admin>",
                "sql_user_management": <управление_пользователями_через_SQL>,
                "sql_database_management": <управление_базами_данных_через_SQL>
              },
              "database_specs": [
                {
                  "name": "<имя_базы_данных>",
                  "engine": "<движок_базы_данных>"
                },
                { <аналогичный_набор_настроек_для_базы_данных_2> },
                { ... },
                { <аналогичный_набор_настроек_для_базы_данных_N> }
              ],
              "user_specs": [
                {
                  "name": "<имя_пользователя>",
                  "password": "<пароль_пользователя>",
                  "permissions": [
                    {
                      "database_name": "<имя_базы_данных>"
                    }
                  ]
                },
                { <аналогичный_набор_настроек_для_пользователя_2> },
                { ... },
                { <аналогичный_набор_настроек_для_пользователя_N> }
              ],
              "host_specs": [
                {
                  "zone_id": "<зона_доступности>",
                  "type": "<тип_хоста>",
                  "subnet_id": "<идентификатор_подсети>",
                  "assign_public_ip": <публичный_доступ_к_хосту>,
                  "shard_name": "<имя_шарда>"
                },
                { <аналогичный_набор_настроек_для_хоста_2> },
                { ... },
                { <аналогичный_набор_настроек_для_хоста_N> }
              ],
              "deletion_protection": <защита_кластера_от_удаления>,
              "maintenance_window": {
                "weekly_maintenance_window": {
                  "day": "<день_недели>",
                  "hour": "<час_дня>"
                }
              }
            ```


            Где:

            * `name` — имя кластера.
            * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.

            * `network_id` — идентификатор [сети](../../vpc/concepts/network.md), в которой будет размещен кластер.

            
            * `security_group_ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в виде массива строк. массив Каждая строка — идентификатор группы безопасности.
                
                {% include [note-sg](../../_includes/mdb/mch/note-sg.md) %}


            * `config_spec` — конфигурация кластера:

                * `version` — версия {{ CH }}: {{ versions.api.str }}.

                * `embedded_keeper` — использование встроенного [сервиса координации](../concepts/coordination-system.md) {{ CK }}: `true` или `false`.

                    {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

                * `clickhouse` — конфигурация {{ CH }}:

                    * `resources.resource_preset_id` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
                    * `resources.disk_size` — размер диска в байтах.
                    * `resources.disk_type_id` — [тип диска](../concepts/storage.md).

                    * `disk_size_autoscaling` — настройки автоматического увеличения размера хранилища {{ CH }}:
                      
                        {% include [disk-size-autoscaling-grpc-ch](../../_includes/mdb/mch/disk-size-autoscaling-grpc-ch.md) %}

                * `access` — настройки, которые разрешают доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}:

                    {% include [grpc-access-settings](../../_includes/mdb/mch/api/grpc-access-settings.md) %}

                * `cloud_storage` — настройки [гибридного хранилища](../concepts/storage.md#hybrid-storage-features):

                    {% include [grpc-cloud-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

                * `sql...` и `admin_password` — группа настроек для управления пользователями и базами данных через SQL:

                    * `admin_password` — пароль пользователя `admin`.
                    * `sql_user_management` — режим [управления пользователями через SQL](./cluster-users.md#sql-user-management): `true` или `false`.
                    * `sql_database_management` — режим [управления базами данных через SQL](./databases.md#sql-database-management): `true` или `false`. Необходимо, чтобы был включен режим управления пользователями через SQL.


                    {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

            * `database_specs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной базе данных и имеет следующую структуру: 
              
                * `name` — имя базы данных.
                * `engine` — движок базы данных. Возможные значения:
                  
                  {% include [database-engine-api](../../_includes/mdb/mch/database-engine-api.md) %}

            * `user_specs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

                {% include [grpc-user-specs](../../_includes/mdb/mch/api/grpc-user-specs.md) %}

            * `host_specs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

                * `type` — тип хоста: `CLICKHOUSE`.
                * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).

                
                * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


                * `shard_name` — имя [шарда](../concepts/sharding.md). Эта настройка имеет смысл только для хостов типа `CLICKHOUSE`.

                
                * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

                   {% include [mch-public-access-sg](../../_includes/mdb/mch/note-public-access-sg-rule.md) %}

                {% include [zk-hosts-details](../../_includes/mdb/mch/api/zk-hosts-details.md) %}


            * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

            * `maintenance_window` — настройки окна технического обслуживания:
              
              * `weekly_maintenance_window.day` — день недели. Допустимые значения: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
              * `weekly_maintenance_window.hour` — час дня по UTC. Допустимые значения: от `1` до `24`.

            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Выполните запрос:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.Create \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Создать кластер с {{ ZK }} {#create-cluster-zk}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать кластер {{ mch-name }} с сервисом координации {{ ZK }}:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Введите имя кластера в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
      * `PRODUCTION` — для стабильных версий ваших приложений.
      * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
  1. Выберите [версию {{ CH }}](../concepts/update-policy.md), которую будет использовать кластер {{ mch-name }}, из выпадающего списка **{{ ui-key.yacloud.mdb.forms.base_field_version }}**. Для большинства кластеров рекомендуется выбрать самую новую LTS-версию.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**:

      * Выберите платформу, тип виртуальной машины и класс хостов — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты БД. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных экземпляров.

      
      * Выберите [тип диска](../concepts/storage.md).

        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


      * Выберите размер диска, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [Резервные копии](../concepts/backup.md).

      * (Опционально) Задайте настройки [автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) {{ CH }}:

        {% include [disk-size-autoscaling-console](../../_includes/mdb/mch/disk-size-autoscaling-console.md) %}

        Настройки автоматического увеличения размера хранилища, заданные для {{ CH }}, применяются ко всем существующим шардам. При добавлении нового шарда значения настройки берутся с самого старого шарда.

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}**:
      
      * Укажите параметры хостов БД, создаваемых вместе с кластером. Чтобы изменить настройки хоста, нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg) в строке с его номером:

        * **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_zone }}** — выберите [зону доступности](../../overview/concepts/geo-scope.md).

        
        * **{{ ui-key.yacloud.mdb.hosts.dialog.field_subnetworks }}** — укажите [подсеть](../../vpc/concepts/network.md#subnet) в выбранной зоне доступности.
        * **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** — разрешите [доступ](connect/index.md) к хосту из интернета.


        * Если для кластера включено [шардирование](../concepts/sharding.md) и хостов больше, чем шардов, выберите шард.

        Чтобы добавить хосты в кластер, нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.

      * Выберите [сервис координации](../concepts/coordination-system.md) **{{ ui-key.yacloud.clickhouse.cluster.value_coordination-service-zookeeper }}**.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-resource }}** выберите платформу, тип виртуальной машины и [класс хоста](../concepts/instance-types.md) для хостов {{ ZK }}.
  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-disk }}** выберите [тип диска](../concepts/storage.md), размер хранилища и при необходимости задайте настройки [автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) для хостов {{ ZK }}.
  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-hosts }}** при необходимости измените настройки автоматически добавленных хостов {{ ZK }}.
        
      Чтобы изменить настройки хоста, нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg) в строке нужного хоста и укажите:
          
      * **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_zone }}** — выберите [зону доступности](../../overview/concepts/geo-scope.md).
      
            
      * **{{ ui-key.yacloud.mdb.hosts.dialog.field_subnetworks }}** — выберите [подсеть](../../vpc/concepts/network.md#subnet) в выбранной зоне доступности.
      
  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**:

      * Если вы хотите управлять пользователями кластера через SQL, в поле **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** выберите из выпадающего списка **{{ ui-key.yacloud.common.enabled }}** и укажите пароль пользователя `admin`. Управление пользователями через другие интерфейсы при этом станет недоступно.

        В противном случае выберите **{{ ui-key.yacloud.common.disabled }}**.


      * Если вы хотите управлять базами данных через SQL, в поле **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}** выберите из выпадающего списка **{{ ui-key.yacloud.common.enabled }}**. Управление базами данных через другие интерфейсы при этом станет недоступно. Поле неактивно, если управление пользователями через SQL выключено.

        В противном случае выберите **{{ ui-key.yacloud.common.disabled }}**.

        {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

      * Укажите имя пользователя.

        {% include [user-name-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

      
      * Укажите пароль пользователя:

        * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}** — выберите, чтобы ввести свой пароль. Длина пароля — от 8 до 128 символов.

        * **{{ ui-key.yacloud.component.password-input.label_button-generate }}** — выберите, чтобы сгенерировать пароль с помощью сервиса {{ connection-manager-name }}.

        Чтобы увидеть пароль, после создания кластера выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Для просмотра паролей требуется роль `lockbox.payloadViewer`.


      * Укажите имя БД. Имя базы может содержать латинские буквы, цифры и подчеркивание. Максимальная длина имени 63 символа. Запрещено создание базы данных с именем `default`.

      * Выберите движок базы данных: 
      
        * `Atomic` (по умолчанию) — поддерживает неблокирующие операции `DROP TABLE` и `RENAME TABLE`, а также атомарные операции `EXCHANGE TABLES`.
        * `Replicated` — поддерживает репликацию метаданных таблиц между всеми репликами базы данных. При этом набор таблиц и их схемы будут одинаковыми для всех реплик.

          Доступен только в [реплицированных](../concepts/replication.md) кластерах.

        Движок задается при создании базы данных и не может быть изменен для этой базы.

      * При необходимости включите для кластера [гибридное хранилище](../concepts/storage.md#hybrid-storage-features).

        {% note warning %}

        Эту опцию невозможно выключить.

        {% endnote %}

      * При необходимости задайте [настройки СУБД](../concepts/settings-list.md#server-level-settings). Их также можно задать позднее.

        Через интерфейсы {{ yandex-cloud }} можно управлять ограниченным набором настроек. С помощью SQL-запросов можно [установить настройки {{ CH }} на уровне запроса](change-query-level-settings.md).

  1. При необходимости задайте сервисные настройки кластера:

      {% include [mch-extra-settings](../../_includes/mdb/mch/extra-settings-web-console.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ mch-name }} с сервисом координации {{ ZK }}:

  
  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

      ```bash
      yc vpc subnet list
      ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.


  1. Посмотрите описание команды CLI для создания кластера:

      ```bash
      {{ yc-mdb-ch }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

      
      ```bash
      {{ yc-mdb-ch }} cluster create \
        --name <имя_кластера> \
        --environment <окружение> \
        --network-name <имя_сети> \
        --host type=<тип_хоста>,`
             `zone-id=<зона_доступности>,`
             `subnet-id=<идентификатор_подсети>,`
             `assign-public-ip=<публичный_доступ_к_хосту> \
        --clickhouse-resource-preset <класс_хоста> \
        --clickhouse-disk-type <тип диска> \
        --clickhouse-disk-size <размер_хранилища_ГБ> \
        --zookeeper-resource-preset <класс_хоста> \
        --zookeeper-disk-type <тип диска> \
        --zookeeper-disk-size <размер_хранилища_ГБ> \
        --user name=<имя_пользователя>,password=<пароль_пользователя> \
        --database name=<имя_базы_данных> \
        --security-group-ids <список_идентификаторов_групп_безопасности> \
        --websql-access=<доступ_из_WebSQL> \
        --deletion-protection
      ```

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано две и более подсетей.


      Где:

      * `--environment` — окружение кластера: `prestable` или `production`.
      * `--host` — параметры хоста:
        * `type` — тип хоста: `clickhouse` или `zookeeper`.
        * `zone-id` — зона доступности.

        
        * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. Эта настройка имеет смысл только для хостов типа `CLICKHOUSE`.

          {% include [mch-public-access-sg](../../_includes/mdb/mch/note-public-access-sg-rule.md) %}

        {% include [zk-hosts-details](../../_includes/mdb/mch/api/zk-hosts-details.md) %}


        Для каждого хоста необходимо указать отдельный флаг `--host`.

      * `--clickhouse-resource-preset` — [класс хоста](../concepts/instance-types.md) {{ CH }}.
      * `--clickhouse-disk-type` — [тип диска](../concepts/storage.md) {{ CH }}.
      * `--clickhouse-disk-size` — размер хранилища {{ CH }} в ГБ.
      * `--zookeeper-resource-preset` — [класс хоста](../concepts/instance-types.md) {{ ZK }}.
      * `--zookeeper-disk-type` — [тип диска](../concepts/storage.md) {{ ZK }}.
      * `--zookeeper-disk-size` — размер хранилища {{ ZK }} в ГБ.
      * `--user` — содержит имя (`name`) и пароль (`password`) пользователя {{ CH }}.

        {% include [user-name-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

        Длина пароля — от 8 до 128 символов.

        
        {% note info %}

        Пароль также можно сгенерировать с помощью сервиса {{ connection-manager-name }}. Для этого измените команду и задайте параметры пользователя таким образом:

        ```bash
          --user name=<имя_пользователя>,generate-password=true
        ```

        Чтобы увидеть пароль, в [консоли управления]({{ link-console-main }}) выберите созданный кластер, перейдите на вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Для просмотра паролей требуется роль `lockbox.payloadViewer`.

        {% endnote %}


      
      * `--security-group-ids` — идентификаторы групп безопасности через запятую.
        
          {% include [note-sg](../../_includes/mdb/mch/note-sg.md) %}
      
      
      * `--websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}. Значение по умолчанию — `false`.

      * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

      Пользователями и базами данных в кластере можно управлять через SQL.

      {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

      1. Чтобы включить [режим управления пользователями через SQL](./cluster-users.md#sql-user-management):

         * задайте значение `true` для параметра `--enable-sql-user-management`;
         * задайте пароль для пользователя `admin` в параметре `--admin-password`.

         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --enable-sql-user-management true \
           --admin-password "<пароль_пользователя_admin>"
         ```


      1. Чтобы включить [режим управления базами данных через SQL](./databases.md#sql-database-management):

         * задайте значение `true` для параметров `--enable-sql-user-management` и `--enable-sql-database-management`;
         * задайте пароль для пользователя `admin` в параметре `--admin-password`.

         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --enable-sql-user-management true \
           --enable-sql-database-management true \
           --admin-password "<пароль_пользователя_admin>"
         ```

      
      1. Чтобы зашифровать диск [пользовательским ключом KMS](../../kms/concepts/key.md), передайте параметр `--disk-encryption-key-id <идентификатор_ключа_KMS>`.

         Подробнее о шифровании дисков читайте в разделе [Хранилище](../concepts/storage.md#disk-encryption).

      1. Чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md), передайте параметр `--serverless-access`. Подробнее о настройке доступа читайте в документации [{{ sf-name }}](../../functions/operations/database-connection.md).


      1. Чтобы разрешить доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md), передайте параметр `--yandexquery-access=true`. Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).


      1. Чтобы задать [настройки гибридного хранилища](../concepts/storage.md#hybrid-storage-settings):

         * Включите гибридное хранилище, задав значение `true` для параметра `--cloud-storage`.

            {% include [Hybrid Storage cannot be switched off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}

         * Передайте настройки гибридного хранилища в соответствующих параметрах:

            {% include [Hybrid Storage settings CLI](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

         ```bash
         {{ yc-mdb-ch }} cluster create \
            ...
            --cloud-storage=true \
            --cloud-storage-data-cache=<хранение_файлов> \
            --cloud-storage-data-cache-max-size=<объем_памяти_в_байтах> \
            --cloud-storage-move-factor=<доля_свободного_места> \
            --cloud-storage-prefer-not-to-merge=<слияние_кусков_данных>
           ...
         ```

         Где:
         * `--cloud-storage-data-cache` — хранение файлов в кластерном хранилище: `true` или `false`.
         * `--cloud-storage-prefer-not-to-merge` — отключает слияние кусков данных в кластерном и объектном хранилищах: `true` или `false`.

      1. Чтобы задать настройки автоматического увеличения размера хранилищ {{ CH }} и {{ ZK }}, используйте флаг `--disk-size-autoscaling`:
        
         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --disk-size-autoscaling clickhouse-disk-size-limit=<максимальный_размер_хранилища_ГБ>,`
                                  `clickhouse-planned-usage-threshold=<порог_для_планового_увеличения_в_процентах>,`
                                  `clickhouse-emergency-usage-threshold=<порог_для_незамедлительного_увеличения_в_процентах>,`
                                  `zookeeper-disk-size-limit=<максимальный_размер_хранилища_ГБ>,`
                                  `zookeeper-planned-usage-threshold=<порог_для_планового_увеличения_в_процентах>,`
                                  `zookeeper-emergency-usage-threshold=<порог_для_незамедлительного_увеличения_в_процентах>
           ...
         ```

         Где `--disk-size-autoscaling` — настройки автоматического увеличения размера хранилищ:
         
         {% include [disk-size-autoscaling-cli](../../_includes/mdb/mch/disk-size-autoscaling-cli.md) %}
      
      1. Чтобы настроить [окно технического обслуживания](../concepts/maintenance.md), используйте флаг `--maintenance-window`:
         
         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --maintenance-window type=<тип_технического_обслуживания>,`
                               `hour=<час_дня>,`
                               `day=<день_недели>
           ...
         ```
         
         Где `--maintenance-window` — настройки окна технического обслуживания:

         * `type` — тип окна технического обслуживания. Допустимые значения:
           
           * `anytime` (по умолчанию) — в любое время.
           * `weekly` — по расписанию. Для этого значения необходимо передать параметры `hour` и `day`.
        
         * `hour` — час дня по UTC. Допустимые значения: от `1` до `24`.
         * `day` — день недели. Допустимые значения: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы создать кластер {{ mch-name }} с сервисом координации {{ ZK }}:

    1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры. Если такой директории нет — создайте ее.

    1. {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Создайте конфигурационный файл с описанием [облачной сети](../../vpc/concepts/network.md#network) и [подсетей](../../vpc/concepts/network.md#subnet).
        * Сеть — описание [облачной сети](../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.
        * Подсети — описание [подсетей](../../vpc/concepts/network.md#network), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

       Пример структуры конфигурационного файла, в котором описывается облачная сеть с одной подсетью:

       ```hcl
       resource "yandex_vpc_network" "<имя_сети_в_{{ TF }}>" {
         name = "<имя_сети>"
       }

       resource "yandex_vpc_subnet" "<имя_подсети_в_{{ TF }}>" {
         name           = "<имя_подсети>"
         zone           = "<зона_доступности>"
         network_id     = yandex_vpc_network.<имя_сети_в_{{ TF }}>.id
         v4_cidr_blocks = ["<подсеть>"]
       }
       ```

    1. Создайте конфигурационный файл с описанием ресурсов кластера, которые необходимо создать:

       * Кластер базы данных — описание кластера и его хостов. Здесь же при необходимости:
          * Задайте [настройки СУБД на уровне сервера](../concepts/settings-list.md#server-level-settings). Их также можно указать позднее.
          * Включите защиту кластера от непреднамеренного удаления.

             {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

       * База данных — описание БД кластера.
       * Пользователь — описание пользователя кластера. Здесь же при необходимости задайте [настройки СУБД на уровне пользователя](../concepts/settings-list.md#dbms-user-settings). Их также можно указать позднее.

          Через интерфейсы {{ yandex-cloud }} можно управлять ограниченным набором настроек. С помощью SQL-запросов можно [установить настройки {{ CH }} на уровне запроса](change-query-level-settings.md).

       Пример структуры конфигурационного файла, в котором описывается кластер из двух хостов {{ CH }} и трех хостов {{ ZK }}:

       ```hcl
       resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
         name                = "<имя_кластера>"
         environment         = "<окружение>"
         network_id          = yandex_vpc_network.<имя_сети_в_{{ TF }}>.id
         security_group_ids  = ["<список_идентификаторов_групп_безопасности>"]
         deletion_protection = <защита_кластера_от_удаления>

         clickhouse {
           resources {
             resource_preset_id = "<класс_хоста>"
             disk_type_id       = "<тип_диска>"
             disk_size          = <размер_хранилища_ГБ>
           }
         }

         zookeeper {
           resources {
             resource_preset_id = "<класс_хоста>"
             disk_type_id       = "<тип_диска>"
             disk_size          = <размер_хранилища_ГБ>
           }
         }

         host {
           type             = "CLICKHOUSE"
           zone             = "<зона_доступности>"
           subnet_id        = yandex_vpc_subnet.<имя_подсети_в_{{ TF }}>.id
           assign_public_ip = <публичный_доступ_к_хосту>
         }

         host {
           type             = "CLICKHOUSE"
           zone             = "<зона_доступности>"
           subnet_id        = yandex_vpc_subnet.<имя_подсети_в_{{ TF }}>.id
           assign_public_ip = <публичный_доступ_к_хосту>
         }

         host {
           type      = "ZOOKEEPER"
           zone      = "<зона_доступности>"
           subnet_id = yandex_vpc_subnet.<имя_подсети_в_{{ TF }}>.id
         }

         host {
           type      = "ZOOKEEPER"
           zone      = "<зона_доступности>"
           subnet_id = yandex_vpc_subnet.<имя_подсети_в_{{ TF }}>.id
         }

         host {
           type      = "ZOOKEEPER"
           zone      = "<зона_доступности>"
           subnet_id = yandex_vpc_subnet.<имя_подсети_в_{{ TF }}>.id
         }

         lifecycle {
           ignore_changes = [database, user]
         }
       }

       resource "yandex_mdb_clickhouse_database" "<имя_БД>" {
         cluster_id = yandex_mdb_clickhouse_cluster.<имя_кластера>.id
         name       = "<имя_БД>"
       }

       resource "yandex_mdb_clickhouse_user" "<имя_пользователя>" {
         cluster_id = yandex_mdb_clickhouse_cluster.<имя_кластера>.id
         name       = "<имя_пользователя>"
         password   = "<пароль_пользователя>"
         permission {
           database_name = yandex_mdb_clickhouse_database.<имя_БД>.name
         }
         settings {
           <имя_параметра_1> = <значение_1>
           <имя_параметра_2> = <значение_2>
           ...
         }
       }
       ```

       Где:

       * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.
        
       * `host` — описание хоста `CLICKHOUSE` или `ZOOKEEPER`.
       
          * `assign_public_ip` — публичный доступ к хосту {{ CH }}: `true` или `false`. Эта настройка имеет смысл только для хостов типа `CLICKHOUSE`.

            {% include [mch-public-access-sg](../../_includes/mdb/mch/note-public-access-sg-rule.md) %}
          
          {% include [zk-hosts-details](../../_includes/mdb/mch/api/zk-hosts-details.md) %}

       * `lifecycle.ignore_changes` — устраняет конфликты ресурсов при операциях с пользователями и базами данных, созданными с помощью отдельных ресурсов.

       Для пользователя указываются:

       * `name`и `password`— имя и пароль пользователя {{ CH }}.

          {% include [user-name](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

          Длина пароля — от 8 до 128 символов.

          
          {% note info %}

          Пароль также можно сгенерировать с помощью сервиса {{ connection-manager-name }}. Для этого вместо `password = "<пароль_пользователя>"` укажите `generate_password = true`.

          Чтобы увидеть пароль, в [консоли управления]({{ link-console-main }}) выберите созданный кластер, перейдите на вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Для просмотра паролей требуется роль `lockbox.payloadViewer`.

          {% endnote %}


       * `permission` — список БД, к которым пользователь должен иметь доступ.

       1. {% include [Maintenance window](../../_includes/mdb/mch/terraform/maintenance-window.md) %}

       1. Чтобы разрешить доступ из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}, добавьте блок `access` с нужными вам настройками:

          ```hcl
          resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
            ...
            access {
              data_lens    = <доступ_из_{{ datalens-name }}>
              metrika      = <доступ_из_Метрики_и_AppMetrika>
              serverless   = <доступ_из_Cloud_Functions>
              yandex_query = <доступ_из_Yandex_Query>
              web_sql      = <выполнение_SQL-запросов_из_консоли_управления>
            }
            ...
          }
          ```

          Где:

          * `data_lens` — доступ из {{ datalens-name }}: `true` или `false`.
          * `metrika` — доступ из Метрики и AppMetrika: `true` или `false`.
          * `serverless` — доступ из {{ sf-name }}: `true` или `false`.
          * `yandex_query` — доступ из {{ yq-full-name }}: `true` или `false`.
          * `web_sql` — выполнение SQL-запросов из консоли управления: `true` или `false`.

       1. Пользователями и базами данных в кластере можно управлять через SQL.

          {% include notitle [SQL Management can't be switched off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

          *  {% include notitle [Enable SQL user management with Terraform](../../_includes/mdb/mch/terraform/sql-management-users.md) %}

          * {% include notitle [Enable SQL database management with Terraform](../../_includes/mdb/mch/terraform/sql-management-databases.md) %}

       1. Чтобы зашифровать диск [пользовательским ключом KMS](../../kms/concepts/key.md), добавьте параметр `disk_encryption_key_id`:

          ```hcl
          resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
            ...
            disk_encryption_key_id = <идентификатор_ключа_KMS>
            ...
          }
          ```

          Подробнее о шифровании дисков читайте в разделе [Хранилище](../concepts/storage.md#disk-encryption).

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, читайте в [документации провайдера]({{ tf-provider-mch }}).

    1. Проверьте корректность файлов конфигурации {{ TF }}:

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}


- REST API {#api}

    Чтобы создать кластер {{ mch-name }} с сервисом координации {{ ZK }}:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое (в примере приведены не все доступные параметры):

            
            ```json
            {
              "folderId": "<идентификатор_каталога>",
              "name": "<имя_кластера>",
              "environment": "<окружение>",
              "networkId": "<идентификатор_сети>",
              "securityGroupIds": [
                "<идентификатор_группы_безопасности_1>",
                "<идентификатор_группы_безопасности_2>",
                ...
                "<идентификатор_группы_безопасности_N>"
              ],
              "configSpec": {
                "version": "<версия_{{ CH }}>",
                "clickhouse": {
                  "resources": {
                    "resourcePresetId": "<класс_хостов>",
                    "diskSize": "<размер_хранилища_в_байтах>",
                    "diskTypeId": "<тип_диска>"
                  },
                  "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergencyUsageThreshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "zookeeper": {
                  "resources": {
                    "resourcePresetId": "<класс_хостов>",
                    "diskSize": "<размер_хранилища_в_байтах>",
                    "diskTypeId": "<тип_диска>"
                  },
                  "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergencyUsageThreshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "access": {
                  "dataLens": <доступ_из_{{ datalens-name }}>,
                  "webSql": <выполнение_SQL-запросов_из_консоли_управления>,
                  "metrika": <доступ_из_Метрики_и_AppMetrika>,
                  "serverless": <доступ_из_Cloud_Functions>,
                  "dataTransfer": <доступ_из_Data_Transfer>,
                  "yandexQuery": <доступ_из_Yandex_Query>
                },
                "cloudStorage": {
                  "enabled": <использование_гибридного_хранилища>,
                  "moveFactor": "<доля_свободного_места>",
                  "dataCacheEnabled": <временное_хранение_файлов>,
                  "dataCacheMaxSize": "<максимальный_объем_памяти_для_хранения_файлов>",
                  "preferNotToMerge": <отключение_слияния_кусков_данных>
                },
                "adminPassword": "<пароль_пользователя_admin>",
                "sqlUserManagement": <управление_пользователями_через_SQL>,
                "sqlDatabaseManagement": <управление_базами_данных_через_SQL>
              },
              "databaseSpecs": [
                {
                  "name": "<имя_базы_данных>",
                  "engine": "<движок_базы_данных>"
                },
                { <аналогичный_набор_настроек_для_базы_данных_2> },
                { ... },
                { <аналогичный_набор_настроек_для_базы_данных_N> }
              ],
              "userSpecs": [
                {
                  "name": "<имя_пользователя>",
                  "password": "<пароль_пользователя>",
                  "permissions": [
                    {
                      "databaseName": "<имя_базы_данных>"
                    }
                  ]
                },
                { <аналогичный_набор_настроек_для_пользователя_2> },
                { ... },
                { <аналогичный_набор_настроек_для_пользователя_N> }
              ],
              "hostSpecs": [
                {
                  "zoneId": "<зона_доступности>",
                  "type": "<тип_хоста>",
                  "subnetId": "<идентификатор_подсети>",
                  "assignPublicIp": <публичный_доступ_к_хосту>,
                  "shardName": "<имя_шарда>"
                },
                { <аналогичный_набор_настроек_для_хоста_2> },
                { ... },
                { <аналогичный_набор_настроек_для_хоста_N> }
              ],
              "deletionProtection": <защита_кластера_от_удаления>,
              "maintenanceWindow": {
                "weeklyMaintenanceWindow": {
                  "day": "<день_недели>",
                  "hour": "<час_дня>"
                }
              }
            }
            ```


            Где:

            * `name` — имя кластера.
            * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
            * `networkId` — идентификатор [сети](../../vpc/concepts/network.md), в которой будет размещен кластер.

            
            * `securityGroupIds` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в виде массива строк. массив Каждая строка — идентификатор группы безопасности.

                {% include [note-sg](../../_includes/mdb/mch/note-sg.md) %}


            * `configSpec` — конфигурация кластера:

                * `version` — версия {{ CH }}: {{ versions.api.str }}.
                * `clickhouse` — конфигурация {{ CH }}:

                    * `resources.resourcePresetId` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
                    * `resources.diskSize` — размер диска в байтах.
                    * `resources.diskTypeId` — [тип диска](../concepts/storage.md).

                    * `diskSizeAutoscaling` — настройки автоматического увеличения размера хранилища {{ CH }}:
                      
                      {% include [disk-size-autoscaling-rest-ch](../../_includes/mdb/mch/disk-size-autoscaling-rest-ch.md) %}

                * `zookeeper` — конфигурация [{{ ZK }}](../concepts/coordination-system.md#zk):

                    * `resources.resourcePresetId` — идентификатор класса хостов. Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
                    * `resources.diskSize` — размер диска в байтах.
                    * `resources.diskTypeId` — [тип диска](../concepts/storage.md).

                    * `diskSizeAutoscaling` — настройки автоматического увеличения размера хранилища {{ ZK }}:
                      
                      {% include [disk-size-autoscaling-rest-zk](../../_includes/mdb/mch/disk-size-autoscaling-rest-zk.md) %}

                * `access` — настройки, которые разрешают доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}:

                    {% include [rest-access-settings](../../_includes/mdb/mch/api/rest-access-settings.md) %}

                * `cloudStorage` — настройки [гибридного хранилища](../concepts/storage.md#hybrid-storage-features):

                    {% include [rest-cloud-storage-settings](../../_includes/mdb/mch/api/rest-cloud-storage-settings.md) %}

                * `sql...` и `adminPassword` — группа настроек для управления пользователями и базами данных через SQL:

                    * `adminPassword` — пароль пользователя `admin`.
                    * `sqlUserManagement` — режим [управления пользователями через SQL](./cluster-users.md#sql-user-management): `true` или `false`.
                    * `sqlDatabaseManagement` — режим [управления базами данных через SQL](./databases.md#sql-database-management): `true` или `false`. Необходимо, чтобы был включен режим управления пользователями через SQL.


                    {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

            * `databaseSpecs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной базе данных и имеет следующую структуру: 
              
                * `name` — имя базы данных.
                * `engine` — движок базы данных. Возможные значения:
                  
                  {% include [database-engine-api](../../_includes/mdb/mch/database-engine-api.md) %}

            * `userSpecs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

                {% include [rest-user-specs](../../_includes/mdb/mch/api/rest-user-specs.md) %}

            * `hostSpecs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

                * `type` — тип хоста: `CLICKHOUSE` или `ZOOKEEPER`.
                * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).

                
                * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


                * `shardName` — имя [шарда](../concepts/sharding.md). Эта настройка имеет смысл только для хостов типа `CLICKHOUSE`.

                
                * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. Эта настройка имеет смысл только для хостов типа `CLICKHOUSE`.

                   {% include [mch-public-access-sg](../../_includes/mdb/mch/note-public-access-sg-rule.md) %}

                {% include [zk-hosts-details](../../_includes/mdb/mch/api/zk-hosts-details.md) %}
                

            * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

            * `maintenanceWindow` — настройки окна технического обслуживания:
              
                * `weeklyMaintenanceWindow.day` — день недели. Допустимые значения: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
                * `weeklyMaintenanceWindow.hour` — час дня по UTC. Допустимые значения: от `1` до `24`.
              
            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters' \
              --data '@body.json'
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#responses).

- gRPC API {#grpc-api}

    Чтобы создать кластер {{ mch-name }} с сервисом координации {{ ZK }}:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое (в примере приведены не все доступные параметры):

            
            ```json
            {
              "folder_id": "<идентификатор_каталога>",
              "name": "<имя_кластера>",
              "environment": "<окружение>",
              "network_id": "<идентификатор_сети>",
              "security_group_ids": [
                "<идентификатор_группы_безопасности_1>",
                "<идентификатор_группы_безопасности_2>",
                ...
                "<идентификатор_группы_безопасности_N>"
              ],
              "config_spec": {
                "version": "<версия_{{ CH }}>",
                "clickhouse": {
                  "resources": {
                    "resource_preset_id": "<класс_хостов>",
                    "disk_size": "<размер_хранилища_в_байтах>",
                    "disk_type_id": "<тип_диска>"
                  },
                  "disk_size_autoscaling": {
                    "planned_usage_threshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergency_usage_threshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "zookeeper": {
                  "resources": {
                    "resource_preset_id": "<класс_хостов>",
                    "disk_size": "<размер_хранилища_в_байтах>",
                    "disk_type_id": "<тип_диска>"
                  },
                  "disk_size_autoscaling": {
                    "planned_usage_threshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergency_usage_threshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "access": {
                  "data_lens": <доступ_из_{{ datalens-name }}>,
                  "web_sql": <выполнение_SQL-запросов_из_консоли_управления>,
                  "metrika": <доступ_из_Метрики_и_AppMetrika>,
                  "serverless": <доступ_из_Cloud_Functions>,
                  "data_transfer": <доступ_из_Data_Transfer>,
                  "yandex_query": <доступ_из_Yandex_Query>
                },
                "cloud_storage": {
                  "enabled": <использование_гибридного_хранилища>,
                  "move_factor": "<доля_свободного_места>",
                  "data_cache_enabled": <временное_хранение_файлов>,
                  "data_cache_max_size": "<максимальный_объем_памяти_для_хранения_файлов>",
                  "prefer_not_to_merge": <отключение_слияния_кусков_данных>
                },
                "admin_password": "<пароль_пользователя_admin>",
                "sql_user_management": <управление_пользователями_через_SQL>,
                "sql_database_management": <управление_базами_данных_через_SQL>
              },
              "database_specs": [
                {
                  "name": "<имя_базы_данных>",
                  "engine": "<движок_базы_данных>"
                },
                { <аналогичный_набор_настроек_для_базы_данных_2> },
                { ... },
                { <аналогичный_набор_настроек_для_базы_данных_N> }
              ],
              "user_specs": [
                {
                  "name": "<имя_пользователя>",
                  "password": "<пароль_пользователя>",
                  "permissions": [
                    {
                      "database_name": "<имя_базы_данных>"
                    }
                  ]
                },
                { <аналогичный_набор_настроек_для_пользователя_2> },
                { ... },
                { <аналогичный_набор_настроек_для_пользователя_N> }
              ],
              "host_specs": [
                {
                  "zone_id": "<зона_доступности>",
                  "type": "<тип_хоста>",
                  "subnet_id": "<идентификатор_подсети>",
                  "assign_public_ip": <публичный_доступ_к_хосту>,
                  "shard_name": "<имя_шарда>"
                },
                { <аналогичный_набор_настроек_для_хоста_2> },
                { ... },
                { <аналогичный_набор_настроек_для_хоста_N> }
              ],
              "deletion_protection": <защита_кластера_от_удаления>,
              "maintenance_window": {
                "weekly_maintenance_window": {
                  "day": "<день_недели>",
                  "hour": "<час_дня>"
                }
              }
            ```


            Где:

            * `name` — имя кластера.
            * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.

            * `network_id` — идентификатор [сети](../../vpc/concepts/network.md), в которой будет размещен кластер.

            
            * `security_group_ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в виде массива строк. массив Каждая строка — идентификатор группы безопасности.

                {% include [note-sg](../../_includes/mdb/mch/note-sg.md) %}


            * `config_spec` — конфигурация кластера:

                * `version` — версия {{ CH }}: {{ versions.api.str }}.

                * `clickhouse` — конфигурация {{ CH }}:

                    * `resources.resource_preset_id` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
                    * `resources.disk_size` — размер диска в байтах.
                    * `resources.disk_type_id` — [тип диска](../concepts/storage.md).

                    * `disk_size_autoscaling` — настройки автоматического увеличения размера хранилища {{ CH }}:
                      
                        {% include [disk-size-autoscaling-grpc-ch](../../_includes/mdb/mch/disk-size-autoscaling-grpc-ch.md) %}

                * `zookeeper` — конфигурация [{{ ZK }}](../concepts/coordination-system.md#zk):
                    
                    * `resources.resource_preset_id` — идентификатор класса хостов. Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
                    * `resources.disk_size` — размер диска в байтах.
                    * `resources.disk_type_id` — [тип диска](../concepts/storage.md).

                    * `disk_size_autoscaling` — настройки автоматического увеличения размера хранилища {{ ZK }}:
                      
                        {% include [disk-size-autoscaling-grpc-zk](../../_includes/mdb/mch/disk-size-autoscaling-grpc-zk.md) %}

                * `access` — настройки, которые разрешают доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}:

                    {% include [grpc-access-settings](../../_includes/mdb/mch/api/grpc-access-settings.md) %}

                * `cloud_storage` — настройки [гибридного хранилища](../concepts/storage.md#hybrid-storage-features):

                    {% include [grpc-cloud-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

                * `sql...` и `admin_password` — группа настроек для управления пользователями и базами данных через SQL:

                    * `admin_password` — пароль пользователя `admin`.
                    * `sql_user_management` — режим [управления пользователями через SQL](./cluster-users.md#sql-user-management): `true` или `false`.
                    * `sql_database_management` — режим [управления базами данных через SQL](./databases.md#sql-database-management): `true` или `false`. Необходимо, чтобы был включен режим управления пользователями через SQL.


                    {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

            * `database_specs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной базе данных и имеет следующую структуру: 
              
                * `name` — имя базы данных.
                * `engine` — движок базы данных. Возможные значения:
                  
                  {% include [database-engine-api](../../_includes/mdb/mch/database-engine-api.md) %}

            * `user_specs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

                {% include [grpc-user-specs](../../_includes/mdb/mch/api/grpc-user-specs.md) %}

            * `host_specs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

                * `type` — тип хоста: `CLICKHOUSE` или `ZOOKEEPER`.
                * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).

                
                * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


                * `shard_name` — имя [шарда](../concepts/sharding.md). Эта настройка имеет смысл только для хостов типа `CLICKHOUSE`.

                
                * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. Эта настройка имеет смысл только для хостов типа `CLICKHOUSE`.

                   {% include [mch-public-access-sg](../../_includes/mdb/mch/note-public-access-sg-rule.md) %}

                {% include [zk-hosts-details](../../_includes/mdb/mch/api/zk-hosts-details.md) %}
                

            * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

            * `maintenance_window` — настройки окна технического обслуживания:
              
              * `weekly_maintenance_window.day` — день недели. Допустимые значения: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
              * `weekly_maintenance_window.hour` — час дня по UTC. Допустимые значения: от `1` до `24`.

            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Выполните запрос:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.Create \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}


## Создать копию кластера {#duplicate}

Вы можете создать кластер {{ CH }}, который будет обладать настройками созданного ранее кластера. Для этого конфигурация исходного кластера {{ CH }} импортируется в {{ TF }}. В результате вы можете либо создать идентичную копию, либо взять за основу импортированную конфигурацию и внести в нее изменения. Использовать импорт удобно, если исходный кластер {{ CH }} обладает множеством настроек и нужно создать похожий на него кластер.

Чтобы создать копию кластера {{ CH }}:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "old" { }
        ```

    1. Запишите идентификатор первоначального кластера {{ CH }} в переменную окружения:

        ```bash
        export CLICKHOUSE_CLUSTER_ID=<идентификатор_кластера>
        ```

        Идентификатор можно запросить вместе со [списком кластеров в каталоге](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. Импортируйте настройки первоначального кластера {{ CH }} в конфигурацию {{ TF }}:

        ```bash
        terraform import yandex_mdb_clickhouse_cluster.old ${CLICKHOUSE_CLUSTER_ID}
        ```

    1. Получите импортированную конфигурацию:

        ```bash
        terraform show
        ```

    1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
    1. Расположите файл в новой директории `imported-cluster`.
    1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер:

        * Укажите новое имя кластера в строке `resource` и параметре `name`.
        * Удалите параметры `created_at`, `health`, `id` и `status`.
        * В блоках `host` удалите параметры `fqdn`.
        * Если в блоке `clickhouse.config.merge_tree` для параметров `max_bytes_to_merge_at_max_space_in_pool`, `max_parts_in_total`, `number_of_free_entries_in_pool_to_execute_mutation` указано значение `0`, удалите эти параметры.
        * В блоке `clickhouse.config.kafka` задайте значение параметра `sasl_password` или удалите этот параметр.
        * В блоке `clickhouse.config.rabbitmq` задайте значение параметра `password` или удалите этот параметр.
        * Если в блоке `maintenance_window` указано значение параметра `type = "ANYTIME"`, удалите параметр `hour`.
        * Если есть блоки `user`, удалите их. Пользователи БД добавляются с помощью отдельного ресурса `yandex_mdb_clickhouse_user`.
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

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

{% endlist %}


## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер {{ mch-name }} с тестовыми характеристиками:

  
  * Имя `mych`.
  * Окружение `production`.
  * Сеть `{{ network-name }}`.
  * Группа безопасности `{{ security-group }}`.
  * Один хост {{ CH }} класса `{{ host-class }}` в подсети `{{ subnet-id }}`, в зоне доступности `{{ region-id }}-a`.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.
  * Один пользователь `user1` с паролем `user1user1`.
  * Одна база данных `db1`.
  * Защита от непреднамеренного удаления.


  Выполните следующую команду:

  
  ```bash
  {{ yc-mdb-ch }} cluster create \
    --name mych \
    --environment=production \
    --network-name {{ network-name }} \
    --clickhouse-resource-preset {{ host-class }} \
    --host type=clickhouse,zone-id={{ region-id }}-a,subnet-id={{ subnet-id }} \
    --clickhouse-disk-size 20 \
    --clickhouse-disk-type {{ disk-type-example }} \
    --user name=user1,password=user1user1 \
    --database name=db1 \
    --security-group-ids {{ security-group }} \
    --deletion-protection
  ```



- {{ TF }} {#tf}

  Создайте кластер {{ mch-name }} и сеть для него с тестовыми характеристиками:

  * Имя `mych`.
  * Окружение `PRESTABLE`.
  * Облако с идентификатором `{{ tf-cloud-id }}`.
  * Каталог с идентификатором `{{ tf-folder-id }}`.
  * Новая облачная сеть `cluster-net`.
  * Новая [группа безопасности по умолчанию](connect/index.md#configuring-security-groups) `cluster-sg` (в сети `cluster-net`), разрешающая подключение к любому хосту кластера из любой сети (в том числе из интернета) по портам `8443`, `9440`.
  * Один хост класса `{{ host-class }}` в новой подсети `cluster-subnet-{{ region-id }}-a`.

    Параметры подсети:
    * диапазон адресов — `172.16.1.0/24`;
    * сеть — `cluster-net`;
    * зона доступности — `{{ region-id }}-a`.

  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 32 ГБ.
  * Имя базы данных `db1`.
  * Пользователь `user1` с паролем `user1user1`.

  Конфигурационные файлы для такого кластера выглядят так:

  1. Конфигурационный файл с описанием настроек провайдера:

      {% include [terraform-provider](../../_includes/mdb/terraform-provider.md) %}

  1. Конфигурационный файл с описанием облачной сети и подсети:

      {% include [terraform-mdb-single-network](../../_includes/mdb/terraform-single-network.md) %}

  1. Конфигурационный файл с описанием группы безопасности:

      {% include [terraform-mch-sg](../../_includes/mdb/mch/terraform/security-groups.md) %}

  1. Конфигурационный файл с описанием кластера и его хоста:

      {% include [terraform-mch-single-host-single-shard](../../_includes/mdb/mch/terraform/single-host-single-shard.md) %}


{% endlist %}

### Создание кластера с сервисом координации {{ ZK }} {#creating-a-multi-host-cluster}


{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер {{ mch-name }} с тестовыми характеристиками:

  
  * Имя `ch-zk`.
  * Окружение `production`.
  * Сеть `{{ network-name }}`.
  * Группа безопасности `{{ security-group }}`.
  * Три хоста {{ CH }} класса `{{ host-class }}`, размещенные в подсетях в трех разных зонах доступности:
      
    * в подсети с идентификатором `e9bhbia2scnk********` в зоне доступности `{{ region-id }}-a`;
    * в подсети с идентификатором `e2lfqbm5nt9r********` в зоне доступности `{{ region-id }}-b`;
    * в подсети с идентификатором `fl8beqmjckv8********` в зоне доступности `{{ region-id }}-d`.
  
  * Три хоста {{ ZK }} класса `{{ zk-host-class }}`, размещенные в подсетях в трех разных зонах доступности:
      
    * в подсети с идентификатором `e9bhbia2scnk********` в зоне доступности `{{ region-id }}-a`;
    * в подсети с идентификатором `e2lfqbm5nt9r********` в зоне доступности `{{ region-id }}-b`;
    * в подсети с идентификатором `fl8beqmjckv8********` в зоне доступности `{{ region-id }}-d`.

  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 32 ГБ для каждого {{ CH }}-хоста кластера.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 10 ГБ для каждого {{ ZK }}-хоста кластера.
  * Один пользователь `user1` с паролем `user1user1`.
  * Одна база данных `db1`.
  * Защита от непреднамеренного удаления.


  Выполните следующую команду:

  
  ```bash
  {{ yc-mdb-ch }} cluster create \
    --name ch-zk \
    --environment=production \
    --network-name {{ network-name }} \
    --host type=clickhouse,zone-id={{ region-id }}-a,subnet-id=e9bhbia2scnk******** \
    --host type=clickhouse,zone-id={{ region-id }}-b,subnet-id=e2lfqbm5nt9r******** \
    --host type=clickhouse,zone-id={{ region-id }}-d,subnet-id=fl8beqmjckv8******** \
    --host type=zookeeper,zone-id={{ region-id }}-a,subnet-id=e9bhbia2scnk******** \
    --host type=zookeeper,zone-id={{ region-id }}-b,subnet-id=e2lfqbm5nt9r******** \
    --host type=zookeeper,zone-id={{ region-id }}-d,subnet-id=fl8beqmjckv8******** \
    --clickhouse-resource-preset {{ host-class }} \
    --clickhouse-disk-size 32 \
    --clickhouse-disk-type {{ disk-type-example }} \
    --zookeeper-resource-preset {{ zk-host-class }} \
    --zookeeper-disk-size 10 \
    --zookeeper-disk-type {{ disk-type-example }} \
    --user name=user1,password=user1user1 \
    --database name=db1 \
    --security-group-ids {{ security-group }} \
    --deletion-protection
  ```



- {{ TF }} {#tf}

  Создайте кластер {{ mch-name }} с тестовыми характеристиками:

  * Имя `mych`.
  * Окружение `PRESTABLE`.
  * Облако с идентификатором `{{ tf-cloud-id }}`.
  * Каталог с идентификатором `{{ tf-folder-id }}`.
  * Новая облачная сеть `cluster-net`.

  * Три хоста {{ CH }} класса `{{ host-class }}` и три хоста {{ ZK }} класса `{{ zk-host-class }}` (для обеспечения работы [репликации](../concepts/replication.md)).

    По одному хосту каждого класса будет размещено в новых подсетях:
    * `cluster-subnet-{{ region-id }}-a`: `172.16.1.0/24`, зона доступности `{{ region-id }}-a`.
    * `cluster-subnet-{{ region-id }}-b`: `172.16.2.0/24`, зона доступности `{{ region-id }}-b`.
    * `cluster-subnet-{{ region-id }}-d`: `172.16.3.0/24`, зона доступности `{{ region-id }}-d`.

    Эти подсети будут принадлежать сети `cluster-net`.

  * Новая [группа безопасности по умолчанию](connect/index.md#configuring-security-groups) `cluster-sg` (в сети `cluster-net`), разрешающая подключение к любому хосту кластера из любой сети (в том числе из интернета) по портам `8443`, `9440`.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 32 ГБ для каждого {{ CH }}-хоста кластера.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 10 ГБ для каждого {{ ZK }}-хоста кластера.
  * Имя базы данных `db1`.
  * Пользователь `user1` с паролем `user1user1`.

  Конфигурационные файлы для такого кластера выглядят так:

  1. Конфигурационный файл с описанием настроек провайдера:

      {% include [terraform-provider](../../_includes/mdb/terraform-provider.md) %}

  1. Конфигурационный файл с описанием облачной сети и подсетей:

      {% include [terraform-mdb-multiple-networks](../../_includes/mdb/terraform-multiple-networks.md) %}

  1. Конфигурационный файл с описанием группы безопасности:

      {% include [terraform-mch-sg](../../_includes/mdb/mch/terraform/security-groups.md) %}

  1. Конфигурационный файл с описанием кластера и его хостов:

      {% include [terraform-mch-multiple-hosts-single-shard](../../_includes/mdb/mch/terraform/multiple-hosts-single-shard.md) %}


{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
