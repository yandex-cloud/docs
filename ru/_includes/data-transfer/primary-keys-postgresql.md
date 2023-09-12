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
Если в таблице нет первичных ключей, тогда в логической репликации [не будет событий изменений строк]({{ pg-docs }}/logical-replication-publication.html) (`UPDATE`, `DELETE`).

* Во время трансфера из {{ PG }} в {{ PG }}, если у вас в источнике трансфера не будет исключена таблица без первичных ключей, то вы увидите ошибку: 

   ```text
    failed to run (abstract1 source): Cannot parse logical replication message: failed to reload schema: primary key check failed: Tables: n / N check failed: "public"."MY_TBL": no key columns found
    ```

 * Во время трансфера из {{ PG }} в другую базу данных, если у вас будет добавлена таблица без первичных ключей, то вы увидите ошибку:

   ```text
   failed to run (abstract1 source): Cannot parse logical replication message: failed to reload schema: primary key check failed: Tables: n / N check failed:
   "public"."MY_TBL": no key columns found
   ``` 