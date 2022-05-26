{% list tabs %}

* custom installation

    To connect, set the required parameters:

    * **Host**: Enter the IP address or FQDN of the host you want to connect to.

    * **Port**: Set the number of the port that {{ data-transfer-name }} will use for the connection.

    * In the **Instance** field, select the [type of connection](https://docs.oracle.com/cd/E11882_01/network.112/e41945/concepts.htm#NETAG002) to the Oracle cluster.

    * Depending on the selected connection type, enter `SID` or `Service name` in an Oracle database.

    * {% include [Field Username](../fields/username.md) %}

    * {% include [Field Password](../fields/password.md) %}

    * **List of included tables**: Data is only transferred from the listed tables. It is set using regular expressions.

    * **List of excluded tables**: Data from the listed tables is not transferred. It is set using regular expressions.

        Both lists support expressions in the following format:
        * `<schema name>.<table name>`: Fully qualified table name.
        * `<schema name>.*`: All tables in the specified schema.
        * `<table name>`: Table in the default schema.

{% endlist %}

