---
title: Overview of {{ GP }} and {{ CB }} in {{ mgp-full-name }}
description: This article provides general information about {{ mgp-full-name }} and supported databases, {{ GP }} and {{ CB }}.
---

# Overview of {{ GP }} and {{ CB }} in {{ mgp-full-name }}

{{ mgp-full-name }} allows you to deploy analytical, column-oriented [MPP](https://en.wikipedia.org/wiki/Massively_parallel) database [clusters](index.md) based on {{ PG }} for large-scale data processing. Each DBMS aggregates multiple {{ PG }} databases into an MPP cluster and establishes communication between them via an Interconnect network. Each cluster node runs its own OS and uses dedicated memory and disk resources, enabling parallel data storage and processing across many nodes. This MPP architecture supports horizontal scaling, ensures high cluster availability, and delivers near-linear performance growth as you add resources. 

The following databases are supported:

* {{ GP }} 6.28 and 6.29: Based on {{ PG }} 9.4. 

    {{ GP }} was originally developed as an open-source project; however, in 2024, access to its source code was restricted. Despite this, {{ mgp-name }} continues to support {{ GP }} version 6 using its open-source [fork](https://github.com/open-gpdb/gpdb).

* {{ CB }} 2: Based on {{ GP }} version 7 with a modernized {{ PG }} 14 kernel; supports dynamic tables and [PAX](https://cloudberry.apache.org/docs/operate-with-data/pax-table-format/) format.

    {{ CB }} is an open-source project developed under Apache License v2.0. 

    {{ CB }} will serve as the basis for future major versions of {{ mgp-name }}.

Learn more about the differences between {{ CB }} and {{ GP }} in [this section](./cloudberry-vs-greenplum/breaking-changes.md).

{{ mgp-name }} handles most of the cluster maintenance operations, including:

* Provisioning resources, creating and reconfiguring databases, and applying software updates.
* Automatically restoring cluster resilience after failures.
* Creating [backups](backup.md) using [WAL-G](https://wal-g.readthedocs.io/), storing them in an S3 storage, and enabling point-in-time recovery ([PITR](https://en.wikipedia.org/wiki/Point-in-time_recovery)) to any moment.

The solution also provides self-service tools for managing clusters:

* [Roles](../security/index.md) for data access management.
* [Command center](command-center.md) and [metrics](../metrics.md) for real-time cluster monitoring.
* [Yezzey](../operations/extensions/yezzey.md) extension for setting up hybrid storage.

{{ mgp-name }} clusters support seamless integration with other {{ yandex-cloud }} services, e.g., with [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) for database migration or [{{ datalens-full-name }}](../../datalens/index.yaml) for data visualization.

## {{ mgp-name }} use cases {#usage}

* Analytical DB: For example, you can linearly accelerate large hash joins by adding more CPUs or nodes.
* General-purpose database replacement: {{ mgp-name }} can be used as a drop-in alternative to Oracle DB, Microsoft SQL Server, or IBM DB2. It handles not only analytical workloads but also numerous short [OLTP queries](https://en.wikipedia.org/wiki/Point-in-time_recovery) typical of {{ PG }}.
* High-performance alternative to {{ PG }}: Because databases available in {{ mgp-name }} are based on {{ PG }}, it supports many familiar {{ PG }} tools, such as JDBC and ODBC drivers, and conforms to the ANSI SQL:2008 standard.

## See also {see-also}

* [{{ GP }} official guides](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/landing-index.html)
* [{{ CB }} official guides](https://cloudberry.apache.org/docs/)
* [Getting started with {{ mgp-name }}](../quickstart.md)
* [Resource relationships in {{ mgp-name }}](index.md)
* [{{ mgp-name }} tutorials](../tutorials/index.md)

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../_includes/mdb/mgp/trademark-cloudberry.md) %}
