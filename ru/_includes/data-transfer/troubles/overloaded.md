### Прерывание трансфера с ошибкой {#overloaded}

Трансфер типа _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_ прерывается с ошибкой.

Текст ошибки:

```text
/Ydb.PersQueue.V1.PersQueueService/AddReadRule failed: OVERLOADED
```

Трансфер прерывается из-за ограничения облачной [квоты]({{ link-console-quotas }}) на количество операций с {{ ydb-name }}.

**Решение:**

1. Увеличьте в [квотах {{ ydb-name }}](../../../ydb/concepts/limits.md) на облако с нужной базой данных значение характеристики **Количество схемных операций в минуту**.
1. [Перезагрузите](../../../data-transfer/operations/transfer.md#reupload) трансфер.
