[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for YDB](../index.md) > Концепции > Обзор

# Обзор Yandex Managed Service for YDB

Сервис Yandex Managed Service for YDB обеспечивает создание и управление базами данных YDB в Yandex Cloud.

Подробнее о концепциях сервиса Yandex Managed Service for YDB читайте в следующих статьях:

* [Термины и определения для Managed Service for YDB](resources.md).
* [Режимы работы Serverless и Dedicated](serverless-and-dedicated.md).
* [Автоматическое масштабирование](autoscaling.md).
* [Таблицы DynamoDB](dynamodb-tables.md).
* [Трансфер данных](transfer.md).
* [Квоты и лимиты в Managed Service for YDB](limits.md).

## СУБД YDB {#ydb}

[YDB](https://ydb.tech/ru) — это горизонтально масштабируемая распределенная отказоустойчивая СУБД. YDB спроектирована с учетом требований высокой производительности — например, обычный сервер может обрабатывать десятки тысяч запросов в секунду. В дизайн системы заложена работа с объемами данных в сотни петабайт. YDB может эксплуатироваться в однодатацентровом и геораспределенном (кросс-датацентровый) режимах на кластере из тысяч серверов.

YDB позволяет обрабатывать транзакции в реальном времени ([OLTP](../../glossary/oltp.md)) и аналитические запросы в режиме онлайн ([OLAP](../../glossary/olap.md)).

Для взаимодействия с YDB доступен [YDB CLI](https://ydb.tech/docs/ru//reference/ydb-cli/), а также [SDK](https://ydb.tech/docs/ru//reference/ydb-sdk/) для C++, Java, Python, Node.js, PHP и Go. В качестве языка запросов к базе данных используется язык [YQL](https://ydb.tech/docs/ru//yql/reference/) (диалект SQL). О назначении и лучших практиках применения инструментов YDB при разработке приложений читайте в разделе [Рекомендации](https://ydb.tech/docs/ru//best_practices/).

Подробнее о концепциях YDB читайте в следующих статьях:

* [Термины и определения](https://ydb.tech/docs/ru//concepts/databases).
* [Модель данных и схема](https://ydb.tech/docs/ru//concepts/datamodel).
* [Транзакции](https://ydb.tech/docs/ru//concepts/transactions).
* [Вторичные индексы](https://ydb.tech/docs/ru//concepts/secondary_indexes).
* [Change Data Capture (CDC)](https://ydb.tech/docs/ru//concepts/cdc).
* [Time to Live (TTL)](https://ydb.tech/docs/ru//concepts/ttl).
* [Скан запросы](https://ydb.tech/docs/ru//concepts/scan_query).
* [Ограничения базы данных](https://ydb.tech/docs/ru//concepts/limits-ydb).
* [Кластер YDB](https://ydb.tech/docs/ru//concepts/cluster/).

## Соглашение об уровне обслуживания {#sla}

Для сервиса действует [соглашение об уровне обслуживания](https://yandex.ru/legal/cloud_sla). Уровень обслуживания сервиса определен в документе [Уровень обслуживания Yandex Managed Service for YDB](https://yandex.ru/legal/cloud_sla_ydb).