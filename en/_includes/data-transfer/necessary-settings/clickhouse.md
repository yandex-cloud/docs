{% list tabs %}

* MDB cluster

    Connecting to a database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mch-name }}](../../../managed-clickhouse/).

    To connect, set the required parameters:

    * {% include [Field Cluster ID](../fields/cluster-id.md) %}
    * {% include [Field Database name](../fields/database-name.md) %}
    * {% include [Field Username](../fields/username.md) %}
    * {% include [Field Password](../fields/password.md) %}

* OnPremise cluster

    Connecting to the database with explicitly specified host network addresses and ports.

    To connect, set the required parameters:

    * **Shards**.
        * **ID**: Specify a row that will allow the service to distinguish shards from each other.
        * **Hosts**: Specify FQDNs or IP addresses of the hosts in the shard.

    * **Connection via SSL**: Enable if the cluster allows only encrypted connections.

    * **PEM certificate**: If transmitted data needs to be encrypted, for example, to meet the requirements of {% if product == "yandex-cloud" %}[PCI DSS]({% if lang == "ru" %}{{ link-pci-dss-ru }}{% endif %}{% if lang =="en" %}{{ link-pci-dss-en }}{% endif %}){% endif %}{% if product == "cloud-il" %}PCI DSS{% endif %}, upload the [certificate](../../../managed-clickhouse/operations/connect#get-ssl-cert) file or add its contents as text.

    * **HTTP port**: Set the number of the port that {{ data-transfer-name }} will use for the connection.

        When connecting via the HTTP port:
        * For optional fields, default values are used (if any).
        * Recording complex types is supported (such as `array` and `tuple`).

    * **Native port**: Set the number of the native port that {{ data-transfer-name }} will use for the connection.
    * {% include [Field Database name](../fields/database-name.md) %}
    * {% include [Field Username](../fields/username.md) %}
    * {% include [Field Password](../fields/password.md) %}

{% endlist %}

