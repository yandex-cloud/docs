* **{{ ui-key.yc-data-transfer.data-transfer.console.form.oracle.console.form.oracle.OracleConnection.connection_type.title }}**: Select the Oracle cluster [connection type](https://docs.oracle.com/cd/E11882_01/network.112/e41945/concepts.htm#NETAG002).

* For the **{{ ui-key.yc-data-transfer.data-transfer.console.form.oracle.console.form.oracle.OracleConnectionType.instance.title }}** connection type:

    * {% include [Field Host](../../fields/oracle/ui/database-host.md) %}
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.oracle.console.form.oracle.OracleInstance.port.title }}**: Set the number of the port that {{ data-transfer-name }} will use for the connection.
    
    * {% include [Field Type](../../fields/oracle/ui/type.md) %}

* For the **{{ ui-key.yc-data-transfer.data-transfer.console.form.oracle.console.form.oracle.OracleConnectionType.tns.title }}** connection type, specify the Oracle RDBMS connection string in the respective field below.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.oracle.console.form.oracle.OracleConnection.user.title }}**: Specify the username {{ data-transfer-name }} will use to connect to the database.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.oracle.console.form.oracle.OracleConnection.password.title }}**: Enter the user password for access to the database.

* {% include [PDB Container](../../fields/oracle/ui/pdb-container.md) %}
* {% include [Field Included Tables](../../fields/oracle/ui/included-tables.md) %}
* {% include [Field Excluded Tables](../../fields/oracle/ui/excluded-tables.md) %}

  The lists include the name of the [schema]({{ oracle.docs }}/admqs/managing-schema-objects.html) that describes the DB contents, structure, and integrity constraints, as well as the table name. Both lists support expressions in the following format:

    * `<schema_name>.<table_name>`: Full table name.
    * `<schema_name>.*`: All tables in the specified schema.
    * `<table_name>`: Table in the default schema.

    Included and excluded table names must meet the ID naming rules in Oracle. For more information, see [this Oracle guide]({{ oracle.docs }}/sqlrf/Database-Object-Names-and-Qualifiers.html). Double quotes within a table name are not supported. Escaping outer double quotes is not required.

* {% include [Convert NUMBER to INT64](../../fields/oracle/ui/convert-number-to-int64.md) %}
