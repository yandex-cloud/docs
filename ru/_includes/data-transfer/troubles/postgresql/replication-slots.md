### Не хватает слотов репликации в базе данных источника {#replication-slots}

Текст ошибки:

```text
Warn(Activate): failed to create a replication slot "<идентификатор трансфера>" at source:
failed to create a replication slot:
failed to create a replication slot:
ERROR: all replication slots are in use
(SQLSTATE 53400)
```

**Решение:** увеличьте количество [слотов репликации]({{ pg-docs }}/logical-replication-config.html) в базе-источнике (по умолчанию `10`).
