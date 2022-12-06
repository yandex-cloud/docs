# Обзор {{ ydb-full-name }}

Сервис {{ ydb-full-name }} обеспечивает создание и управление базами данных {{ ydb-short-name }} в {{ yandex-cloud }}.

Подробнее о концепциях сервиса {{ ydb-full-name }} читайте в следующих статьях:

* [{#T}](resources.md).
* [{#T}](serverless-and-dedicated.md).
* [{#T}](dynamodb-tables.md).
* [{#T}](limits.md).

## СУБД {{ ydb-short-name }} {#ydb}

[{{ ydb-short-name }}](https://ydb.tech/ru) — это горизонтально масштабируемая распределенная отказоустойчивая СУБД. {{ ydb-short-name }} спроектирована с учетом требований высокой производительности — например, обычный сервер может обрабатывать десятки тысяч запросов в секунду. В дизайн системы заложена работа с объемами данных в сотни петабайт. {{ ydb-short-name }} может эксплуатироваться в однодатацентровом и геораспределенном (кросс-датацентровый) режимах на кластере из тысяч серверов.

Для взаимодействия с {{ ydb-short-name }} доступен [{{ ydb-short-name }} CLI](https://ydb.tech/ru/docs/reference/ydb-cli/), а также [SDK](https://ydb.tech/ru/docs/reference/ydb-sdk/) для C++, Java, Python, Node.js, PHP и Go. В качестве языка запросов к базе данных используется язык [YQL](https://ydb.tech/ru/docs/yql/reference/) (диалект SQL). О назначении и лучших практиках применения инструментов {{ ydb-short-name }} при разработке приложений читайте в разделе [Рекомендации](https://ydb.tech/ru/docs/best_practices/).

Подробнее об архитектуре {{ ydb-short-name }} читайте в следующих статьях:

* [Термины и определения](https://ydb.tech/ru/docs/concepts/databases).
* [Модель данных и схема](https://ydb.tech/ru/docs/concepts/datamodel).
* [Транзакции](https://ydb.tech/ru/docs/concepts/transactions).
* [Вторичные индексы](https://ydb.tech/ru/docs/concepts/secondary_indexes).
* [Time to Live (TTL)](https://ydb.tech/ru/docs/concepts/ttl).
* [Скан запросы](https://ydb.tech/ru/docs/concepts/scan_query).
* [Ограничения базы данных](https://ydb.tech/ru/docs/concepts/limits-ydb).
* [Кластер {{ ydb-short-name }}](https://ydb.tech/ru/docs/concepts/cluster/).


## Соглашение об уровне обслуживания {#sla}

Для сервиса действует [соглашение об уровне обслуживания](https://yandex.ru/legal/cloud_sla). Уровень обслуживания сервиса определен в документе [Уровень обслуживания Yandex {{ ydb-name }}](https://yandex.ru/legal/cloud_sla_ydb).

