---
title: Updates to a {{ mch-full-name }} cluster v2
description: 'This section describes differences between the {{ TF }} provider''s resource v2 and resource v1 for {{ mch-name }}: the changes in the nested section structure, host format, sharding, and other parameters.'
---

# Updates in a v2 cluster

[Resource v1]({{ tf-provider-link }}/resources/mdb_clickhouse_cluster) (`yandex_mdb_clickhouse_cluster`) is now deprecated and will be deleted in one of the upcoming provider versions.

[Resource v2]({{ tf-provider-link }}/resources/mdb_clickhouse_cluster_v2) (`yandex_mdb_clickhouse_cluster_v2`) is implemented on the [{{ TF }} plugin framework](https://developer.hashicorp.com/terraform/plugin/framework) and fixes a number of issues the resource v1 had:

* In v1, hosts were stored as an ordered list; therefore, changing their order or any discrepancies between the `plan` and the current resource `state` might have resulted in excessive host recreation.
* Users and databases within the cluster resource led to excessive changes in `plan` when only the cluster was changed.
* Changes that {{ TF }} showed in `plan` did not always match the `apply` result.


## List of updates in v2 {#types-of-changes}

* Nested sections are now [specified](#nested-blocks) as attributes.
* The `host` section was [replaced](#host-to-hosts) with the `hosts` associative array.
* The coordination service's hosts were [updated](#coordination-service-hosts).
* The `database` and `user` sections were [deleted](#database-and-user) from the cluster resource.
* The `shard` section was [replaced](#shard-to-shards) with the `shards` associative array.
* The `pattern` section name was [changed](#pattern-to-patterns) to `patterns`.
* The `compression` repeat sections were [transformed](#compression) into a list.
* Certain fields were [added, changed, or deleted](#fields-ref).


### Unchanged attributes {#unchanged}

In both versions, the following attributes have the same names and types:

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

In v2, the standard `timeouts` section is supported without changes in the syntax.


### Nested sections {#nested-blocks}

Nested sections are now specified as attributes. In v1, a lot of nested objects were described using the section syntax. In v2, they use the assignment syntax: `= { }`.

{% include [v1-v2-syntax-table](../../_includes/managed-clickhouse/v1-v2-syntax-table.md) %}

The table contains an incomplete list: other nested objects inside `clickhouse.config`, e.g., `merge_tree` and `query_cache`, are also specified using the assignment syntax in v2.

The following sections do not require the assignment syntax and remain unchanged:

* `maintenance_window { }`
* `shard_group { }`
* `format_schema { }`
* `ml_model { }`
* `extension { }` (only v2)

New attributes introduced in v2 that use the assignment syntax:

* `restore = { backup_id = "...", include_patterns = [...], exclude_patterns = [...] }`.
* `performance_diagnostics = { enabled = true, processes_refresh_interval = "15s" }`.
* `external_dictionary = { "dict_name" = { ... } }`: Associative array, where the key is the dictionary name.


### The `host` section {#host-to-hosts}

The `host` section was replaced with the `hosts` associative array. This is the most critical change.

v1 used repeat unnamed `host { }` sections, as {{ TF }} could not map a specific section to a specific host in the API. This resulted in false changes if shard names were empty or the host order changed.

v2 uses an associative array where a key is assigned to each host. The provider uses this key to exactly identify a host in `state`.

You can specify any name for a key. The main principle is name comprehensibility, e.g., `"h1"`, `"shard1-rc1a"`, or `"rc1a-fqdn.{{ dns-zone }}"`.

**Example**

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


#### Coordination service hosts {#coordination-service-hosts}

Your {{ ZK }} hosts from v1 (`type = "ZOOKEEPER"`) directly migrate to v2: the type does not change, and the `zookeeper { }` section is transformed into `zookeeper = { }`. The semantics does not change.

{% note info %}

v2 also supports the `KEEPER` value (for a separate {{ CK }}) for the `type` argument, while v1 did not have this value. The type name does not change the configuration structure: the `zookeeper = { resources }` section is still required. In v2, the filed reference only contains `CLICKHOUSE` and `ZOOKEEPER`. It is an error, because `KEEPER` is also an acceptable value.

{% endnote %}


### The `database` and `user` sections {#database-and-user}

The `database` and `user` sections were deleted from the cluster resource. In v1, you could manage databases and users directly inside the cluster resource. In v2, they have separate resources.

The `permission { }`, `settings { }`, and `quota { }` nested sections migrate to the new `yandex_mdb_clickhouse_user` resource without any changes and keep their section syntax and fields.

**Example**

#|
|| **v1** | **v2** ||
||

```hcl
# v1: inline inside yandex_mdb_clickhouse_cluster
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
# v2: separate resources
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

### The `shard` section {#shard-to-shards}

The `shard` section was replaced with the `shards` associative array. Like v1, v2 fully supports overriding resources for individual shards. Only the syntax has changed: an associative array is used instead of a section, and `resources` inside are specified using `= { }`.

v2 has the `disk_size_autoscaling` parameter you can specify for each shard. v1 did not support this parameter.

{% note warning %}

In v1, you could concurrently specify `clickhouse.resources` and `shard.resources`, and shard-level resources took priority. In v2, it is prohibited: `clickhouse.resources` and `shards[*].resources` are mutually exclusive. If you set both parameters, the provider will return an error. Only use one-level settings.

The same rule applies to `disk_size_autoscaling`.

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

If you do not need to override resources for individual shards, do not specify `resources`:

```hcl
shards = {
  "shard1" = { weight = 100 }
  "shard2" = { weight = 100 }
}
```

||
|#


### The `pattern` section {#pattern-to-patterns}

The name of the nested repeat section inside `clickhouse.config.graphite_rollup` has changed from `pattern` to `patterns`. The section contents have not changed.

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


### The `compression` sections {#compression}

The repeat `compression` sections were transformed into a list. In v1, `compression` comprised a set of repeat sections. In v2, it is `ListNestedAttribute`, thus you need to use the list syntax. The field set has not changed: `method`, `min_part_size`, `min_part_size_ratio`, and `level`.

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


### Fields {#fields-ref}

#### Removed fields {#removed-fields}

| Field v1 | Notes |
| --- | --- |
| `database { }` (inside the cluster resource) | Replaced by the `yandex_mdb_clickhouse_database` resource. |
| `user { }` (inside the cluster resource) | Replaced by the `yandex_mdb_clickhouse_user` resource. |
| `clickhouse.config.kafka_topic { }` | v2 does not support topic-level {{ KF }} configuration. |
| `clickhouse.config.mark_cache_size` | In v2, this field was removed. |
| `clickhouse.config.merge_tree.allow_remote_fs_zero_copy_replication` | In v2, this field was removed. |
| `status` | The read-only attribute was removed. If your configuration contains `output { value = ...cluster.main.status }`, delete this fragment. |
| `health` | The read-only attribute was removed. Same as `status`. |


#### Renamed fields {#renamed-fields}

| v1 | v2 | Notes |
| --- | --- | --- |
| `clickhouse.config.graphite_rollup[*].pattern` | `clickhouse.config.graphite_rollup[*].patterns` | The name was changed to the plural. The nested object's structure has not changed. |


#### New fields {#new-fields-v2}

{% note warning %}

You cannot specify both `clickhouse.resources` and `shards[*].resources` at the same time. Use either the global `clickhouse.resources` or shard-level `shards[*].resources`, but not both at the same time.

The same rule applies to `disk_size_autoscaling`.

{% endnote %}


##### Cluster level {#cluster-level}

| Field v2 | Syntax | Description |
| --- | --- | --- |
| `allow_host_recreation` | `allow_host_recreation = true` | It allows the provider to recreate hosts when needed, e.g., when changing the disk type. This field is optional; no default value is set. |
| `restore` | `restore = { backup_id = "..." }` | It allows restoring from a backup when creating a host. The fields include `backup_id` (required), `include_patterns` (optional, a list), and `exclude_patterns` (optional, a list). They are specified using the assignment syntax. |
| `performance_diagnostics` | `performance_diagnostics = { ... }` | The fields include `enabled` (`bool` type) and `processes_refresh_interval` (`string` type, e.g., `"15s"`). They are specified using the assignment syntax. |
| `external_dictionary` | `external_dictionary = { "dict_name" = { ... } }` | Associative array of external dictionaries, where the key is the dictionary name. It is specified using the assignment syntax rather than as a section. The supported data sources include `http`, `mysql`, `clickhouse`, `mongodb`, and `postgresql`. |
| `extension` | `extension { name = "..." version = "..." }` | {{ CH }} cluster extension. It is set as a section. It is only supported in v2; v1 did not have this field. |


##### clickhouse level {#clickhouse-level}

| Field v2 | Notes |
| --- | --- |
| `disk_size_autoscaling` | It is set on the same level as the `resources` field rather than inside it. The fields include `disk_size_limit`, `planned_usage_threshold`, and `emergency_usage_threshold`. |


##### zookeeper level {#zookeeper-level}

| Field v2 | Notes |
| --- | --- |
| `disk_size_autoscaling` | The structure is the same as the above one. It is set at the same level as `resources`. |


##### shards level {#shards-level}

| Field v2 | Notes |
| --- | --- |
| `disk_size_autoscaling` | It is set at the same level as `resources` inside the `shard` element. |


##### clickhouse.config level {#new-fields-ch-config}

| Fields v2 | Notes |
| --- | --- |
| `custom_macros` | List of objects in the `{ name = "...", value = "..." }` format (non-associative array). |
| `mysql_protocol` | `bool` field that allows using the {{ MY }} compatibility protocol. |
| `access_control_improvements` | It is set via assignment: `access_control_improvements = { select_from_system_db_requires_grant = true, select_from_information_schema_requires_grant = true }`. |
| `async_insert_threads`, `backup_threads`, `restore_threads` | Settings for the number of threads (`Int64`). |
| `total_memory_tracker_sample_probability` | `Float64`. |
| `error_log_enabled`, `error_log_retention_size`, `error_log_retention_time` | Separate `bool` and `int64` fields, not a nested section. |
| `query_metric_log_enabled`, `query_metric_log_retention_size`, `query_metric_log_retention_time` | The same structure is used. |
| `processors_profile_log_enabled`, `processors_profile_log_retention_size`, `processors_profile_log_retention_time` | The same structure is used. Note: The official guide contains erroneous descriptions of the `processors_profile_log_retention_size` and `processors_profile_log_retention_time` fields. The fields themselves work correctly. |
| `kafka.batch_size`, `kafka.message_max_bytes` | New fields inside `kafka = { }`. |
| `merge_tree.materialize_ttl_recalculate_only` | Field inside `merge_tree = { }`. |
| `merge_tree.deduplicate_merge_projection_mode`, `merge_tree.lightweight_mutation_projection_mode` | `string` listing fields inside `merge_tree`. |
| `merge_tree.fsync_after_insert`, `merge_tree.fsync_part_directory` | `bool` fields inside `merge_tree`. |
| `merge_tree.min_rows_to_fsync_after_merge`, `merge_tree.min_compressed_bytes_to_fsync_after_merge`, `merge_tree.min_compressed_bytes_to_fsync_after_fetch` | `Int64` fields inside `merge_tree`. |


## Complete configuration example: v1 vs. v2 {#full-example}

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
  # This section did not exist in v1: remove it for a no-op migration.
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


## Migration errors {#errors}

### Blocks of type "X" are not expected here {#blocks-of-type-x-are-not-expected-here}

```text
│ Error: Unsupported block type
│   Blocks of type "access" are not expected here. Did you mean to define argument "access"?
│   If so, use the equals sign to assign it a value.
```

To fix the error, add `=` after `access`, i.e., `access = { ... }`.


### Blocks of type "host" are not expected here {#blocks-of-type-host-are-not-expected-here}

To fix the error, replace the repeat `host { }` sections with the `hosts = { }` associative array.


### Error: Argument or block definition required (for shards) {#argument-or-block-definition-required-for-shards}

In v2, `shards` is an attribute. To fix this error, use `shards = { "shard1" = {} }` instead of a section.


### Error protobuf filler: Attribute X is not mapped {#error-protobuf-filler-attribute-x-is-not-mapped}

The possible causes may include the following:

* **Invalid field name**.

    The name is missing in `clickhouse.config` or was removed. For more information, see the [field reference](#fields-ref) above.

* **Invalid type**.

    The field exists but has an invalid type, e.g., a string instead of an integer. You can find the required data type in the [field reference](#fields-ref).

* **Not supported in this {{ CH }} version**.

    Some fields are available starting from a certain version. You can find the version requirements in [this provider guide]({{ tf-docs-link }}).

* **Provider-side mapping error**.

    Sometimes the field is present in the schema but the provider does not process it. If the field name and type are valid, create a task in the provider's repository.


#### Useful links {#see-also}

* [{#T}](../operations/migration-v1-v2.md)