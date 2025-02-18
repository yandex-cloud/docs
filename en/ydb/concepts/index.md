---
title: '{{ ydb-full-name }} overview'
description: In this article, you will learn about the {{ ydb-short-name }} DBMS and service level agreement.
---

# {{ ydb-full-name }} overview

{{ ydb-full-name }} allows you to create and manage {{ ydb-short-name }} databases in {{ yandex-cloud }}.

To learn more about {{ ydb-full-name }} concepts, see the following articles:

* [{#T}](resources.md).
* [{#T}](serverless-and-dedicated.md).
* [{#T}](dynamodb-tables.md).
* [{#T}](limits.md).

## {{ ydb-short-name }} DBMS {#ydb}

[{{ ydb-short-name }}](https://ydb.tech/en) is a horizontally scalable distributed fault tolerant DBMS. {{ ydb-short-name }} is designed for high performance with a typical server being capable of handling tens of thousands of queries per second. The system is natively designed to process hundreds of petabytes of data. {{ ydb-short-name }} can operate either in a single-datacenter or a geodistributed (cross-datacenter) configuration on a cluster made up of thousands of servers.

{{ ydb-short-name }} enables online transaction processing (OLTP) and online analytical processing (OLAP).

To interact with {{ ydb-short-name }}, you can use the [{{ ydb-short-name }} CLI]({{ ydb.docs }}/reference/ydb-cli/) and [SDKs]({{ ydb.docs }}/reference/ydb-sdk/) for C++, Java, Python, Node.js, PHP, and Go. The language used for DB queries is [YQL]({{ ydb.docs }}/yql/reference/), a dialect of SQL. For more information about the purpose and best practices of using {{ ydb-short-name }} tools when developing applications, see [Recommendations]({{ ydb.docs }}/best_practices/).

To learn more about {{ ydb-short-name }} concepts, see the following articles:

* [Terms and definitions]({{ ydb.docs }}/concepts/databases).
* [Data model and schema]({{ ydb.docs }}/concepts/datamodel).
* [Transactions]({{ ydb.docs }}/concepts/transactions).
* [Secondary indexes]({{ ydb.docs }}/concepts/secondary_indexes).
* [Change Data Capture (CDC)]({{ ydb.docs }}/concepts/cdc).
* [Time to Live (TTL)]({{ ydb.docs }}/concepts/ttl).
* [Scan queries]({{ ydb.docs }}/concepts/scan_query).
* [Database limits]({{ ydb.docs }}/concepts/limits-ydb).
* [{{ ydb-short-name }} cluster]({{ ydb.docs }}/concepts/cluster/).

## Service Level Agreement {#sla}

The service is subject to a [service level agreement](https://yandex.com/legal/cloud_sla). The service level is set out in the document titled [Yandex {{ ydb-name }} Service Level](https://yandex.com/legal/cloud_sla_ydb).