# Connecting external dictionaries in {{ mch-name }}

You can add [external dictionaries](../concepts/dictionaries.md#external-dicts) to your cluster and remove them. For more information about dictionaries, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/).

{{ mch-name }} supports several types of dictionary sources:

* {{ CH }}
* HTTP(s)
* {{ MG }}
* {{ MY }}
* {{ PG }}

You can manage dictionaries either via SQL or via cloud interfaces. We recommend SQL.

{% note warning %}

Changing dictionary settings will restart {{ CH }} servers on the cluster hosts.

{% endnote %}

## Getting a list of dictionaries {#get-dicts-list}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add an external dictionary to a {{ CH }} cluster:

   1. View a description of the CLI command for getting detailed cluster information:

      ```bash
      {{ yc-mdb-ch }} cluster get --help
      ```

   1. Run this command:

      ```bash
      {{ yc-mdb-ch }} cluster get <cluster_name>
      ```

   The added dictionaries are displayed in the `dictionaries:` section of command execution results.

- API {#api}

   To get a list of dictionaries, use the [get](../api-ref/Cluster/get.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) gRPC API call.

- SQL {#sql}

   1. [Connect](connect.md) to the required database of the {{ mch-name }} cluster using `clickhouse-client`.
   1. Run the `SHOW DICTIONARIES` [query]({{ ch.docs }}/sql-reference/statements/show/#show-dictionaries).

{% endlist %}

## Adding a dictionary {#add-dictionary}

{% list tabs group=instructions %}

- Management console {#console}

   {% note warning %}

   If the dictionary is added via the console, it cannot be managed via SQL.

   {% endnote %}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}** tab.
   1. In the top-right corner, click **{{ ui-key.yacloud.mdb.cluster.dictionaries.button-action_add-dictionary }}**.
   1. Specify [dictionary settings](#settings-console) and click **{{ ui-key.yacloud.mdb.cluster.dictionaries.button_submit }}**.

- CLI {#cli}

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
         --name=<{{ CH }}_cluster_name> \
         --dict-name=<dictionary_name> \
         ...
      ```

- API {#api}

   {% note warning %}

   If the dictionary is added via the API, it cannot be managed via SQL.

   {% endnote %}

   To add a dictionary, use the [createExternalDictionary](../api-ref/Cluster/createExternalDictionary.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/CreateExternalDictionary](../api-ref/grpc/cluster_service.md#CreateExternalDictionary) gRPC API call.

- SQL {#sql}

   {% note warning %}

   If the dictionary is added via SQL, management using the console, the CLI, and the API is not available for it.

   {% endnote %}

   1. [Connect](connect.md) to the required database of the {{ mch-name }} cluster using `clickhouse-client`.
   1. Run the [DDL query]({{ ch.docs }}/sql-reference/statements/create/dictionary/) and specify [dictionary settings](#settings-sql):

      ```sql
      CREATE DICTIONARY <dictionary_name>(
      <data_columns>
      )
      PRIMARY KEY <key_column_name>
      SOURCE(<source>(<source_configuration>))
      LIFETIME(<update_interval>)
      LAYOUT(<how_dictionary_is_stored_in_memory>());
      ```

{% endlist %}

## Removing a dictionary {#delete-dictionary}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the dictionary you want to delete and select **{{ ui-key.yacloud.mdb.cluster.dictionaries.button_action-delete }}**.

- CLI {#cli}

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
        --name <cluster_name> \
        --dict-name <dictionary_name> \
      ```

- API {#api}

   To delete a dictionary, use the [deleteExternalDictionary](../api-ref/Cluster/deleteExternalDictionary.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteExternalDictionary](../api-ref/grpc/cluster_service.md#DeleteExternalDictionary) gRPC API call.

- SQL {#sql}

   1. [Connect](connect.md) to the required database of the {{ mch-name }} cluster using `clickhouse-client`.
   1. Run the `DROP DICTIONARY <DB_name>.<dictionary_name>` [query]({{ ch.docs }}/sql-reference/statements/drop/#drop-dictionary).

{% endlist %}

## Dictionary settings {#settings}

### SQL {#settings-sql}

* `<dictionary_name>`: Name of new dictionary.
* `<data_columns>`: List of columns with dictionary data and their type.
* `PRIMARY KEY`: Dictionary key column name.
* `SOURCE`: Source and its parameters.
* `LIFETIME`: Dictionary update frequency.
* `LAYOUT`: Method for storing dictionary in memory. The supported methods are `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, and `complex_key_cache`.

For more information about the settings, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

### Management console {#settings-console}

* **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_name }}**: Name of a new dictionary.

#### Source {#console-source}

{% list tabs group=data_sources %}

- {{ CH }} {#clickhouse}

   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_host }}**: Source host name. The host must be in the same network as the {{ CH }} cluster.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}**: Port for connecting to the source.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}**: Name of source database user.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}**: Password to access the source database.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}**: Source database name.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}**: Source table name.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_where }}**: Condition for selecting rows to generate a dictionary from. For example, the `id=10` selection condition is the same as the `WHERE id=10` SQL command.
   * (Optional) **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}**: SQL query to check for dictionary changes. {{ CH }} updates the dictionary only if there are changes in the query results.
      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

- HTTP(s) {#https}

   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_http-url }}**: HTTP(s) source URL.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_http-format }}**: File [format]({{ ch.docs }}/interfaces/formats/#formats) for an HTTP(s) source. For more information about the formats, see the [{{ CH }} documentation]({{ ch.docs }}/interfaces/formats/#formats).

- {{ MG }} {#mongodb}

   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_host }}**: Source host name. The host must be in the same network as the {{ CH }} cluster.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}**: Port for connecting to the source.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}**: Name of source database user.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}**: Password to access the source database.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}**: Source database name.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_collection }}**: Name of the collection for the source.

- {{ MY }} {#mysql}

   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_replicas }}**: List of {{ MY }} replicas to use as the dictionary source.
      For replicas, you can set general connection settings or set up a port, username and password.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}**: Port for connecting to the source.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}**: Name of source database user.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}**: Password to access the source database.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}**: Source database name.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}**: Source table name.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_where }}**: Condition for selecting rows to generate a dictionary from. For example, the `id=10` selection condition is the same as the `WHERE id=10` SQL command.
   * (Optional) **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}**: SQL query to check for dictionary changes. {{ CH }} updates the dictionary only if there are changes in the query results.
      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

- {{ PG }} {#postgresql}

   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_hosts }}**: Names of a {{ PG }} host and its [replicas](../../managed-postgresql/concepts/replication.md) that will be used as dictionary sources. The hosts must be in the same network as the {{ CH }} cluster.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}**: Port for connecting to the source.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}**: Name of source database user.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}**: Password to access the source database.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}**: Source database name.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}**: Source table name.
   * (Optional) **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}**: SQL query to check for dictionary changes. {{ CH }} updates the dictionary only if there are changes in the query results.
      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_postgresql-ssl-mode }}**: Mode for establishing a secure SSL TCP/IP connection to the {{ PG }} database.
      For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-PARAMKEYWORDS).

{% endlist %}

For more information about dictionary sources and their connection settings, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).

#### Layout {#console-method}

* **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_layout-type }}**: Dictionary layout. The supported layouts are `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, and `complex_key_cache`. For more information about layouts, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
* **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_size-in-cells }}**: Number of cache cells for the `cache` and `complex_key_cache` layouts. For more information about the cache, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).
* **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_structure-id }}**: Dictionary key column name. The key column must be in UInt64 data type. It is used for `flat`, `hashed`, `cache`, and `range_hashed` layouts. For more information about the keys, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
* **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_structure-attributes }}**: List of columns with dictionary data:

   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-name }}**: Column name.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-type }}**: Column data type.
   * (Optional) **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-nullValue }}**: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot use `NULL` in this field.
   * (Optional) **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-expression }}**: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) that {{ CH }} executes with the column value.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-hierarchical }}**: Hierarchical support flag.
   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-injective }}**: Injective `id` → `attribute` mapping flag.

