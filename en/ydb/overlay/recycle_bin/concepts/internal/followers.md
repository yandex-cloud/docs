<!-- incorporated into concepts/datamodel/table#read_only_replicas -->

#### Role of table shard followers

Physically, table shards are served by partitions that provide consistent, reliable storage on a shared distributed storage. The partitions also serve the distributed transaction protocol. In this schema (the classic one with an active partition leader), all queries to the table shard are made at a single point.

By storing data on a shared store, in YDB you can run one or more shard followers without allocating additional space on the store: the data is already stored in replicated format and you can serve more than one reader (but the writer is still strictly one at every moment).

Such followers can be used for:
* Serving clients demanding minimal delays otherwise unachievable in a multi-DC cluster. This is achieved by bringing the query execution point closer to the query formulation point, which eliminates the delay associated with inter-DC transfers. As a result, you can both preserve all the storage reliability guarantees of the multi-DC cluster and respond to occasional read queries in milliseconds.
* Handling read requests from followers without affecting modifying queries running on the shard. This can be useful both for isolating different scenarios and for increasing the partition bandwidth.
* Ensuring continued maintenance when moving the partition leader (both in regular cases (balancing) and in an emergency). It lets the processes in the cluster survive without affecting the reading clients.

#### Guarantees

The internal state of each of the followers is restored exactly and fully consistently from the leader state.

Besides the data status in storage, followers also receive a stream of updates from the leader. Updates are sent in real time, immediately after the commit to the log. However, they are sent asynchronously, resulting in some delay (dozens of milliseconds) in applying updates to followers relative to their commit on the leader.

If there are multiple followers, their delay from the leader may vary: although each follower of each of the shards retains internal consistency, artifacts may be observed between different shards. Please allow for this in your application code. For that same reason, it's currently impossible to perform cross-shard transactions from followers.
