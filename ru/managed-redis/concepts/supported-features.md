---
title: "Доступные команды {{ mrd-full-name }}"
description: "На странице представлен список команд Redis, которые нельзя выполнить в кластере {{ RD }}." 
---

# Доступные команды {{ mrd-name }}

{{ mrd-name }} позволяет выполнять [любые команды {{ RD }}](https://redis.io/commands), кроме следующих:

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
