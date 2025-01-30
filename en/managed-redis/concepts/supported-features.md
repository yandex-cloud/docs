---
title: Available {{ mrd-full-name }} commands
description: This page provides a list of {{ VLK }} commands which you cannot run in a {{ VLK }} cluster.
---

# Available {{ mrd-name }} commands

{{ mrd-name }} allows you to run [any {{ VLK }}](https://valkey.io/commands) commands, except the following ones:

* For a non-sharded cluster:

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

* The same commands are not supported for [sharded](sharding.md) clusters as for non-sharded ones, plus the following:

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
