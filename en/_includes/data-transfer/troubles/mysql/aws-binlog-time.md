### Error when transferring from AWS RDS for {{ MY }} {#aws-binlog-time}

_{{ dt-type-copy-repl }}_ and _{{ dt-type-repl }}_ transfers from the [Amazon RDS for {{ MY }}](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html) source might experience a table loading error.

Error example:

```text
Failed to execute LoadSnapshot:
Cannot load table "name": unable to read rows and push by chunks:
unable to push changes: unable to execute per table push:
error: err: sql: transaction has already been committed or rolled back
rollback err: sql: transaction has already been committed or rolled back
```

This error is caused by the short {{ MY }} binary log file retention time in Amazon RDS.

**Solution:**

Increase the binary log retention time by using the command below:

```sql
call mysql.rds_set_configuration('binlog retention hours', <hours>);
```

The maximum retention time is 168 hours (7 days). The default is `NULL` (binary log files are not retained). For more information, see the [Amazon RDS documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/mysql_rds_set_configuration.html).
