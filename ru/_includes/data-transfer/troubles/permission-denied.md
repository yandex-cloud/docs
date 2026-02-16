### Отсутствие необходимых прав у пользователя {#permission-denied}

Текст ошибки:

```text
Warn(Activate): failed to load schema using pg_dump:
unable to execute pg_dump to get sequence data:
Unable to exec pg_dump: exit status 1;
stderr: pg_dump: error: query failed: ERROR: permission denied for
```

**Решение:** [подготовьте источник](../../../data-transfer/operations/prepare.md#source) и [активируйте](../../../data-transfer/operations/transfer.md#activate) трансфер повторно.
