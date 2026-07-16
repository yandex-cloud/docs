Depending on its type, maintenance can impact your cluster as follows:

* Show little to no impact on database users.
* Break database connections in place, forcing clients to re-establish their connections.
* Make your cluster read-only for a while.
* Restart the master and trigger master failover to one of the replicas.
* Cause master host failover in the cluster, making the database read-only for a while.

Maintenance tasks have an estimated duration and completion date. These time frames are calculated based on historical data from similar operations. The actual completion times may vary depending on your cluster.
