# Exporting {{ GP }} data to a cold storage


In a {{ mgp-full-name }} cluster, you can enable [hybrid storage](../../../managed-greenplum/concepts/hybrid-storage.md) for [append-optimized (AO) and append-optimized column-oriented (AOCO) tables](../../../managed-greenplum/concepts/tables.md). With this done, the [{{ YZ }} extension](../../../managed-greenplum/operations/extensions/yezzey.md) can transfer data in such tables from a cluster storage to a cold storage.

Cold storage is a convenient option if you need to store your data for a long time without using it much. This will make data storage [less costly](../../../managed-greenplum/pricing/index.md#rules-storage).


{% note info %}

This feature is at the [Preview](../../../overview/concepts/launch-stages.md) stage and free of charge.

{% endnote %}


To transfer your data from a cluster storage to a cold storage:

1. [Export the {{ GP }} table to a cold storage](#transfer).
1. [Check the result](#check).

You can also [transfer your data back](#offload-to-local-storage) to a cluster storage.

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mgp-name }} cluster fee: Using computing resources allocated to hosts and disk space (see [{{ GP }} pricing](../../../managed-greenplum/pricing/index.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).


## Getting started {#before-you-begin}

1. [Create a {{ mgp-name }} cluster](../../../managed-greenplum/operations/cluster-create.md). When creating a cluster, make sure to enable **{{ ui-key.yacloud.greenplum.section_cloud-storage }}**.

   {% note info %}

   You cannot disable this option after you save your cluster settings.

   {% endnote %}

1. Get an SSL certificate to connect to the {{ GP }} database:

   {% include [install-certificate](../../../_includes/mdb/mgp/install-certificate.md) %}

   {% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Export the {{ GP }} table to a cold storage {#transfer}

1. Connect to the cluster:

   {% include [default-connstring](../../../_includes/mdb/mgp/default-connstring.md) %}

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

1. Transfer the `ao_table` data to a cold storage:

   ```bash
   SELECT yezzey_define_offload_policy('ao_table');
   ```

## Check the result {#check}

1. Check how much of the cluster local cache and cold storage is used by:

   * `ao_table`:

      ```bash
      SELECT * FROM yezzey_offload_relation_status('ao_table');
      ```

   * Each segment file in `ao_table`:

      ```bash
      SELECT * FROM yezzey_offload_relation_status_per_filesegment('ao_table');
      ```

   If there are non-zero values in each `external_bytes` column in the command output, the table was successfully transferred to a cold storage.

1. Check which table segment files are now in the cold storage:

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

## Move the table from the cold storage to the cluster storage {#offload-to-local-storage}

To move `ao_table` from the cold storage back to the cluster storage, run this command:

```bash
SELECT yezzey_load_relation('ao_table');
```

## Delete the resources you created {#clear-out}

If you no longer need the cluster you created, [delete it](../../../managed-greenplum/operations/cluster-delete.md).
