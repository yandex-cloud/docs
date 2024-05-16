In {{ mkf-name }} clusters with the {{ kraft-short-name }} protocol, only the _combined mode_ is used, where a [broker](../../../managed-kafka/concepts/brokers.md) and the {{ kraft-short-name }} metadata controller reside on the same {{ KF }} host at the same time. In this case, only three {{ KF }} hosts are created in the cluster in one of these configurations:

* All three are in the same [availability zone](../../../overview/concepts/geo-scope.md).
* Each host is located in a separate availability zone.

[Learn how to create](../../../managed-kafka/operations/cluster-create.md#higher-version) a {{ mkf-name }} cluster with the {{ kraft-short-name }} protocol.
