# Connecting external dictionaries

You can add [external dictionaries](../concepts/dictionaries.md#external-dicts) to your cluster and remove them. For more information about dictionaries, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/).

{{ mch-name }} supports several types of dictionary sources.

* {{ CH }}.
* HTTP(s).
* {{ MG }}.
* {{ MY }}.
* {{ PG }}.

Dictionaries can be managed either via SQL or via cloud interfaces. SQL is the recommended method.

## Getting a list of dictionaries {#get-dicts-list}

{% list tabs %}

* SQL

   1. [Connect](connect.md) to the desired database of the cluster {{ mch-name }} with the help of `clickhouse-client`.
   1. Run the `SHOW DICTIONARIES` [query](https://{{ ch-domain }}/docs/en/sql-reference/statements/show/#show-dictionaries).

* Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster and open the **Dictionaries** tab.

* CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add an external dictionary to a {{ CH }} cluster:

   1. View a description of the CLI command for getting detailed cluster information:

      ```bash
      {{ yc-mdb-ch }} cluster get --help
      ```

   1. Run the command:

      ```bash
      {{ yc-mdb-ch }} cluster get <cluster name>
      ```

   The added dictionaries are displayed in the `dictionaries:` section of command execution results.

* API

   You can view a list of dictionaries and other cluster parameters using the [get](../api-ref/Cluster/get.md) method.

{% endlist %}

## Adding a dictionary {#add-dictionary}

{% list tabs %}

* SQL

   {% note warning %}

   If the dictionary is added via SQL, management using the console, the CLI, and the API is not available for it.

   {% endnote %}

   1. [Connect](connect.md) to the desired database of the cluster {{ mch-name }} with the help of `clickhouse-client`.
   1. Run a [DDL query](https://{{ ch-domain }}/docs/en/sql-reference/statements/create/dictionary/) and specify [dictionary settings](#settings-sql):

      ```sql
      CREATE DICTIONARY <dictionary name>(
      <data columns>
      )
      PRIMARY KEY <name of the column with keys>
      SOURCE(<source>(<source configuration>))
      LIFETIME(<update interval>)
      LAYOUT(<method for storing dictionaries in memory>());
      ```

* Management console

   {% note warning %}

   If the dictionary is added via the console, it cannot be managed via SQL.

   {% endnote %}

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster and open the **Dictionaries** tab.
   1. In the upper-right corner, click **Add dictionary**.
   1. Specify [dictionary settings](#settings-console) and click **Save**.

* CLI

   {% note warning %}

   If the dictionary is added via the CLI, it cannot be managed via SQL.

   {% endnote %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add an external dictionary to a {{ CH }} cluster:

   1. View a description of the CLI command for adding dictionaries:

      ```bash
      {{ yc-mdb-ch }} cluster add-external-dictionary --help
      ```

   1. Run the add dictionary command and specify [dictionary settings](#settings-cli):

      ```bash
      {{ yc-mdb-ch }} cluster add-external-dictionary \
         --name=<{{ CH }} cluster name> \
         --dict-name=<dictionary name> \
         ...
      ```

* API

   {% note warning %}

   If the dictionary is added via the API, it cannot be managed via SQL.

   {% endnote %}

   You can add a dictionary using the [createExternalDictionary](../api-ref/Cluster/createExternalDictionary.md) method.

{% endlist %}

## Removing a dictionary {#delete-dictionary}

{% list tabs %}

* SQL

   1. [Connect](connect.md) to the desired database of the cluster {{ mch-name }} with the help of `clickhouse-client`.
   1. Run the `DROP DICTIONARY <DB name>.<dictionary name>` [query](https://{{ ch-domain }}/docs/en/sql-reference/statements/drop/#drop-dictionary).

* Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster and open the **Dictionaries** tab.
   1. Click the ![image](../../_assets/options.svg) icon in the same row as the desired host and select **Delete**.

* CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove an external dictionary:

   1. View a description of the CLI's remove dictionary command:

      ```bash
      {{ yc-mdb-ch }} cluster remove-external-dictionary --help
      ```

   1. Run the command to remove a dictionary:

      ```bash
      {{ yc-mdb-ch }} cluster remove-external-dictionary \
        --name <cluster name> \
        --dict-name <dictionary name> \
      ```

* API

   You can remove dictionaries using the [deleteExternalDictionary](../api-ref/Cluster/deleteExternalDictionary.md) method.

{% endlist %}

## Dictionary settings {#settings}

### SQL {#settings-sql}

* <dictionary name>: Name of a new dictionary.
* <data columns>: List of columns with dictionary data and data type.
* PRIMARY KEY: Dictionary key column name.
* SOURCE: Source and its parameters.
* LIFETIME: Frequency of dictionary updates.
* LAYOUT: Method for storing a dictionary in memory. Supported methods: `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, and `complex_key_cache`.

For more information about the settings, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

### Management console {#settings-console}

* **Name**: Name of a new dictionary.

#### Source {#console-source}

{% list tabs %}

* {{ CH }}

   * **Host**: Source host name. The host must be in the same network as the {{ CH }} cluster.
   * **Port**: Port for connecting to the source.
   * **User**: Source database username.
   * **Password**: Password to access the source database.
   * **Database**: Name of source database.
   * **Table**: Source table name.
   * **Selection condition**: Condition for selecting rows to generate a dictionary from. For example, the selection condition `id=10` is the same as the SQL command `WHERE id=10`.
   * (Optional) **Dictionary status check**: SQL query to check for dictionary changes. {{ CH }} updates the dictionary only if there are changes in the query results.
      For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

* HTTP(s)

   * **URL**: HTTP(s) source URL.
   * **File format**: File [format](https://{{ ch-domain }}/docs/en/interfaces/formats/#formats) for an HTTP(s) source. For more information about the formats, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/interfaces/formats/#formats).

* {{ MG }}

   * **Host**: Source host name. The host must be in the same network as the {{ CH }} cluster.
   * **Port**: Port for connecting to the source.
   * **User**: Source database username.
   * **Password**: Password to access the source database.
   * **Database**: Name of source database.
   * **Collection**: Name of the collection for the source.

* {{ MY }}

   * **Replicas**: List of {{ MY }} replicas to use as the dictionary source.
      For replicas, you can set general connection settings or set up a port, username and password.
   * **Port**: Port for connecting to the source.
   * **User**: Source database username.
   * **Password**: Password to access the source database.
   * **Database**: Name of source database.
   * **Table**: Source table name.
   * **Selection condition**: Condition for selecting rows to generate a dictionary from. For example, the selection condition `id=10` is the same as the SQL command `WHERE id=10`.
   * (Optional) **Dictionary status check**: SQL query to check for dictionary changes. {{ CH }} updates the dictionary only if there are changes in the query results.
      For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

* {{ PG }}

   * **Hosts**: Names of a {{ PG }} host and its [replicas](../../managed-postgresql/concepts/replication.md) that will be used as dictionary sources. The hosts must be in the same network as the {{ CH }} cluster.
   * **Port**: Port for connecting to the source.
   * **User**: Source database username.
   * **Password**: Password to access the source database.
   * **Database**: Name of source database.
   * **Table**: Source table name.
   * (Optional) **Dictionary status check**: SQL query to check for dictionary changes. {{ CH }} updates the dictionary only if there are changes in the query results.
      For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).
   * **SSL mode**: Mode for establishing a secure SSL TCP/IP connection to the {{ PG }} database.
      For more information, see the [{{ PG }}documentation](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-PARAMKEYWORDS).

{% endlist %}

For more information about dictionary sources and their connection settings, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).

#### Layout {#console-method}

* **Layout**: Method for storing a dictionary in memory. Supported methods: `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, and `complex_key_cache`. For more information about layouts, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
* **Cache size**: Number of cache cells for the `cache` and `complex_key_cache` methods. For more information about the cache, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).
* **Numeric key**: Dictionary key column name. The key column must be in UInt64 data type. Used for `flat`, `hashed`, `cache`, and `range_hashed` methods. For more information about the keys, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
* **Data columns**: List of columns with dictionary data:

   * **Name**: Column name.
   * **Type**: Column data type.
   * (Optional) **Default value**: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You can't use `NULL` in this field.
   * (Optional) **Expression**: [Expression](https://{{ ch-domain }}/docs/en/sql-reference/syntax/#syntax-expressions) that {{ CH }} executes with the column value.
   * **Hierarchical**: Hierarchical support flag.
   * **Injective**: Flag that shows whether the `id` -> `attribute` image is injective

For more information about the column settings, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict_structure-attributes).

#### Update rate {#console-rate}

* **Lifetime**: Set how often the dictionary updates:

   * **Fixed**: Fixed period between dictionary updates:

      * **Period duration**: Update interval for dictionary data in seconds.

   * **Variable**: Time range for {{ CH }} to randomly select the time for update. This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers:

      * **Minimum**: Minimum value of the interval between dictionary updates in seconds.
      * **Maximum**: Maximum value of the interval between dictionary updates in seconds.

For more information about dictionary updates, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

### CLI {#settings-cli}

* `--dict-name`: Name of a new dictionary.

{% list tabs %}

* {{ CH }}

   * `--clickhouse-source`: Settings of a {{ CH }} source:

      * `db`: Source database name.
      * `table`: Source table name.
      * `host`: Source host name. The host must be in the same network as the {{ CH }} cluster.
      * `port`: Port for connecting to the source.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `where`: Condition for selecting rows to generate a dictionary from. For example, the selection condition `id=10` is the same as the SQL command `WHERE id=10`.

* HTTP(s)

   * `--http-source-url`: HTTP(s) source URL.
   * `--http-source-format`: File [format](https://{{ ch-domain }}/docs/en/interfaces/formats/#formats) for an HTTP(s) source. For more information about the formats, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/interfaces/formats/#formats).

* {{ MG }}

   * `--mongodb-source`: Settings of a {{ MG }} source:

      * `db`: Source database name.
      * `connection`: Name of the collection for the {{ MG }} source.
      * `host`: Source host name. The host must be in the same network as the {{ CH }} cluster.
      * `port`: Port for connecting to the source.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.

* {{ MY }}

   * `--mysql-source`: Settings of a {{ MY }} source:

      * `db`: Source database name.
      * `table`: Source table name.
      * `port`: Port for connecting to the source.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `where`: Condition for selecting rows to generate a dictionary from. For example, the selection condition `id=10` is the same as the SQL command `WHERE id=10`.

   * `--mysql-replica`: Settings of {{ MY }} source replicas:

      * `host`: Replica host name.
      * `priority`: Replica priority. During a connection attempt, {{ CH }} reads from replicas based on their priority. The lower the number, the higher the priority.
      * `port`: Port for connecting to the replica.
      * `user`: Name of database user.
      * `password`: Password to access the database.

   * `--mysql-invalidate-query`: Query to check for dictionary changes. {{ CH }} updates the dictionary only if there are changes in the query results.

* {{ PG }}

   * `--postgresql-source`: Settings of a {{ PG }} source:

      * `db`: Source database name.
      * `table`: Source table name.
      * `port`: Port for connecting to the source.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `ssl-mode`: Mode for establishing a secure SSL TCP/IP connection to the {{ PG }} database Acceptable values: `disable`, `allow`, `prefer`, `verify-ca`, or `verify-full`.

   * `--postgresql-source-hosts`: Names of a {{ PG }} host its [replicas](../../managed-postgresql/concepts/replication.md) that will be used as dictionary sources. The hosts must be in the same network as the {{ CH }} cluster.

   * `--postgresql-invalidate-query`: Query to check for dictionary changes. {{ CH }} updates the dictionary only if there are changes in the query results.

{% endlist %}

* `--structure-id`: Key column name. The key column must be in UInt64 data type. Used for `flat`, `hashed`, `cache`, and `range_hashed` methods. For more information about the keys, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
* `--structure-key`: List of columns with dictionary data:

   * `name`: Column name.
   * `type`: Type of column data.
   * `null-value`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You can't use `NULL` in this field.
   * `expression`: [Expression](https://{{ ch-domain }}/docs/en/sql-reference/syntax/#syntax-expressions) that {{ CH }} executes with the column value.
   * `hierarchical`: Hierarchical support flag.
   * `injective`: Flag that shows whether the `id` → `attribute` image is injective

* `--structure-attribute`: Description of the fields available for database queries:

   * `name`: Column name.
   * `type`: Type of column data.
   * `null-value`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You can't use `NULL` in this field.
   * `expression`: [Expression](https://{{ ch-domain }}/docs/en/sql-reference/syntax/#syntax-expressions) that {{ CH }} executes with the column value.
   * `hierarchical`: Hierarchical support flag.
   * `injective`: Flag that shows whether the `id` → `attribute` image is injective

* `--fixed-lifetime`: Fixed interval between dictionary updates in seconds.
* `--lifetime-range`: Time range for {{ CH }} to randomly select the time for update. This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers.

   * `min`: Minimum interval between dictionary updates in seconds.
   * `max`: Maximum interval between dictionary updates in seconds.

* `--layout-type`: Method of storing dictionary in memory. Supported methods: `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, and `complex_key_cache`. For more information about layouts, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
* `--layout-size-in-cells`: Number of cache cells for the `cache` and `complex_key_cache` methods. For more information about the cache, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).

### API {#settings-api}

For more information about the settings, see the description of the [createExternalDictionary](../api-ref/Cluster/createExternalDictionary.md) API method.

## Examples

{% list tabs %}

* CLI

   Let's say we want to add a dictionary with the following parameters:

   * `mych` cluster.
   * `mychdict` name.
   * `id` name of the key column.
   * Fields available for database queries:

      * `id` of the `UInt64` type.
      * `field1` of the `String` type.

   * Fixed period between dictionary updates 300 seconds.
   * `cache` layout.
   * {{ PG }} source:

      * `db1` database.
      * `table` table name.
      * `5432` connection port.
      * `user1` name of the database user.
      * `user1user1` password to access the database.
      * `verify-full` mode for establishing a secure SSL TCP/IP connection to the database.

   * `rc1b-05vjbfhfkrycjyq8.mdb.yandexcloud.net` host name.

   To add such a dictionary, run the command:

   ```bash
   {{ yc-mdb-ch }} cluster add-external-dictionary \
      --name=mych \
      --dict-name=mychdict \
      --structure-id=id \
      --structure-attribute name=id,`
                           `type=UInt64,`
                           `name=field1,`
                           `type=String \
      --fixed-lifetime=300 \
      --layout-type=cache \
      --postgresql-source db=db1,`
                         `table=table,`
                         `port=5432,`
                         `user=user1,`
                         `password=user1user1,`
                         `ssl-mode=verify-full \
      --postgresql-source-hosts=rc1b-05vjbfhfkrycjyq8.mdb.yandexcloud.net
   ```

{% endlist %}
