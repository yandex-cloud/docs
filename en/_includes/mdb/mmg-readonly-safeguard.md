If at least one host in a {{ mmg-name }} cluster runs out of allocated disk space, the {{ MG }} instance on this host will crash and the host will be disabled. If the host was a [`PRIMARY` replica](../../managed-mongodb/concepts/replication.md), this role will be assigned to one of the `SECONDARY` replicas. As a result of migrating the `PRIMARY` role from one host to another, you may run out of disk space on all hosts in the cluster, which will result in a complete cluster failure.

To avoid this, {{ mmg-name }} monitors disk space in use and automatically enables read-only mode (using the [`db.fsyncLock` method](https://docs.mongodb.com/manual/reference/method/db.fsyncLock/)) for those hosts in the cluster that have:

* Less than 500 MB of free disk space left (if the host storage size is less than 600 GB).
* Less than 5 GB of free disk space left (if the host storage size is 600 GB or more).
