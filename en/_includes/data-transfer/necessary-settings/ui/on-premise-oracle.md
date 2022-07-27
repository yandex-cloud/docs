* **Connection**: Select the Oracle cluster [connection type](https://docs.oracle.com/cd/E11882_01/network.112/e41945/concepts.htm#NETAG002).

* For the **Instance** connection type:

   * {% include [Field Host](../../fields/oracle/ui/database-host.md) %}
   * {% include [Field Port](../../fields/common/ui/database-port.md) %}
   * {% include [Field Type](../../fields/oracle/ui/type.md) %}

* For the **TNS connect string** connection type, specify the Oracle RDBMS connection string in the respective field below.

* {% include [Field Username](../../fields/common/ui/username.md) %}
* {% include [Field Password](../../fields/common/ui/password.md) %}
* {% include [PDB Container](../../fields/oracle/ui/pdb-container.md) %}
* {% include [Field Included Tables](../../fields/oracle/ui/included-tables.md) %}
* {% include [Field Excluded Tables](../../fields/oracle/ui/excluded-tables.md) %}

   Both lists support expressions in the following format:

   * `<schema name>.<table name>`: Fully qualified table name.
   * `<schema name>.*`: All tables in the specified schema.
   * `<table name>`: Table in the default schema.

* {% include [Convert NUMBER to INT64](../../fields/oracle/ui/convert-number-to-int64.md) %}
