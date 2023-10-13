### Не удается создать слот репликации на стадии активации {#lock-replication}

В начале работы трансфера создается один или несколько [слотов репликации]({{ pg-docs }}/logicaldecoding-explanation.html#LOGICALDECODING-REPLICATION-SLOTS) в базе-источнике. При этом объекты базы блокируются. Если какой-то объект заблокирован другой транзакцией, возникнет конкурирующая блокировка, и трансфер завершится с ошибкой.

**Решение:**

1. Найдите `PID` процесса, конкурирующего за блокировки с трансфером:

   ```sql
   /* поиск PID трансфера */
   SELECT active_pid
     FROM pg_replication_slots
     WHERE slot_name = '<ID_трансфера>';

   /* поиск PID блокирующего процесса */
   SELECT pid, pg_blocking_pids(pid) as blocked_by
     FROM pg_stat_activity
     WHERE cardinality(pg_blocking_pids(pid)) > 0;
   ```

   ```text
           pid      | blocked_by
   -----------------+-------------------
    <PID_трансфера> | {<PID_блокирующей_транзакции>}
   (1 row)
   ```

1. Посмотрите блокирующий запрос:

   ```sql
   SELECT query, usename
     FROM pg_stat_activity
     WHERE pid = <PID_блокирующей_транзакции>;
   ```

1. (Опционально) Остановите транзакцию командой:

   ```sql
   SELECT pg_terminate_backend(<PID_блокирующей_транзакции>);
   ```

1. [Активируйте трансфер](../../../../data-transfer/operations/transfer.md#activate) повторно.
