# Федеративные запросы

Федеративные запросы — это способ обрабатывать информацию из различных источников данных с помощью одного общего запроса к этим источникам. В настоящее время федеративные запросы поддерживают взаимодействие с базами данных ClickHouse®, PostgreSQL и с хранилищами данных Yandex Object Storage.

Для работы с данными, хранящимися во внешних СУБД, достаточно создать [соединение](glossary.md#connection). Для работы с несхематизированными данными, хранящимися в бакетах S3, нужно дополнительно создать [привязку к данным](glossary.md#binding).

Подробная информация про работу с различными источниками данных приведена в соответствующих разделах:
* [ClickHouse®](../sources-and-sinks/clickhouse.md).
* [Greenplum®](../sources-and-sinks/greenplum.md).
* [MySQL®](../sources-and-sinks/mysql.md).
* [PostgreSQL](../sources-and-sinks/postgresql.md).
* [S3](../sources-and-sinks/object-storage-binding.md).
* [YDB](../sources-and-sinks/ydb.md).

Пример работы с федеративными запросами с помощью Yandex Query:


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvtaitffc5pk6hpa24?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=1EN28LVncPM).



## Примеры использования {#examples}

* [Федеративные запросы к данным](../tutorials/yq-federative-queries.md).