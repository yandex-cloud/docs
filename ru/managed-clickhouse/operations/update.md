# Изменение настроек кластера

После создания кластера вы можете:

* [Изменить настройки сервисного аккаунта](#change-service-account).

* [{#T}](#change-resource-preset).

* [{#T}](#change-disk-size) (недоступно для [хранилища](../concepts/storage.md) на нереплицируемых SSD-дисках).

* [{#T}](#SQL-management)

* [Настроить серверы](#change-clickhouse-config) {{ CH }} согласно [документации {{ CH }}]{% if lang == "ru" %}(https://clickhouse.yandex/docs/ru/operations/server_settings/settings/){% endif %}{% if lang == "en" %}(https://clickhouse.yandex/docs/en/operations/server_settings/settings/){% endif %}.

* [Изменить дополнительные настройки кластера](#change-additional-settings).

* [Изменить группы безопасности кластера](#change-sg-set).

## Изменить настройки сервисного аккаунта {#change-service-account}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
    1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
    {% if audience != "internal" %}

    1. Выберите нужный сервисный аккаунт из списка или [создайте новый](../../iam/operations/sa/create.md). Подробнее о настройке сервисного аккаунта см. в разделе [{#T}](s3-access.md).

    {% else %}

    1. Выберите нужный сервисный аккаунт из списка или создайте новый. Подробнее о настройке сервисного аккаунта см. в разделе [{#T}](s3-access.md).
    
    {% endif %}

       {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

{% endlist %}

## Изменить класс хостов {#change-resource-preset}

{% note info %}

В кластерах с поддержкой {{ CK }} хосты {{ ZK }} не используются. Подробнее см. в разделе [{#T}](../concepts/replication.md).

{% endnote %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Чтобы изменить класс хостов {{ CH }}, в блоке **Класс хоста** выберите нужный класс.
  1. Чтобы изменить класс хостов {{ ZK }}:

      1. Нажмите кнопку **Настроить {{ ZK }}**.

      1. В блоке **Класс хоста {{ ZK }}** выберите нужный класс для хоста {{ ZK }}.

  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```
     {{ yc-mdb-ch }} cluster update --help
     ```

  1. Запросите список доступных классов хостов (в колонке `ZONES` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     {% if audience != "internal" %}

     ```bash
     {{ yc-mdb-ch }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

     {% else %}

     ```bash
     {{ yc-mdb-ch }} resource-preset list

     +------------+---------------+-------+----------+
     |     ID     |   ZONE IDS    | CORES |  MEMORY  |
     +------------+---------------+-------+----------+
     | db1.nano   | man, sas, vla |     1 | 2.0 GB   |
     | db1.micro  | man, sas, vla |     1 | 8.0 GB   |
     | db1.small  | man, sas, vla |     2 | 16.0 GB  |
     | db1.medium | man, sas, vla |     4 | 32.0 GB  |
     | db1.large  | man, sas, vla |     8 | 64.0 GB  |
     | db1.xlarge | man, sas, vla |    16 | 128.0 GB |
     +------------+---------------+-------+----------+
     ```

     {% endif %}

  1. Укажите нужный класс в команде изменения кластера:

     ```
     {{ yc-mdb-ch }} cluster update <имя кластера>
       --clickhouse-resource-preset <ID класса>
     ```

     {{ mch-short-name }} запустит операцию изменения класса хостов для кластера.

  1. Чтобы изменить класс хостов {{ ZK }}, передайте нужное значение в параметре `--zookeeper-resource-preset`.

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените в описании кластера {{ mch-name }} значение параметра `resource_preset_id` в блоках `clickhouse.resources` и `zookeeper.resources` для хостов {{ CH }} и {{ ZK }} соответственно:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          clickhouse {
            resources {
              resource_preset_id = "<класс хостов {{ CH }}>"
              ...
            }
          }
          zookeeper {
            resources {
              resource_preset_id = "<класс хостов {{ ZK }}>"
              ...
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе нужные значения в параметре `configSpec.clickhouse.resources.resourcePresetId` (для ZooKeeper — `configSpec.zookeeper.resources.resourcePresetId`).

  Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% note info %}

В кластерах с поддержкой {{ CK }} хосты {{ ZK }} не используются. Подробнее см. в разделе [{#T}](../concepts/replication.md).

{% endnote %}

Проверьте, что нужный кластер не использует хранилище на нереплицируемых SSD-дисках. Увеличить размер хранилища на нереплицируемых SSD-дисках невозможно.

{% list tabs %}

- Консоль управления

  Чтобы увеличить размер хранилища для кластера:
  
  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В разделе **Размер хранилища** укажите необходимое значение.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-ch }} cluster update --help
     ```
     
  1. Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты]({{ link-console-quotas }}) для вашего облака и проверьте, что в секции **Managed Databases** не исчерпано место в строке **Объем HDD-хранилищ** или **Объем SSD-хранилищ**.

  1. Укажите нужный объем хранилища в команде изменения кластера (должен быть не меньше, чем значение `disk_size` в свойствах кластера):

     ```bash
     {{ yc-mdb-ch }} cluster update <идентификатор или имя кластера> \
       --clickhouse-disk-size <размер хранилища в ГБ>
     ```

     Если все условия выполнены, {{ mch-short-name }} запустит операцию по увеличению объема хранилища.

  1. Чтобы увеличить объем хранилища хостов {{ ZK }}, передайте нужное значение в параметре `--zookeeper-disk-size`.

- Terraform

  Чтобы увеличить размер хранилища:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените в описании кластера {{ mch-name }} значение параметра `disk_size` в блоках `clickhouse.resources` и `zookeeper.resources` для хостов {{ CH }} и {{ ZK }} соответственно:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          clickhouse {
            resources {
              disk_size = <размер хранилища в гигабайтах>
              ...
            }
          }
          zookeeper {
            resources {
              disk_size = <размер хранилища в гигабайтах>
              ...
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты]({{link-console-quotas}}) для вашего облака и проверьте, что в секции **Managed Databases** не исчерпано место в строке **Объем HDD-хранилищ** или **Объем SSD-хранилищ**.

  Чтобы увеличить размер хранилища, воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).
  * Нужный объем хранилища в параметре `configSpec.clickhouse.resources.diskSize`.
  * Нужный объем хранилища хостов {{ ZK }} в параметре `configSpec.zookeeper.resources.diskSize`.
  * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

    {% include [Сброс настроек изменяемого объекта](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

## Включить управление пользователями и базами данных через SQL {#SQL-management}

Сервис {{ mch-name }} позволяет включить управление [пользователями](./cluster-users.md#sql-user-management) и [базами данных](./databases.md#sql-database-management) кластера через SQL.

{% note alert %}

Включенные однажды настройки управления пользователями или базами данных через SQL невозможно выключить.

{% endnote %}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Для [управления пользователями через SQL](./cluster-users.md#sql-user-management) включите настройку **Управление пользователями через SQL** и укажите пароль пользователя `admin`.
  1. Для [управления базами данных через SQL](./databases.md#sql-database-management), включите настройки **Управление пользователями через SQL** и **Управление базами данных через SQL**, укажите пароль пользователя `admin`.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Чтобы включить [режим управления пользователями через SQL](./cluster-users.md#sql-user-management):

        * задайте значение `true` для параметра `--enable-sql-user-management`;
        * задайте пароль для пользователя `admin` в параметре `--admin-password`.

        ```bash
        {{ yc-mdb-ch }} cluster update <идентификатор или имя кластера> \
           ...
           --enable-sql-user-management true \
           --admin-password "<пароль пользователя admin>"
        ```

    1. Чтобы включить [режим управления базами данных через SQL](./databases.md#sql-database-management):

        * задайте значение `true` для параметров `--enable-sql-user-management` и `--enable-sql-database-management`;
        * задайте пароль для пользователя `admin` в параметре `--admin-password`.

        ```bash
        {{ yc-mdb-ch }} cluster update <идентификатор или имя кластера> \
           ...
           --enable-sql-user-management true \
           --enable-sql-database-management true \
           --admin-password "<пароль пользователя admin>"
        ```

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. {% include [Enable SQL user management with Terraform](../../_includes/mdb/mch/terraform/sql-management-users.md) %}

    1. {% include [Enable SQL database management with Terraform](../../_includes/mdb/mch/terraform/sql-management-databases.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера Terraform]({{ tf-provider-mch }}).

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе нужные значения в параметре `configSpec.clickhouse.config`:
    * `sqlUserManagement` — задайте значение `true` для включения режима [управления пользователями через SQL](cluster-users.md#sql-user-management).
    * `sqlDatabaseManagement` — задайте значение `true` для включения режима [управления базами данных через SQL](databases.md#sql-database-management). Необходимо, чтобы был включен режим управления пользователями через SQL.
    * `adminPassword` — задайте пароль пользователя `admin`, с помощью которого осуществляется управление.

{% endlist %}

## Изменить настройки {{ CH }} {#change-clickhouse-config}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените [настройки {{ CH }}](../concepts/settings-list.md#dbms-cluster-settings), нажав на кнопку **Настроить** в блоке **Настройки СУБД**.
  1. Нажмите кнопку **Сохранить изменения**.

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените в описании кластера {{ mch-name }} значения параметров в блоке `clickhouse.config`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          clickhouse {
            ...

            config {
              # Общие настройки СУБД
              ...

              merge_tree {
                # Настройки движка MergeTree
                ...
              }

              kafka {
                # Общие настройки получения данных из Apache Kafka
                ...
              }

              kafka_topic {
                # Настройки отдельного топика Apache Kafka
                ...
              }

              rabbit_mq {
                # Настройки получения данных из {{ RMQ }}
                username = "<имя пользователя>"
                password = "<пароль>"
              }

              compression {
                # Настройки сжатия данных
                method              = "<метод сжатия: LZ4 или ZSTD>"
                min_part_size       = <минимальный размер куска данных таблицы в байтах>
                min_part_size_ratio = <отношение размера наименьшего куска таблицы к полному размеру таблицы>
              }

              graphite_rollup {
                # Настройки движка GraphiteMergeTree для прореживания и агрегирования/усреднения
                # (rollup) данных Graphite.
                ...
              }
            }
          ...
          }
        ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера Terraform](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе нужные значения в параметре `configSpec.clickhouse.config`.

  Все поддерживаемые настройки описаны в разделе [{#T}](../concepts/settings-list.md#dbms-cluster-settings) и в [справочнике API](../api-ref/Cluster/update.md).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените дополнительные настройки кластера:

     {% include [mch-extra-settings](../../_includes/mdb/mch/extra-settings-web-console.md) %}

  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-ch }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-ch }} cluster update <идентификатор или имя кластера> \
          --backup-window-start <время начала резервного копирования> \
          --datalens-access=<true или false> \
          --maintenance-window type=<тип технического обслуживания: anytime или weekly>,`
                              `day=<день недели для типа weekly>,`
                              `hour=<час дня для типа weekly> \
          --metrika-access=<true или false> \
          --websql-access=<true или false> \
          --deletion-protection=<защита от удаления кластера: true или false> \
          --serverless-access=<true или false>
        ```

    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--datalens-access` — разрешает доступ из DataLens. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [{#T}](datalens-connect.md).

    * {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window.md) %}

    * `--metrika-access` — разрешает [импорт данных из AppMetrika в кластер]{% if lang == "ru" %}(https://appmetrica.yandex.ru/docs/cloud/index.html){% endif %}{% if lang == "en" %}(https://appmetrica.yandex.com/docs/cloud/index.html){% endif %}. Значение по умолчанию — `false`.

    * `--websql-access` — разрешает [выполнять SQL запросы](web-sql-query.md) из консоли управления. Значение по умолчанию — `false`.
    {% if audience != "internal" %}

    * `--serverless-access` — разрешает доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md). Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).

    {% else %}

    * `--serverless-access` — разрешает доступ к кластеру из сервиса {{ sf-full-name }}. Значение по умолчанию — `false`.

    {% endif %}

    * {% include [Защита от удаления кластера](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера {{ mch-name }} блок `backup_window_start`.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          backup_window_start {
            hours   = <Час начала резервного копирования>
            minutes = <Минута начала резервного копирования>
          }
          ...
        }
        ```

    1. Чтобы разрешить доступ из других сервисов {{ yandex-cloud }} и [выполнение SQL-запросов из консоли управления](web-sql-query.md), измените значения соответствующих полей в блоке `access`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          access {
            data_lens  = <Доступ из DataLens: true или false>
            metrika    = <Доступ из Метрики и AppMetrika: true или false>
            serverless = <Доступ из Cloud Functions: true или false>
            web_sql    = <Выполнение SQL-запросов из консоли управления: true или false>
          }
          ...
        }
        ```

    1. {% include [maintenance-window](../../_includes/mdb/mch/terraform-maintenance-window.md) %}

    1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          deletion_protection = <защита от удаления кластера: true или false>
        }
        ```

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера Terraform](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.
    * Настройки доступа из других сервисов и к SQL-запросам из консоли управления в параметре `configSpec.access`.
    * Настройки окна резервного копирования в параметре `configSpec.backupWindowStart`.
    * {% include [maintenance-window](../../_includes/mdb/api/maintenance-window.md) %}
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    {% note warning %}

    Этот метод API сбросит все настройки кластера, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, обязательно передайте название полей, подлежащих изменению, в параметре `updateMask`.

    {% endnote %}
    
  {% if audience != "internal" %}

  Чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md), передайте значение `true` для параметра `configSpec.access.serverless`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).

  {% else %}

  Чтобы разрешить доступ к кластеру из сервиса {{ sf-full-name }}, передайте значение `true` для параметра `configSpec.access.serverless`.

  {% endif %}

{% endlist %}

## Изменить группы безопасности {#change-sg-set}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```
      {{ yc-mdb-ch }} cluster update --help
      ```

  1. Укажите нужные группы безопасности в команде изменения кластера:

      ```
      {{ yc-mdb-ch }} cluster update <имя кластера>
        --security-group-ids <список идентификаторов групп безопасности>
      ```

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените значение параметра `security_group_ids` в описании кластера:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          security_group_ids = [ <список идентификаторов групп безопасности кластера> ]
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера Terraform](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
  * Список идентификаторов групп безопасности в параметре `securityGroupIds`.
  * Список настроек, которые необходимо изменить, в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}
