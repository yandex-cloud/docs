# External tables

{{ mgp-name }} allows you to work with data from sources that are external to a {{ mgp-name }} cluster. This functionality uses _external tables_, i.e., special objects in a database that reference tables, buckets, or files from external sources. External DBMS data is accessed via the [{{ GP }} Platform Extension Framework](../operations/external-tables.md) (PXF) protocol; files on external file servers are accessed via the [{{ GP }} Parallel File Server](../operations/gpfdist/connect.md) (`gpfdist`) utility. {{ GP }} and {{ CB }} use different `gpfdist` utilities. For more information about the utilities, see these [{{ GP }}]({{ gp.docs.broadcom }}/6/greenplum-database/utility_guide-ref-gpfdist.html) and [{{ CB }} guides]({{ gp.docs.cloudberry }}/sys-utilities/gpfdist).

With external tables, you can:

* Query external data sources.
* Load datasets from external sources into a {{ mgp-name }} cluster database.
* Join local and external tables in queries.
* Write data to external tables or files.

{% note info %}

For security reasons, {{ mgp-name }} does not support the creation of external web tables that use shell scripts.

{% endnote %}

## External data sources for PXF operations {#pxf-data-sources}

{{ mgp-name }} uses _external data sources_ to create external tables. Each source is similar to a web server configuration used to access data in external DBMS's. This is why sources are only used for PXF operations.

Sources enable you to do the following:

* In the configuration, specify the parameters that cannot be included in an [SQL query for creating a PXF external table](../operations/pxf/create-table.md).
* Avoid explicitly specifying the user password in an SQL query for creating an external table.
* Simplify your SQL query for creating a table: with a dedicated source properly configured, there is no need to list configuration parameters in your query.
* Simplify your configuration update: it is enough to redefine the parameters at the source only once without changing them for each table separately.

## Working with files on external sources using gpfdist {#gpfdist}

`gpfdist` is a file server that provides {{ mgp-name }} cluster hosts with parallel access to files on a remote server via the HTTP protocol.

This utility is installed on all {{ mgp-name }} cluster segment hosts, but to work with external files you need to [install and run](../operations/gpfdist/connect.md#run-gpfdist) it on the server those files are stored on.

To work with files using `gpfdist`, follow these steps:

1. On the remote server, run `gpfdist`, which will open access to a specified directory on a specified port.
1. [Create an external table](../operations/gpfdist/connect.md#create-gpfdist-table) in the {{ mgp-name }} cluster. In the `LOCATION` parameter, specify the `gpfdist` protocol, server address, port, and file path or file group mask.

When accessing such a table, the cluster's segment hosts connect to `gpfdist` in parallel, each segment reading or writing its own portion of the data. Data flows between the segments and the remote server directly bypassing the master host. During loading, data is distributed between segments either evenly or as per the specified [distribution key](sharding.md#distribution-key). This improves performance when handling large amounts of external data.

With `gpfdist`, you can:

* Use delimited text files (`TEXT`, `CSV`, and `CUSTOM` formats), as well as gzip and bzip2 compressed files.
* Use external tables to read data from files and write data to files. Do this by creating a table with the `READABLE` or `WRITABLE` option on.
* Specify multiple files and multiple servers running `gpfdist` in a single external table.
* Distribute the network load by running multiple instances of the utility on the same server using different directories and ports.

The server running `gpfdist` must be available at the specified port from the network the {{ mgp-name }} cluster is connected to. You should [configure security groups](../operations/connect/index.md#configuring-security-groups) for this to work. If the server running `gpfdist` is outside of {{ yandex-cloud }} and accessible via the internet, [configure a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the cluster network.

[External data sources](#pxf-data-sources) are not used for `gpfdist`: all connection parameters are specified in the SQL query used to create the external table.

## Use cases {#examples}

* [{#T}](../tutorials/config-server-for-s3.md)
* [{#T}](../tutorials/pxf-named-queries.md)

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../_includes/mdb/mgp/trademark-cloudberry.md) %}
