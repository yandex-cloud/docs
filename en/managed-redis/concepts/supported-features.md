# Restrictions {{ mrd-name }}

{{ mrd-name }} allows you to run [any Redis commands](https://redis.io/commands), except the following:

- `BGREWRITEAOF`
- `BGSAVE`
- `CLUSTER`
- `COMMAND`
- `CONFIG`
- `DEBUG`
- `EVAL`
- `EVALSHA`
- `LASTSAVE`
- `MIGRATE`
- `MODULE`
- `MONITOR`
- `MOVE`
- `OBJECT`
- `REPLICAOF`
- `SAVE`
- `SCRIPT`
- `SHUTDOWN`
- `SLAVEOF`

