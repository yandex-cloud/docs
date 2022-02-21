Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ таблицы без первичных ключей не переносятся. Чтобы сохранить работоспособность трансфера при переносе базы с такими таблицами:

* Не переносите таблицы без первичных ключей. Для этого добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings.md).
* Добавьте идентификатор реплики на таблицах без `primary key`:
    * Для таблиц с индексом установите `REPLICA IDENTITY` по `unique key`:

        ```sql
        ALTER TABLE MY_TBL REPLICA IDENTITY USING INDEX MY_IDX;
        ```

    * Для таблиц без индекса измените `REPLICA IDENTITY`:

        ```sql
        ALTER TABLE MY_TBL REPLICA IDENTITY FULL;
        ```
