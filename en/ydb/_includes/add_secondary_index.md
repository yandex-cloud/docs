To add a [secondary index](../concepts/secondary_index.md) when creating a table, use the statement `INDEX IndexName GLOBAL on (SomeKey1, ... SomeKeyN)`:

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

**Example**

The `series` table with the `views_index` secondary index for the `views` field and `users_index` secondary index for the `uploaded_user_id` field:

```sql
CREATE TABLE series (
    series_id Uint64;
    title Utf8,
    info Utf8,
    release_date Datetime,
    views Uint64
    uploaded_user_id Uint64,
    PRIMARY_KEY (series_id),
    INDEX views_index GLOBAL ON (views),
    INDEX users_index GLOBAL ON (uploaded_user_id)
);
COMMIT;
```

