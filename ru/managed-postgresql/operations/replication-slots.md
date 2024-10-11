---
title: Управление слотами репликации в {{ mpg-full-name }}
description: Следуя данной инструкции, вы сможете создать и настроить слот репликации.
---

# Управление слотами репликации

Кластер {{ mpg-name }} может содержать физические и логические слоты репликации:

* Физические слоты создаются сервисом автоматически на базе хостов-реплик и используются для [репликации данных](../concepts/replication.md) в рамках самого кластера {{ mpg-name }}.
* Логические слоты создаются пользователем и используются для [логической репликации](../concepts/replication.md#logical-decoding) данных между кластерами, например при захвате изменений данных (CDC).

Подробности см. [в документации {{ PG }}](https://www.postgresql.org/docs/current/logicaldecoding.html).

## Посмотреть список логических слотов репликации {#list}

1. [Подключитесь](connect.md) к базе данных с помощью учетной записи пользователя с [ролью `mdb_replication`](../concepts/roles.md#mdb-replication).
1. Выполните SQL-запрос:

    ```sql
    SELECT * FROM pg_replication_slots WHERE slot_type='logical';
    ```

    Запрос возвращает таблицу всех логических слотов репликации с их параметрами.

## Создать слот репликации {#create}

1. Задайте максимальный размер WAL при репликации в [настройке](../concepts/settings-list.md#setting-max-slot-wal-keep-size) `Max slot wal keep size`.

    {% note warning %}

    При значении настройки `-1` (размер не ограничен) открытые логические слоты репликации, из которых не считывается информация, будут препятствовать удалению WAL-файлов. В результате WAL-файлы займут все дисковое пространство и вы потеряете возможность подключаться к кластеру.

    {% endnote %}

1. [Подключитесь](connect.md) к базе данных с помощью учетной записи пользователя с [ролью `mdb_replication`](../concepts/roles.md#mdb-replication).
1. Выполните SQL-запрос:

    ```sql
    SELECT pg_create_logical_replication_slot 
    ( '<имя_слота>', '<имя_плагина>', <temporary>, <two_phase> )
    ```

    Где:

    * `<имя_слота>` — уникальное имя слота. Обязательный параметр.
    * `<имя_плагина>` — имя плагина из списка поддерживаемых выходных плагинов. Список см. в разделе [Репликация](../concepts/replication.md#logical-decoding). Обязательный параметр.
    * `temporary` — если выбрано значение `true`, слот будет удален по окончании текущей сессии или при возникновении ошибки. По умолчанию `false`.
    * `two_phase` — если выбрано значение `true`, слот будет декодировать [подготовленные транзакции](https://www.postgresql.org/docs/current/sql-prepare-transaction.html). По умолчанию `false`.

## Удалить слот репликации {#delete}

1. [Подключитесь](connect.md) к базе данных с помощью учетной записи пользователя с [ролью `mdb_replication`](../concepts/roles.md#mdb-replication).
1. Выполните SQL-запрос:

    ```sql
    SELECT pg_drop_replication_slot ('<имя_слота>');
    ```

## Пример {#example}

Чтобы создать новый слот репликации с именем `json_slot`, который декодирует информацию об изменениях базы данных в формат JSON с помощью плагина `wal2json`:

1. Убедитесь, что в [настройке](../concepts/settings-list.md#setting-max-slot-wal-keep-size) `Max slot wal keep size` задано значение, отличное от `-1`.
1. Выполните SQL-запрос:

    ```sql
    SELECT pg_create_logical_replication_slot ( 'json_slot', 'wal2json', false, false );
    ```

    Вариант ответа:

    ```sql
    pg_create_logical_replication_slot 
    ------------------------------------
    (json_slot,1/92001108)
    (1 row)
    ```

1. Убедитесь, что слот появился в списке:

    ```sql
    SELECT * from pg_replication_slots;
    ```

Если слот вам больше не нужен, удалите его:

```sql
SELECT pg_drop_replication_slot ('json_slot');
```
