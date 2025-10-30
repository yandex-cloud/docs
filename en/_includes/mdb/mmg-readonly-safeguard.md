If at least one host in a {{ mmg-name }} cluster runs out of allocated disk space, the {{ SD }} instance on this host will crash and the host will be disabled. If the host was a [`PRIMARY` replica](../../storedoc/concepts/replication.md), this role will be assigned to one of the `SECONDARY` replicas. As a result of migrating the `PRIMARY` role from one host to another, you may run out of disk space on all hosts in the cluster, which will result in a complete cluster failure.

To avoid this, {{ mmg-name }} monitors how much disk space is used and automatically activates _read-only_ mode (using the `db.fsyncLock` method) for those cluster hosts that have:

* Less than 500 MB of free disk space left (if the host storage size is less than 600 GB).
* Less than 5 GB of free disk space left (if the host storage size is 600 GB or more).
