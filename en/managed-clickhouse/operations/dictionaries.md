# Connecting external dictionaries

You can add [external dictionaries](../concepts/dictionaries.md#external-dicts) to your cluster and remove them. To learn more about dictionaries, see the [documentation for {{ CH }}](https://clickhouse.yandex/docs/en/query_language/dicts/).

{{ mch-name }} supports several types of dictionary sources.

- HTTP(s)
- {{ PG }}
- {{ MY }}
- {{ CH }}
- {{ MG }}

Dictionaries can be managed either via SQL or via cloud interfaces. SQL is the recommended method.

## Adding a dictionary {#add-dictionary}

{% list tabs %}

- SQL

  {% note alert %}

  If the dictionary is added via SQL, management using the console, the CLI, and the API is not available for it.

  {% endnote %}

    1. [Connect](connect.md) to the desired database of the cluster {{ mch-name }} with the help of `clickhouse-client`.

    1. Execute [DDL request](https://clickhouse.tech/docs/ru/sql-reference/statements/create/dictionary/):

       ```sql
       CREATE DICTIONARY <dictionary name>(
       <data columns>
       )
       PRIMARY KEY <key column name>
       SOURCE(<source>(<source configuration>))
       LIFETIME(<lifetime of dictionary in memory>)
       LAYOUT(<memory layout configuration>());
       ```

- Management console

  {% note alert %}

  If the dictionary is added via the console, it cannot be managed via SQL.

  {% endnote %}

    1. Select the cluster:
        1. Go to the folder page and select **{{ mch-name }}**.
        1. Click on the name of the cluster and open the **Dictionaries** tab.
        1. Click **Add dictionary**.

    1. Configure the dictionary source parameters:

       Different types of sources take different connection parameters.
        * **URL**: HTTP(s) source URL.
        * **File format**: HTTP(s) source file [format](https://clickhouse.yandex/docs/en/interfaces/formats/#formats). For more information about formats, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/interfaces/formats/#formats).
        * **Replicas**: List of {{ MY }} replicas to use as the dictionary source.
          You can configure replica-specific connection parameters (port, username, and password) or set general parameters.
        * **Host**: Source host name. The host must be in the same network as the {{ CH }} cluster.
        * **Priority**: {{ MY }} replica priority.  During a connection attempt, {{ CH }} reads from replicas based on their priority. The lower the number, the higher the priority.
        * **Port**: Port for connecting to the source.
        * **User**: Source database username.
        * **Password**: Password for accessing the source database.
        * **Database**: Name of source database.
        * **Selection condition**: Condition for selecting rows to generate a dictionary from. For example, the selection condition ```id=10``` is the same as the SQL command ```WHERE id=10```.
          This parameter is available for {{ MY }} and {{ CH }}.
        * **Table**: Source table name.
        * **Collection**: Name of the collection for the {{ MG }} source.
        * **Dictionary status check**: Optional parameter. An SQL query to check changes in a dictionary.
          {{ CH }} updates the dictionary only if there are changes in the query results.
          For more information, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
        * **SSL mode**: Mode for establishing a secure SSL TCP/IP connection to the {{ PG }} database.
          For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-PARAMKEYWORDS).

       For more information about dictionary sources and their connection parameters, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_sources/).

    1. Configure the structure and how the dictionary is stored in memory:

       **{{ mch-name }}** supports several ways to store dictionaries in memory:
       ```flat```, ```hashed```, ```cache```, ```range_hashed```, ```complex_key_hashed```, ```complex_key_cache```.
       For more information about how to store dictionaries in memory, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/).

       Parameters vary for the different methods of storing dictionaries in memory:
        * **Cache size**: Number of cache cells for the `cache` and `complex_key_cache` methods .
          For more information about the cache, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/#cache).
        * **Numeric key**: Dictionary key column name. The key column must be in the UInt64 data type.
          Used for `flat`, `hashed`, `cache`, and `range_hashed` methods.
          For more information about keys, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/#chislovoi-kliuch).
        * **Composite key**: Columns that make up the composite key of a dictionary. Specify the column IDs and their data types.
          Used for the `complex_key_hashed` and `complex_key_cache` methods.
          For more information about composite keys, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/#sostavnoi-kliuch).
        * **Start of range column** and **End of range column**: Columns indicating the start and end of the range for the `range_hashed` method.
          Specify the column IDs and their data types.
          For more information about ranges, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed).
        * **Data columns**: List of columns with dictionary data:
            * **Name**: Column name.
            * **Type**: Column data type.
            * **Default value**: Default value for an empty element.
              When loading a dictionary, all empty elements are replaced with this value.
              You can't use NULL in this field. Optional parameter.
            * **Expression**: [Expression](https://clickhouse.yandex/docs/en/query_language/syntax/#syntax-expressions) that {{ CH }} executes with the column value. Optional parameter.
            * **Hierarchical**: Hierarchical support flag.
            * **Injective**: Flag that shows whether the id -> attribute image is injective

       For more information about column parameters, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/#ext_dict_structure-attributes).

    1. Set how often the dictionary updates:

       {{ CH }} loads dictionaries to the RAM and periodically updates them.
       You can set a fixed update interval in seconds, or specify a time range for {{ CH }} to randomly select the time for update.
       This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers.

       For more information about dictionary updates, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_lifetime/).

