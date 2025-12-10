If you are creating a multi-host cluster without using [{{ CK }}](../../../../managed-clickhouse/concepts/replication.md#ck), the following rules apply to {{ ZK }} hosts:

* If the cluster [cloud network](../../../../vpc/concepts/network.md) has subnets in each [availability zone](../../../../overview/concepts/geo-scope.md), and {{ ZK }} host settings are not specified, then {{ ZK }} hosts will automatically be added, one per subnet.

* If only some availability zones in the cluster network have subnets, specify the {{ ZK }} host settings explicitly.
