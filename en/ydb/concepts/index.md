# {{ ydb-full-name }} overview

{{ ydb-full-name }} lets you create and manage {{ ydb-short-name }} databases in {{ yandex-cloud }}.

To learn more about {{ ydb-full-name }} concepts, see the following articles:

* [{#T}](resources.md).
* [{#T}](serverless-and-dedicated.md).
* [{#T}](dynamodb-tables.md).
* [{#T}](limits.md).

## {{ ydb-short-name }} DBMS {#ydb}

[{{ ydb-short-name }}](https://ydb.tech/en) is a horizontally scalable distributed fault-tolerant DBMS. {{ ydb-short-name }} is designed for high performance with a typical server being capable of handling tens of thousands of queries per second. The system is designed to handle hundreds of petabytes of data. {{ ydb-short-name }} can operate in single data center and geo-distributed (cross data center) modes on a cluster of thousands of servers.

To interact with {{ ydb-short-name }}, you can use the [{{ ydb-short-name }} CLI](https://ydb.tech/en/docs/reference/ydb-cli/) and [SDKs](https://ydb.tech/en/docs/reference/ydb-sdk/) for C++, Java, Python, Node.js, PHP, and Go. The language used for DB queries is [YQL](https://ydb.tech/en/docs/yql/reference/), a dialect of SQL. For more information about the purpose and best practices of using {{ ydb-short-name }} tools when developing applications, see [Recommendations](https://ydb.tech/en/docs/best_practices/).

To learn more about the {{ ydb-short-name }} architecture, see the following articles:

* [Terms and definitions](https://ydb.tech/en/docs/concepts/databases).
* [Data model and schema](https://ydb.tech/en/docs/concepts/datamodel).
* [Transactions](https://ydb.tech/en/docs/concepts/transactions).
* [Secondary indexes](https://ydb.tech/en/docs/concepts/secondary_indexes).
* [Time to Live (TTL)](https://ydb.tech/en/docs/concepts/ttl).
* [Scan queries](https://ydb.tech/en/docs/concepts/scan_query).
* [Database limits](https://ydb.tech/en/docs/concepts/limits-ydb).
* [{{ ydb-short-name }} cluster](https://ydb.tech/en/docs/concepts/cluster/).


## Service Level Agreement {#sla}

The service is subject to the [service level agreement (SLA)](https://yandex.com/legal/cloud_sla). The service level is defined in [Service Level for {{ ydb-full-name }}](https://yandex.com/legal/cloud_sla_ydb).


