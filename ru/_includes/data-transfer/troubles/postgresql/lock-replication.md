### Не удается создать слот репликации на стадии активации {#lock-replication}

В начале работы трансфера создается один или несколько [слотов репликации]({{ pg-docs }}/logicaldecoding-explanation.html#LOGICALDECODING-REPLICATION-SLOTS) в базе-источнике. При этом объекты базы блокируются. Если какой-то объект заблокирован другой транзакцией, возникнет конкурирующая блокировка, и трансфер завершится с ошибкой.

**Решение:**

1. Найдите процесс, конкурирующий за блокировки с трансфером:

   ```sql
   SELECT
     activity.pid,
     activity.usename,
     activity.query,
     blocking.pid AS blocking_id,
     blocking.query AS blocking_query
   FROM
     pg_stat_activity AS activity
     JOIN pg_stat_activity AS blocking ON blocking.pid = ANY(
       pg_blocking_pids(activity.pid)
     )
   WHERE
     activity.query like '%<идентификатор_трансфера>%';
   ```

   Идентификатор трансфера можно получить со [списком трансферов в каталоге](../../../../data-transfer/operations/transfer.md#list).

   Ответ:

   ```text
          pid      |      usename       |      query      |         blocking_id          |    blocking_query
   ----------------+--------------------+-----------------+------------------------------+----------------------
   <PID_трансфера> | <имя_пользователя> | <текст_запроса> | <PID_блокирующей_транзакции> | <блокирующий_запрос>
   (1 row)
   ```

1. Остановите транзакцию командой:

   ```sql
   SELECT pg_terminate_backend(<PID_блокирующей_транзакции>);
   ```

1. [Активируйте трансфер](../../../../data-transfer/operations/transfer.md#activate) повторно.
