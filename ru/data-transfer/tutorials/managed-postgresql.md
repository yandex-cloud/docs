# Миграция данных в {{ mpg-full-name }}

Чтобы перенести вашу базу данных в сервис {{ mpg-full-name }}, нужно непосредственно перенести данные, закрыть старую базу данных на запись и переключить нагрузку на кластер БД в {{ yandex-cloud }}.

Миграция с помощью {{ data-transfer-name }} позволяет:

* обойтись без создания промежуточной {% if lang == "ru" and audience != "internal" %}[виртуальной машины](../../glossary/vm.md){% else %}виртуальной машины{% endif %} или разрешения доступа к вашему кластеру-приемнику {{ mpg-name }} из интернета;
* минимизировать время недоступности базы данных при миграции;
* мигрировать со старых версий {{ PG }} на более новые.

Подробнее см. в разделе [{#T}](../concepts/use-cases.md).

Чтобы использовать этот способ миграции, разрешите подключение к кластеру-источнику из интернета.

## Перенос данных {#data-transfer}

{% include notitle [MPG moving data with Data Transfer](../../_tutorials/datatransfer/managed-postgresql.md) %}

## Перенос таблиц с типами данных из расширений {{ PG }}

Сервис {{ data-transfer-name }} поддерживает копирование таблиц, содержащих столбцы с типами данных, определённых в расширениях {{ PG }}, а также копирование таблиц с производными типами (массивами таких типов и композитными типами с полями таких типов). Однако на данный момент есть ограничение — тип данных должен реализовывать __функции двоичного ввода и вывода__. То есть, для типа данных в системной таблице [pg_type](https://www.postgresql.org/docs/current/catalog-pg-type.html) значения в колонках `typsend` и `typreceive` должны быть отличны от нуля.

Например, для расширения [PostGIS](https://postgis.net/) перенос колонок с типами [`GEOMETRY`](https://postgis.net/docs/geometry.html), [`GEOMETRY_DUMP`](https://postgis.net/docs/geometry_dump.html) и [`GEOGRAPHY`](https://postgis.net/docs/geography.html) поддержан, а перенос типов [`BOX2D`](https://postgis.net/docs/box2d_type.html) и [`BOX3D`](https://postgis.net/docs/box3d_type.html) на данный момент не поддержан.

## См. также {#see-also}

Другие способы миграции описаны в [документации {{ mpg-full-name }}](../../managed-postgresql/tutorials/data-migration.md).
