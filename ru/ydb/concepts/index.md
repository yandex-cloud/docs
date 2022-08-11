# Обзор {{ ydb-full-name }}

Сервис {{ ydb-full-name }} обеспечивает создание и управление базами данных {{ ydb-short-name }} в {{ yandex-cloud }}.

Подробнее о концепциях сервиса {{ ydb-full-name }} читайте в следующих статьях:

* [{#T}](resources.md).
* [{#T}](serverless-and-dedicated.md).
* [{#T}](dynamodb-tables.md).
* [{#T}](limits.md).

## СУБД {{ ydb-short-name }} {#ydb}

[{{ ydb-short-name }}]{% if lang == "en" %}(https://ydb.tech/en){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru){% endif %} — это горизонтально масштабируемая распределенная отказоустойчивая СУБД. {{ ydb-short-name }} спроектирована с учетом требований высокой производительности — например, обычный сервер может обрабатывать десятки тысяч запросов в секунду. В дизайн системы заложена работа с объемами данных в сотни петабайт. {{ ydb-short-name }} может эксплуатироваться в однодатацентровом и геораспределенном (кросс-датацентровый) режимах на кластере из тысяч серверов.

Для взаимодействия с {{ ydb-short-name }} доступен [{{ ydb-short-name }} CLI]{% if lang == "en" %}(https://ydb.tech/en/docs/reference/ydb-cli/){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/reference/ydb-cli/){% endif %}, а также [SDK]{% if lang == "en" %}(https://ydb.tech/en/docs/reference/ydb-sdk/){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/reference/ydb-sdk/){% endif %} для C++, Java, Python, Node.js, PHP и Go. В качестве языка запросов к базе данных используется язык [YQL]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/){% endif %} (диалект SQL). О назначении и лучших практиках применения инструментов {{ ydb-short-name }} при разработке приложений читайте в разделе [Рекомендации]{% if lang == "ru" %}(https://ydb.tech/ru/docs/best_practices/){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/best_practices/){% endif %}.

Подробнее об архитектуре {{ ydb-short-name }} читайте в следующих статьях:

* [Термины и определения]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/databases){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/databases){% endif %}.
* [Модель данных и схема]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/datamodel){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/datamodel){% endif %}.
* [Транзакции]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/transactions){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/transactions){% endif %}.
* [Вторичные индексы]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/secondary_indexes){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/secondary_indexes){% endif %}.
* [Time to Live (TTL)]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/ttl){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/ttl){% endif %}.
* [Скан запросы]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/scan_query){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/scan_query){% endif %}.
* [Ограничения базы данных]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/limits-ydb){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/limits-ydb){% endif %}.
* [Кластер {{ ydb-short-name }}]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/cluster/){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/cluster/){% endif %}.

## Соглашение об уровне обслуживания {#sla}

Для сервиса действует [соглашение об уровне обслуживания]{% if lang == "ru" %}(https://yandex.ru/legal/cloud_sla){% endif %}{% if lang == "en" %}(https://yandex.com/legal/cloud_sla){% endif %}. Уровень обслуживания сервиса определен в документе [Уровень обслуживания Yandex {{ ydb-name }}]{% if lang == "ru" %}(https://yandex.ru/legal/cloud_sla_ydb){% endif %}{% if lang == "en" %}(https://yandex.com/legal/cloud_sla_ydb){% endif %}.
