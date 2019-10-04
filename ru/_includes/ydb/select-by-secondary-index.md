Чтобы сделать запрос [`SELECT`](../../ydb/yql/reference/syntax/select.md) по вторичному индексу, используйте конструкцию:

```sql
SELECT * 
    FROM TableName view IndexName
    WHERE …
```

**Примеры**

* Выбрать все поля из таблицы `series` по индексу `views_index` с условием `views >= someValue`:

  ```sql
  SELECT series_id, title, info, release_date, views, uploaded_user_id
      FROM series view views_index
      WHERE views >= someValue
  ```

* Сделать [`JOIN`](../../ydb/yql/reference/syntax/join.md) таблиц `series` и `users` c заданным полем `userName` по индексам `users_index` и `name_index` соответственно:

  ```sql
  SELECT t1.series_id, t1.title
      FROM series view users_index AS t1
      INNER JOIN users view name_index AS t2
      ON t1.uploaded_user_id == t2.user_id
      WHERE t2.name == userName;
  ```