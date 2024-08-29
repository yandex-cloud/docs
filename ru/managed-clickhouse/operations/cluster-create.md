---
title: "Как создать кластер {{ CH }}"
description: "Следуя данной инструкции, вы сможете создать кластер {{ CH }} с одним или несколькими хостами базы данных."
---

# Создание кластера {{ CH }}


Кластер {{ CH }} — это один или несколько хостов базы данных, между которыми можно настроить репликацию.

{% note info %}

* Количество хостов, которые можно создать вместе с кластером {{ CH }}, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

{% endnote %}

Выбранный [механизм обеспечения работы репликации](../concepts/replication.md) также влияет на количество хостов в кластере из нескольких хостов:

* Кластер, использующий для управления репликацией и отказоустойчивостью {{ CK }}, должен состоять из трех или более хостов — отдельные хосты для запуска {{ CK }} не требуются. Создать такой кластер можно только с помощью CLI и [API](../../glossary/rest-api.md).

    
    Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Доступ к {{ CK }} предоставляется по запросу. Обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.


* При использовании {{ ZK }} кластер может состоять из двух и более хостов. Еще 3 хоста {{ ZK }} будут добавлены в кластер автоматически.

    Минимальное количество ядер для одного хоста {{ ZK }} зависит от суммарного количества ядер хостов {{ CH }}. Подробнее см. в разделе [Репликация](../concepts/replication.md#zk).

    {% note alert %}

    
    Эти хосты учитываются в расчете использованной [квоты ресурсов]({{ link-console-quotas }}) в облаке и в [расчете стоимости](../pricing.md#prices-zookeeper) кластера.


    {% endnote %}

## Создать кластер {#create-cluster}

Для создания кластера {{ mch-name }} нужна роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль [{{ roles.mch.editor }} или выше](../security.md#roles-list). О том, как назначить роль, см. [документацию {{ iam-name }}](../../iam/operations/roles/grant.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  
  @[youtube](https://www.youtube.com/watch?v=M_RXJfOoEFE&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=4&pp=iAQB)


  Чтобы создать кластер {{ mch-name }}:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Введите имя кластера в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
      * `PRODUCTION` — для стабильных версий ваших приложений.
      * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
  1. Выберите версию {{ CH }}, которую будет использовать кластер {{ mch-name }}, из выпадающего списка **{{ ui-key.yacloud.mdb.forms.base_field_version }}**. Для большинства кластеров рекомендуется выбрать самую новую LTS-версию.

  
  1. Если вы планируете использовать данные из бакета {{ objstorage-name }} с [ограниченным доступом](../../storage/concepts/bucket#bucket-access), то выберите сервисный аккаунт из выпадающего списка или создайте новый. Подробнее о настройке сервисного аккаунта см. в разделе [Настройка доступа к {{ objstorage-name }}](s3-access.md).


  1. В блоке **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**:

      * Выберите платформу, тип виртуальной машины и класс хостов — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты БД. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных экземпляров.

      
      * Выберите [тип диска](../concepts/storage.md).

        {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

        
        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}



      * Выберите размер диска, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [Резервные копии](../concepts/backup.md).

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}**:

      * Если вы хотите создать дополнительные хосты базы данных, нажмите **{{ ui-key.yacloud.mdb.forms.button_add-host }}**. После добавления второго хоста появится кнопка **Настроить ZooKeeper**. Измените настройки {{ ZK }} в блоках **{{ ui-key.yacloud.mdb.forms.section_zookeeper-resource }}**, **{{ ui-key.yacloud.mdb.forms.section_zookeeper-disk }}** и **{{ ui-key.yacloud.mdb.forms.section_zookeeper-hosts }}** при необходимости.
      * Укажите параметры хостов базы, создаваемых вместе с кластером. Чтобы изменить добавленный хост, наведите курсор на строку хоста и нажмите на значок ![image](../../_assets/console-icons/pencil.svg).
      * Чтобы к хосту можно было подключаться из интернета, включите настройку **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**:

      * Если вы хотите управлять пользователями кластера через SQL, в поле **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** выберите из выпадающего списка **{{ ui-key.yacloud.common.enabled }}** и укажите пароль пользователя `admin`. Управление пользователями через другие интерфейсы при этом станет недоступно.

        В противном случае выберите **{{ ui-key.yacloud.common.disabled }}**.


      * Если вы хотите управлять базами данных через SQL, в поле **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}** выберите из выпадающего списка **{{ ui-key.yacloud.common.enabled }}**. Управление базами данных через другие интерфейсы при этом станет недоступно. Поле неактивно, если управление пользователями через SQL выключено.

        В противном случае выберите **{{ ui-key.yacloud.common.disabled }}**.

        {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

      * Имя пользователя и пароль.

        {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

      * Имя БД. Имя базы может содержать латинские буквы, цифры и подчеркивание. Максимальная длина имени 63 символа. Запрещено создание базы данных с именем `default`.

      * При необходимости включите для кластера [гибридное хранилище](../concepts/storage.md#hybrid-storage-features).

        {% note alert %}

        Эту опцию невозможно выключить.

        {% endnote %}

      * При необходимости задайте [настройки СУБД](../concepts/settings-list.md#server-level-settings). Их также можно задать позднее.

        Через интерфейсы {{ yandex-cloud }} можно управлять ограниченным набором настроек. С помощью SQL-запросов можно [установить настройки {{ CH }} на уровне запроса](change-query-level-settings.md).

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** укажите параметры хостов БД, создаваемых вместе с кластером. Чтобы изменить настройки хоста, нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg) в строке с его номером:

      * **{{ ui-key.yacloud.mdb.hosts.dialog.field_zones }}** — выберите [зону доступности](../../overview/concepts/geo-scope.md).
      * **{{ ui-key.yacloud.mdb.hosts.dialog.field_subnetworks }}** — укажите [подсеть](../../vpc/concepts/network.md#subnet) в выбранной зоне доступности.
      * **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** — разрешите [доступ](connect/index.md) к хосту из интернета.

      Чтобы добавить хосты в кластер, нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.

  1. При необходимости задайте сервисные настройки кластера:

      {% include [mch-extra-settings](../../_includes/mdb/mch/extra-settings-web-console.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ mch-name }}:

  
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
        --clickhouse-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --clickhouse-disk-size <размер_хранилища_ГБ> \
        --user name=<имя_пользователя>,password=<пароль_пользователя> \
        --database name=<имя_базы_данных> \
        --security-group-ids <список_идентификаторов_групп_безопасности> \
        --websql-access=<true_или_false> \
        --deletion-protection=<защита_от_удаления_кластера>
      ```

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.


      Где:

      * `--environment` — окружение кластера: `prestable` или `production`.
      * `--host` — параметры хоста:
        * `type` — тип хоста: `clickhouse` или `zookeeper`.
        * `zone-id` — зона доступности.
        * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

      
      * `--clickhouse-disk-type` — тип диска.

        {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}


      * `--websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}. Значение по умолчанию — `false`.

      * `--deletion-protection` — защита от удаления кластера: `true` или `false`.

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

      
      1. Чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md), передайте параметр `--serverless-access`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).


      1. Чтобы разрешить доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md), передайте параметр `--yandexquery-access=true`. Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).


      1. Чтобы включить [{{ CK }}](../concepts/replication.md#ck) в кластере, задайте значение `true` для параметра `--embedded-keeper`.

         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --embedded-keeper true
         ```

         {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

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

  {% note info %}

  По умолчанию при создании кластера устанавливается режим [технического обслуживания](../concepts/maintenance.md) `anytime` — в любое время. Вы можете установить конкретное время обслуживания при [изменении настроек кластера](update.md#change-additional-settings).

  {% endnote %}

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы создать кластер {{ mch-name }}:

    1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры. Если такой директории нет — создайте ее.

    
    1. {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Создайте конфигурационный файл с описанием [облачной сети](../../vpc/concepts/network.md#network) и [подсетей](../../vpc/concepts/network.md#subnet).
        * Сеть — описание [облачной сети](../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.
        * Подсети — описание [подсетей](../../vpc/concepts/network.md#network), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

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

       * Кластер базы данных — описание кластера и его хостов. Здесь же при необходимости:
          * Задайте [настройки СУБД](../concepts/settings-list.md). Их также можно указать позднее.

             Через интерфейсы {{ yandex-cloud }} можно управлять ограниченным набором настроек. С помощью SQL-запросов можно [установить настройки {{ CH }} на уровне запроса](change-query-level-settings.md).

          * Включите защиту от удаления.

             {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

       Пример структуры конфигурационного файла, в котором описывается кластер из одного хоста:

       
       ```hcl
       resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
         name                = "<имя_кластера>"
         environment         = "<окружение>"
         network_id          = yandex_vpc_network.<имя_сети_в_{{ TF }}>.id
         security_group_ids  = ["<список_идентификаторов_групп_безопасности>"]
         deletion_protection = <защита_от_удаления_кластера>

         clickhouse {
           resources {
             resource_preset_id = "<класс_хоста>"
             disk_type_id       = "<тип_диска>"
             disk_size          = <размер_хранилища_ГБ>
           }
         }

         database {
           name = "<имя_базы_данных>"
         }

         user {
           name     = "<имя_пользователя_БД>"
           password = "<пароль>"
           permission {
             database_name = "<имя_БД_в_которой_создается_пользователь>"
           }
         }

         host {
           type             = "CLICKHOUSE"
           zone             = "<зона_доступности>"
           subnet_id        = yandex_vpc_subnet.<имя_подсети_в_{{ TF }}>.id
           assign_public_ip = <публичный_доступ_к_хосту>
         }
       }
       ```


       {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

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

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mch }}).

    1. Проверьте корректность файлов конфигурации {{ TF }}:

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  Чтобы создать кластер {{ mch-name }}, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) и передайте в запросе:
  * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
  * Имя кластера в параметре `name`.
  * Окружение кластера в параметре `environment`.
  * Конфигурацию кластера в параметре `configSpec`.
  * Конфигурацию хостов кластера в одном или нескольких параметрах `hostSpecs`.
  * Идентификатор сети в параметре `networkId`.

  
  * Идентификаторы групп безопасности в параметре `securityGroupIds`.


  * Настройки доступа из других сервисов в параметре `configSpec.access`.

  Чтобы разрешить [подключение](connect/index.md) к хостам кластера из интернета, передайте значение `true` в параметре `hostSpecs.assignPublicIp`.

  При необходимости включите управление пользователями и базами данных через SQL:
  * `configSpec.sqlUserManagement` — задайте значение `true` для включения режима [управления пользователями через SQL](cluster-users.md#sql-user-management).
  * `configSpec.sqlDatabaseManagement` — задайте значение `true` для включения режима [управления базами данных через SQL](databases.md#sql-database-management). Необходимо, чтобы был включен режим управления пользователями через SQL.
  * `configSpec.adminPassword` — задайте пароль пользователя `admin`, с помощью которого осуществляется управление.

  {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}


  Чтобы задать [настройки гибридного хранилища](../concepts/storage.md##hybrid-storage-settings):

    * Включите гибридное хранилище, передав значение `true` в параметре `configSpec.cloudStorage.enabled`.
    * Передайте настройки гибридного хранилища в параметрах `configSpec.cloudStorage`:

        {% include [Hybrid Storage settings API](../../_includes/mdb/mch/hybrid-storage-settings-api.md) %}

  При создании кластера из нескольких хостов:

  * Если для параметра `embeddedKeeper` указано значение `true`, для управления репликацией будет использоваться [{{ CK }}](../concepts/replication.md#ck).

      {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

  * Если значение параметра `embeddedKeeper` не задано или равно `false`, для управления репликацией и распределением запросов будет использоваться {{ ZK }}.

    
    Если в [облачной сети](../../vpc/concepts/network.md) кластера есть подсети в каждой из [зон доступности](../../overview/concepts/geo-scope.md), а настройки хостов {{ ZK }} не заданы, в каждую подсеть будет автоматически добавлено по одному такому хосту.

    Если подсети в сети кластера есть только в некоторых зонах доступности, укажите настройки хостов {{ ZK }} явно.


{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups).

{% endnote %}


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
        * Если в блоке `clickhouse.config.merge_tree` указано значение параметра `max_parts_in_total = 0`, удалите этот параметр.
        * Если в блоке `maintenance_window` указано значение параметра `type = "ANYTIME"`, удалите параметр `hour`.
        * Если есть блоки `user`, добавьте в них параметры `name` и `password`.
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

  Чтобы создать кластер с одним хостом, передайте один параметр `--host`.

  Создайте кластер {{ mch-name }} с тестовыми характеристиками:

  
  * Имя `mych`.
  * Окружение `production`.
  * Сеть `default`.
  * Группа безопасности `{{ security-group }}`.
  * Один хост {{ CH }} класса `{{ host-class }}` в подсети `b0rcctk2rvtr********`, в зоне доступности `{{ region-id }}-a`.
  * {{ CK }}.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.
  * Один пользователь `user1` с паролем `user1user1`.
  * Одна база данных `db1`.
  * Защита от случайного удаления кластера.


  Выполните следующую команду:

  
  ```bash
  {{ yc-mdb-ch }} cluster create \
    --name mych \
    --environment=production \
    --network-name default \
    --clickhouse-resource-preset {{ host-class }} \
    --host type=clickhouse,zone-id={{ region-id }}-a,subnet-id=b0cl69g98qum******** \
    --embedded-keeper true \
    --clickhouse-disk-size 20 \
    --clickhouse-disk-type {{ disk-type-example }} \
    --user name=user1,password=user1user1 \
    --database name=db1 \
    --security-group-ids {{ security-group }} \
    --deletion-protection=true
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

### Создание кластера из нескольких хостов {#creating-a-multi-host-cluster}


{% list tabs group=instructions %}

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

{% include [connection-manager](../../_includes/mdb/connection-manager.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