For more information about the column settings, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict_structure-attributes).

#### Update rate {#console-rate}

* **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_update-interval }}**: Set how often the dictionary updates:

   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.label_fixed-lifetime }}**: Fixed period between dictionary updates:

      * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_fixed-lifetime }}**: Update interval for dictionary data in seconds.

   * **{{ ui-key.yacloud.mdb.cluster.dictionaries.label_range-lifetime }}**: Time range for {{ CH }} to randomly select the time for update. This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers:

      * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_range-lifetime-min }}**: Minimum interval between dictionary updates in seconds.
      * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_range-lifetime-max }}**: Maximum interval between dictionary updates in seconds.

For more information about dictionary updates, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

### CLI {#settings-cli}

* `--dict-name`: Name of a new dictionary.

{% list tabs group=data_sources %}

- {{ CH }} {#clickhouse}

   * `--clickhouse-source`: Settings of a {{ CH }} source:

      * `db`: Source database name.
      * `table`: Source table name.
      * `host`: Source host name. The host must be in the same network as the {{ CH }} cluster.
      * `port`: Port for connecting to the source.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `where`: Condition for selecting rows to generate a dictionary from. For example, the `id=10` selection condition is the same as the `WHERE id=10` SQL command.

- HTTP(s) {#https}

   * `--http-source-url`: HTTP(s) source URL.
   * `--http-source-format`: File [format]({{ ch.docs }}/interfaces/formats/#formats) for an HTTP(s) source. For more information about the formats, see the [{{ CH }} documentation]({{ ch.docs }}/interfaces/formats/#formats).

- {{ MG }} {#mongodb}

   * `--mongodb-source`: Settings of a {{ MG }} source:

      * `db`: Source database name.
      * `connection`: Name of the collection for the {{ MG }} source.
      * `host`: Source host name. The host must be in the same network as the {{ CH }} cluster.
      * `port`: Port for connecting to the source.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.

- {{ MY }} {#mysql}

   * `--mysql-source`: Settings of a {{ MY }} source:

      * `db`: Source database name.
      * `table`: Source table name.
      * `port`: Port for connecting to the source.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `where`: Condition for selecting rows to generate a dictionary from. For example, the `id=10` selection condition is the same as the `WHERE id=10` SQL command.

   * `--mysql-replica`: Settings of {{ MY }} source replicas:

      * `host`: Replica host name.
      * `priority`: Replica priority. During a connection attempt, {{ CH }} reads from replicas based on their priority. The lower the number, the higher the priority.
      * `port`: Port for connecting to the replica.
      * `user`: Name of database user.
      * `password`: Password to access the database.

   * `--mysql-invalidate-query`: Query to check for dictionary changes. {{ CH }} updates the dictionary only if there are changes in the query results.

- {{ PG }} {#postgresql}

   * `--postgresql-source`: Settings of a {{ PG }} source:

      * `db`: Source database name.
      * `table`: Source table name.
      * `port`: Port for connecting to the source.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `ssl-mode`: Mode for establishing a secure SSL TCP/IP connection to the {{ PG }} database. Acceptable values: `disable`, `allow`, `prefer`, `verify-ca`, or `verify-full`.

   * `--postgresql-source-hosts`: Names of a {{ PG }} host its [replicas](../../managed-postgresql/concepts/replication.md) that will be used as dictionary sources. The hosts must be in the same network as the {{ CH }} cluster.

   * `--postgresql-invalidate-query`: Query to check for dictionary changes. {{ CH }} updates the dictionary only if there are changes in the query results.

{% endlist %}

* `--structure-id`: Dictionary key column name. The key column must be in UInt64 data type. It is used for `flat`, `hashed`, `cache`, and `range_hashed` layouts. For more information about the keys, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
* `--structure-key`: List of columns with dictionary data:

   * `name`: Column name.
   * `type`: Type of column data.
   * `null-value`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot use `NULL` in this field.
   * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) that {{ CH }} executes with the column value.
   * `hierarchical`: Hierarchical support flag.
   * `injective`: Injective `id` → `attribute` mapping flag.

* `--structure-attribute`: Description of the fields available for database queries:

   * `name`: Column name.
   * `type`: Type of column data.
   * `null-value`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot use `NULL` in this field.
   * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) that {{ CH }} executes with the column value.
   * `hierarchical`: Hierarchical support flag.
   * `injective`: Injective `id` → `attribute` mapping flag.

* `--fixed-lifetime`: Fixed interval between dictionary updates in seconds.
* `--lifetime-range`: Time range for {{ CH }} to randomly select the time for update. This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers.

   * `min`: Minimum interval between dictionary updates in seconds.
   * `max`: Maximum interval between dictionary updates in seconds.

* `--layout-type`: Method of storing dictionary in memory. The supported layouts are `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, and `complex_key_cache`. For more information about layouts, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
* `--layout-size-in-cells`: Number of cache cells for the `cache` and `complex_key_cache` methods. For more information about the cache, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).

### API {#settings-api}

For more information about the settings, see the description of the [createExternalDictionary](../api-ref/Cluster/createExternalDictionary.md) API method.

## Examples

{% list tabs group=instructions %}

- CLI {#cli}

   Add a dictionary with test characteristics:

   * Cluster: `mych`.
   * Name: `mychdict`.
   * Key column name: `id`.
   * Fields available for database queries:

      * `id` of the `UInt64` type.
      * `field1` of the `String` type.

   * Fixed period between dictionary updates 300 seconds.
   * Layout: `cache`.
   * {{ PG }} source:

      * Database: `db1`.
      * Table name: `table`.
      * Connection port: `5432`.
      * Database user name: `user1`.
      * Password for access to the database: `user1user1`.
      * `verify-full` mode for establishing a secure SSL TCP/IP connection to the database.

   * Host name: `rc1b-05vjbfhf********.{{ dns-zone }}`.

   Run the following command:

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
      --postgresql-source-hosts=rc1b-05vjbfhf********.{{ dns-zone }}
   ```

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
