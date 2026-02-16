### Ошибка external table has more URLs than segments {#external_table_url_limit}

Пример ошибки:

```pgsql
Unable to select and insert with external WRITABLE table: ERROR: external table has more URLs than available primary segments that can write into them
```

Ошибка возникает, если заданное количество потоков больше количества таблиц.

**Решение:** задайте количество потоков, не превышающее количество таблиц.