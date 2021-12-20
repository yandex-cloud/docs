---
title: Yandex Database (YDB). Обзор СУБД
description: 'Yandex Database (YDB) — это горизонтально масштабируемая распределённая отказоустойчивая СУБД. YDB спроектирована с учетом требований высокой производительности — например, обычный сервер может обрабатывать десятки тысяч запросов в секунду. В дизайн системы заложена работа с объемами данных в сотни петабайт.'
---

# Обзор Yandex Database (YDB)

*{{ ydb-full-name }}* ({{ ydb-short-name }}) — это горизонтально масштабируемая распределённая отказоустойчивая СУБД. {{ ydb-short-name }} спроектирована с учетом требований высокой производительности — например, обычный сервер может обрабатывать десятки тысяч запросов в секунду. В дизайн системы заложена работа с объемами данных в сотни петабайт. {{ ydb-short-name }} может эксплуатироваться в однодатацентровом и геораспределенном (кросс-датацентровый) режимах на кластере из тысяч серверов.

{{ ydb-short-name }} обеспечивает:

* [строгую консистентность](https://en.wikipedia.org/wiki/Consistency_model#Strict_Consistency) с возможностью ослабления для увеличения производительности;
* поддержку запросов [YQL]{% if audience == "external" %}(../../yql/reference/overview.md){% else %}(http://yql.yandex-team.ru/docs/ydb){% endif %} (диалект SQL для работы с большими данными);
* автоматическую репликацию данных;
* высокую доступность с автоматической обработкой отказов вычислительных узлов, стоек, или зон доступности;
* автоматическое партицирование данных при увеличении их объема или увеличении нагрузки.

Для взаимодействия с {{ ydb-short-name }} доступен [YDB CLI]{% if audience == "external" %}(../../quickstart/yql-api/ydb-cli.md){% else %}(../../oss/public/reference/ydb-cli/install.md){% endif %}, а также SDK для {% if oss %}[C++](../../getting_started/start_cpp.md),{% endif %}  [Java](https://github.com/yandex-cloud/ydb-java-sdk), [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk) и [Go](https://github.com/yandex-cloud/ydb-go-sdk)

{{ ydb-short-name }} поддерживает реляционную [модель данных](../../concepts/datamodel.md) и оперирует таблицами с предопределённой схемой. Для удобства организации таблиц поддерживается создание директорий по аналогии с файловой системой.

В качестве основного способа формирования команд к базе данных используется язык YQL, являющийся диалектом SQL. Таким образом, пользователю предлагается мощный и, в то же время, привычный способ взаимодействия с БД.

В {{ ydb-short-name }} поддерживаются высокопроизводительные распределенные [ACID](https://en.wikipedia.org/wiki/ACID_(computer_science))-транзакции, которые могут затрагивать несколько записей из разных таблиц. Обеспечивается самый строгий уровень изоляции транзакций — serializable. Также имеется возможность ослабления уровня изоляции для увеличения производительности.

В дизайн {{ ydb-short-name }} заложена поддержка разных сценариев нагрузки, таких как [OLTP](https://en.wikipedia.org/wiki/Online_transaction_processing) и [OLAP](https://en.wikipedia.org/wiki/Online_analytical_processing). В текущей реализации поддержка аналитических запросов ограничена. Поэтому можно говорить, что в данный момент {{ ydb-short-name }} — это OLTP-база данных.

{{ ydb-short-name }} используется в сервисах Яндекса в качестве высокопроизводительной [OLTP](https://en.wikipedia.org/wiki/Online_transaction_processing) СУБД. В частности, сервисы {{ yandex-cloud }} Yandex Object Storage и Yandex Block Storage используют {{ ydb-short-name }} для хранения данных и базируются на её компонентах.

## YDB в Yandex.Cloud

Вы можете создать базу данных в бессерверной (Serverless) конфигурации или с выделенными серверами (Dedicated). Подробнее о различиях в конфигурациях читайте в разделе [{#T}](../serverless_and_dedicated.md).

{% if audience == "internal" or audience == "tech" %}

## YDB в Yandex

Взаимодействие SDK с серверами YDB построено на базе протокола gRPC. Спецификация протокола взаимодействия с {{ ydb-short-name }} открыта. Это позволяет реализовать SDK для любого языка программирования.{% if oss != true %} В дополнение к перечисленным выше OpenSource SDK внутри Yandex доступен [C++ SDK](../operations/start_cpp.md).{% endif %}

{% endif %}