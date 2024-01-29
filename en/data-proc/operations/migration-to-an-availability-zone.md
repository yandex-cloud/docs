# Migrating a {{ dataproc-name }} cluster to a different availability zone

Subclusters of each {{ dataproc-name }} cluster reside in the same [cloud network](../../vpc/concepts/network.md#network) and [availability zone](../../overview/concepts/geo-scope.md). You can move subclusters from one availability zone to another. This process is known as cluster migration.

{% note info %}

Only [lightweight clusters](../concepts/index.md#light-weight-clusters) can be migrated to a different availability zone. Migration of HDFS and {{ metastore-full-name }} clusters is currently not supported. The support team will notify cluster owners before manually migrating any HDFS and {{ metastore-name }} clusters deployed in the `{{ region-id }}-c` availability zone.

{% endnote %}

To move {{ dataproc-name }} subclusters to a different availability zone:

1. Make sure [security groups are configured](cluster-create.md#change-security-groups) in your network.
1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone you want to move your subclusters to.
1. [Set up a NAT gateway and link a route table](../../vpc/operations/create-nat-gateway.md) to the new subnet.
1. [Create a cluster](cluster-create.md#create) in the appropriate availability zone.
1. [Delete the cluster](cluster-delete.md) in the source availability zone.

{% include [zone-d-host-restrictions](../../_includes/mdb/ru-central1-d-broadwell.md) %}
