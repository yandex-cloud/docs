# Brokers

Brokers are hosts in {{ mkf-name }} clusters where [{{ KF }} topics and partitions](topics.md) are located.
Topic partitions store messages that clients ([producers and consumers](producers-consumers.md)) work with.

A broker performs the following functions:

- Accepts connections from clients.

- Provides clients with information about topics, partitions, and other brokers in the cluster.

- Receives requests to read and write messages from clients.

- Stores messages.

- Participates in partition replication.

  Each partition that is replicated has a leader broker that accepts read and write requests and several follower brokers that replicate the leader data. The number of followers depends on the replication factor (the number indicating how many replicas of partition data a cluster should have). For example, if the replication factor is 1, a partition will have no followers. If 2, it will have one follower, if 3, two followers, and so on.

For more information about how brokers work with messages, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#semantics).
