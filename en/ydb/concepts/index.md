# Overview

{% if audience == "internal" %}

*{{ ydb-full-name }}* ({{ ydb-short-name }}) is a horizontally scalable, distributed, fault-tolerant DBMS. {{ ydb-short-name }} is designed to meet high performance requirements, for example, a typical server can handle dozens of thousands of requests per second. The system is designed to handle hundreds of petabytes of data. {{ ydb-short-name }} can operate in two modes:
a single data center database or a geo-distributed (cross data center) database on a cluster of thousands of servers.

{{ ydb-short-name }} used in Yandex services as a high-performance [OLTP](https://en.wikipedia.org/wiki/Online_transaction_processing) DBMS. Yandex services like Yandex Cloud Object Storage and Yandex Block Storage use {{ ydb-short-name }} for storing data and are based on its components.

{{ ydb-short-name }} provides:

* [Strict consistency](https://en.wikipedia.org/wiki/Consistency_model#Strict_Consistency), which can be decreased in order to improve performance.
* Support for [YQL](../yql/reference/quickstart.md) queries (YQL is an SQL dialect for big data processing).
* Automatic data replication.
* High availability with automatic failover in case a server or data center goes offline.
* Automatic re-sharding as data grows.

For the user, {{ ydb-short-name }} is a traditional database server that is accessed over gRPC protocol. Protocol specifications for accessing {{ ydb-short-name }} are open. This allows for the creation of SDKs for any programming language. {{ ydb-short-name }} provides SDKs for [C++](../getting_started/start_cpp.md), [Java](../getting_started/start_java.md), [Python](../getting_started/start_python.md), and [Go](../getting_started/start_go.md).

{{ ydb-short-name }} supports a familiar relational DBMS [data model](datamodel.md) and manages tables with a predefined schema. To make it easier to manage tables, directories can be created like in the file system.

Database commands are mainly written in YQL, a language similar to SQL. This gives the user a powerful and already familiar way to interact with the database.

{{ ydb-short-name }} supports high-performance distributed [ACID](https://en.wikipedia.org/wiki/ACID_(computer_science)) transactions that may affect multiple records in different tables. The highest level of transaction isolation is provided: serializable. You can also decrease the level of isolation to improve performance.

{{ ydb-short-name }} natively supports different processing options, such as [OLTP](https://en.wikipedia.org/wiki/Online_transaction_processing) and [OLAP](https://en.wikipedia.org/wiki/Online_analytical_processing). The current version offers limited analytical query support. This is why we can say that {{ ydb-short-name }} is currently an OLTP database.

{% else if audience == "external" %}

*Yandex Database* ({{ ydb-short-name }}) is a horizontally scalable, distributed, fault-tolerant DBMS. {{ ydb-short-name }} is designed to meet high performance requirements, for example, a typical server can handle dozens of thousands of requests per second. The system is designed to handle hundreds of petabytes of data.

{{ ydb-short-name }} is a regional database hosted in three [availability zones](../../overview/concepts/geo-scope.md).

{{ ydb-short-name }} provides:

* [Strict consistency](https://en.wikipedia.org/wiki/Consistency_model#Strict_Consistency), which can be decreased in order to improve performance.
* Support for [YQL](../yql/reference/quickstart.md) queries (YQL is an SQL dialect for big data processing).
* Automatic data replication.
* High availability with automatic failover in case a server or availability zone goes offline.
* Automatic re-sharding as data grows.

{{ ydb-short-name }} provides SDKs for [Java](https://github.com/yandex-cloud/ydb-java-sdk), [Python](https://github.com/yandex-cloud/ydb-python-sdk), and [Go](https://github.com/yandex-cloud/ydb-go-sdk).

{{ ydb-short-name }} supports a relational [data model](datamodel.md) and manages tables with a predefined schema. To make it easier to manage tables, directories can be created like in the file system.

{{ ydb-short-name }} supports high-performance distributed [ACID](https://en.wikipedia.org/wiki/ACID_(computer_science)) transactions that may affect multiple records in different tables. The highest level of transaction isolation is provided: serializable. You can also decrease the level of isolation to improve performance.

{{ ydb-short-name }} natively supports different processing options, such as [OLTP](https://en.wikipedia.org/wiki/Online_transaction_processing) and [OLAP](https://en.wikipedia.org/wiki/Online_analytical_processing). The current version offers limited analytical query support. This is why we can say that YDB is currently an OLTP database.

{% endif %}

