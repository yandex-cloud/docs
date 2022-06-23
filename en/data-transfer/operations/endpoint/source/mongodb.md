# Configuring a {{ MG }} source endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mmg-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).


## {{ mmg-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mmg-full-name }}](../../../../managed-mongodb/).

{% list tabs %}

- Management console

   {% include [Managed MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/managed-mongodb.md) %}

{% endlist %}


## Custom installation {#on-premise}

Connecting to the database with an explicitly specified network address and port.

{% list tabs %}

- Management console

   {% include [On premise MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mongodb.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **List of included collections**: Data is only transferred from listed collections. All collections are transferred by default.

   * **List of excluded collections**: Data is transferred from all collections except the specified ones.

   If a source is experiencing high workload (over 10000 write transactions per second), we recommend that you select these settings to have no more than ten different databases at each endpoint. This will help avoid database connection errors while the transfer is ongoing.

   {% note info %}

   If you use several endpoints, you need to create a separate transfer for each one.

   {% endnote %}

{% endlist %}
