### Не добавляются новые таблицы {#no-new-tables}

​В трансфер типа _{{ dt-type-copy-repl}}_ не добавляются новые таблицы.

**Решение:**

* [Деактивируйте](../../../data-transfer/operations/transfer.md#deactivate) и [активируйте](../../../data-transfer/operations/transfer.md#activate) трансфер повторно.
* Создайте таблицу в базе-приемнике вручную.
* [Создайте](../../../data-transfer/operations/transfer.md#create) отдельный трансфер типа _{{ dt-type-copy }}_ и добавьте в него только вновь созданные таблицы. При этом исходный трансфер типа _{{ dt-type-copy-repl}}_ можно не деактивировать.
