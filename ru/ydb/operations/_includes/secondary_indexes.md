---
sourcePath: ru/ydb/overlay/operations/_includes/secondary_indexes.md
---
# Работа со вторичными индексами

## Добавление вторичных индексов {#add-si}

Чтобы добавить [вторичный индекс](../../concepts/secondary_indexes.md) при создании таблицы, используйте конструкцию `INDEX IndexName GLOBAL ON (SomeKey1, ... SomeKeyN)`:

```sql
CREATE TABLE TableName (
    Key1 Type,
    Key2 Type,
    …
    PRIMARY KEY (SomeKey),
    INDEX IndexName1 GLOBAL ON (SomeKey),
    INDEX IndexName2 GLOBAL ON (SomeKey1, SomeKey2, ...)
);
COMMIT;
```

**Пример**

Таблица `series` со вторичными ключами `views_index` по полю `views`, и `users_index` по полю `uploaded_user_id`:

```sql
CREATE TABLE series (
    series_id Uint64,
    title Utf8,
    info Utf8,
    release_date Datetime,
    views Uint64,
    uploaded_user_id Uint64,
    PRIMARY KEY (series_id),
    INDEX views_index GLOBAL ON (views),
    INDEX users_index GLOBAL ON (uploaded_user_id)
);
```
## Выборка по вторичному индексу {#select-si}

Чтобы сделать запрос `SELECT` по вторичному индексу, используйте конструкцию:

```sql
SELECT *
    FROM TableName VIEW IndexName
    WHERE …
```

**Примеры**

* Выбрать все поля из [таблицы](../../yql/reference/syntax/create_table.md#si-add) `series` по индексу `views_index` с условием `views >= someValue`:

  ```sql
  SELECT series_id, title, info, release_date, views, uploaded_user_id
      FROM series VIEW views_index
      WHERE views >= someValue
  ```

* Сделать [`JOIN`](../../yql/reference/syntax/join.md) таблиц `series` и `users` c заданным полем `userName` по индексам `users_index` и `name_index` соответственно:

  ```sql
  SELECT t1.series_id, t1.title
      FROM series VIEW users_index AS t1
      INNER JOIN users VIEW name_index AS t2
      ON t1.uploaded_user_id == t2.user_id
      WHERE t2.name == userName;
  ```
