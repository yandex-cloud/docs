[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Valkey™](../index.md) > [Концепции](index.md) > Доступные команды

# Доступные команды Yandex Managed Service for Valkey™

Yandex Managed Service for Valkey™ позволяет выполнять [любые команды Valkey™](https://valkey.io/commands), кроме следующих:

* Для нешардированного кластера:

    - `ACL`
    - `BGREWRITEAOF`
    - `BGSAVE`
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

* Для [шардированного](sharding.md) кластера недоступны те же команды, что и для нешардированного, а также:

    - `ADDSLOTS`
    - `ADDSLOTSRANGE`
    - `BUMPEPOCH`
    - `DELSLOTS`
    - `DELSLOTSRANGE`
    - `FAILOVER`
    - `FLUSHSLOTS`
    - `FORGET`
    - `MEET`
    - `REPLICATE`
    - `RESET`
    - `SAVECONFIG`
    - `SET-CONFIG-EPOCH`
    - `SETSLOT`