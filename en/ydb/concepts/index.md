---
title: Yandex Database (YDB). DBMS overview
description: 'Yandex Database (YDB) is a scale-out distributed fault-tolerant DBMS. YDB is designed with high performance in mind - for example, a typical server can handle tens of thousands of requests per second. The system is designed to handle hundreds of petabytes of data. '

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Yandex Database (YDB) overview

*Yandex Database* ({{ ydb-short-name }}) is a horizontally scalable distributed fault-tolerant DBMS. {{ ydb-short-name }} is designed to meet high performance requirements. For example, a typical server can handle dozens of thousands of queries per second. The system is designed to handle hundreds of petabytes of data.

{{ ydb-short-name }} is a regional database and is located in three [availability zones](../../overview/concepts/geo-scope.md).

{{ ydb-short-name }} provides:

* [Strict consistency](https://en.wikipedia.org/wiki/Consistency_model#Strict_Consistency), which can be lowered in order to raise performance.
* Support for queries written in [YQL](../yql/reference/overview.md) (an SQL dialect for working with big data).
* Automatic data replication.
* High availability with automatic failover in case a server or availability zone goes offline.
* Automatic data partitioning as data or load grows.

{{ ydb-short-name }} may operate in two modes:

* Dedicated mode: In this mode, separate virtual hosts with the specified resources are allocated to the database. You set the number of hosts, their [computing resources](databases.md#compute-units), storage parameters, and cloud networks yourself.

  If DB computing resources are not enough to handle the current load, the query processing decreases to the point of denial of service. To avoid this, make sure you [add computing resources](../operations/create_manage_database.md#change-db-params) to the database in time.

   This mode is convenient if you have a good idea of the amount of resources your database needs to operate and can predict peak loads. When using this mode, you pay for the allocated computing resources, storage, and backups, regardless of the number of DB operations. Read more about pricing in the [pricing policy](../pricing/dedicated.md).

* Serverless mode: In this mode, you can deploy a database in a served environment without creating separate hosts. You don't need to monitor computing resources, networks, or other parameters. The service automatically provides all the resources that the DB needs to run and scales them based on the load.

   Serverless mode is good for small projects that do not require a separate server or for tasks with uneven hard-to-predict load. In this mode, you pay for the actual DB operations and for storing data and backups. Read more about pricing in the [pricing policy](../pricing/serverless.md).

   The {{ ydb-full-name }} serverless mode supports data operations using both the YDB API and [Document API](../docapi/api-ref/index.md), an Amazon DynamoDB-compatible HTTP API. You can use this API to perform operations on document tables.

{{ ydb-short-name }} provides the YDB API and its implementations as the [YDB CLI](../quickstart/examples-ydb-cli.md) and [YDB SDK](../sdk/index.md) for [Java](https://github.com/yandex-cloud/ydb-java-sdk), [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk), and [Go](https://github.com/yandex-cloud/ydb-go-sdk)

{{ ydb-short-name }} supports a relational [data model](datamodel.md) and manages tables with a predefined schema. To make it easier to organize tables, directories can be created like in the file system.

{{ ydb-short-name }} supports high-performance distributed [ACID](https://en.wikipedia.org/wiki/ACID_(computer_science)) transactions that may affect multiple records in different tables. It provides the serializable isolation level, which is the strictest transaction isolation. You can also lower the level of isolation to raise performance.

{{ ydb-short-name }} natively supports different processing options, such as [OLTP](https://en.wikipedia.org/wiki/Online_transaction_processing) and [OLAP](https://en.wikipedia.org/wiki/Online_analytical_processing). The current version offers limited analytical query support. This is why we can say that YDB is currently an OLTP database.

