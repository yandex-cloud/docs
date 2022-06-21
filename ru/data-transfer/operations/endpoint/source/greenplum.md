# Настройка эндпоинта-источника {{ GP }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

## Пользовательская инсталляция {#on-premise}

Подключение к БД с явным указанием сетевых адресов и портов.

{% list tabs %}

- Консоль управления

    {% include [On premise Greenplum UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-greenplum.md) %}

    {% include [Common Greenplum table list UI](../../../../_includes/data-transfer/necessary-settings/ui/greenplum-table-list.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs %}

- Консоль управления

    * **Ограничение на размер буфера** — ограничение потребления памяти трансфером (в байтах). Чем больше размер буфера, тем быстрее выполняется перенос данных, но возникает риск аварийного завершения работы трансфера из-за исчерпания доступного объёма памяти. Рекомендуем использовать значение по умолчанию.

    * **Схема служебных объектов** — схема, которая будет использоваться для размещения служебных объектов трансфера.

        Например, чтобы обеспечить целостность снапшотов ([snapshot consistency](https://docs.greenplum.org/6-16/admin_guide/dml.html)) для [heap-таблиц](https://docs.greenplum.org/6-8/admin_guide/ddl/ddl-storage.html#topic37), в процессе работы трансфера создается служебная функция, которая будет размещена в указанной схеме.

{% endlist %}

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
