# Ограничения Managed Service for Redis

Managed Service for Redis позволяет выполнять [любые команды Redis](https://redis.io/commands), кроме следующих:

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
