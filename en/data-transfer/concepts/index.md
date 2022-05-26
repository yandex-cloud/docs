---
title: "Relationship between {{data-transfer-full-name}} service resources"
description: "{{data-transfer-full-name}} allows you to easily transfer data between databases. The service allows you to reduce the time for the migration process, minimize downtime when switching to a new database or have a permanent replica of the database."
---

# Relationships between resources in {{ data-transfer-name }}

{{ data-transfer-full-name }} helps transfer data between DBMSs, object storages or message brokers. This way you can reduce the migration period and minimize downtime when switching to a new database.

{{ data-transfer-full-name }} is configurable via {{ yandex-cloud }} standard interfaces.

The service is suitable for creating a permanent replica of the database. The transfer of the database schema from the source to the target is automated.

## Endpoint {#endpoint}

_Endpoint_ is a configuration used to connect to the _datasource_ service or _target service_. In addition to connection settings, the endpoint may contain information about which data will be involved in the transfer and how it should be processed during the transfer.

As the data source or target you can use:

| Service | Source | Target |
|------------------------------------------------------------------------------------------------------------|:------------------------------------:|:------------------------------------:|
| Your own {{ GP }} database                                                                           | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| {{ CH }} database — your own or as part of the [{{ mch-short-name }} service](../../managed-clickhouse/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ MG }} database — your own or as part of the [{{ mmg-short-name }} service](../../managed-mongodb/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ MY }} database — your own or as part of the [{{ mmy-short-name }} service](../../managed-mysql/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Your own Oracle database                                                                              | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| {{ PG }} database — your own or as part of the [{{ mpg-short-name }} service](../../managed-postgresql/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ KF }} topic: Your own topic or a topic in [{{ mkf-short-name }}](../../managed-kafka/). | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| Data stream [{{ yds-full-name }}](../../data-streams/) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| {{ ydb-name }} database: A database in [{{ ydb-name }}](../../ydb/). | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| Bucket [{{ objstorage-full-name }}](../../storage/) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |

## Transfer {#transfer}

_Transfer_ is the process of transmitting data between the source service and the target service. It should be in the same folder as the endpoints that you use.

### Transfer types {#transfer-type}

The following types of transfers are available:

* _{{ dt-type-copy }}_: Moves a snapshot of the source to the target.
* _{{ dt-type-repl }}_: Continuously receives changes from the source and applies them to the target. Initial data synchronization is not performed.
* _{{ dt-type-copy-repl }}_: Transfers the current state of the source to the target and keeps it up-to-date.

For more information about the differences between transfer types, see [{#T}](./transfer-lifecycle.md).

### Compatibility of sources and targets {#connectivity-matrix}

Different DBMS systems can act as a source and as a target. Supported source and target combinations:

| Source \ Target | {{ PG }} | {{ MY }} | {{ MG }} | {{ ydb-name }} | {{ CH }} | {{ objstorage-name }} |
|:-------------------:|:-----------------------------:|:-----------------------:|:-----------------------------:|:-----------------------------:|:-----------------------------:|:---------------------:|
| {{ PG }} | Copy, replicate | - | - | Copy^1^, replicate^1^ | Copy^1^, replicate^1^ | Copy^1^ |
| {{ MY }} | - | Copy, replicate | - | Copy^1^, replicate^1^ | Copy^1^, replicate^1^ | Copy^1^ |
| {{ MG }} | - | - | Copy^1^, replicate^1^ | - | - | Copy^1^ |
| Oracle | Copy^1^, replicate^1^ | - | - | - | Copy^1^, replicate^1^ | - |
| {{ CH }} | - | - | - | - | Copy^1^ | - |
| {{ GP }} | Copy^2^ | - | - | - | Copy^2^ | - |
| {{ yds-full-name }} | - | - | - | Replicate^1^ | Copy^1^, replicate^1^ | Replicate^1^ |
| {{ KF }} | - | - | - | Replicate^1^ | Replicate^1^ | Replicate^1^ |


^1^ This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage.
^2^ This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage and is available upon request. Contact [support]({{ link-console-support }}) or your account manager.

## Service specifics for sources and targets {#features}

### {{ CH }} {#clickhouse}

If replication is enabled on a {{ CH }} target, the engines for recreating tables are selected depending on the source type:

* When transferring data from row-oriented database management systems, the [ReplicatedReplacingMergeTree](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/replication/) and [ReplacingMergeTree](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/replacingmergetree/) engines are used.
* When transferring data from {{ CH }}, the [ReplicatedMergeTree](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/replication/) engines are used.

### {{ MG }} {#mongodb}

By default, the service does not shard collections transferred to a sharded cluster. For more information, see [Preparing for the transfer](../operations/prepare.md#target-mg).

### {{ PG }} {#postgresql}

The service does not transfer any materialized views (`MATERIALIZED VIEW`). When transferring data from one {{ PG }} cluster to another, manually create all the necessary materialized views in the target cluster after [deactivating the transfer](../operations/transfer.md#deactivate).

When you replicate data, the bandwidth may be up to 20-30 thousand transactions per second.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
