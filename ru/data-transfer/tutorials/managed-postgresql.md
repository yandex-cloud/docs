# Миграция базы данных в {{ mpg-full-name }}

Чтобы перенести вашу базу данных в сервис {{ mpg-full-name }}, нужно непосредственно перенести данные, закрыть старую базу данных на запись и переключить нагрузку на кластер БД в {{ yandex-cloud }}.

Миграция с помощью {{ data-transfer-name }} позволяет:

* обойтись без создания промежуточной [виртуальной машины](../../glossary/vm.md) или разрешения доступа к вашему кластеру-приемнику {{ mpg-name }} из интернета;
* минимизировать время недоступности базы данных при миграции;
* мигрировать со старых версий {{ PG }} на более новые.

Подробнее см. в разделе [{#T}](../concepts/use-cases.md).

Чтобы использовать этот способ миграции, разрешите подключение к кластеру-источнику из интернета.

## Перенос данных {#data-transfer}

{% include notitle [MPG moving data with Data Transfer](../../_tutorials/datatransfer/managed-postgresql.md) %}

## Перенос таблиц со столбцами tsvector {#tsvector}

По умолчанию копирование таблиц с [типом данных `tsvector`]({{ pg-docs }}/datatype-textsearch.html#DATATYPE-TSVECTOR) выполняется при помощи команд `INSERT`, что значительно медленнее стандартного копирования. Для ускорения [переноса данных](#data-transfer) выполните действия:

1. При [подготовке кластера-приемника](../../data-transfer/operations/prepare.md#target-pg) создайте таблицы со столбцами `tsvector` в кластере-приемнике вручную, но замените тип столбцов с `tsvector` на `text`.
1. При [создании эндпоинта для приемника](../../data-transfer/operations/endpoint/index.md#create) установите в настройках для поля **Политика очистки** значение `Не очищать`.
1. После [активации трансфера](../../data-transfer/operations/transfer.md#activate) и перехода его в статус {{ dt-status-repl }} приведите данные в нужных столбцах к типу `tsvector`:

    ```sql
    ALTER TABLE <имя таблицы>
    ALTER COLUMN <имя столбца> SET DATA TYPE tsvector
    USING
    to_tsvector(<имя столбца>);
    ```

## См. также {#see-also}

Другие способы миграции описаны в [документации {{ mpg-full-name }}](../../managed-postgresql/tutorials/data-migration.md).
