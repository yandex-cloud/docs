---
title: Resource relationships in {{ data-transfer-full-name }}
description: You can use {{ data-transfer-full-name }} to easily transfer data between databases. The service enables you to save time on migration, minimize downtime when switching to a new database, and maintain a database replica that is always up to date.
---

# Resource relationships in {{ data-transfer-name }}

{{ data-transfer-full-name }} helps transfer data between DBMS, object storages, and message brokers. This way you can reduce the migration period and minimize downtime when switching to a new database.

{{ data-transfer-full-name }} is configurable via {{ yandex-cloud }} standard interfaces.

The service is suitable for creating a permanent replica of the database. The transfer of the database schema from the source to the target is automated.

## Endpoint {#endpoint}

An _endpoint_ is a configuration used to connect to a service: _datasource_ or _target_. In addition to connection settings, the endpoint may contain information about which data will be involved in the transfer and how it should be processed during the transfer.

The following can be the data source or target:

| Service                                                                                                                                |                                Source                                |               Target               |
|---------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------:|:------------------------------------:|
| {{ KF }} topic: Your own or as part of [{{ mkf-short-name }}](../../managed-kafka/)                                       |                  ![yes](../../_assets/common/yes.svg)                  | ![yes](../../_assets/common/yes.svg) |
| AWS CloudTrail message stream                                                                                                        |                  ![yes](../../_assets/common/yes.svg)                  |  ![no](../../_assets/common/no.svg)  |
| Your own BigQuery database                                                                                                      |                  ![yes](../../_assets/common/yes.svg)                  |  ![no](../../_assets/common/no.svg)  |
| {{ CH }} database: Your own or as part of [{{ mch-short-name }}](../../managed-clickhouse/)                            |                  ![yes](../../_assets/common/yes.svg)                  | ![yes](../../_assets/common/yes.svg) |
| Your own {{ ES }} database                                                                                                                                                                                |                  ![yes](../../_assets/common/yes.svg)                  | ![yes](../../_assets/common/yes.svg) |
| {{ GP }} database: Your own or as part of [{{ mgp-short-name }}](../../managed-greenplum/)                             |                  ![yes](../../_assets/common/yes.svg)                  | ![yes](../../_assets/common/yes.svg) |
| {{ MG }} database: Your own or as part of [{{ mmg-short-name }}](../../managed-mongodb/)                               |                  ![yes](../../_assets/common/yes.svg)                  | ![yes](../../_assets/common/yes.svg) |
| {{ MY }} database: Your own or as part of [{{ mmy-short-name }}](../../managed-mysql/)                                 |                  ![yes](../../_assets/common/yes.svg)                  | ![yes](../../_assets/common/yes.svg) |
| Your own Oracle database                                                                                                        |                  ![yes](../../_assets/common/yes.svg)                  |  ![no](../../_assets/common/no.svg)  |
| {{ PG }} database: Your own or as part of [{{ mpg-short-name }}](../../managed-postgresql/)                            |                  ![yes](../../_assets/common/yes.svg)                  | ![yes](../../_assets/common/yes.svg) |
| {{ OS }} database: Your own or as part of [{{ mos-short-name }}](../../managed-opensearch/)                            |                  ![yes](../../_assets/common/yes.svg)                  | ![yes](../../_assets/common/yes.svg) |
| S3-compatible bucket |                  ![yes](../../_assets/common/yes.svg)                  |  ![no](../../_assets/common/no.svg)  |
| [{{ yds-full-name }}](../../data-streams/) data stream                                                                               |                  ![yes](../../_assets/common/yes.svg)                  | ![yes](../../_assets/common/yes.svg) |
| {{ ydb-name }} database: As part of [{{ ydb-name }}](../../ydb/)                                                           |                  ![yes](../../_assets/common/yes.svg)                  | ![yes](../../_assets/common/yes.svg) |
| [{{ objstorage-full-name }}](../../storage/) bucket                                                                                    |                  ![yes](../../_assets/common/yes.svg)                  | ![yes](../../_assets/common/yes.svg) |
| 

## Transfer {#transfer}

_Transfer_ is the process of transmitting data between the source and target service. It should be in the same folder as the endpoints used.

If subnets are specified for endpoints, these subnets must be hosted in the same [availability zone](../../overview/concepts/geo-scope.md). Otherwise, activating the transfer with such endpoints will result in an error.

### Worker {#worker}

_Worker_ is a utility process that starts a data transfer. A separate VM is allocated for each worker. You can specify which computing resources to use for this virtual machine:

{% include [vm-computing-resources](../../_includes/data-transfer/vm-computing-resources.md) %}

During [parallel copying](sharded.md) or parallel replication (for the {{ DS }}, {{ ydb-short-name }}, and {{ KF }} sources), the user selects the number of workers to run at the same time.

vCPU count and RAM size impact the [cost of {{ data-transfer-name }} resources](../pricing.md). To optimize usage and data transfer costs, we recommend using workers efficiently by reducing their number and increasing the load on each worker. You can also change the worker configuration in the [transfer settings](../operations/transfer.md#update) for [billable](../pricing.md) source-target pairs at the [GA](../../overview/concepts/launch-stages.md) stage.

### Transfer types {#transfer-type}

{% include [include](../../_includes/data-transfer/transfer-types.md) %}

For more information about the differences between transfer types, see [{#T}](./transfer-lifecycle.md).

### Compatibility of sources and targets {#connectivity-matrix}

{% include [include](../../_includes/data-transfer/connectivity-marix.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}