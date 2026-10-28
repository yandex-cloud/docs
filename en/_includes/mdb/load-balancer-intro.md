Using a load balancer gives you the following advantages:

* A single entry point for connecting to the master host.
* Even distribution of read requests among replicas that factors in their load.
* Choice of [load balancing policy](#balancing-policies). For example, you can set `Least connections` to distribute load among replicas with the fewest connections.
* Minimization of cluster unavailability during master failover or changes in the replica composition.
* To switch the application to a new cluster when restoring from a backup, you just need to replace a single FQDN.

The load balancer automatically accounts for changes in cluster topology: new replicas are included in load balancing, and removed ones are excluded.

In the cluster architecture, the load balancer is implemented as a separate service that can be enabled when creating a cluster. The load balancer is assigned a single FQDN common to all [availability zones](../../overview/concepts/geo-scope.md), which serves as a single entry point for all database requests. A load balancer instance is provisioned in every availability zone where your cluster hosts reside.

The load balancer stops and starts simultaneously with the cluster stop and start. The load balancer distributes incoming traffic across all hosts in the cluster. It automatically adds or removes hosts from the load balancing pool as your cluster scales up or down.
