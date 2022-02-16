{% list tabs %}

* Custom installation

    Connecting to the database with an explicitly specified network address and port.

    To connect, set the required parameters:
    * **Host IP or FQDN**: Enter the IP address or FQDN of the master host to connect to.
    * **Database port**: Set the number of the port that {{ data-transfer-name }} will use for the connection.
    * **CA Certificate**: If the transmitted data needs to be encrypted, for example, to meet the requirements of [PCI DSS]({% if lang == "ru" %}{{ link-pci-dss-ru }}{% endif %}{% if lang =="en" %}{{ link-pci-dss-en }}{% endif %}), upload the [certificate](../../../managed-mysql/operations/connect.md#get-ssl-cert) file or add its contents as text.
    * {% include [Field Database name](../fields/database-name.md) %}
    * {% include [Field Username](../fields/username.md) %}
    * {% include [Field Password](../fields/password.md) %}

* MDB cluster

    Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mmy-name }}](../../../managed-mysql/).

    To connect, set the required parameters:
    * {% include [Field Cluster ID](../fields/cluster-id.md) %}
    * {% include [Field Database name](../fields/database-name.md) %}
    * {% include [Field Username](../fields/username.md) %}
    * {% include [Field Password](../fields/password.md) %}

{% endlist %}

