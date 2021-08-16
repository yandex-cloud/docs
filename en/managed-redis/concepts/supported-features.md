# Limitations {{ mrd-name }}

{{ mrd-name }} lets you run [any Redis command](https://redis.io/commands), except the following:

- `BGREWRITEAOF`
- `BGSAVE`
- `COMMAND`
- `CONFIG`
- `DEBUG`
- `LASTSAVE`
- `MIGRATE`
- `MODULE`
- `MONITOR`
- `MOVE`
- `OBJECT`
- `REPLICAOF`
- `SAVE`
- `SHUTDOWN`
- `SLAVEOF`

