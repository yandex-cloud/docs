# Migrating a {{ dataproc-name }} cluster to a different availability zone

Subclusters of each {{ dataproc-name }} cluster reside in the same [cloud network](../../vpc/concepts/network.md#network) and [availability zone](../../overview/concepts/geo-scope.md). You can move subclusters from one availability zone to another. This process is known as cluster migration.

{% note info %}

This section provides migration guides for [lightweight clusters](../concepts/index.md#light-weight-clusters) only. Guides for HDFS clusters are currently under development. If you store your data in a cluster hosted in the `{{ region-id }}-c` availability zone and it uses the HDFS, the {{ yandex-cloud }} support team will notify you when the migration guides for these clusters become available.

{% endnote %}

To move {{ dataproc-name }} subclusters to a different availability zone:

1. Make sure [security groups are configured](cluster-create.md#change-security-groups) in your network.
1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone you want to move your subclusters to.
1. [Set up a NAT gateway and link a route table](../../vpc/operations/create-nat-gateway.md) to the new subnet.
1. [Create a cluster](cluster-create.md#create) in the appropriate availability zone.
1. [Delete the cluster](cluster-delete.md) in the source availability zone.
