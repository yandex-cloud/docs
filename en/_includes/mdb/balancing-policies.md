Using balancing policies, you can configure a balancer's behavior when distributing queries across cluster replicas. A policy is specified for all types of target connections to replicas when creating a cluster.

The following policies are available:

* `Round Robin`: Selects a replica according to the [Round-Robin](https://en.wikipedia.org/wiki/Round-robin_scheduling) policy.
* `Least connections`: Selects the replica with the fewest connections.
* `Localized Round Robin`: When selecting a replica according to the round-robin policy, priority is given to replicas in the same availability zone as the balancer's instance receiving the query.
