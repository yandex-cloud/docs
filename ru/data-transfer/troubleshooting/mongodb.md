# {{ MG }}

В некоторых случаях работа трансфера типа _{{ dt-type-repl }}_ на этапе репликации прерывается из-за ошибок:

* Размер объекта в коллекции превышает 16 МБ.

    ```text
    Warn(replication): Usage of bulk objects in 'collection '<имя БД>.<имя коллекции>''
    breaks change event log, transfer is stopping.
    Reason: (BSONObjectTooLarge) BSONObj size: <размер объекта> (<размер объекта в hex>) is invalid.
    Size muse be between 0 and 16793600(16MB).
    ```

* Размер ключа коллекции превышает 5 МБ.

    ```text
    Warn(replication): Usage of bulk objects in 'database <имя БД>'
    breaks change event log, transfer is stopping.
    Reason: (Location<номер позиции>) Tried to create string longer than 16MB.
    ```

Эти ошибки обусловлены [внутренними ограничениями](https://docs.mongodb.com/manual/reference/limits/) {{ MG }} на размер пользовательских объектов.

Для устранения проблемы [исключите](../operations/endpoint/source/mongodb.md) из трансфера коллекции, превышающие лимиты {{ MG }}, после чего [активируйте](../operations/transfer.md#activate) трансфер повторно.
