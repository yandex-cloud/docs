# {{ ydb-full-name }} overview

{{ ydb-full-name }} lets you create and manage {{ ydb-short-name }} databases in {{ yandex-cloud }}.

To learn more about {{ ydb-full-name }} concepts, see the following articles:

* [{#T}](resources.md).
* [{#T}](serverless-and-dedicated.md).
* [{#T}](dynamodb-tables.md).
* [{#T}](limits.md).

## {{ ydb-short-name }} DBMS {#ydb}

[{{ ydb-short-name }}]{% if lang == "en" %}(https://ydb.tech/en){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru){% endif %} is a horizontally scalable distributed fault-tolerant DBMS. {{ ydb-short-name }} is designed for high performance with a typical server being capable of handling tens of thousands of queries per second. The system is designed to handle hundreds of petabytes of data. {{ ydb-short-name }} can operate in single data center and geo-distributed (cross data center) modes on a cluster of thousands of servers.

To interact with {{ ydb-short-name }}, you can use the [{{ ydb-short-name }} CLI]{% if lang == "en" %}(https://ydb.tech/en/docs/reference/ydb-cli/){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/reference/ydb-cli/){% endif %} and [SDKs]{% if lang == "en" %}(https://ydb.tech/en/docs/reference/ydb-sdk/){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/reference/ydb-sdk/){% endif %} for C++, Java, Python, Node.js, PHP, and Go. The language used for DB queries is [YQL]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/){% endif %}, a dialect of SQL. For more information about the purpose and best practices of using {{ ydb-short-name }} tools when developing applications, see [Recommendations]{% if lang == "ru" %}(https://ydb.tech/ru/docs/best_practices/){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/best_practices/){% endif %}.

To learn more about the {{ ydb-short-name }} architecture, see the following articles:

* [Terms and definitions]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/databases){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/databases){% endif %}.
* [Data model and schema]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/datamodel){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/datamodel){% endif %}.
* [Transactions]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/transactions){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/transactions){% endif %}.
* [Secondary indexes]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/secondary_indexes){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/secondary_indexes){% endif %}.
* [Time to Live (TTL)]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/ttl){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/ttl){% endif %}.
* [Scan queries]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/scan_query){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/scan_query){% endif %}.
* [Database limits]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/limits-ydb){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/limits-ydb){% endif %}.
* [{{ ydb-short-name }} cluster]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/cluster/){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/cluster/){% endif %}.

{% if product == "yandex-cloud" %}

## Service Level Agreement {#sla}

The service is subject to the [service level agreement (SLA)]{% if lang == "ru" %}(https://yandex.ru/legal/cloud_sla){% endif %}{% if lang == "en" %}(https://yandex.com/legal/cloud_sla){% endif %}. The service level is defined in [Service Level for {{ ydb-full-name }}]{% if lang == "ru" %}(https://yandex.ru/legal/cloud_sla_ydb){% endif %}{% if lang == "en" %}(https://yandex.com/legal/cloud_sla_ydb){% endif %}.


{% endif %}
