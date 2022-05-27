# Source endpoint parameters {{ CH }}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can set the following:

* Connection settings to a [{{ mch-full-name }} cluster](#managed-service) or a [custom installation](#on-premise), including those based on {{ compute-full-name }} virtual machines. These parameters are required.
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

    * **Included tables**: Data is only transferred from the listed tables. It is set using regular expressions.
    * **Excluded tables**: Data from the listed tables is not transferred. It is set using regular expressions.

    Both lists support expressions in the following format:

    * `<schema name>.<table name>`: Fully qualified table name.
    * `<schema name>.*`: All tables in the specified schema.
    * `<table name>`: Table in the default schema.

{% endlist %}
