---
title: Обзор {{ ydb-full-name }}
description: Из статьи вы узнаете про СУБД {{ ydb-short-name }} и соглашение об уровне обслуживания.
---

# Обзор {{ ydb-full-name }}


Сервис {{ ydb-full-name }} обеспечивает создание и управление базами данных {{ ydb-short-name }} в {{ yandex-cloud }}.

Подробнее о концепциях сервиса {{ ydb-full-name }} читайте в следующих статьях:

* [{#T}](resources.md).
* [{#T}](serverless-and-dedicated.md).
* [{#T}](dynamodb-tables.md).
* [{#T}](limits.md).

## СУБД {{ ydb-short-name }} {#ydb}

[{{ ydb-short-name }}](https://ydb.tech/ru) — это горизонтально масштабируемая распределенная отказоустойчивая СУБД. {{ ydb-short-name }} спроектирована с учетом требований высокой производительности — например, обычный сервер может обрабатывать десятки тысяч запросов в секунду. В дизайн системы заложена работа с объемами данных в сотни петабайт. {{ ydb-short-name }} может эксплуатироваться в однодатацентровом и геораспределенном (кросс-датацентровый) режимах на кластере из тысяч серверов.

{{ ydb-short-name }} позволяет обрабатывать транзакции в реальном времени ([OLTP](../../glossary/oltp.md)) и аналитические запросы в режиме онлайн ([OLAP](../../glossary/olap.md)).

Для взаимодействия с {{ ydb-short-name }} доступен [{{ ydb-short-name }} CLI]({{ ydb.docs }}/reference/ydb-cli/), а также [SDK]({{ ydb.docs }}/reference/ydb-sdk/) для C++, Java, Python, Node.js, PHP и Go. В качестве языка запросов к базе данных используется язык [YQL]({{ ydb.docs }}/yql/reference/) (диалект SQL). О назначении и лучших практиках применения инструментов {{ ydb-short-name }} при разработке приложений читайте в разделе [Рекомендации]({{ ydb.docs }}/best_practices/).

Подробнее о концепциях {{ ydb-short-name }} читайте в следующих статьях:

* [Термины и определения]({{ ydb.docs }}/concepts/databases).
* [Модель данных и схема]({{ ydb.docs }}/concepts/datamodel).
* [Транзакции]({{ ydb.docs }}/concepts/transactions).
* [Вторичные индексы]({{ ydb.docs }}/concepts/secondary_indexes).
* [Change Data Capture (CDC)]({{ ydb.docs }}/concepts/cdc).
* [Time to Live (TTL)]({{ ydb.docs }}/concepts/ttl).
* [Скан запросы]({{ ydb.docs }}/concepts/scan_query).
* [Ограничения базы данных]({{ ydb.docs }}/concepts/limits-ydb).
* [Кластер {{ ydb-short-name }}]({{ ydb.docs }}/concepts/cluster/).


## Соглашение об уровне обслуживания {#sla}

Для сервиса действует [соглашение об уровне обслуживания](https://yandex.ru/legal/cloud_sla). Уровень обслуживания сервиса определен в документе [Уровень обслуживания Yandex {{ ydb-name }}](https://yandex.ru/legal/cloud_sla_ydb).

