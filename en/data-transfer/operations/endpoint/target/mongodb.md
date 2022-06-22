# Configuring a {{ MG }} target endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* {% if product == "yandex-cloud" %}[{{ mmg-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise){% endif %}{% if product == "cloud-il" %}[{{ MG }} custom installation](#on-premise){% endif %} settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

{% if product == "yandex-cloud" %}

## {{ mmg-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mmg-full-name }}](../../../../managed-mongodb/).

{% include [Managed MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/managed-mongodb.md) %}

{% endif %}

## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% include [On premise MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mongodb.md) %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   {% if audience != "internal" %}

   * {% include [Field Subnet ID](../../../../_includes/data-transfer/fields/common/ui/subnet-id.md) %}

   {% endif %}

   * {% include [Field CA certificate](../../../../_includes/data-transfer/fields/mongodb/ui/ca-certificate.md) %}

   * **Cleanup policy**: Select a way to clean up data in the target database before the transfer:

      * `DISABLED`: Do not clean up.

         Select this option if only replication without copying data is performed.

      * `Drop`: Fully delete tables included in the transfer (default).

         Use this option so that the latest schema version is always transferred to the target database from the source whenever the transfer is activated.

      * `TRUNCATE`: Delete only the data from the collections included in the transfer but leave the schema.

         Use this option if the schema in the target database differs from the one that would have been transferred from the source during the transfer.

      {% note warning %}

      By default, {{ data-transfer-name }} transfers collections without sharding. If you are transferring data to a sharded target cluster and want your collections to be sharded:

      1. [Prepare the target cluster](../../prepare.md#target-mg) to shard the collections.
      1. Select `DISABLED` or `TRUNCATE `as your cleanup policy.

         Selecting the `DROP `policy will result in the service deleting all the data from the target database, including sharded collections, and replacing them with new unsharded ones when a transfer is activated.

      {% endnote %}

{% endlist %}
