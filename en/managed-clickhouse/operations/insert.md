# Adding data to {{ CH }}

## Normal data insertion {#general-insert}

To add data to the database as part of a normal routine, use the `INSERT` statement described in the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/statements/insert-into/). The `INSERT` queries should be sent no more than once per second.

To upload large data, use data compression during transmission: for example, you can enable it for HTTP or `clickhouse-client`. To learn more, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/interfaces/).

## Inserting data and specifying the format schema {#insert-with-format-schema}

{% include [mch-format-schemas-intro](../../_includes/mdb/mch-format-schemas-intro.md) %}

## Example of using a format schema when inserting data {#example}

**The example was tested in the following environment:**
- Virtual machine in {{ yandex-cloud }} running Ubuntu 20.04 LTS.
- Bash: `5.0.16`.
- clickhouse-client: `20.10.2.20`.
- capnproto: `0.7.0`.
- protobuf-compiler: `3.6.1`.
- Python: `3.8.5`; pip3: `20.0.2`.

Let's say a single-host {{ mch-name }} `chcluster` cluster is created with the `db1` database and you need to insert user data into the `db1.users` table. Let's assume that each user record contains the following information:
- The `id` of the user.
- The username `name`.

To insert user data in the Cap'n Proto and Protobuf formats into the `db1.users` table:
1. [Install dependencies](#satisfy-dependencies).
1. [Prepare data format schemas](#prepare-format-schemas).
1. [Prepare scripts](#prepare-scripts).
1. [Insert data](#insert-data).


## Before you begin {#before-you-begin}

1. Examine the data format that will be used for insertion so that the correct format schemas are [prepared](#prepare-format-schemas).

   In this scenario, for demonstration, it is assumed that:
   - The user's `id` is represented as an unsigned 64-bit integer (`Uint64` in Cap'n Proto and {{ CH }}, and `uint64` in Protobuf).
   - The username `name` is presented in the form of a string (`Text` in Cap'n Proto, `string` in Protobuf, and `String` in {{ CH }}).

   To learn more about supported data types, see the documentation for [Cap'n Proto](https://capnproto.org/language.html), [Protobuf](https://developers.google.com/protocol-buffers/docs/proto3), and [{{ CH }}](https://{{ ch-domain }}/docs/en/sql-reference/data-types/).

1. [Connect to the cluster](connect.md) and create the `db1.users` table of the desired type, if you haven't created it yet:

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

   {% list tabs %}

   - Cap'n Proto

      `user.capnp`
      ```
      @0xbec0f3f99cec4fbf;

      struct User {
        id @0 :UInt64;
        name @1 :Text;
      }
      ```

      To learn more about the file format, see the [documentation for Cap'n Proto](https://capnproto.org/language.html).

   - Protobuf

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


1. [Connect the format schema](format-schemas.md#add-format-schema) to the `chcluster` cluster:
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

   {% list tabs %}

   - Cap'n Proto

      `capnproto-example.py`
      ```python
      import requests
      import io
      import capnp
      from user_capnp import User

      DB_HOST="<FQDN of the {{ CH }} host>"
      DB_NAME="db1"
      DB_USER="<DB user name>"
      DB_PASS="<DB user password>"
      CA_CERT="{{ crt-local-dir }}{{ crt-local-file }}"

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
          INSERT INTO {database}.users FORMAT {type} SETTINGS format_schema='{name}:{cls}'
          '''.format(database=DB_NAME,
                     type=SCHEMA_TYPE,
                     name=SCHEMA_NAME,
                     cls=SCHEMA_CLASS), data=message.getvalue())
      ```

      This script:
      1. Gets the `User` class from the connected `user.capnp` (`from user_capnp import User`).
      1. Executes requests to the cluster over HTTPS using SSL.
      1. Writes the test dataset to the User class object (`def add_user ...`) and adds this object to the `message` I/O bitstream.
      1. Inserts the data from the `message` bitstream to the `db1.users` table based on data of the `User` from the format schema `schema-capnproto` in the cluster.

   - Protobuf

      `protobuf-example.py`
      ```python
      import requests
      import io
      import varint
      from user_pb2 import User

      DB_HOST="<FQDN of the {{ CH }} host>"
      DB_NAME="db1"
      DB_USER="<DB user name>"
      DB_PASS="<DB user password>"
      CA_CERT="{{ crt-local-dir }}{{ crt-local-file }}"

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
          '''INSERT INTO {database}.users FORMAT {type} SETTINGS format_schema='{name}:{cls}'
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


### Inserting data {#insert-data}

1. Run the scripts you prepared [previously](#prepare-scripts):

   {% list tabs %}

   - Cap'n Proto

      ```bash
      python3 capnproto-example.py
      ```

   - Protobuf

      ```bash
      python3 protobuf-example.py
      ```

   {% endlist %}

1. [Connect to the cluster](connect.md) and make sure that the data was successfully inserted by running the `SELECT` query:

   {% list tabs %}

   - Cap'n Proto

      ```sql
      SELECT * FROM db1.users;

      ┌─id─┬─name─┐
      │ 11 │ John │
      │ 12 │ Bob  │
      │ 13 │ Jane │
      └────┴──────┘
      ```

   - Protobuf

      ```sql
      SELECT * FROM db1.users;

      ┌─id─┬─name────┐
      │ 21 │ Stephen │
      │ 22 │ Olivia  │
      │ 23 │ Tim     │
      └────┴─────────┘
      ```

   {% endlist %}
