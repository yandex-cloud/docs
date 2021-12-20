Чтобы добавить [вторичный индекс](../../../concepts/secondary_indexes.md) при создании таблицы, используйте конструкцию `INDEX IndexName GLOBAL ON (SomeKey1, ... SomeKeyN)`:

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
