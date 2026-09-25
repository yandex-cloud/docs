---
title: Изменения в кластере {{ mch-full-name }} v2
description: 'В этом разделе описаны отличия ресурса v2 провайдера {{ TF }} от ресурса v1 для сервиса {{ mch-name }}: изменение структуры вложенных блоков, формата хостов, шардирования и других параметров.'
---

# Изменения в кластере v2

[Ресурс v1]({{ tf-provider-link }}/resources/mdb_clickhouse_cluster) (`yandex_mdb_clickhouse_cluster`) устарел и будет удален в одной из следующих версий провайдера.

[Ресурс v2]({{ tf-provider-link }}/resources/mdb_clickhouse_cluster_v2) (`yandex_mdb_clickhouse_cluster_v2`) реализован на базе [{{ TF }} Plugin Framework](https://developer.hashicorp.com/terraform/plugin/framework) и решает ряд проблем ресурса v1:

* В v1 хосты хранились в виде упорядоченного списка, поэтому изменение их порядка или любое расхождение между планом (`plan`) и текущим состоянием ресурсов (`state`) могло привести к ненужному пересозданию хостов.
* Пользователи и базы данных внутри ресурса кластера приводили к избыточным изменениям в `plan`, когда изменялся только сам кластер.
* Изменения, которые {{ TF }} отображает в `plan`, не всегда соответствовали результату `apply`.


## Перечень изменений в v2 {#types-of-changes}

* Вложенные блоки теперь [задаются](#nested-blocks) как атрибуты.
* Блок `host` [заменен](#host-to-hosts) на ассоциативный массив `hosts`.
* Хосты сервиса координации [обновлены](#coordination-service-hosts).
* Блоки `database` и `user` [удалены](#database-and-user) из ресурса кластера.
* Блок `shard` [заменен](#shard-to-shards) ассоциативным массивом `shards`.
* Имя блока `pattern` [изменено](#pattern-to-patterns) на `patterns`.
* Повторяющиеся блоки `compression` [преобразованы](#compression) в список.
* Некоторые поля [добавлены, изменены и удалены](#fields-ref).


### Атрибуты без изменений {#unchanged}

В обеих версиях следующие атрибуты имеют одинаковые имена и типы:

* `name`
* `description`
* `folder_id`
* `network_id`
* `environment`
* `version`
* `labels`
* `deletion_protection`
* `service_account_id`
* `security_group_ids`
* `disk_encryption_key_id`
* `sql_user_management`
* `sql_database_management`
* `admin_password`
* `embedded_keeper`
* `copy_schema_on_new_hosts`
* `backup_retain_period_days`

В v2 поддержка стандартного блока `timeouts` сохранена без изменений в синтаксисе.


### Вложенные блоки {#nested-blocks}

Вложенные блоки теперь задаются как атрибуты. В v1 многие вложенные объекты описывались блочным синтаксисом, в v2 для них используется синтаксис присваивания — `= { }`.

{% include [v1-v2-syntax-table](../../_includes/managed-clickhouse/v1-v2-syntax-table.md) %}

В таблице приведен неполный перечень: другие вложенные объекты внутри `clickhouse.config`, например `merge_tree` и `query_cache`, также задаются с использованием синтаксиса присваивания в v2.

Следующие блоки не требуют синтаксиса присваивания и остаются без изменений:

* `maintenance_window { }`
* `shard_group { }`
* `format_schema { }`
* `ml_model { }`
* `extension { }` (только v2)

Новые атрибуты, которые появились в v2 и используют синтаксис присваивания:

* `restore = { backup_id = "...", include_patterns = [...], exclude_patterns = [...] }`
* `performance_diagnostics = { enabled = true, processes_refresh_interval = "15s" }`
* `external_dictionary = { "dict_name" = { ... } }` — ассоциативный массив, где ключ — имя словаря


### Блок host {#host-to-hosts}

Блок `host` заменен на ассоциативный массив `hosts` — это наиболее значимое изменение.

В v1 использовались повторяющиеся безымянные блоки `host { }` — {{ TF }} не мог сопоставить конкретный блок с конкретным хостом в API. Из-за этого возникали ложные изменения, если имена шардов были пустыми или менялся порядок хостов.

В v2 используется ассоциативный массив, в котором каждому хосту назначается ключ. Провайдер использует этот ключ, чтобы однозначно идентифицировать хост в `state`.

Имена ключей можно задавать произвольно — главное, чтобы они были вам понятны, например `"h1"`, `"shard1-rc1a"` или `"rc1a-fqdn.{{ dns-zone }}"`.

**Пример**

#|
|| **v1** | **v2** ||
||

```hcl
# v1
host {
  type      = "CLICKHOUSE"
  zone      = "{{ region-id }}-a"
  subnet_id = "..."
}
host {
  type      = "CLICKHOUSE"
  zone      = "{{ region-id }}-b"
  subnet_id = "..."
}
```

|

```hcl
# v2
hosts = {
  "h1" = {
    type      = "CLICKHOUSE"
    zone      = "{{ region-id }}-a"
    subnet_id = "..."
  }
  "h2" = {
    type      = "CLICKHOUSE"
    zone      = "{{ region-id }}-b"
    subnet_id = "..."
  }
}
```

||
|#


#### Хосты сервиса координации {#coordination-service-hosts}

Ваши хосты {{ ZK }} из v1 (`type = "ZOOKEEPER"`) напрямую переносятся в v2: тип остается тем же, а блок `zookeeper { }` преобразуется в `zookeeper = { }`. Семантика не меняется.

{% note info %}

В v2 для аргумента `type` также поддерживается значение `KEEPER` (для отдельного {{ CK }}), которого не было в v1. При этом имя типа не меняет структуру конфигурации: по-прежнему требуется блок `zookeeper = { resources }`. В справочнике полей в v2 по ошибке указаны только `CLICKHOUSE` и `ZOOKEEPER`, но `KEEPER` также является допустимым значением.

{% endnote %}


### Блоки database и user {#database-and-user}

Блоки `database` и `user` удалены из ресурса кластера. В v1 можно было управлять базами данных и пользователями непосредственно внутри ресурса кластера. В v2 для них используются отдельные ресурсы.

Вложенные блоки `permission { }`, `settings { }` и `quota { }` переносятся в новый ресурс `yandex_mdb_clickhouse_user` без изменений с сохранением блочного синтаксиса и набора полей.

**Пример**

#|
|| **v1** | **v2** ||
||

```hcl
# v1 — inline inside yandex_mdb_clickhouse_cluster
database {
  name = "mydb"
}
user {
  name     = "alice"
  password = "secret"
}
```

|

```hcl
# v2 — separate resources
resource "yandex_mdb_clickhouse_database" "mydb" {
  cluster_id = yandex_mdb_clickhouse_cluster_v2.main.id
  name       = "mydb"
}

resource "yandex_mdb_clickhouse_user" "alice" {
  cluster_id = yandex_mdb_clickhouse_cluster_v2.main.id
  name       = "alice"
  password   = "secret"
}
```

||
|#

### Блок shard {#shard-to-shards}

Блок `shard` заменен ассоциативным массивом `shards`. В v2 поддержка переопределения ресурсов для отдельных шардов сохраняется в полном объеме. Меняется только синтаксис: вместо блока используется ассоциативный массив, а `resources` внутри задается через `= { }`.

В v2 появился параметр `disk_size_autoscaling`, который можно задавать для каждого шарда. В v1 он не поддерживался.

{% note warning %}

В v1 можно было одновременно задавать `clickhouse.resources` и `shard.resources`. При этом приоритет имели ресурсы на уровне шарда. В v2 это запрещено: `clickhouse.resources` и `shards[*].resources` взаимоисключающие. Если задать оба параметра, провайдер вернет ошибку. Используйте только один уровень настройки.

Это же правило распространяется на `disk_size_autoscaling`.

{% endnote %}

#|
|| **v1** | **v2** ||
||

```hcl
# v1
shard {
  name   = "shard1"
  weight = 100
  resources {
    resource_preset_id = "{{ host-class }}"
    disk_size          = 32
    disk_type_id       = "{{ disk-type-example }}"
  }
}
```

|

```hcl
# v2
shards = {
  "shard1" = {
    weight = 100
    resources = {
      resource_preset_id = "{{ host-class }}"
      disk_size          = 32
      disk_type_id       = "{{ disk-type-example }}"
    }
    # optional: disk_size_autoscaling = { disk_size_limit = 100, ... }
  }
}
```

Если вам не нужно переопределять ресурсы для отдельных шардов, не указывайте `resources`:

```hcl
shards = {
  "shard1" = { weight = 100 }
  "shard2" = { weight = 100 }
}
```

||
|#


### Блок pattern {#pattern-to-patterns}

Имя вложенного повторяющегося блока внутри `clickhouse.config.graphite_rollup` изменилось с `pattern` на `patterns`. Содержимое блока не изменилось.

#|
|| **v1** | **v2** ||
||

```hcl
# v1
clickhouse {
  config {
    graphite_rollup {
      name = "my_rollup"
      pattern {
        regexp    = ".*"
        function  = "any"
        retention { age = 0, precision = 60 }
      }
    }
  }
}
```

|

```hcl
# v2
clickhouse = {
  config = {
    graphite_rollup = [{
      name = "my_rollup"
      patterns = [{
        regexp    = ".*"
        function  = "any"
        retention = [{ age = 0, precision = 60 }]
      }]
    }]
  }
}
```

||
|#


### Блоки compression {#compression}

Повторяющиеся блоки `compression` преобразованы в список. В v1 `compression` представлял собой набор повторяющихся блоков. В v2 это `ListNestedAttribute`, поэтому необходимо использовать синтаксис списка. Набор полей не изменился: `method`, `min_part_size`, `min_part_size_ratio` и `level`.

#|
|| **v1** | **v2** ||
||

```hcl
# v1
clickhouse {
  config {
    compression {
      method            = "LZ4"
      min_part_size     = 1073741824
      min_part_size_ratio = 0.01
    }
    compression {
      method            = "ZSTD"
      min_part_size     = 1073741824
      min_part_size_ratio = 0.01
    }
  }
}
```

|

```hcl
# v2
clickhouse = {
  config = {
    compression = [
      { method = "LZ4",  min_part_size = 1073741824, min_part_size_ratio = 0.01 },
      { method = "ZSTD", min_part_size = 1073741824, min_part_size_ratio = 0.01, level = 3 },
    ]
  }
}
```
||
|#


### Поля {#fields-ref}

#### Удаленные поля {#removed-fields}

| Поле v1 | Примечания |
| --- | --- |
| `database { }` (внутри ресурса кластера) | Заменено на ресурс `yandex_mdb_clickhouse_database`. |
| `user { }` (внутри ресурса кластера) | Заменено на ресурс `yandex_mdb_clickhouse_user`. |
| `clickhouse.config.kafka_topic { }` | В v2 не поддерживается конфигурация {{ KF }} на уровне отдельных топиков. |
| `clickhouse.config.mark_cache_size` | В v2 это поле удалено. |
| `clickhouse.config.merge_tree.allow_remote_fs_zero_copy_replication` | В v2 это поле удалено. |
| `status` | Атрибут только для чтения удален. Если конфигурация содержит `output { value = ...cluster.main.status }`, удалите этот фрагмент. |
| `health` | Атрибут только для чтения удален. Значение совпадает с `status`. |


#### Переименованные поля {#renamed-fields}

| v1 | v2 | Примечания |
| --- | --- | --- |
| `clickhouse.config.graphite_rollup[*].pattern` | `clickhouse.config.graphite_rollup[*].patterns` | Название изменено на форму множественного числа. Структура вложенного объекта не изменилась. |


#### Новые поля {#new-fields-v2}

{% note warning %}

Значения `clickhouse.resources` и `shards[*].resources` нельзя задавать одновременно. Используйте либо глобальное значение `clickhouse.resources`, либо `shards[*].resources` на уровне шарда, но не оба одновременно.

Это же правило распространяется на `disk_size_autoscaling`.

{% endnote %}


##### Уровень кластера {#cluster-level}

| Поле v2 | Синтаксис | Описание |
| --- | --- | --- |
| `allow_host_recreation` | `allow_host_recreation = true` | Позволяет провайдеру пересоздавать хосты, когда это необходимо, например при изменении типа диска. Данное поле необязательное, значения по умолчанию нет. |
| `restore` | `restore = { backup_id = "..." }` | Позволяет выполнить восстановление из резервной копии при создании. Поля: `backup_id` (обязательное), `include_patterns` (необязательное, список), `exclude_patterns` (необязательное, список). Задаются через синтаксис присваивания. |
| `performance_diagnostics` | `performance_diagnostics = { ... }` | Поля: `enabled` (тип `bool`), `processes_refresh_interval` (тип `string`, например `"15s"`). Задаются через синтаксис присваивания. |
| `external_dictionary` | `external_dictionary = { "dict_name" = { ... } }` | Ассоциативный массив внешних словарей, где ключ — имя словаря. Задается через синтаксис присваивания, а не в виде блока. Поддерживаемые источники данных: `http`, `mysql`, `clickhouse`, `mongodb`, `postgresql`. |
| `extension` | `extension { name = "..." version = "..." }` | Расширение кластера {{ CH }}. Задается в виде блока. Поддерживается только в v2, отсутствовало в v1. |


##### Уровень clickhouse {#clickhouse-level}

| Поле v2 | Примечания |
| --- | --- |
| `disk_size_autoscaling` | Задается на одном уровне с полем `resources`, а не внутри него. Поля: `disk_size_limit`, `planned_usage_threshold`, `emergency_usage_threshold`. |


##### Уровень zookeeper {#zookeeper-level}

| Поле v2 | Примечания |
| --- | --- |
| `disk_size_autoscaling` | Структура аналогична описанной выше; задается на одном уровне с `resources`. |


##### Уровень shards {#shards-level}

| Поле v2 | Примечания |
| --- | --- |
| `disk_size_autoscaling` | Задается на одном уровне с `resources` внутри элемента `shard`. |


##### Уровень clickhouse.config {#new-fields-ch-config}

| Поля v2 | Примечания |
| --- | --- |
| `custom_macros` | Список объектов вида `{ name = "...", value = "..." }` (не ассоциативный массив). |
| `mysql_protocol` | Поле типа `bool`, которое позволяет использовать протокол совместимости с {{ MY }}. |
| `access_control_improvements` | Задается через присваивание: `access_control_improvements = { select_from_system_db_requires_grant = true, select_from_information_schema_requires_grant = true }`. |
| `async_insert_threads`, `backup_threads`, `restore_threads` | Настройки количества потоков (`Int64`). |
| `total_memory_tracker_sample_probability` | `Float64`. |
| `error_log_enabled`, `error_log_retention_size`, `error_log_retention_time` | Отдельные поля типа `bool` и `int64`, не в виде вложенного блока. |
| `query_metric_log_enabled`, `query_metric_log_retention_size`, `query_metric_log_retention_time` | Используется та же структура. |
| `processors_profile_log_enabled`, `processors_profile_log_retention_size`, `processors_profile_log_retention_time` | Используется та же структура. Примечание: в официальной документации указаны неправильные описания полей `processors_profile_log_retention_size` и `processors_profile_log_retention_time`. Сами поля работают корректно. |
| `kafka.batch_size`, `kafka.message_max_bytes` | Новые поля внутри `kafka = { }`. |
| `merge_tree.materialize_ttl_recalculate_only` | Поле внутри `merge_tree = { }`. |
| `merge_tree.deduplicate_merge_projection_mode`, `merge_tree.lightweight_mutation_projection_mode` | Поля перечисления типа `string` внутри `merge_tree`. |
| `merge_tree.fsync_after_insert`, `merge_tree.fsync_part_directory` | Поля типа `bool` внутри `merge_tree`. |
| `merge_tree.min_rows_to_fsync_after_merge`, `merge_tree.min_compressed_bytes_to_fsync_after_merge`, `merge_tree.min_compressed_bytes_to_fsync_after_fetch` | Поля типа `Int64` внутри `merge_tree`. |


## Полный пример конфигурации: сравнение v1 и v2 {#full-example}

#|
|| **v1** | **v2** ||
|| 
```hcl
# v1
resource "yandex_mdb_clickhouse_cluster" "main" {
  name        = "my-cluster"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.net.id
  version     = "25.3"

  deletion_protection      = false
  copy_schema_on_new_hosts = true
  embedded_keeper          = false
  backup_retain_period_days = 7

  labels = {
    env = "prod"
  }

  clickhouse {
    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 32
    }
    config {
      log_level               = "TRACE"
      max_connections         = 100
      max_concurrent_queries  = 50
      timezone                = "UTC"
      merge_tree {
        min_bytes_for_wide_part = 104857600
        ttl_only_drop_parts     = true
      }
    }
  }

  zookeeper {
    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }
  }

  access {
    data_lens     = true
    web_sql       = true
    data_transfer = false
  }

  cloud_storage {
    enabled             = true
    data_cache_enabled  = false
    data_cache_max_size = 0
    move_factor         = 0.01
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "MON"
    hour = 3
  }

  shard {
    name   = "shard1"
    weight = 100
  }
  shard {
    name   = "shard2"
    weight = 100
  }

  host {
    type       = "CLICKHOUSE"
    zone       = "{{ region-id }}-a"
    subnet_id  = yandex_vpc_subnet.a.id
    shard_name = "shard1"
  }
  host {
    type       = "CLICKHOUSE"
    zone       = "{{ region-id }}-b"
    subnet_id  = yandex_vpc_subnet.b.id
    shard_name = "shard2"
  }
  host {
    type      = "ZOOKEEPER"
    zone      = "{{ region-id }}-a"
    subnet_id = yandex_vpc_subnet.a.id
  }
  host {
    type      = "ZOOKEEPER"
    zone      = "{{ region-id }}-b"
    subnet_id = yandex_vpc_subnet.b.id
  }
  host {
    type      = "ZOOKEEPER"
    zone      = "{{ region-id }}-d"
    subnet_id = yandex_vpc_subnet.d.id
  }

  database { name = "mydb" }

  user {
    name     = "alice"
    password = "secret"
    permission {
      database_name = "mydb"
    }
  }

  shard_group {
    name        = "group1"
    description = "first group"
    shard_names = ["shard1", "shard2"]
  }
}
```

| 

```hcl
# v2
resource "yandex_mdb_clickhouse_cluster_v2" "main" {
  name        = "my-cluster"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.net.id
  version     = "25.3"

  deletion_protection       = false
  copy_schema_on_new_hosts  = true
  embedded_keeper           = false
  backup_retain_period_days = 7

  labels = {
    env = "prod"
  }

  clickhouse = {
    resources = {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 32
    }
    config = {
      log_level              = "TRACE"
      max_connections        = 100
      max_concurrent_queries = 50
      timezone               = "UTC"
      merge_tree = {
        min_bytes_for_wide_part = 104857600
        ttl_only_drop_parts     = true
      }
    }
  }

  zookeeper = {
    resources = {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }
  }

  access = {
    data_lens     = true
    web_sql       = true
    data_transfer = false
  }

  cloud_storage = {
    enabled             = true
    data_cache_enabled  = false
    data_cache_max_size = 0
    move_factor         = 0.01
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "MON"
    hour = 3
  }

  shards = {
    "shard1" = { weight = 100 }
    "shard2" = { weight = 100 }
  }

  # Hosts: named map instead of repeated blocks
  hosts = {
    "c1" = {
      type       = "CLICKHOUSE"
      zone       = "{{ region-id }}-a"
      subnet_id  = yandex_vpc_subnet.a.id
      shard_name = "shard1"
    }
    "c2" = {
      type       = "CLICKHOUSE"
      zone       = "{{ region-id }}-b"
      subnet_id  = yandex_vpc_subnet.b.id
      shard_name = "shard2"
    }
    "k1" = {
      type      = "ZOOKEEPER"
      zone      = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.a.id
    }
    "k2" = {
      type      = "ZOOKEEPER"
      zone      = "{{ region-id }}-b"
      subnet_id = yandex_vpc_subnet.b.id
    }
    "k3" = {
      type      = "ZOOKEEPER"
      zone      = "{{ region-id }}-d"
      subnet_id = yandex_vpc_subnet.d.id
    }
  }

  # extension is v2-only, uses block syntax.
  # This block did not exist in v1 — remove it for a no-op migration.
  extension {
    name    = "geodb"
    version = "2024.07.03-210328"
  }

  # shard_group stays as block syntax
  shard_group {
    name        = "group1"
    description = "first group"
    shard_names = ["shard1", "shard2"]
  }
}

# Databases: now separate resources
resource "yandex_mdb_clickhouse_database" "mydb" {
  cluster_id = yandex_mdb_clickhouse_cluster_v2.main.id
  name       = "mydb"
}

# Users: now separate resources
resource "yandex_mdb_clickhouse_user" "alice" {
  cluster_id = yandex_mdb_clickhouse_cluster_v2.main.id
  name       = "alice"
  password   = "secret"
  permission {
    database_name = "mydb"
  }
}
```

||
|#


## Ошибки при миграции {#errors}

### Blocks of type "X" are not expected here {#blocks-of-type-x-are-not-expected-here}

```text
│ Error: Unsupported block type
│   Blocks of type "access" are not expected here. Did you mean to define argument "access"?
│   If so, use the equals sign to assign it a value.
```

Чтобы исправить ошибку, после `access` добавьте `=` — `access = { ... }`


### Blocks of type "host" are not expected here {#blocks-of-type-host-are-not-expected-here}

Чтобы исправить ошибку, замените повторяющиеся блоки `host { }` на ассоциативный массив `hosts = { }`.


### Error: Argument or block definition required (для shards) {#argument-or-block-definition-required-for-shards}

В v2 `shards` — это атрибут. Чтобы исправить ошибку, используйте `shards = { "shard1" = {} }`, а не блок.


### Error protobuf filler: Attribute X is not mapped {#error-protobuf-filler-attribute-x-is-not-mapped}

Возможные причины:

* **Неверное имя поля.**

    Поле отсутствует в `clickhouse.config` или было удалено. Подробнее в [справочнике полей](#fields-ref) выше.

* **Неверный тип.**

    Поле существует, но указано значение неправильного типа, например строка вместо целого числа. Требуемый тип данных описан в [справочнике полей](#fields-ref).

* **Не поддерживается в данной версии {{ CH }}.**

    Некоторые поля доступны только с определенной версии. Требования к версии описаны в [документации провайдера]({{ tf-docs-link }}).

* **Ошибка сопоставления в провайдере.**

    Иногда поле есть в схеме, но не обрабатывается провайдером. Если имя и тип поля указаны правильно, создайте задачу в репозитории провайдера.


#### Полезные ссылки {#see-also}

* [{#T}](../operations/migration-v1-v2.md)