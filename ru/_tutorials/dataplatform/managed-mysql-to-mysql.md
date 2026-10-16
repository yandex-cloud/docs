# Миграция на сторонний кластер {{ MY }}


Поддерживается миграция между разными версиями: например, можно перенести базы из {{ MY }} версии 5.7 в версию 8. При этом мажорная версия {{ MY }} на стороннем кластере должна быть не ниже версии на кластере {{ mmy-full-name }}.

Чтобы перенести базу данных, развернутую в кластере {{ mmy-full-name }}, на сторонний кластер {{ MY }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте сторонний кластер {{ MY }}](#prepare-cluster).
1. [Перенесите данные](#transfer-data).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость инфраструктуры для миграции входит плата за каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы {{ data-transfer-name }}](../../data-transfer/pricing.md)).



## Подготовьте сторонний кластер {{ MY }} {#prepare-cluster}

Создайте кластер {{ MY }} любой подходящей конфигурации. При этом:

* Версия {{ MY }} должна быть не ниже чем на кластере-источнике.

    Перенос данных с повышением мажорной версии {{ MY }} возможен, но не гарантируется. Подробнее в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

    Миграция с понижением версии {{ MY }} [невозможна](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

* [Режим SQL](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) должен быть таким же, как и на кластере-источнике.


## Перенесите данные {#transfer-data}

{% include notitle [MySQL migration with Data Transfer](datatransfer/managed-mysql-to-mysql.md) %}


## Как удалить созданные ресурсы {#clear-out}


Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:


{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите](../../data-transfer/operations/transfer.md#delete) остановленный трансфер.
    1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}


## Полезные ссылки {#see-also}

Другие способы миграции описаны в [документации {{ mmy-full-name }}](../../managed-mysql/tutorials/index.md).
