# Exporting {{ GP }} data to a cold storage

{{ mgp-full-name }} data is stored on cluster disks. Using a [{{ YZ }} extension](https://github.com/yezzey-gp/yezzey/) from {{ yandex-cloud }}, you can move this data to a cold storage in {{ objstorage-full-name }}. This way, it will be stored in a service bucket in a compressed and encrypted form. It is convenient if you need to store your data for a long time while rarely using it. This will make data storage [less costly](../../storage/pricing.md).

{{ YZ }} supports append-optimized (AO) and append-optimized column-oriented (AOCO) tables. For more information about the tables, see [{#T}](../../managed-greenplum/concepts/tables.md) and the [{{ GP }} documentation](https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/admin_guide-ddl-ddl-storage.html).


{% note info %}

This functionality is at the [Preview](../../overview/concepts/launch-stages.md) stage and is free of charge.

{% endnote %}


To transfer your data from {{ mgp-name }} cluster disks to the cold storage in {{ objstorage-name }}:

1. [Transfer a {{ GP }} table to {{ objstorage-name }}](#transfer).
1. [Check the result](#check).

You can also [transfer your data back](#offload-to-local-storage) to cluster disks.

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. [Create a {{ mgp-name }} cluster](../../managed-greenplum/operations/cluster-create.md). When creating a cluster, make sure to enable **{{ ui-key.yacloud.greenplum.section_cloud-storage }}**.

   {% note info %}

   You cannot disable this option after you save your cluster settings.

   {% endnote %}

1. Get an SSL certificate to connect to the {{ GP }} database:

   {% include [install-certificate](../../_includes/mdb/mgp/install-certificate.md) %}

   {% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Export the {{ GP }} table to {{ objstorage-name }} {#transfer}

1. Connect to the cluster:

   {% include [default-connstring](../../_includes/mdb/mgp/default-connstring.md) %}

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

1. Create an append-optimized table named `ao_table`:

   ```bash
   CREATE TABLE ao_table (a int)
       WITH (appendoptimized=true)
       DISTRIBUTED BY (a);
   ```

1. Populate the table with a series of integers from 1 through 10,000:

   ```bash
   INSERT INTO ao_table SELECT * FROM GENERATE_SERIES(1, 10000);
   ```

1. Transfer the `ao_table` data to the cold storage in {{ objstorage-name }}:

   ```bash
   SELECT yezzey_define_offload_policy('ao_table');
   ```

## Check the result {#check}

1. Check out how much space in the cluster local cache and {{ objstorage-name }} is used by:

   * Your `ao_table`:

      ```bash
      SELECT * FROM yezzey_offload_relation_status('ao_table');
      ```

   * Each segment file in `ao_table`:

      ```bash
      SELECT * FROM yezzey_offload_relation_status_per_filesegment('ao_table');
      ```

   If there are non-zero values in each `external_bytes` column in command output, the table is transferred to the cold storage in {{ objstorage-name }}.

1. Check out which of the table segment files are now in {{ objstorage-name }}:

   ```bash
   SELECT * FROM yezzey_relation_describe_external_storage_structure('ao_table');
   ```

1. Make sure the data can be read from {{ objstorage-name }}:

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

1. Make sure the data can be written to {{ objstorage-name }}:

   1. Add a series of integers from 1 through 10,000 to your `ao_table`:

      ```bash
      INSERT INTO ao_table SELECT * FROM GENERATE_SERIES(1, 10000);
      ```

   1. Check that the number of rows has doubled:

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

## Transfer the table from {{ objstorage-name }} to cluster disks {#offload-to-local-storage}

To transfer your `ao_table` from {{ objstorage-name }} back to the {{ mgp-name }} cluster disks, run the command below:

```bash
SELECT yezzey_load_relation('ao_table');
```

## Delete the resources you created {#clear-out}

If you no longer need the cluster you created, [delete it](../../managed-greenplum/operations/cluster-delete.md).
