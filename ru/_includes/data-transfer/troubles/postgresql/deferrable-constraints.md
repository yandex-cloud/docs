### Ошибка трансфера таблиц с отложенными ограничениями {#deferrable-constr}

Ошибка возникает в трансферах типа {{ dt-type-repl }} или {{ dt-type-copy-repl }}, так как обновление таблиц и транзакций с отложенными (`DEFERRABLE`) ограничениями не поддерживается {{ data-transfer-name }}. Подробнее об отложенных ограничениях см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/sql-set-constraints.html).

**Решение:** замените тип ограничений в таких таблицах на `IMMEDIATE` и [активируйте](../../../../data-transfer/operations/transfer.md#activate) трансфер повторно.
