### Размер ключа коллекции превышает 5 МБ {#string-size}

Текст ошибки:

```text
Warn(replication): Usage of bulk objects in 'database <имя_БД>'
breaks change event log, transfer is stopping.
Reason: (Location<номер_позиции>) Tried to create string longer than 16MB.
```

Если размер ключа коллекции превышает 5 МБ, трансферы типа _{{ dt-type-repl }}_ прерываются из-за [внутренних ограничений](https://docs.mongodb.com/manual/reference/limits/) {{ MG }} на размер пользовательских объектов.

**Решение:** [исключите](../../../../data-transfer/operations/endpoint/source/mongodb.md) из трансфера коллекции, превышающие лимиты {{ MG }}, после чего [активируйте](../../../../data-transfer/operations/transfer.md#activate) трансфер повторно.
