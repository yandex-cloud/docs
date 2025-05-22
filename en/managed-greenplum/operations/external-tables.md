# Working with PXF

The [{{ GP }} Platform Extension Framework]({{ gp.docs.broadcom }}-platform-extension-framework/6-11/gp-pxf/intro_pxf.html) (PXF) protocol is used to access data in external databases.

Let's say there is a table with sales data over several years. It contains three data types:

* Hot data for the last few months stored in {{ MY }}.
* Warm data for the last few years stored in {{ GP }}.
* Cold data for a longer period stored in S3.

The colder the data, the less often it is accessed.

To distribute data across multiple DBMS's and enable access to it, PXF is used to [create external tables](../concepts/external-tables.md), i.e., special objects in {{ GP }} that reference tables, buckets, or files from external sources. This section provides [guidelines](#work-with-pxf) on how to create external tables that reference external DBMS'S.

For such tables, you can specify external data source settings in the SQL query. Alternatively, you can [create a source](#work-with-pxf) in {{ mgp-name }} with the settings you need and provide that source in the SQL query.


## Getting started {#before-you-begin}

1. In the {{ mgp-name }} cluster subnet, [set up a NAT gateway and link a routing table](../../vpc/operations/create-nat-gateway.md).
1. In the same subnet, [create a security group](../../vpc/operations/security-group-create.md) allowing all incoming and outgoing traffic from all addresses.


## Get started with external tables using PXF {#work-with-pxf}

1. Add a data source to {{ mgp-name }}. The steps needed to add a source depend on the source connection type:

    * [S3](pxf/create-s3-source.md)
    * [JDBC](pxf/create-jdbc-source.md)
    * [HDFS](pxf/create-hdfs-source.md)
    * [Hive](pxf/create-hive-source.md)

1. [Create an external table](pxf/create-table.md) using PXF.

1. (Optional) [Update the default PXF settings](./pxf/settings.md).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
