If you are creating a multi-host cluster without using [{{ CK }}](../../../../managed-clickhouse/concepts/replication.md#ck), the following rules apply to {{ ZK }} hosts:

* If the cluster [cloud network](../../../../vpc/concepts/network.md) has subnets in each [availability zone](../../../../overview/concepts/geo-scope.md), and {{ ZK }} host settings are not specified, then one such host will automatically be added to each subnet.

* If only some availability zones in the cluster's network have subnets, specify the {{ ZK }} host settings explicitly.
