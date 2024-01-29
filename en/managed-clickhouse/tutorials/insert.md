---
title: "How to add data to a {{ CH }} cluster in {{ mch-full-name }}"
description: "Follow this guide to add data to your {{ CH }} cluster."
---

# Adding data to {{ CH }}

For regular data inserts into tables, use an `INSERT INTO` statement:

```sql
INSERT INTO db_name.table_name VALUES (v11, v12, v13), (v21, v22, v23), ...
```

Insert queries should be run no more than once per second. To group multiple small queries into a large one, use [buffering](#buffer-insert).

For more information about the `INSERT INTO` statement, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/insert-into#insert).

## Inserting data from a file {#file-insert}

To insert local file data into a table, use an `INSERT INTO` statement, such as:

```sql
INSERT INTO db_name.table_name FROM INFILE '<full_file_path>'
[COMPRESSION '<compression_format>'] FORMAT <data_format>;
```

With the `COMPRESSION` option, you can transfer compressed files. Use it to upload large amounts of data. The option is supported when using [clickhouse-client]({{ ch.docs }}/interfaces/cli) or [HTTP interface]({{ ch.docs }}/interfaces/http). If no compression format is specified, it is identified by the file extension. The compression format may take the following values: `none`, `gzip`, `deflate`, `br`, `xz`, `zstd`, `lz4`, and `bz2`.

For a list of supported data formats, see the [{{ CH }} documentation]({{ ch.docs }}/interfaces/formats). To learn how to set up Cap'n Proto and Protobuf data format schemas, see [Managing data format schemas](../operations/format-schemas.md).

## Inserting data through buffering {#buffer-insert}

When you insert data into {{ CH }}, a part of computing resources is used for performing housekeeping operations. Each time you run an `INSERT` query, {{ CH }} creates a separate data part in storage. In addition to table rows, parts like this contain auxiliary files with metadata. Next, {{ CH }} joins data parts in the background. The more join queries are required, the more resources will be used.

As a result, the load on the cluster from one thousand queries to insert a single row will exceed that from a single query to insert one thousand rows. Therefore, we recommend inserting data into tables in large chunks from 1,000 to 100,000 rows.

If small chunks of data are delivered from various sources, use one of the following buffering options:

* [Asynchronous inserts](#async-insert) (recommended)
* [Buffer tables](#buffer-table)

### Asynchronous data inserts {#async-insert}

If the [Async insert](../concepts/settings-list.md#setting-async-insert) setting is configured at the user level, all insert queries from this user first get to the in-memory buffer. Data from the buffer is flushed to a table if one of the following conditions is met:

* The buffer size has reached the [Async insert max data size](../concepts/settings-list.md#setting-async-insert-max-data-size) setting value.
* The time set in the [Async insert busy timeout](../concepts/settings-list.md#setting-async-insert-busy-timeout) setting has passed since the first `INSERT` query run after flushing the data.

To enable asynchronous data inserts, [set](../operations/update.md#change-clickhouse-config) the **Async insert** setting to `1`.

Note that [row deduplication](https://clickhouse.com/docs/en/guides/developer/deduplication) is not available when using asynchronous inserts.

For more information about asynchronous data inserts, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/cloud/bestpractices/asynchronous-inserts).

### Inserting data via a buffer table {#buffer-table}

A buffer table is created in RAM. It accumulates data it receives and then flushes the data to the main table if the preset conditions are met.

To create a buffer table, the `Buffer` table engine is used. It accepts the following basic parameters as an input:

```text
Buffer(database, table, num_layers, min_time, max_time, min_rows, max_rows, min_bytes, max_bytes)
```

Where:

* `database`: DB name.
* `table`: Name of the table to flush the data to.
* `num_layers`: Number of buffers. A table is physically stored in memory as multiple independent buffers.
* `min_time`, `max_time`, `min_rows`, `max_rows`, `min_bytes`, and `max_bytes`: Parameters that set conditions for flushing the data to the main table. The time is measured in seconds.

The data is flushed to the main table upon reaching all minimum values or one of the maximum values. If the size of a received chunk exceeds the `max_rows` or `max_bytes` value, the data is written to the main table directly rather than buffered.

To learn more about additional engine parameters and limits for tables based on the `Buffer` engine, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/special/buffer).

#### Example {#buffer-table-example}

1. Create a regular table named `users` in `db1`:

   ```sql
   CREATE TABLE IF NOT EXISTS db1.users (id UInt64, name String)
   ENGINE = MergeTree() ORDER BY id;
   ```

1. Create a buffer table named `users_buffer` and link it to the `users` main table:

   ```sql
   CREATE TABLE db1.users_buffer AS db1.users ENGINE = Buffer(db1, users, 1, 10, 100, 10000, 1000000, 10000000, 100000000);
   ```

1. Send data to the buffer table:

   ```sql
   INSERT INTO db1.users_buffer VALUES (1, 'Vlad'), (2, 'John'), (3, 'Zara');
   ```

1. Check data in the main table, it will appear there in 100 seconds (`max_time`):

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

## Inserting data and specifying the format schema {#insert-with-format-schema}

{% include [Format schemas intro](../../_includes/mdb/mch/format-schemas-intro.md) %}

## Example of using a format schema when inserting data {#example}

**The example was tested in the following environment:**
- Virtual machine in {{ yandex-cloud }} running Ubuntu 20.04 LTS.
- Bash: `5.0.16`.
- clickhouse-client: `20.10.2.20`.
- capnproto: `0.7.0`.
- protobuf-compiler: `3.6.1`.
- Python: `3.8.5`; pip3: `20.0.2`.

Let's say a single-host {{ mch-name }} `chcluster` cluster is created with the `db1` database and you need to insert user data into the `db1.users` table. Let's assume that each user record contains the following information:
- User `id`.
- User `name`.

To insert user data in the Cap'n Proto and Protobuf formats into the `db1.users` table:
1. [Install dependencies](#satisfy-dependencies).
1. [Prepare data format schemas](#prepare-format-schemas).
1. [Prepare scripts](#prepare-scripts).
1. [Insert data](#insert-data).


### Getting started {#before-you-begin}

1. Examine the data format that will be used for insertion so that the correct format schemas are [prepared](#prepare-format-schemas).

   In this scenario, for demonstration, it is assumed that:
   - The user's `id` is represented as an unsigned 64-bit integer (`Uint64` in Cap'n Proto and {{ CH }}, and `uint64` in Protobuf).
   - The username `name` is presented in the form of a string (`Text` in Cap'n Proto, `string` in Protobuf, and `String` in {{ CH }}).

   To learn more about supported data types, see the documentation for [Cap'n Proto](https://capnproto.org/language.html), [Protobuf](https://developers.google.com/protocol-buffers/docs/proto3), and [{{ CH }}]({{ ch.docs }}/sql-reference/data-types/).

1. [Connect to the cluster](../operations/connect.md) and create the `db1.users` table of the preferred format, if you have not created it yet:

   ```sql
   CREATE TABLE IF NOT EXISTS db1.users (id UInt64, name String)
   ENGINE = MergeTree() ORDER BY id;
   ```


### Installing dependencies {#satisfy-dependencies}

```bash
sudo apt update && sudo apt install -y python3 python3-pip capnproto protobuf-compiler && \
pip3 install protobuf varint pycapnp
```


### Preparing format schemas {#prepare-format-schemas}

1. Create a file with a schema description:

   {% list tabs group=data_format %}

   - Cap'n Proto {#capn}

      `user.capnp`
      ```
      @0xbec0f3f99cec4fbf;

      struct User {
        id @0 :UInt64;
        name @1 :Text;
      }
      ```

      To learn more about the file format, see the [documentation for Cap'n Proto](https://capnproto.org/language.html).

   - Protobuf {#protobuf}

      `user.proto`
      ```
      syntax = "proto3";

      message User {
        uint64 id = 1;
        string name = 2;
      };
      ```

      To learn more information about the file format, see the [documentation for Protobuf](https://developers.google.com/protocol-buffers/docs/overview).

   {% endlist %}


1. [Upload the file](../../storage/operations/objects/upload.md) to {{ objstorage-name }} and [get a link](../../storage/operations/objects/link-for-download.md) to it.


1. [Connect the format schema](../operations/format-schemas.md#add-format-schema) to the `chcluster` cluster:
   - For the Cap'n Proto format schema (`user.capnp` file), set the name `schema-capnproto`.
   - For the Protobuf format schema, (`user.protobuf` file), set the name `schema-protobuf`.


### Preparing scripts {#prepare-scripts}

These Python scripts prepare test data about users in the appropriate formats and insert them into a cluster table.

{% note info %}

Python scripts are provided for demonstration. You can prepare and insert binary data in the required format by creating a similar script in a different programming language.

{% endnote %}

To prepare scripts:
1. Compile the `user.proto` Protobuf schema file for Python:

   ```bash
   protoc user.proto --python_out .
   ```

   The `user_pb2.py` file will be generated.

1. Create files with Python code:

   {% list tabs group=data_format %}

   - Cap'n Proto {#capn}

      `capnproto-example.py`
      ```python
      import requests
      import io
      import capnp
      from user_capnp import User

      DB_HOST="<FQDN_of_the_{{ CH }}_host>"
      DB_NAME="db1"
      DB_USER="<DB_user_name>"
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

      This script:
      1. Gets the `User` class from the connected `user.capnp` (`from user_capnp import User`).
      1. Executes requests to the cluster over HTTPS using SSL.
      1. Writes the test dataset to the User class object (`def add_user ...`) and adds this object to the `message` I/O bitstream.
      1. Inserts the data from the `message` bitstream to the `db1.users` table based on the `User` class data from the `schema-capnproto` format schema in the cluster.

   - Protobuf {#protobuf}

      `protobuf-example.py`
      ```python
      import requests
      import io
      import varint
      from user_pb2 import User

      DB_HOST="<FQDN_of_the_{{ CH }}_host>"
      DB_NAME="db1"
      DB_USER="<DB_user_name>"
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

      This script:
      1. Gets the `User` class from the connected `user_pb2.py` file, which was received after the proto file was compiled (`from user_pb2 import User`).
      1. Writes the test dataset to the User class object (`def add_user ...`) and adds this object to the `message` I/O bitstream.
      1. Inserts data from the `message` bitstream to the `db1.users` table based on the `User` class data from the `schema-protobuf` format schema in the cluster.

   {% endlist %}

   To learn how to get a host FQDN, see [this guide](../operations/connect.md#fqdn).

### Inserting data {#insert-data}

1. Run the scripts you prepared [previously](#prepare-scripts):

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

1. [Connect to the cluster](../operations/connect.md) and make sure that the data was successfully inserted by running the `SELECT` query:

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
