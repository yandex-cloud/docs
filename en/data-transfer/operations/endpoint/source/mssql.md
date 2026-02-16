---
title: Transferring data from a Microsoft SQL Server source endpoint
description: Follow this guide to set up a data transfer from a Microsoft SQL Server source endpoint.
---

# Transferring data from a Microsoft SQL Server source endpoint

{{ data-transfer-full-name }} enables you to migrate data from a Microsoft SQL Server database to {{ yandex-cloud }} managed databases and implement various data processing and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the Microsoft SQL Server database](#prepare) for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. In case of any issues, [use ready-made solutions](../../../../data-transfer/troubleshooting/index.md) to resolve them.

## Scenarios for transferring data from Microsoft SQL Server {#scenarios}

You can implement scenarios for data migration and delivery from a Microsoft SQL Server database to managed databases for further storage in the cloud, processing and loading into data marts for further visualization.

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the Microsoft SQL Server database {#prepare}

{% include [prepare ms sql server db](../../../../_includes/data-transfer/endpoints/sources/ms-sqlserver-prepare.md) %}

## Configuring the Microsoft SQL Server source endpoint {#endpoint-settings}

When [creating](../index.md#create) an endpoint, select `MSSQL` as your database type and configure access to {{ MS }}. You can [change](../index.md#update) the settings after you create an endpoint.

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.host.title }}**: IP address or FQDN of the host you need to connect to.
  
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.port.title }}**: Port number {{ data-transfer-name }} will use for connections to the host. 

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.database.title }}**: Name of the DB to connect to.

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.username.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.password.title }}**: DB user name and password.
  
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.replication_method.title }}**: Replication method used to retrieve data from the database. `STANDARD` replication requires no setup on the database side, but it does not show data changes. `CDC` replication allows you to capture data inserts, updates, and deletes.
  
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.ssl_method.title }}**: Encryption method used when exchanging data with the database:
      
        * `UNENCRYPTED`: Saving the password as plain text.
      
        * `ENCRYPTER (trust cert)`: Using a certificate from a trusted source.

        * `ENCRYPTER (verify cert)`: Using a self-signed certificate.
    
{% endlist %}

For more information about the settings, see the [{{ AB }} documentation](https://docs.airbyte.com/integrations/sources/mssql/).


## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ MY }}](../target/mysql.md)
* [{{ MG }}](../target/mongodb.md)
* [{{ CH }}](../target/clickhouse.md)
* [{{ GP }}](../target/greenplum.md)
* [{{ ydb-full-name }}](../target/yandex-database.md)
* [{{ KF }}](../target/kafka.md)
* [{{ DS }}](../target/data-streams.md)
* [{{ PG }}](../target/postgresql.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

{% include [Internet access](../../../../_includes/data-transfer/notes/internet-access.md) %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

{% include [airbyte-trademark](../../../../_includes/data-transfer/airbyte-trademark.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
