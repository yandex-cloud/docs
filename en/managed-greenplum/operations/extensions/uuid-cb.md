# Using uuid-cb in {{ mgp-name }}

The `uuid-cb` extension exports functions for generating and validating unique IDs in compliance with the Russian Central Bank requirements:

* `uuid_cb_generate()`: Generates a `text` value that is a unique ID in the format required by the Russian Central Bank.
* `uuid_cb_valid(text)`: Returns a `boolean` value that indicates if a text argument is a unique ID in the format required by the Russian Central Bank.

## Installing the uuid-cb extension in a {{ GP }} cluster {#uuid-cb-install}

1. [Connect to the database](../connect.md) as the owner or a user with the `CREATE` permission and run the command:

   ```sql
   CREATE EXTENSION "uuid-cb";
   ```

1. Make sure that the extension is installed:

   ```sql
   SELECT extname FROM pg_extension;
   ```

## Usage example

1. Create a table with unique IDs and data such as:

   ```sql
   CREATE TABLE uid_tbl (
       uid TEXT NOT NULL DEFAULT uuid_cb_generate() CHECK (uuid_cb_valid(uid) = true),
       data INTEGER NOT NULL,
       PRIMARY KEY (uid)
       )
   DISTRIBUTED BY(uid);
   ```

   The unique IDs in the format required by the Russian Central Bank will be generated in the `uid` column as default values. A check doesn't allow inserting values that are not unique IDs in the format required by the Russian Central Bank.

1. Insert the test data into the `data` column:

   ```sql
   INSERT INTO uid_tbl (data)
   SELECT d FROM generate_series(1, 10) d;
   ```

   For each command run, pseudorandom ID values are generated.

1. Check the generated data:

   ```sql
   SELECT * FROM uid_tbl;
   ```

   Result:

   ```text
                     uid                   | data 
   ----------------------------------------+------
    4b68f587-6739-11ed-80d4-1b1dc5b7125e-1 |    8
    4b68f589-6739-11ed-80d4-1b1dc5b7125e-1 |   10
    4b68f581-6739-11ed-80d4-1b1dc5b7125e-1 |    2
    4b68f583-6739-11ed-80d4-1b1dc5b7125e-1 |    4
    4b68f585-6739-11ed-80d4-1b1dc5b7125e-1 |    6
    4b68f588-6739-11ed-80d4-1b1dc5b7125e-9 |    9
    4b68f580-6739-11ed-80d4-1b1dc5b7125e-9 |    1
    4b68f582-6739-11ed-80d4-1b1dc5b7125e-9 |    3
    4b68f584-6739-11ed-80d4-1b1dc5b7125e-9 |    5
    4b68f586-6739-11ed-80d4-1b1dc5b7125e-9 |    7
   (10 rows)
   ```

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
