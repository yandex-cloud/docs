# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Increase the storage size](#change-disk-size) (available only for network storage, `network-hdd` and `network-ssd`).

* [Configure the {{ PG }} servers](#change-postgresql-config) according to the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config.html).

* [Set the operation mode for the connection pooler](#change-pgbouncer-config).

## Changing the host class {#change-resource-preset}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View the description of the CLI's update cluster command:

      ```
      $ {{ yc-mdb-pg }} cluster update --help
      ```

  2. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

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

  3. Specify the class in the update cluster command:

      ```
      $ {{ yc-mdb-pg }} cluster update <cluster name>
           --resource-preset <class ID>
      ```

      {{ mpg-short-name }} will run the update host class command for the cluster.

- API

  You can change the [host class](../concepts/instance-types.md) using the API [update](../api-ref/Cluster/update.md) method: pass the necessary value in the request parameter `configSpec.clickhouse.resources.resourcePresetId`.

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increasing storage size {#change-disk-size}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the storage size for a cluster:

  {% if audience != "internal" %}

  3. Make sure the required cluster is using network storage (it is not yet possible to increase the size of local storage). To do this, request information about the cluster and find the `disk_type_id` field: it should be set to `network-hdd` or `network-ssd`:

      ```
      $ {{ yc-mdb-pg }} cluster get <cluster name>

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

  1. View the description of the CLI's update cluster command:

     ```
     $ {{ yc-mdb-pg }} cluster update --help
     ```

  1. Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the {{ mpg-full-name }} section still has space available in the **space** line.

  1. Specify the required amount of storage in the update cluster command (it must be at least as large as `disk_size` in the cluster properties):

      ```
      $ {{ yc-mdb-pg }} cluster update <cluster name>
           --disk-size <storage size in GB>
      ```

      If all these conditions are met, {{ mpg-short-name }} launches the operation to increase storage space.

- API

  You can change the storage size for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.postgresqlConfig_<version>.resources.diskSize`.

  Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the {{ mpg-full-name }} section still has space available in the **space** line.

{% endlist %}

## Changing {{ PG }} settings {#change-postgresql-config}

You can change the DBMS settings for the hosts in your cluster, both the default ones and those changing with the host class.

When [the host class changes](#change-resource-preset), {{ mpg-short-name }} automatically changes the following settings (if they weren't set manually):

- `max_connections`
- `shared_buffers`
- `min_wal_size`
- `max_wal_size`
- `autovacuum_max_workers`
- `autovacuum_vacuum_cost_delay`
- `autovacuum_vacuum_cost_limit`

The settings you set manually will no longer change automatically. Exceptions can occur if the set value doesn't become invalid as you change the host class: for example, it's impossible to set `max_connections` to 800 and then change the cluster host class to `s2.micro` (for more information about the maximum number of connections, see [{#T}](cluster-create.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change {{ PG }} server settings:

  1. View the full list of settings specified for the cluster:

     ```
     $ {{ yc-mdb-pg }} cluster get <cluster name> --full
     ```

  1. View the description of the CLI's update cluster configuration command:

      ```
      $ {{ yc-mdb-pg }} cluster update-config --help
      ```

  2. Set the required parameter values.

      All supported parameters are listed in [the request format for the update method](../api-ref/Cluster/update.md), in the `postgresqlConfig_<version>` field. To specify the parameter name in the CLI's call, convert the name from <q>lowerCamelCase</q> to <q>snake_case</q>. For example, the `logMinDurationStatement` parameter from an API request should be converted to `log_min_duration_statement` for the CLI command:

      ```
      $ {{ yc-mdb-pg }} cluster update-config <cluster name>
           --set log_min_duration_statement=100,<parameter name>=<value>,...
      ```

      {{ mpg-short-name }} will run the operation for changing the cluster settings.

- API

  You can change the DBMS settings for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.postgresqlConfig_<version>.config`.

{% endlist %}

## Set the operation mode for the connection pooler {#change-pgbouncer-config}

You can set one of the modes described in the [PgBouncer documentation](https://pgbouncer.github.io/usage).

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the PgBouncer operation mode:

  1. View the description of the CLI's update cluster command:

      ```
      $ {{ yc-mdb-pg }} cluster update --help
      ```

  2. Specify the necessary operation mode using the `--connection-pooling-mode` flag:

      ```
      $ {{ yc-mdb-pg }} cluster update <cluster name>
           --connection-pooling-mode <SESSION, TRANSACTION or STATEMENT>
      ```

      {{ mpg-short-name }} runs the operation for changing the connection pooler mode.

- API

  You can change the connection pooler's operation mode for a cluster using the [update](../api-ref/Cluster/update.md) API method: pass the appropriate value in the `configSpec.poolerConfig.poolingMode` request parameter.

{% endlist %}

