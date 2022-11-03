### Ошибка при трансфере из AWS RDS for {{ MY }} {#aws-binlog-time}

В трансферах типа _{{ dt-type-copy-repl}}_ и _{{ dt-type-repl}}_ из источника [Amazon RDS for {{ MY }}](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html) может возникнуть ошибка загрузки таблиц.

Пример ошибки:

```text
Failed to execute LoadSnapshot: 
Cannot load table "name": unable to read rows and push by chunks: 
unable to push changes: unable to execute per table push: 
error: err: sql: transaction has already been committed or rolled back 
rollback err: sql: transaction has already been committed or rolled back
```

Ошибка вызвана коротким временем хранения файлов бинарного лога {{ MY }} в Amazon RDS.

**Решение:**

Увеличьте время хранения бинарного лога с помощью команды:

```sql
call mysql.rds_set_configuration('binlog retention hours', <кол-во часов>);
```

Максимальное значение времени хранения — 168 ч (7 дней). Значение по умолчанию — `NULL` (файлы бинарного лога не сохраняются). Подробнее см. в [документации Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/mysql_rds_set_configuration.html).
