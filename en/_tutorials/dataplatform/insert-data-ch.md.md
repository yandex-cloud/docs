# Adding data to {{ CH }}

To insert data into a table, use an `INSERT INTO` statement:

```sql
INSERT INTO db_name.table_name VALUES (v11, v12, v13), (v21, v22, v23), ...
```

We recommend sending insert queries no more than once per second. You can use [buffering](#buffer-insert) to combine multiple small queries into a single large one.

Learn more about `INSERT INTO` from this [{{ CH }} guide]({{ ch.docs }}{{ lang }}/sql-reference/statements/insert-into#insert).

## Inserting data from a file {#file-insert}

To insert data into a table from a local file, use the `INSERT INTO` statement in the following format:

```sql
INSERT INTO db_name.table_name FROM INFILE '<full_path_to_file>'
[COMPRESSION '<compression_format>'] FORMAT <data_format>;
```

The `COMPRESSION` allows you to transfer compressed files, which is perfect for uploading large amounts of data. This option is supported when working through the [clickhouse-client]({{ ch.docs }}{{ lang }}/interfaces/cli) or the [HTTP interface]({{ ch.docs }}{{ lang }}/interfaces/http). If the compression format is not specified, the system determines it based on the file extension. Supported compression formats: `none`, `gzip`, `deflate`, `br`, `xz`, `zstd`, `lz4`, and `bz2`.

For a list of supported data formats, refer to this [{{ CH }} guide]({{ ch.docs }}{{ lang }}/interfaces/formats). To learn how to set up Cap'n Proto and Protobuf data format schemas, see [Managing data format schemas](../../managed-clickhouse/operations/format-schemas.md).

## Inserting data using buffering {#buffer-insert}

When inserting data into {{ CH }}, a portion of the computational resources is consumed by overhead operations. Each `INSERT` query creates a new data part in {{ CH }} storage. In addition to the data rows, each part contains auxiliary metadata files. To reduce the number of data parts, {{ CH }} merges them in the background. The more merge operations required, the more resources are consumed.

As a result, a thousand individual insert queries will impose more load on the cluster than a single query inserting one thousand rows. Therefore, we recommend inserting data in batches of 1,000 to 100,000 rows.

If data arrives in small batches from different sources, use one of the following buffering mechanisms:

* [Asynchronous inserts](#async-insert) (recommended)
* [Buffer tables](#buffer-table)

### Asynchronous inserts {#async-insert}

If the [Async insert](../../managed-clickhouse/concepts/settings-list.md#setting-async-insert) setting is enabled for a user, then all insert queries from that user are first buffered in RAM. Data is flushed from the buffer to the destination table when one of the following conditions is met:

* The buffer size reaches the [Async insert max data size](../../managed-clickhouse/concepts/settings-list.md#setting-async-insert-max-data-size) setting.
* The time since the first `INSERT` after the last buffer flush exceeds the value of the [Async busy timeout](../../managed-clickhouse/concepts/settings-list.md#setting-async-insert-busy-timeout) setting.

To enable asynchronous data inserts, [set](../../managed-clickhouse/operations/change-query-level-settings.md#yandex-cloud-interfaces) **Async insert** to `1`.

Note that asynchronous inserts do not support [row deduplication]({{ ch.docs }}{{ lang }}/guides/developer/deduplication).

For more details about asynchronous data inserts, see this [{{ CH }} guide]({{ ch.docs }}{{ lang }}/best-practices/use-materialized-views).

### Using a buffer table for inserts {#buffer-table}

A buffer table, created in RAM, accumulates incoming data and flushes it to the target table once preset conditions are met.

To create a buffer table,  use the `Buffer` table engine. It requires the following parameters:

```text
Buffer(database, table, num_layers, min_time, max_time, min_rows, max_rows, min_bytes, max_bytes)
```

Where:

* `database`: Database name.
* `table`: Target table name.
* `num_layers`: Number of buffers. A table is physically stored in memory as multiple independent buffers.
* `min_time`, `max_time`, `min_rows`, `max_rows`, `min_bytes`, and `max_bytes`: Conditions for flushing data from the buffer to the target table. The time is specified in seconds.

Flushing occurs when all minimum conditions are satisfied, or when any one of the maximum limits is reached. If the size of incoming data batch exceeds the `max_rows` or `max_bytes` settings, the system writes it directly to the target table, bypassing the buffer.

For details on additional `Buffer` engine parameters and table limitations, see this [{{ CH }} guide]({{ ch.docs }}{{ lang }}/engines/table-engines/special/buffer).

#### Example {#buffer-table-example}

1. Create a regular table named `users` in the `db1` database:

    ```sql
    CREATE TABLE IF NOT EXISTS db1.users (id UInt64, name String)
    ENGINE = MergeTree() ORDER BY id;
    ```

1. Create a buffer table named `users_buffer` linked to the target table `users`:

    ```sql
    CREATE TABLE db1.users_buffer AS db1.users ENGINE = Buffer(db1, users, 1, 10, 100, 10000, 1000000, 10000000, 100000000);
    ```

1. Insert data into the buffer table:

    ```sql
    INSERT INTO db1.users_buffer VALUES (1, 'Vlad'), (2, 'John'), (3, 'Zara');
    ```

1. Verify the data appears in the target table within the `max_time` interval of 100 seconds:

    ```sql
    SELECT * FROM db1.users;
    ```

Result:

```text
┌─id─┬─name─┐
│  1 │ Vlad │
│  2 │ John │
│  3 │ Zara │
└────┴──────┘
```

## Data insertion with schema specification {#insert-with-format-schema}

{% include [Format schemas intro](../../_includes/mdb/mch/format-schemas-intro.md) %}

## Example of using a schema for data insertion {#example}

**This example was tested in the following environment**:
- Yandex Cloud VM running Ubuntu 20.04 LTS.
- Bash: `5.0.16`.
- clickhouse-client: `20.10.2.20`.
- capnproto: `0.7.0`.
- protobuf-compiler: `3.6.1`.
- Python: `3.8.5`; pip3: `20.0.2`.

Suppose you have created a single-host {{ mch-name }} cluster named `chcluster` with a database named `db1`. You need to insert user data into the `db1.users` table, where each record contains the following information:
- `id`: User ID.
- `name`: Username.

To insert Cap'n Proto and Protobuf user data into the `db1.users` table:
1. [Install the dependencies](#satisfy-dependencies).
1. [Prepare the schemas](#prepare-format-schemas).
1. [Prepare scripts](#prepare-scripts).
1. [Insert data](#insert-data).


### Getting started {#before-you-begin}

1. Examine the input data format in order to  [prepare](#prepare-format-schemas) the appropriate schema definitions.

   In our demonstration example, we assume the following:
   - The user ID (`id`) is an unsigned 64-bit integer (`Uint64` in Cap'n Proto and {{ CH }}, and `uint64` in Protobuf).
   - The username (`name`) is a string (`Text` in Cap'n Proto, `string` in Protobuf, `String` in {{ CH }}).

   For more information on supported data types, see the relevant [Cap'n Proto](https://capnproto.org/language.html), [Protobuf](https://developers.google.com/protocol-buffers/docs/proto3), and [{{ CH }} guides]({{ ch.docs }}{{ lang }}/sql-reference/data-types).

1. [Connect to the cluster](../../managed-clickhouse/operations/connect/clients.md) and create the `db1.users` table if it does not exist, using the required schema:

   ```sql
   CREATE TABLE IF NOT EXISTS db1.users (id UInt64, name String)
   ENGINE = MergeTree() ORDER BY id;
   ```


### Installing dependencies {#satisfy-dependencies}

```bash
sudo apt update && sudo apt install -y python3 python3-pip capnproto protobuf-compiler && \
pip3 install protobuf varint pycapnp
```


### Defining the schemas {#prepare-format-schemas}

1. Create a schema definition file:

   {% list tabs group=data_format %}

   - Cap'n Proto {#capn}

     `user.capnp`
     ```capnproto
     @0xbec0f3f99cec4fbf;

     struct User {
       id @0 :UInt64;
       name @1 :Text;
     }
     ```

     For file format details, see this [Cap'n Proto guide](https://capnproto.org/language.html).

   - Protobuf {#protobuf}

     `user.proto`
     ```capnproto
     syntax = "proto3";

     message User {
       uint64 id = 1;
       string name = 2;
     };
     ```

     For file format detials, see this [Protobuf guide](https://developers.google.com/protocol-buffers/docs/overview).

   {% endlist %}


1. [Upload the file](../../storage/operations/objects/upload.md) to {{ objstorage-name }} and [retrieve its public URL](../../storage/operations/objects/link-for-download.md).


1. [Add your schema](../../managed-clickhouse/operations/format-schemas.md#add-format-schema) to the `chcluster` cluster:
   - For the Cap'n Proto schema (`user.capnp`), use the name `schema-capnproto`.
   - For the Protobuf schema (`user.protobuf`), use the name `schema-protobuf`.


### Preparing scripts {#prepare-scripts}

The following Python scripts generate test user data in required formats and insert it into your cluster table.

{% note info %}

Python is used here solely for demonstration. The core logic of generating binary data in required format and inserting it into the table can be implemented in any programming language.

{% endnote %}

To prepare the scripts:
1. Generate the Python code from the `user.proto` Protobuf schema file:

   ```bash
   protoc user.proto --python_out .
   ```

   This command will generate the `user_pb2.py` file.

1. Create files with the following Python code:

   {% list tabs group=data_format %}

   - Cap'n Proto {#capn}

     `capnproto-example.py`
     ```python
     import requests
     import io
     import capnp
     from user_capnp import User

     DB_HOST="<{{ CH }}>_host_FQDN"
     DB_NAME="db1"
     DB_USER="<DB_username>"
     DB_PASS="<DB_user_password>"
     CA_CERT="{{ crt-local-dir }}{{ crt-local-file-root }}"

     SCHEMA_NAME = 'schema-capnproto'
     SCHEMA_TYPE = "CapnProto"
     SCHEMA_CLASS = "User"

     def execute_query(query, data=None):
         url = 'https://{host}:8443/'.format(host=DB_HOST)
         params = {
             'database': DB_NAME,
             'query': query.strip()
         }
         auth = {
             'X-ClickHouse-User': DB_USER,
             'X-ClickHouse-Key': DB_PASS
         }

         rs = requests.post(url,
                            params=params,
                            headers=auth,
                            data=data,
                            verify=CA_CERT)

         rs.raise_for_status()

     def add_user(fileobj, user_id, user_name):
         user = User.new_message()
         user.id = user_id
         user.name = user_name

         fileobj.write(user.to_bytes())

     message = io.BytesIO()

     add_user(message, 11, 'John')
     add_user(message, 12, 'Bob')
     add_user(message, 13, 'Jane')

     execute_query(
         '''
         INSERT INTO {database}.users SETTINGS format_schema='{name}:{cls}' FORMAT {type}
         '''.format(database=DB_NAME,
                    type=SCHEMA_TYPE,
                    name=SCHEMA_NAME,
                    cls=SCHEMA_CLASS), data=message.getvalue())
     ```

     The script above does the following:
     1. Imports the `User` class generated from the `user.capnp` schema (`from user_capnp import User`).
     1. Queries the cluster via HTTPS with SSL encryption.
     1. Creates a User class object, populates it with the test dataset, (`def add_user ...`) and serializes it into a `message` bitstream for I/O.
     1. Deserializes the `message` bitstream into the `User` object using the `schema-capnproto` schema and inserts the resulting data into the `db1.users` cluster table.

   - Protobuf {#protobuf}

     `protobuf-example.py`
     ```python
     import requests
     import io
     import varint
     from user_pb2 import User

     DB_HOST="<{{ CH }}>_host_FQDN"
     DB_NAME="db1"
     DB_USER="<DB_username>"
     DB_PASS="<DB_user_password>"
     CA_CERT="{{ crt-local-dir }}{{ crt-local-file-root }}"

     SCHEMA_NAME = 'schema-protobuf'
     SCHEMA_TYPE = "Protobuf"
     SCHEMA_CLASS = "User"

     def execute_query(query, data=None):
         url = 'https://{host}:8443/'.format(host=DB_HOST)
         params = {
             'database': DB_NAME,
             'query': query.strip()
         }
         auth = {
             'X-ClickHouse-User': DB_USER,
             'X-ClickHouse-Key': DB_PASS
         }

         rs = requests.post(url,
                            params=params,
                            headers=auth,
                            data=data,
                            verify=CA_CERT)

         rs.raise_for_status()

     def add_user(fileobj, user_id, user_name):
         user = User()
         user.id = user_id
         user.name = user_name

         fileobj.write(varint.encode(user.ByteSize()))
         fileobj.write(user.SerializeToString())

     message = io.BytesIO()
     add_user(message, 21, 'Stephen')
     add_user(message, 22, 'Olivia')
     add_user(message, 23, 'Tim')

     execute_query(
         '''INSERT INTO {database}.users SETTINGS format_schema='{name}:{cls}' FORMAT {type}
         '''.format(database=DB_NAME,
                    type=SCHEMA_TYPE,
                    name=SCHEMA_NAME,
                    cls=SCHEMA_CLASS), data=message.getvalue())
     ```

     The script above does the following:
     1. Imports the `User` class from the `user_pb2.py` module generated by compiling the relevant proto file (`from user_pb2 import User`).
     1. Creates a User class object, populates it with the test dataset, (`def add_user ...`) and serializes it into a `message` bitstream for I/O.
     1. Deserializes the `message` bitstream into the `User` object using the `schema-protobuf` schema and inserts the resulting data into the `db1.users` cluster table.

   {% endlist %}

   To learn how to get a host’s FQDN, see [this guide](../../managed-clickhouse/operations/connect/fqdn.md).

### Inserting data {#insert-data}

1. Run the scripts you prepared [at the previous step](#prepare-scripts):

   {% list tabs group=data_format %}

   - Cap'n Proto {#capn}

     ```bash
     python3 capnproto-example.py
     ```

   - Protobuf {#protobuf}

     ```bash
     python3 protobuf-example.py
     ```

   {% endlist %}

1. [Connect to the cluster](../../managed-clickhouse/operations/connect/clients.md) and verify the data was inserted by running the `SELECT` query:

   {% list tabs group=data_format %}

   - Cap'n Proto {#capn}

     ```sql
     SELECT * FROM db1.users;

     ┌─id─┬─name─┐
     │ 11 │ John │
     │ 12 │ Bob  │
     │ 13 │ Jane │
     └────┴──────┘
     ```

   - Protobuf {#protobuf}

     ```sql
     SELECT * FROM db1.users;

     ┌─id─┬─name────┐
     │ 21 │ Stephen │
     │ 22 │ Olivia  │
     │ 23 │ Tim     │
     └────┴─────────┘
     ```

   {% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
