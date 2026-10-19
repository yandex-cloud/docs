# Exporting {{ GP }} data to a hybrid storage


In a {{ GP }} cluster, you can enable [hybrid storage](../../../managed-greenplum/concepts/hybrid-storage.md) for [append-optimized (AO) and append-optimized column-oriented (AOCO) tables](../../../managed-greenplum/concepts/tables.md). Then you can use the [{{ YZ }} extension](../../../managed-greenplum/operations/extensions/yezzey.md) to transfer such tables' data from a cluster storage to a hybrid storage.

Hybrid storage is a convenient option if you need to store your data for a long time without using it much. This will make data storage [less costly](../../../managed-greenplum/pricing/index.md#rules-storage).

To transfer your data from a cluster storage to a hybrid storage:

1. [Export the {{ GP }} table to a hybrid storage](#transfer).
1. [Check the result](#check).

You can also [transfer your data back](#offload-to-local-storage) to a cluster storage.

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mgp-name }} cluster: use of computing resources allocated to hosts, storage and backup size (see [{{ mgp-name }} pricing](../../../managed-greenplum/pricing/index.md)).
* {{ objstorage-full-name }} bucket: use of storage, data operations (see [{{ objstorage-name }} pricing](../../../storage/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).


## Getting started {#before-you-begin}

1. [Create a {{ GP }} cluster](../../../managed-greenplum/operations/cluster-create.md). When creating a cluster, make sure to enable **{{ ui-key.yacloud.greenplum.section_cloud-storage }}**.

   {% note info %}

   You cannot disable this option after you save your cluster settings.

   {% endnote %}

1. Get an SSL certificate to connect to the {{ GP }} database:

   {% include [install-certificate](../../../_includes/mdb/mgp/install-certificate.md) %}

   {% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Export the {{ GP }} table to a hybrid storage {#transfer}

1. Connect to the cluster:

   ```bash
   psql "host=c-<cluster_ID>.rw.{{ dns-zone }} \
   port={{ port-mgp }} \
   sslmode=verify-full \
   dbname=postgres \
   user=<username> \
   target_session_attrs=read-write"
   ```

1. Create a database named `db_with_yezzey`:

   ```bash
   CREATE DATABASE db_with_yezzey;
   ```

   The new DB will be granted permissions to install extensions. These permissions are not granted for the default DB.

1. Connect to the new DB:

   ```bash
   \connect db_with_yezzey
   ```

1. Create a {{ YZ }} extension:

   ```bash
   CREATE EXTENSION yezzey;
   ```

1. Create an AO table named `ao_table`:

   ```bash
   CREATE TABLE ao_table (a int)
       WITH (appendoptimized=true)
       DISTRIBUTED BY (a);
   ```

1. Populate the table with a series of integers from 1 through 10,000:

   ```bash
   INSERT INTO ao_table SELECT * FROM GENERATE_SERIES(1, 10000);
   ```

1. Transfer `ao_table` data to a hybrid storage:

   ```bash
   SELECT yezzey_define_offload_policy('ao_table');
   ```

## Check the result {#check}

1. Check how much space in the cluster local cache and hybrid storage is used by:

   * `ao_table`:

      ```bash
      SELECT * FROM yezzey_offload_relation_status('ao_table');
      ```

   * Each segment file of `ao_table`:

      ```bash
      SELECT * FROM yezzey_offload_relation_status_per_filesegment('ao_table');
      ```

   If there are non-zero values in the `external_bytes` column of the command output, the table was successfully transferred to a hybrid storage.

1. Check which table segment files are now in the hybrid storage:

   ```bash
   SELECT * FROM yezzey_relation_describe_external_storage_structure('ao_table');
   ```

1. Make sure you can read data from the transferred table:

   ```bash
   SELECT AVG(a) FROM ao_table;
   ```

   Result:

   ```text
             avg          
   -----------------------
    5000.5000000000000000
   (1 row)
   ```

1. Make sure you can write data to the transferred table:

   1. Add a series of integers 1 through 10,000 to `ao_table`:

      ```bash
      INSERT INTO ao_table SELECT * FROM GENERATE_SERIES(1, 10000);
      ```

   1. Make sure the number of rows has doubled:

      ```bash
      SELECT COUNT(1) FROM ao_table;
      ```

      Result:

      ```text
       count
      -------
       20000
      (1 row)
      ```

## Move a table from a hybrid storage to a cluster storage {#offload-to-local-storage}

To move the table named `ao_table` from a hybrid storage back to a cluster storage, run this command:

```bash
SELECT yezzey_load_relation('ao_table');
```

## Delete the resources you created {#clear-out}

If you no longer need the cluster you created, [delete it](../../../managed-greenplum/operations/cluster-delete.md).
