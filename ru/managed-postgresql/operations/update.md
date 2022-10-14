# Изменение настроек кластера

{% if product == "cloud-il" %}

{% include [one-az-disclaimer](../../_includes/overview/one-az-disclaimer.md) %}

{% endif %}

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).

* [{#T}](#change-disk-size).

* [Настроить серверы {{ PG }}](#change-postgresql-config) согласно [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config.html).

* [Изменить дополнительные настройки кластера](#change-additional-settings).

* [{#T}](#start-manual-failover).

* [Переместить кластер](#move-cluster) в другой каталог.

{% if audience != "internal" %}

* [Изменить группы безопасности кластера](#change-sg-set).

{% endif %}

{% note info %}

О том, как изменить версию {{ PG }} кластера, читайте в разделе [{#T}](cluster-version-update.md).

{% endnote %}

## Изменить класс хостов {#change-resource-preset}

{% note info %}

Некоторые настройки {{ PG }} [зависят от выбранного класса хостов](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В блоке **Класс хоста** выберите нужный класс для хостов {{ PG }}.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

  1. Запросите список доступных классов хостов (в колонке `ZONES` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     {% if audience != "internal" %}

     ```bash
     {{ yc-mdb-pg }} resource-preset list
     ```

     ```text
     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

     {% else %}

     ```text
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

      ```bash
      {{ yc-mdb-pg }} cluster update <идентификатор или имя кластера> \
          --resource-preset <идентификатор класса хостов>
      ```

      {{ mpg-short-name }} запустит операцию изменения класса хостов для кластера.

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

  1. Измените в описании кластера {{ mpg-name }} значение атрибута `resource_preset_id` в блоке `config.resources`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
        ...
        config {
          resources {
            resource_preset_id = "<класс хоста>"
            ...
          }
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
  * Идентификатор класса хоста в параметре `configSpec.resources.resourcePresetId`. Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.
  * Список настроек, которые необходимо изменить (в данном случае — `configSpec.resources.resourcePresetId`), в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## {% if audience != "internal" %}Увеличить{% else %}Изменить{% endif %} размер хранилища {#change-disk-size}

{% note info %}

Некоторые настройки {{ PG }} [зависят от размера хранилища](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% if audience != "internal" %}
Проверьте, что в облаке достаточно квот для увеличения хранилища. Откройте страницу [Квоты]({{ link-console-quotas }}) для облака и убедитесь, что в секции **Managed Databases** в строке **Объем HDD-хранилищ** или **Объем SSD-хранилищ** есть запас места.
{% endif %}

{% list tabs %}

- Консоль управления

  Чтобы {% if audience != "internal" %}увеличить{% else %}изменить{% endif %} размер хранилища для кластера:

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В блоке **Размер хранилища** укажите необходимое значение.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы {% if audience != "internal" %}увеличить{% else %}изменить{% endif %} размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-pg }} cluster update --help
     ```

  1. Укажите нужный объем хранилища в команде изменения кластера{% if audience != "internal" %} (должен быть не меньше, чем значение `disk_size` в свойствах кластера){% endif %}:

      ```bash
      {{ yc-mdb-pg }} cluster update <идентификатор или имя кластера> \
           --disk-size <размер хранилища в гигабайтах>
      ```

- {{ TF }}

  Чтобы {% if audience != "internal" %}увеличить{% else %}изменить{% endif %} размер хранилища для кластера:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

  1. Измените в описании кластера {{ mpg-name }} значение атрибута `disk_size` в блоке `config.resources`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
        ...
        config {
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

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

  Чтобы {% if audience != "internal" %}увеличить{% else %}изменить{% endif %} размер хранилища для кластера, воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
  * Новый размер хранилища в параметре `configSpec.resources.diskSize`.
  * Список настроек, которые необходимо изменить (в данном случае — `configSpec.resources.diskSize`), в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить настройки {{ PG }} {#change-postgresql-config}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% note warning %}

* Вы не можете менять настройки {{ PG }} с помощью команд SQL.
* Некоторые настройки {{ PG }} [зависят от выбранного класса хостов или размера хранилища](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените [настройки {{ PG }}](../concepts/settings-list.md), нажав кнопку **Настроить** в блоке **Настройки СУБД**.
  1. Нажмите кнопку **Сохранить**.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [настройки сервера {{ PG }}](../concepts/settings-list.md):

  1. Посмотрите полный список настроек, установленных для кластера:

     ```bash
     {{ yc-mdb-pg }} cluster get <идентификатор или имя кластера> --full
     ```

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-pg }} cluster update-config --help
      ```

  1. Установите нужные значения параметров:

      Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `postgresqlConfig_<версия {{ PG }}>`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `maxPreparedTransactions` из запроса к API преобразуется в `max_prepared_transactions` для команды CLI:

      ```bash
      {{ yc-mdb-pg }} cluster update-config <идентификатор или имя кластера> \
         --set <имя параметра1>=<значение1>,<имя параметра2>=<значение2>,...
      ```

      {{ mpg-short-name }} запустит операцию по изменению настроек кластера.

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

    1. Измените в описании кластера {{ mpg-short-name }} значения параметров в блоке `config.postgresql_config`. Если такого блока нет — создайте его.

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
          ...
          config {
            ...
            postgresql_config = {
              max_connections                   = <макс.число соединений>
              enable_parallel_hash              = <true или false>
              vacuum_cleanup_index_scale_factor = <число от 0 до 1>
              ...
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Нужные значения настроек в параметре `configSpec.postgresqlConfig_<версия {{ PG }}>`.
    * Список настроек, которые необходимо изменить, в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените дополнительные настройки кластера:

     {% include [mpg-extra-settings](../../_includes/mdb/mpg/extra-settings-web-console.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-pg }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-pg }} cluster update <идентификатор или имя кластера> \
            --backup-window-start <время начала резервного копирования> \
            --datalens-access=<true или false> \
            --maintenance-window type=<тип технического обслуживания: anytime или weekly>,`
                                `day=<день недели для типа weekly>,`
                                `hour=<час дня для типа weekly> \
            --websql-access=<true или false> \
            --deletion-protection=<защита от удаления кластера: true или false> \
            --connection-pooling-mode=<режим работы менеджера соединений> \
            --serverless-access=<true или false> \
            --performance-diagnostics enabled=<true или false>,`
                                     `sessions-sampling-interval=<интервал сбора сессий (в секундах)>,`
                                     `statements-sampling-interval=<интервал сбора запросов (в секундах)>
        ```

    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    {% if product == "yandex-cloud" %}* `--datalens-access` — разрешает доступ из DataLens. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [{#T}](datalens-connect.md).{% endif %}

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * `--websql-access` — разрешает [выполнять SQL запросы](web-sql-query.md) из консоли управления. Значение по умолчанию — `false`.
    {% if product == "yandex-cloud" %}
    {% if audience != "internal" %}

    * `--serverless-access` — разрешает доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md). Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).

    {% else %}

    * `--serverless-access` — разрешает доступ к кластеру из сервиса {{ sf-full-name }}. Значение по умолчанию — `false`.

    {% endif %}
    {% endif %}

    * `--connection-pooling-mode` — указывает [режим работы менеджера соединений](../concepts/pooling.md): `SESSION`, `TRANSACTION` или `STATEMENT`.

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * `--performance-diagnostics` — настройки [сбора статистики](./performance-diagnostics.md#activate-stats-collector):

        * `enabled` — значение `true` активирует сбор статистики. Значение по умолчанию — `false`.
        * `sessions-sampling-interval` — интервал сбора сессий, в секундах. Допустимые значения — от `1` до `86400`.
        * `statements-sampling-interval` — интервал сбора запросов, в секундах. Допустимые значения — от `60` до `86400`.

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

  1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера {{ mpg-name }} блок `config.backup_window_start`.

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
        ...
        config {
          backup_window_start {
            hours   = <Час начала резервного копирования>
            minutes = <Минута начала резервного копирования>
          }
          ...
        }
      }
      ```

  1. Чтобы разрешить доступ из {{ datalens-full-name }} и [выполнение SQL-запросов из консоли управления](web-sql-query.md), измените значения соответствующих полей в блоке `config.access`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
        ...
        config {
          access {
            data_lens = <Доступ из DataLens: true или false>
            web_sql   = <Выполнение SQL-запросов из консоли управления: true или false>
            ...
        }
        ...
      }
      ```

  1. Чтобы изменить [режим работы менеджера соединений](../concepts/pooling.md), добавьте к описанию кластера {{ mpg-name }} блок `config.pooler_config`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
        ...
        config {
          pooler_config {
            pool_discard = <параметр Odyssey pool_discard: true или false>
            pooling_mode = "<режим работы: SESSION, TRANSACTION или STATEMENT>"
          }
          ...
        }
      }
      ```

  1. {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

  1. {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

  1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
        ...
        deletion_protection = <защита от удаления кластера: true или false>
      }
      ```

      {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Настройки доступа из других сервисов и к SQL-запросам из консоли управления в параметре `configSpec.access`.
    * Настройки окна резервного копирования в параметре `configSpec.backupWindowStart`.
    * [Режим работы менеджера соединений](../concepts/pooling.md) в параметре `configSpec.poolerConfig.poolingMode`.
    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

  {% if product == "yandex-cloud" %}
  {% if audience != "internal" %}

    Чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md), передайте значение `true` для параметра `configSpec.access.serverless`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).

    {% else %}

    Чтобы разрешить доступ к кластеру из сервиса {{ sf-full-name }}, передайте значение `true` для параметра `configSpec.access.serverless`.

  {% endif %}
  {% endif %}

  Чтобы активировать [сбор статистики](./performance-diagnostics.md#activate-stats-collector):

  {% include [Performance diagnostic API](../../_includes/mdb/mpg/performance-diagnostics-api.md) %}

  {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

{% endlist %}

## Вручную переключить хост-мастер {#start-manual-failover}

В отказоустойчивом кластере {{ mpg-name }} из нескольких хостов вы можете переключить роль мастера с текущего хоста-мастера на одну из реплик. После этой операции текущий хост-мастер станет хостом-репликой для нового мастера.

Особенности переключения мастера в {{ mpg-name }}:

* Нельзя сделать мастером реплику, для которой явно указан источник потока репликации.
* Если явно не указать имя хоста-реплики, мастер переключится на одну из кворумных реплик.

Подробнее см. в разделе [{#T}](../concepts/replication.md).

Чтобы переключить мастер:

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![icon-hosts.svg](../../_assets/mdb/hosts.svg) **Хосты**.
  1. Нажмите кнопку ![icon-autofailover.svg](../../_assets/mdb/autofailover.svg) **Переключить мастер**.
      * Чтобы переключить мастер на одну из кворумных реплик, оставьте опцию **Выбрать хост-мастер автоматически** включенной.
      * Чтобы переключить мастер на конкретную реплику, выключите опцию **Выбрать хост-мастер автоматически** и затем выберите нужную реплику из выпадающего списка.
  1. Нажмите кнопку **Переключить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  {{ yc-mdb-pg }} cluster start-failover <идентификатор или имя кластера> \
      --host <имя хоста-реплики>
  ```

  Имя хоста-реплики можно запросить со [списком хостов в кластере](hosts.md#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

    1. Укажите имя хоста-реплики, на которую нужно переключиться, в параметре `host_master_name`.

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
          ...
          host_master_name = "<имя хоста-реплики: атрибут name соответствующего блока host>"
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [startFailover](../api-ref/Cluster/startFailover.md) и передайте в запросе:

    * Идентификатор кластера, в котором нужно переключить мастер, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * (Опционально) Имя хоста-реплики, которую нужно сделать мастером, в параметре `hostName`. Чтобы узнать имя, [получите список хостов в кластере](hosts.md#list).

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
    1. Нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) справа в строке кластера, который вы хотите переместить.
    1. Выберите пункт **Переместить**.
    1. Выберите каталог, в который вы хотите переместить кластер.
    1. Нажмите кнопку **Переместить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        {{ yc-mdb-pg }} cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        {{ yc-mdb-pg }} cluster move <идентификатор кластера> \
           --destination-folder-name=<имя каталога назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Воспользуйтесь методом API [move](../api-ref/Cluster/move.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Идентификатор каталога назначения в параметре `destinationFolderId`.

{% endlist %}

{% if audience != "internal" %}

## Изменить группы безопасности {#change-sg-set}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

  1. Укажите нужные группы безопасности в команде изменения кластера:

      ```bash
      {{ yc-mdb-pg }} cluster update <идентификатор или имя кластера> \
          --security-group-ids <список групп безопасности>
      ```

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

  1. Измените значение параметра `security_group_ids` в описании кластера:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
        ...
        security_group_ids = [ <список групп безопасности кластера> ]
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Список идентификаторов групп безопасности в параметре `securityGroupIds`.
    * Список настроек, которые необходимо изменить (в данном случае — `securityGroupIds`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}

{% endif %}