- CLI

  {% note alert %}

  If the dictionary is added via the CLI, it cannot be managed via SQL.

  {% endnote %}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add an external dictionary to a {{ CH }} cluster:

    1. View a description of the CLI command for adding dictionaries:

       ```
       $ {{ yc-mdb-ch }} cluster add-external-dictionary --help
       ```

    1. Run the add dictionary command. Example of the command for a {{ PG }} dictionary:

       ```
       $ {{ yc-mdb-ch }} cluster add-external-dictionary \
          --name <{{ CH }} cluster name> \
          --dict-name <dictionary name> \
          --structure-id <key column name> \
          --structure-attribute name=<data column name>,type=<data type>,null-value=<empty element value >,expression=<expression>,hierarchical=<true|false>,injective=<true|false> \
          --fixed-lifetime <update interval in seconds> \
          --layout-type <flat|hashed|cache|range_hashed|complex_key_hashed|complex_key_cache> \
          --postgresql-source db=<source DB name>,table=<source table name>,port=<connection port>,user=<source DB user name>,password=<source DB password>,ssl-mode=<disable|allow|prefer|require|verify-ca|verify-full> \
          --postgresql-source-hosts <source DB hosts> \
       ```

- API

  {% note alert %}

  If the dictionary is added via the API, it cannot be managed via SQL.

  {% endnote %}

  You can add a dictionary using the [createExternalDictionary](../api-ref/Cluster/createExternalDictionary.md) method.

{% endlist %}

## Viewing a list of dictionaries {#get-dicts-list}

{% list tabs %}

- SQL
    1. [Connect](connect.md) to the desired database of the cluster {{ mch-name }} with the help of `clickhouse-client`.
    1. Execute  [the request](https://clickhouse.tech/docs/ru/sql-reference/statements/show/#show-dictionaries) `SHOW DICTIONARIES`.

- Management console
    1. Go to the folder page and select **{{ mch-name }}**.
    1. Click on the name of the cluster and open the **Dictionaries** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add an external dictionary to a {{ CH }} cluster:

    1. View a description of the CLI command for getting detailed cluster information:

       ```
       {{ yc-mdb-ch }} cluster get --help
       ```

    1. Run the command:

       ```
       {{ yc-mdb-ch }} cluster get <cluster name>
       ```

  The added dictionaries are displayed in the ```dictionaries:``` section of command execution results.

- API

  You can view a list of dictionaries and other cluster parameters using the [get](../api-ref/Cluster/get.md) method.

{% endlist %}

## Removing a dictionary {#delete-dictionary}

{% list tabs %}

- SQL
    1. [Connect](connect.md) to the desired database of the cluster {{ mch-name }} with the help of `clickhouse-client`.
    1. Execute [the request](https://clickhouse.tech/docs/ru/sql-reference/statements/drop/#drop-dictionary) `DROP DICTIONARY <database name>.<dictionary name>`.

- Management console
    1. Go to the folder page and click **{{ mch-name }}**.
    1. Click on the name of the cluster and open the **Dictionaries** tab.
    1. Click ![image](../../_assets/vertical-ellipsis.svg) in the line of the necessary host and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove an external dictionary:

    1. View a description of the CLI command to remove dictionaries:

       ```
       {{ yc-mdb-ch }} cluster remove-external-dictionary --help
       ```

    1. Run the command to remove a dictionary:

       ```
       {{ yc-mdb-ch }} cluster remove-external-dictionary \
       --name <cluster name> \
       --dict-name <dictionary name> \
       ```

- API

  You can remove a dictionary using the [deleteExternalDictionary](../api-ref/Cluster/deleteExternalDictionary.md) method.

{% endlist %}

