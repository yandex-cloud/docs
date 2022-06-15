# Source endpoint parameters {{ CH }}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mch-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ mch-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mch-name }}](../../../../managed-clickhouse/).

{% list tabs %}

- Management console

   {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse.md) %}

{% endlist %}

## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs %}

- Management console

   {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **Included tables**: Data is only transferred from listed tables. It is set using regular expressions.
   * **Excluded tables**: Data from the listed tables is not transferred. It is set using regular expressions.

   Both lists support expressions in the following format:

   * `<schema name>.<table name>`: Fully qualified table name.
   * `<schema name>.*`: All tables in the specified schema.
   * `<table name>`: Table in the default schema.

{% endlist %}
