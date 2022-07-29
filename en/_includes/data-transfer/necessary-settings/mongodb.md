{% list tabs %}

* Custom installation

    Connecting to the database with an explicitly specified network address and port.

    To connect, set the required parameters:

    * **Host list**: Specify the IP addresses or FQDN of the hosts to connect to.
    * **Port**: Set the port on which the service will connect to the cluster.
    * **CA Certificate**: If the transmitted data needs to be encrypted, for example, to meet the requirements of [PCI DSS]({% if lang == "ru" %}{{ link-pci-dss-ru }}{% endif %}{% if lang =="en" %}{{ link-pci-dss-en }}{% endif %}), upload the [certificate](../../../managed-mongodb/operations/connect/index.md#get-ssl-cert) or add its contents as text.
    * **Authentication source**: The name of the database associated with the user and password.
    * {% include [Field Username](../fields/username.md) %}
    * {% include [Field Password](../fields/password.md) %}
    * **Replica set**: Specify the name of the replica set.

* MDB cluster

    Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mmg-full-name }}](../../../managed-mongodb/).

    To connect, set the required parameters:

    * {% include [Field Cluster ID](../fields/cluster-id.md) %}
    * **Authentication source**: Specify the name of the database associated with the user and password.
    * {% include [Field Username](../fields/username.md) %}
    * {% include [Field Password](../fields/password.md) %}

{% endlist %}

