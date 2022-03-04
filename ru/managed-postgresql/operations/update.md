# Изменение настроек кластера

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).

* [{#T}](#change-disk-size) (недоступно для [хранилища](../concepts/storage.md) на нереплицируемых SSD-дисках).

* [Настроить серверы {{ PG }}](#change-postgresql-config) согласно [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config.html).

* [Изменить дополнительные настройки кластера](#change-additional-settings).

* [Вручную переключать мастер в кластере](#start-manual-failover).

* [Изменить группы безопасности кластера](#change-sg-set).

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

     
     ```bash
     {{ yc-mdb-pg }} resource-preset list
     ```

     ```text
     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

  1. Укажите нужный класс в команде изменения кластера:

      ```bash
      {{ yc-mdb-pg }} cluster update <идентификатор или имя кластера> \
          --resource-preset <идентификатор класса хостов>
      ```

      {{ mpg-short-name }} запустит операцию изменения класса хостов для кластера.

- Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

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

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе нужное значение в параметре `configSpec.resources.resourcePresetId`.

  Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% note info %}

Некоторые настройки {{ PG }} [зависят от размера хранилища](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

Проверьте, что нужный кластер не использует хранилище на нереплицируемых SSD-дисках. Увеличить размер хранилища на нереплицируемых SSD-дисках невозможно.

{% list tabs %}

- Консоль управления

  Чтобы увеличить размер хранилища для кластера:

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В блоке **Размер хранилища** укажите необходимое значение.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-pg }} cluster update --help
     ```

  1. Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты]({{ link-console-quotas }}) для вашего облака и проверьте, что в секции **Managed Databases** не исчерпано место в строке **Объем HDD-хранилищ** или **Объем SSD-хранилищ**.

  1. Укажите нужный объем хранилища в команде изменения кластера (должен быть не меньше, чем значение `disk_size` в свойствах кластера):

      ```bash
      {{ yc-mdb-pg }} cluster update <идентификатор или имя кластера> \
           --disk-size <объем хранилища, ГБ>
      ```

      Если все условия выполнены, {{ mpg-short-name }} запустит операцию по увеличению объема хранилища.

- Terraform

  Чтобы увеличить размер хранилища для кластера:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

  1. Измените в описании кластера {{ mpg-name }} значение атрибута `disk_size` в блоке `config.resources`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
        ...
        config {
          resources {
            disk_size = <объем хранилища, ГБ>
            ...
          }
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

- API

  Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`.
  * Новый размер хранилища в параметре `configSpec.postgresqlConfig_<версия {{ PG }}>.resources.diskSize`.
  * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

      {% include [Сброс настроек изменяемого объекта](../../_includes/mdb/note-api-updatemask.md) %}

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

      ```bash
      {{ yc-mdb-pg }} cluster update-config <идентификатор или имя кластера> \
           --set <имя параметра1>=<значение1>,...
      ```

      {{ mpg-short-name }} запустит операцию по изменению настроек кластера.

      Все поддерживаемые параметры перечислены в [описании настроек {{ PG }}](../concepts/settings-list.md).

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе нужные значения в параметре `configSpec.postgresqlConfig_<версия>.config`.

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените дополнительные настройки кластера:

     {% include [mpg-extra-settings](../../_includes/mdb/mpg-extra-settings-web-console.md) %}

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
            --maintenance-window type=<weekly или anytime> \
            --websql-access=<true или false> \
            --deletion-protection=<защита от удаления кластера: true или false> \
            --connection-pooling-mode=<режим работы менеджера соединений> \
            --serverless-access=<true или false>
        ```

    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli-additional-settings/backup-window-start.md) %}

    * `--datalens-access` — разрешает доступ из DataLens. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [{#T}](datalens-connect.md).

    {% include [maintenance-window](../../_includes/mdb/cli-additional-settings/maintenance-window.md) %}

    * `--websql-access` — разрешает [выполнять SQL запросы](web-sql-query.md) из консоли управления. Значение по умолчанию — `false`.
    
    * `--serverless-access` — разрешает доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md). Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).

    * `--connection-pooling-mode` — указывает [режим работы менеджера соединений](../concepts/pooling.md): `SESSION`, `TRANSACTION` или `STATEMENT`.

    {% include [Защита от удаления кластера](../../_includes/mdb/cli-additional-settings/deletion-protection-db.md) %}

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

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

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.
    * Настройки доступа из других сервисов и к SQL-запросам из консоли управления в параметре `configSpec.access`.
    * Настройки окна резервного копирования в параметре `configSpec.backupWindowStart`.
    * [Режим работы менеджера соединений](../concepts/pooling.md) в параметре `configSpec.poolerConfig.poolingMode`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    {% note warning %}

    Этот метод API сбросит все настройки кластера, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, обязательно передайте название полей, подлежащих изменению, в параметре `updateMask`.

    {% endnote %}

  
  Чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md), передайте значение `true` для параметра `configSpec.access.serverless`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).

{% endlist %}

## Переключить мастер {#start-manual-failover}

В отказоустойчивом кластере {{ PG }} из нескольких хостов вы можете переключить роль мастера с текущего хоста-мастера на хост-реплику в кластере. После этой операции текущий хост-мастер станет хостом-репликой для нового мастера.

Особенности переключения мастера в {{ mpg-name }}:

1. Переключить мастер на реплику, для которой явно указан источник потока репликации, нельзя.
1. Если явно не указать имя хоста-реплики, мастер переключится на одну из кворумных реплик.

Подробнее см. в разделе [{#T}](../concepts/replication.md).

Чтобы переключить мастер:

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
  1. Нажмите кнопку **Переключить мастер**.
  1. Чтобы переключить мастер на одну из кворумных реплик, оставьте опцию **Выбрать хост-мастер автоматически** включенной.
  1. Чтобы переключить мастер на конкретную реплику, выключите опцию **Выбрать хост-мастер автоматически** и затем выберите нужную реплику из выпадающего списка.
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

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Укажите имя хоста-реплики, на которую нужно переключиться, в параметре `host_master_name`.

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
            ...
            host_master_name = "<имя хоста-реплики: атрибут name соответствующего блока host>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

- API

  Воспользуйтесь методом API [startFailover](../api-ref/Cluster/startFailover.md) и передайте в запросе:
  1. Идентификатор кластера, в котором нужно переключить мастер, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  1. Имя хоста-реплики, на которую нужно переключиться, в параметре `hostName`. Чтобы узнать имя, [получите список хостов в кластере](hosts.md#list).

{% endlist %}


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

- Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

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

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
  * Список групп в параметре `securityGroupIds`.
  * Список настроек, которые необходимо изменить, в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}
