### Размер объекта в коллекции превышает 16 МБ {#object-size}

Текст ошибки:

```text
Warn(replication): Usage of bulk objects in 'collection '<имя БД>.<имя коллекции>''
breaks change event log, transfer is stopping.
Reason: (BSONObjectTooLarge) BSONObj size: <размер объекта> (<размер объекта в hex>) is invalid.
Size muse be between 0 and 16793600(16MB).
```

Если размер объекта в коллекции превышает 16 МБ, трансферы типа _{{ dt-type-repl }}_ прерываются из-за [внутренних ограничений](https://docs.mongodb.com/manual/reference/limits/) {{ MG }} на размер пользовательских объектов.

**Решение:** [исключите](../../../../data-transfer/operations/endpoint/source/mongodb.md) из трансфера коллекции, превышающие лимиты {{ MG }}, после чего [активируйте](../../../../data-transfer/operations/transfer.md#activate) трансфер повторно.
