### Не переносятся данные {#no-transfer}

При попытке перенести данные из источника {{ CH }} выводится ошибка:

```text

Syntax error: failed at position 25 ('-'): <детали_ошибки>. Expected one of: token, Dot, UUID, alias, AS, identifier, FINAL, SAMPLE, INTO OUTFILE, FORMAT, SETTINGS, end of query

```

**Решение:**

{{ data-transfer-full-name }} не может переносить базы данных, в названии которых есть дефис. Переименуйте базу данных, если есть такая возможность.