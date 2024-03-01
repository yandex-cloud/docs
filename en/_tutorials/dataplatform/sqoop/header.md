The [Sqoop](../../../data-proc/operations/sqoop-usage.md) utility allows you to import databases to the {{ dataproc-name }} cluster. Depending on the {{ dataproc-name }} cluster configuration, you can import data to:

* {{ objstorage-full-name }} bucket
* HDFS directory
* Apache Hive
* Apache HBase

To use Sqoop to import the source cluster databases to the {{ dataproc-name }} target cluster:

1. [Prepare the source cluster](#prepare).
1. [Run the import](#import).
1. [Check the import for correctness](#check).

If you no longer need the resources you created, [delete them](#clear-out).

{% include [No Sqoop in DataProc v2.0](../../../_includes/data-proc/no-sqoop-in-dataproc2.md) %}
