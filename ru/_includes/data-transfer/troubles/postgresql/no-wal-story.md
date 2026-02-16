### Не хватает истории в WAL для продолжения репликации при смене хоста-мастера {#no-wal-story}

При смене хоста-мастера в кластере-источнике трансферы типа _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_ могут завершиться ошибкой:

```text
ERROR: requested WAL segment pg_wal/0000000E0000022700000087 has already been removed (SQLSTATE 58P01)
```

Ошибка возникает, если хранимой в [WAL](https://www.postgresql.org/docs/current/wal-intro.html) на новом мастере истории недостаточно для продолжения репликации с того же места.

**Решение**: увеличьте в кластере-источнике значение [настройки](../../../../managed-postgresql/concepts/settings-list.md#setting-wal-keep-size) `Wal keep size`. В качестве минимального значения рекомендуется взять среднее значение из графика **Source buffer size** в [мониторинге {{ data-transfer-name }}](../../../../data-transfer/operations/monitoring.md). Если на диске достаточно свободных ресурсов, укажите значение настройки с запасом.
