---
title: "Relationship between {{data-transfer-full-name}} service resources"
description: "{{data-transfer-full-name}} allows you to easily transfer data between databases. The service allows you to reduce the time for the migration process, minimize downtime when switching to a new database or have a permanent replica of the database."
---
# Relationships between resources in {{ data-transfer-name }}

{{ data-transfer-full-name }} helps transfer data between DBMS, object stores, and message brokers. This way you can reduce the migration period and minimize downtime when switching to a new database.

{{ data-transfer-full-name }} is configurable via {{ yandex-cloud }} standard interfaces.

The service is suitable for creating a permanent replica of the database. The transfer of the database schema from the source to the target is automated.

## Endpoint {#endpoint}

_Endpoint_ is a configuration used to connect to the data _source service_ or _target service_. In addition to connection settings, the endpoint may contain information about which data will be involved in the transfer and how it should be processed during the transfer.

The following can be the data source or target:

| Service | Source | Target |
|----------------------------------------------------------------------------------------------------------|:------------------------------------:|:------------------------------------:|
| {{ CH }} database — your own or as part of the  [{{ mch-short-name }} service](../../managed-clickhouse) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ MG }} database — your own or as part of the  [{{ mmg-short-name }} service](../../managed-mongodb)    | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ MY }} database — your own or as part of the  [{{ mmy-short-name }} service](../../managed-mysql)      | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ PG }} database — your own or as part of the  [{{ mpg-short-name }} service](../../managed-postgresql) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ KF }} topic — your own or as part of the [{{ mkf-short-name }} service](../../managed-kafka)          | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)   |
| [{{ yds-full-name }}](../../data-streams) data stream                                                    | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)   |
| {{ ydb-name }} database — as part of the [{{ ydb-name }} service](../../ydb)                             | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) |
| [{{ objstorage-full-name }}](../../storage) bucket                                                       | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) |

## Transfer {#transfer}

_Transfer_ is the process of transmitting data between the source and target service. It should be in the same folder as the endpoints used.

### Transfer types {#transfer-type}

The following types of transfers are available:

* _{{ dt-type-copy }}_: Moves a snapshot of the source to the target.
* _{{ dt-type-repl }}_: Continuously receives changes from the source and applies them to the target. Initial data synchronization is not performed.
* _{{ dt-type-copy-repl }}_: Transfers the current state of the source to the target and keeps it up-to-date.

For more information about the differences between transfer types, see [{#T}](./transfer-lifecycle.md).

### Compatibility of sources and targets {#connectivity-matrix}

Different DBMS systems can act as a source and as a target. Possible source and target combinations:

| Source \ Target | {{ PG }} | {{ MY }} | {{ MG }} | {{ ydb-name }} | {{ CH }} | {{ objstorage-name }} |
| :-------------------: | :-----------------------------: | :-----------------------: | :-----------------------------: | :-----------------------------: | :-----------------------------: | :---------------------: |
| {{ PG }} | Copy, replicate | - | - | Copy^1^, replicate^1^ | Copy^1^, replicate^1^ | Copy^1^ |
| {{ MY }} | - | Copy, replicate | - | Copy^1^, replicate^1^ | Copy^1^, replicate^1^ | Copy^1^ |
| {{ MG }} | - | - | Copy^1^, replicate^1^ | - | - | Copy^1^ |
| Oracle | Copy^1^, replicate^1^ | - | - | - | Copy^1^, replicate^1^ | - |
| {{ CH }} | - | - | - | - | Copy^1^ | - |
| {{ yds-full-name }} | - | - | - | Replicate^1^ | Copy^1^, replicate^1^ | Replicate^1^ |
| {{ KF }} | - | - | - | Replicate^1^ | Replicate^1^ | Replicate^1^ |

^1^ This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage.

## Specifics of the service's work with sources and targets

### {{ CH }} {#clickhouse}

If replication is enabled on a {{ CH }} target, the engines for recreating tables are selected depending on the source type:

* When transferring data from string DBMS, the [ReplicatedReplacingMergeTree]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/replication/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/replication/){% endif %} and [ReplacingMergeTree]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/replacingmergetree/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/replacingmergetree/){% endif %} engines are used.
* When transferring data from {{ CH }}, the [ReplicatedMergeTree]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/replication/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/replication/){% endif %} engines are used.

## Bandwidth {#bandwidth}

The speed for copying data can reach 15 MBps. It usually takes 2-3 hours to copy a 100 GB database. The exact time depends on the target settings.

When you replicate data, the bandwidth may be up to 20-30 thousand transactions per second.

