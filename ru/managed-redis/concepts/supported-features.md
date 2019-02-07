# Ограничения [!KEYREF mrd-name]

[!KEYREF mrd-name] позволяет выполнять [любые команды Redis](https://redis.io/commands), кроме следующих:

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
