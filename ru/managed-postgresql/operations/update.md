# Изменение настроек кластера

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).

* [Увеличить размер хранилища](#change-disk-size) (доступно только для сетевого хранилища, `network-hdd` и `network-ssd`).

* [Настраивать серверы](#change-postgresql-config) {{ PG }} согласно [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config.html).

* [Устанавливать режим работы менеджера подключений](#change-pgbouncer-config).


## Изменить класс хостов {#change-resource-preset}

{% list tabs %}

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
     | s1.nano   | ru-central1-a, ru-central1-b,  |     1 | 4.0 GB   |
     |           | ru-central1-c                  |       |          |
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
          resource_preset_id: s1.nano
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


## Установить режим работы менеджера подключений {#change-pgbouncer-config}

Вы можете установить один из режимов работы, описанных в [документации PgBouncer](https://pgbouncer.github.io/usage).

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить режим работы PgBouncer:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```
      $ {{ yc-mdb-pg }} cluster update --help
      ```

  1. Укажите нужный режим работы с помощью флага `--connection-pooling-mode`:

      ```
      $ {{ yc-mdb-pg }} cluster update <имя кластера>
           --connection-pooling-mode <SESSION, TRANSACTION или STATEMENT>
      ```

      {{ mpg-short-name }} запустит операцию по изменению режима работы менеджера подключений.


- API

  Изменить режим работы менеджера подключений для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужное значение в параметре `configSpec.poolerConfig.poolingMode`.

{% endlist %}
