---
title: Commands available in {{ mrd-full-name }}
description: This page provides a list of Redis commands which cannot be run in a {{ RD }} cluster.
---

# Supported {{ mrd-name }} commands

{{ mrd-name }} allows you to run [any {{ RD }} commands](https://redis.io/commands), except the following:

* For non-sharded clusters:

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
