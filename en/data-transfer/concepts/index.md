---
title: "Relationships between {{ data-transfer-full-name }} resources"
description: "With {{ data-transfer-full-name }}, you can easily transfer data between databases. The service enables you to save time on migration, minimize downtime when switching to a new database, and maintain a database replica that is always up to date."
---

# Relationships between resources in {{ data-transfer-name }}

{{ data-transfer-full-name }} helps transfer data between DBMS, object storages, and message brokers. This way you can reduce the migration period and minimize downtime when switching to a new database.

{{ data-transfer-full-name }} is configurable via {{ yandex-cloud }} standard interfaces.

The service is suitable for creating a permanent replica of the database. The transfer of the database schema from the source to the target is automated.

## Endpoint {#endpoint}

_Endpoint_ is a configuration used to connect to the _datasource_ service or _target_ service. In addition to connection settings, the endpoint may contain information about which data will be involved in the transfer and how it should be processed during the transfer.

The following can be the data source or target:

{% if product == "yandex-cloud" %}

| Service | Source | Target |
|------------------------------------------------------------------------------------------------------------|:------------------------------------:|:------------------------------------:|
| {{ KF }} topic: Your own topic or a topic in [{{ mkf-short-name }}](../../managed-kafka/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| AWS CloudTrail message stream | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| Your own BigQuery database | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| {{ CH }} database: Your own or as part of the [{{ mch-short-name }} service](../../managed-clickhouse/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ GP }} database: Your own or as part of the [{{ mgp-short-name }} service](../../managed-greenplum/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ MG }} database: Your own or as part of the [{{ mmg-short-name }} service](../../managed-mongodb/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ MY }} database: Your own or as part of the [{{ mmy-short-name }} service](../../managed-mysql/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Your own Oracle database | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| {{ PG }} database: Your own or as part of the [{{ mpg-short-name }} service](../../managed-postgresql/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| S3 compatible bucket | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| Data stream [{{ yds-full-name }}](../../data-streams/) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| {{ ydb-name }} database: A database in [{{ ydb-name }}](../../ydb/) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| Bucket [{{ objstorage-full-name }}](../../storage/) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |

{% endif %}

{% if product == "cloud-il" %}

| Service | Source | Target |
|------------------------------------------------------------------------------------------------------------|:------------------------------------:|:------------------------------------:|
| {{ KF }} topic: Your own topic or a topic in [{{ mkf-short-name }}](../../managed-kafka/) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| AWS CloudTrail message stream | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| Your own BigQuery database | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| {{ CH }} database: Your own or as part of the [{{ mch-short-name }} service](../../managed-clickhouse/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Your own {{ GP }} database                                                                           | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| Your own {{ MG }} database                                                                           | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ MY }} database: Your own or as part of the [{{ mmy-short-name }} service](../../managed-mysql/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Your own Oracle database | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| {{ PG }} database: Your own or as part of the [{{ mpg-short-name }} service](../../managed-postgresql/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Bucket [{{ objstorage-full-name }}](../../storage/) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |

{% endif %}

## Transfer {#transfer}

_Transfer_ is the process of transmitting data between the source and target service. It should be in the same folder as the endpoints used.

If subnets are specified for endpoints, they must be hosted in the same {% if audience != "internal" %}[availability zone](../../overview/concepts/geo-scope.md){% else %}availability zone{% endif %}. Otherwise, activating the transfer with such endpoints will result in an error.

### Transfer types {#transfer-type}

The following types of transfers are available:

* _{{ dt-type-copy }}_: Moves a snapshot of the source to the target.
* _{{ dt-type-repl }}_: Continuously receives changes from the source and applies them to the target. Initial data synchronization is not performed.
* _{{ dt-type-copy-repl }}_: Transfers the current state of the source to the target and keeps it up-to-date.

For more information about the differences between transfer types, see [{#T}](./transfer-lifecycle.md).

### Compatibility of sources and targets {#connectivity-matrix}

{% include [include](../../_includes/data-transfer/connectivity-marix.md) %}