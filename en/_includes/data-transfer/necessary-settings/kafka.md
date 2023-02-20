{% list tabs %}

* Managed Kafka

    Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mkf-name }}](../../../managed-kafka/).

    To connect, set the required parameters:
    * **Managed Kafka**: Select the cluster to connect to.
    * **Authentication**: Specify the name and password of the account that {{ data-transfer-name }} will connect to the topic as.
    * {% include [Field Topic](../fields/topic.md) %}

* On Premise

    Connecting to the topic with explicitly specified broker host network addresses.

    To connect, set the required parameters:

    * **On Premise**:

        * **Broker addresses**: Specify the IP addresses or FQDNs of the broker hosts.

            If the {{ KF }} port number differs from the standard one, specify it with a colon after the host name:

            ```text
            <broker host IP or FQDN>:<port number>
            ```

        * **SSL**: Use encryption to protect the connection.
        * **PEM certificate**: If transmitted data needs to be encrypted, for example, to meet the requirements of {% if product == "yandex-cloud" %}[PCI DSS]({% if lang == "ru" %}{{ link-pci-dss-ru }}{% endif %}{% if lang =="en" %}{{ link-pci-dss-en }}{% endif %}){% endif %}{% if product == "cloud-il" %}PCI DSS{% endif %}, upload the [certificate](../../../managed-kafka/operations/connect.md#get-ssl-cert) file or add its contents as text.

    * **Authentication**: If you select `SASL`, specify the account name, password, and hashing mechanism.
    * {% include [Field Topic](../fields/topic.md) %}

{% endlist %}

