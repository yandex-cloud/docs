# Brokers

Brokers are hosts in a {{ mkf-name }} cluster where [{{ KF }} topics and partitions](topics.md) reside.
Topic partitions store messages that clients [(producers and consumers)](producers-consumers.md) work with.

A broker performs the following functions:
- Accepts connections from clients.
- Provides clients with information about topics, partitions, and other brokers in the cluster.
- Receives requests to read and write messages from clients.
- Stores messages.
- Participates in partition replication.

  Each replicated partition has a leader broker that accepts read and write requests, and multiple follower brokers that replicate the leader data. The number of followers depends on the replication factor, i.e., the number that determines how many replicas of partition data a cluster has. For example, if the replication factor equals to 1, a partition will have no followers; if it is 2, it will have one follower, if 3, two followers, etc.

For more information about how brokers handle messages, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#semantics).