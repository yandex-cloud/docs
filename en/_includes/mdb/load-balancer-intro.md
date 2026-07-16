Using a load balancer gives you the following advantages:

* A single entry point for connecting to the master host.
* Even distribution of read requests among replicas, taking their load into account
* Choice of load balancing policy. For example, you can set `Least connections` to distribute load to replicas with the fewest connections.
* Minimization of cluster unavailability during master failover or changes in the replica composition.
* To switch the application to a new cluster when restoring from a backup, you just need to replace a single FQDN.

The load balancer automatically accounts for changes in cluster topology: new replicas are included in load balancing, and removed ones are excluded.

In the cluster architecture, the load balancer is implemented as a separate service that can be enabled when creating or modifying a cluster. The load balancer stops and starts simultaneously with the cluster stop and start. The load balancer is assigned a single FQDN common to all availability zones, which serves as a single entry point for all database requests.Incoming traffic to the load balancer is distributed across all hosts in the cluster, and when hosts are added or removed from the cluster, they are automatically added to or removed from balancing.