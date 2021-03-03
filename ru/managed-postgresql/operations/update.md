# Изменение настроек кластера

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).

* [Увеличить размер хранилища](#change-disk-size) (доступно только для сетевого хранилища, `network-hdd` и `network-ssd`).

* [Настроить серверы {{ PG }}](#change-postgresql-config) согласно [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config.html).

* [Изменить дополнительные настройки кластера](#change-additional-settings).

* [Установить режим работы менеджера соединений](#change-pooler-config).

* [Вручную переключать мастер в кластере](#start-manual-failover).

* [Изменить группы безопасности кластера](#change-sg-set).

{% note warning %}

Вы не можете менять настройки серверов {{ PG }} с помощью команд SQL.

{% endnote %}

## Изменить класс хостов {#change-resource-preset}

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

      ```
      $ {{ yc-mdb-pg }} cluster update --help
      ```

  1. Запросите список доступных классов хостов (в колонке `ZONES` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     {% if audience != "internal" %}

     ```
     $ {{ yc-mdb-pg }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

     {% else %}

     ```
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
      $ {{ yc-mdb-pg }} cluster update <имя кластера>
           --resource-preset <ID класса>
      ```

      {{ mpg-short-name }} запустит операцию изменения класса хостов для кластера.

- API

  Изменить [класс хостов](../concepts/instance-types.md) кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужное значение в параметре `configSpec.resources.resourcePresetId`.

  Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В блоке **Размер хранилища** укажите необходимое значение.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища для кластера:

  {% if audience != "internal" %}

  1. Проверьте, что нужный кластер использует именно сетевое хранилище (увеличить размер локального хранилища пока невозможно). Для этого запросите информацию о кластере и найдите поле `disk_type_id` — его значение должно быть `network-hdd` или `network-ssd`:

      ```
      $ {{ yc-mdb-pg }} cluster get <имя кластера>

      id: c7qkvr3u78qiopj3u4k2
      folder_id: b1g0ftj57rrjk9thribv
      ...
      config:
        ...
        resources:
          resource_preset_id: s1.micro
          disk_size: "10737418240"
          disk_type_id: network-ssd
      ...
      ```

  {% endif %}

  1. Посмотрите описание команды CLI для изменения кластера:

     ```
     $ {{ yc-mdb-pg }} cluster update --help
     ```

  1. Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты]({{ link-console-quotas }}) для вашего облака и проверьте, что в секции {{ mpg-full-name }} не исчерпано место в строке **space**.

  1. Укажите нужный объем хранилища в команде изменения кластера (должен быть не меньше, чем значение `disk_size` в свойствах кластера):

      ```
      $ {{ yc-mdb-pg }} cluster update <имя кластера>
           --disk-size <размер хранилища в ГБ>
      ```

      Если все условия выполнены, {{ mpg-short-name }} запустит операцию по увеличению объема хранилища.

- API

  Изменить размер хранилища для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.postgresqlConfig_<версия>.resources.diskSize`.

  Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты]({{ link-console-quotas }}) для вашего облака и проверьте, что в секции {{ mpg-full-name }} не исчерпано место в строке **space**.

{% endlist %}

## Изменить настройки {{ PG }} {#change-postgresql-config}

Вы можете изменить настройки СУБД для хостов вашего кластера — как установленные по умолчанию, так и изменяющиеся вместе с классом хостов.

С [изменением класса хостов](#change-resource-preset) {{ mpg-short-name }} автоматически меняет следующие настройки (если они не были выставлены вручную):

- `max_connections`
- `shared_buffers`
- `min_wal_size`
- `max_wal_size`
- `autovacuum_max_workers`
- `autovacuum_vacuum_cost_delay`
- `autovacuum_vacuum_cost_limit`

Настройки, которые вы установили вручную, больше не будут меняться автоматически. Исключения могут возникать, если с изменением класса хоста установленное значение не становится недействительным: например, не получится задать значение 800 для `max_connections`, а затем изменить класс хостов кластера на `s2.micro` (подробнее о максимальном количестве подключений см. в разделе [{#T}](cluster-create.md)).

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить настройки сервера {{ PG }}:

  1. Посмотрите полный список настроек, установленных для кластера:

     ```
     $ {{ yc-mdb-pg }} cluster get <имя кластера> --full
     ```

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```
      $ {{ yc-mdb-pg }} cluster update-config --help
      ```

  1. Установите нужные значения параметров.

      Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `postgresqlConfig_<версия>`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `logMinDurationStatement` из запроса к API преобразуется в `log_min_duration_statement` для команды CLI:

      ```
      $ {{ yc-mdb-pg }} cluster update-config <имя кластера>
           --set log_min_duration_statement=100,<имя параметра>=<значение>,...
      ```

      {{ mpg-short-name }} запустит операцию по изменению настроек кластера.

- API

  Изменить настройки СУБД для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.postgresqlConfig_<версия>.config`.

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

* Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените дополнительные настройки кластера:

     {% include [mpg-extra-settings](../../_includes/mdb/mpg-extra-settings-web-console.md) %}

* CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-pg }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-pg }} cluster update <имя кластера> \
            --backup-window-start <время начала резервного копирования> \
            --datalens-access=<true или false> \
            --maintenance-window type=<weekly или anytime> \
            --websql-access=<true или false>
        ```

    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli-additional-settings/backup-window-start.md) %}

    * `--datalens-access` — разрешает доступ из DataLens. Значение по умолчанию — `false`. Подробнее о настройке подключения см в разделе [{#T}](datalens-connect.md).

    {% include [maintenance-window](../../_includes/mdb/cli-additional-settings/maintenance-window.md) %}

    * `--websql-access` — разрешает [выполнять SQL запросы](web-sql-query.md) из консоли управления. Значение по умолчанию — `false`.

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

* API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметрах `configSpec.access` и `configSpec.backupWindowStart`.

{% endlist %}

## Установить режим работы менеджера соединений {#change-pooler-config}

Для менеджера соединений можно установить сессионный или транзакционный режим работы. Подробнее см. в разделе [{#T}](../concepts/pooling.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить режим работы менеджера соединений:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```
      $ {{ yc-mdb-pg }} cluster update --help
      ```

  1. Укажите нужный режим работы с помощью флага `--connection-pooling-mode`:

      ```
      $ {{ yc-mdb-pg }} cluster update <имя кластера>
           --connection-pooling-mode <SESSION или TRANSACTION>
      ```

      {{ mpg-short-name }} запустит операцию по изменению режима работы менеджера соединений.

- API

  Изменить режим работы менеджера соединений для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужное значение в параметре `configSpec.poolerConfig.poolingMode`.

{% endlist %}

## Переключить мастер {#start-manual-failover}

В отказоустойчивом кластере {{ PG }} из нескольких хостов вы можете переключить роль мастера с текущего хоста-мастера на хост-реплику в кластере. После этой операции текущий хост-мастер станет хостом-репликой для нового мастера.

Особенности переключения мастера в {{  mpg-name }}:

1. Переключить мастер на реплику, для которой явно указан источник потока репликации, нельзя.
1. Если явно не указать имя хоста-реплики, мастер переключится на синхронную реплику.

Подробнее см. в разделе [{#T}](../concepts/replication.md).

{% list tabs %}

- Консоль управления

  Чтобы переключить мастер:
  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
  1. Нажмите кнопку **![image](../../_assets/pencil.svg) Переключить мастер**.
  1. Чтобы переключить мастер на синхронную реплику, оставьте опцию **Выбрать хост-мастер автоматически** включенной.
  1. Чтобы переключить мастер на другую реплику, выключите опцию **Выбрать хост-мастер автоматически** и затем выберите нужную реплику из выпадающего списка.
  1. Нажмите кнопку **Переключить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы переключить мастер, выполните команду:

  ```
  $ {{ yc-mdb-pg }} cluster start-failover <имя кластера> --host <имя хоста-реплики>
  ```

  Имя хоста-реплики можно запросить со [списком хостов в кластере](hosts.md#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

  Чтобы переключить мастер, воспользуйтесь методом API [startFailover](../api-ref/Cluster/startFailover.md) и передайте в запросе:
  1. Идентификатор кластера, в котором нужно переключить мастер, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  1. Имя хоста-реплики, на которую нужно переключиться, в параметре `hostName`. Чтобы узнать имя, [получите список хостов в кластере](hosts.md#list-hosts).

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

      ```
      $ {{ yc-mdb-pg }} cluster update --help
      ```

  1. Укажите нужные группы безопасности в команде изменения кластера:

      ```
      $ {{ yc-mdb-pg }} cluster update <имя кластера>
           --security-group-ids <список групп безопасности>
      ```

- API

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) кластера, воспользуйтесь методом API `update` и передайте в запросе:

  - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
  - Список групп в параметре `securityGroupIds`.
  - Список настроек, которые необходимо изменить, в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}
