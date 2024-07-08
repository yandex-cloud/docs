* For transfers with the {{ dt-status-copy }} status, you cannot perform any actions reducing the origin's _operation log_ (oplog) time window. You should not add, delete, or reconfigure shards in any way during copying or perform any other actions resulting in a shorter operation log time window.

* In transfers in {{ dt-status-repl }} status, you may encounter the key duplication problem when a sharded {{ MG }} cluster with a sharding index other than `_id` is the target. While a transfer is underway, we caution against creating clusters with sharding indexes other than `_id` on the target.
