---
title: '{{ GP }} and {{ mgp-full-name }} overview'
description: This article provides general information about {{ GP }} and {{ mgp-full-name }}.
---

# {{ GP }} and {{ mgp-full-name }} overview

{{ GP }} is an analytical, column-oriented DBMS designed for storing and processing large volumes of data.

Built on {{ PG }}, {{ GP }} consists of multiple {{ PG }} database instances combined into a single cluster using [MPP](https://en.wikipedia.org/wiki/Massively_parallel) architecture. These instances communicate over a high-speed network, Interconnect. Each cluster node runs its own OS and uses dedicated memory and disk resources, enabling parallel data storage and processing across many nodes. This MPP architecture supports horizontal scaling, ensures high cluster availability, and delivers near-linear performance growth as you add resources.

## {{ GP }} use cases {#usage}

* Analytical DB: for example, you can linearly accelerate large hash joins in {{ GP }} by adding more CPUs or nodes.
* General-purpose database replacement: {{ GP }} can serve as a drop-in alternative to Oracle DB, Microsoft SQL Server, or IBM DB2. It handles not only analytical workloads but also numerous short [OLTP queries](https://en.wikipedia.org/wiki/Point-in-time_recovery) typical of {{ PG }}.
* High-performance alternative to {{ PG }}: based on {{ PG }}, {{ GP }} supports many familiar {{ PG }} tools, such as JDBC and ODBC drivers, and conforms to the ANSI SQL:2008 standard.

## {{ GP }} in {{ mgp-full-name }} {#managed-gp}

{{ GP }} was originally developed as an open-source project; however, in 2024, access to its source code was restricted. Despite this, {{ mgp-name }} continues to support {{ GP }} version 6 using its open-source [fork](https://github.com/orgs/open-gpdb/discussions/11). 

{{ mgp-name }} enables you to deploy {{ GP }} [clusters](index.md) in the {{ yandex-cloud }} infrastructure and automates most maintenance tasks, including:

* Provisioning resources, creating and reconfiguring databases, and applying software updates.
* Automatically restoring cluster resilience after failures.
* Creating [backups](backup.md) using [WAL-G](https://wal-g.readthedocs.io/), storing them in an S3 storage, and enabling point-in-time recovery ([PITR](https://en.wikipedia.org/wiki/Point-in-time_recovery)) to any moment.

The solution also provides self-service tools for managing {{ GP }} clusters:

* [Roles](../security/index.md) for data access management.
* [Command center](command-center.md) and [metrics](../metrics.md) for real-time cluster monitoring.
* [Yezzey](../operations/extensions/yezzey.md) extension for setting up hybrid storage.

{{ mgp-name }} clusters support seamless integration with other {{ yandex-cloud }} services, e.g., with [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) for database migration or [{{ datalens-full-name }}](../../datalens/index.yaml) for data visualization.

## See also {see-also}

* [{{ GP }} official documentation](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/landing-index.html)
* [Getting started with {{ mgp-name }}](../quickstart.md)
* [Resource relationships in {{ mgp-name }}](index.md)
* [{{ mgp-name }} tutorials](../tutorials/index.md)

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
