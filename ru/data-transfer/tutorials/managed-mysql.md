# Миграция базы данных в {{ mmy-name }}

С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из стороннего кластера-источника в кластер-приемник {{ mmy-name }}.

Этот способ позволяет перенести базу целиком без остановки обслуживания пользователей. Для его использования необходимо разрешить подключение к кластеру-источнику из интернета.

## Перед началом работы {#before-you-begin}

 [Создайте кластер {{ mmy-name }}](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации. При этом:

* Версия {{ MY }} должна быть не ниже чем на кластере-источнике.

    Перенос данных c повышением мажорной версии {{ MY }} возможен, но не гарантируется. Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

    Миграция с понижением версии {{ MY }} [невозможна](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

* [Режим SQL](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) должен быть таким же, как и на кластере-источнике.

## Перенос данных {#data-transfer}

{% include notitle [MySQL migration with Data Transfer](../../_tutorials/datatransfer/managed-mysql.md) %}

## Смотри также {#see-also}

Другие способы миграции описаны в [документации {{ mmy-full-name }}](../../managed-mysql/tutorials/data-migration.md).
