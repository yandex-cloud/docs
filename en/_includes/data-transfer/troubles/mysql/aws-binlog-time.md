### Error when transferring from AWS RDS for {{ MY }} {#aws-binlog-time}

In transfers of type _{{ dt-type-copy-repl }}_ and _{{ dt-type-repl }}_ from the source [Amazon RDS for {{ MY }}](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html) there may be an error loading tables.

Error example:

```text
Failed to execute LoadSnapshot: 
Cannot load table "name": unable to read rows and push by chunks: 
unable to push changes: unable to execute per table push: 
error: err: sql: transaction has already been committed or rolled back 
rollback err: sql: transaction has already been committed or rolled back
```

The error is caused by the short storage time of the {{ MY }} binary log files in Amazon RDS.

**Solution:**

Increase the storage time of the binary log using the command:

```sql
call mysql.rds_set_configuration('binlog retention hours', <hours>);
```

The maximum storage time is 168 hours (7 days). The default value is `NULL' (binary log files are not saved). For more information, see [Amazon RDS Documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/mysql_rds_set_configuration.html).