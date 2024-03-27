# Migrating a lightweight {{ dataproc-name }} cluster to a different availability zone

Subclusters of each {{ dataproc-name }} cluster reside in the same [cloud network](../../vpc/concepts/network.md#network) and [availability zone](../../overview/concepts/geo-scope.md). You can migrate a cluster to a different availability zone. The migration process depends on the cluster type:

* The following describes how to migrate [lightweight clusters](../concepts/index.md#light-weight-clusters).
* For more information about migrating HDFS clusters, see [this guide](../tutorials/hdfs-cluster-migration.md).
* {{ metastore-full-name }} cluster migration is not available. If you use such clusters located in the `{{ region-id }}-c` availability zone, the {{ yandex-cloud }} tech support will notify you once the relevant migration guide is available.

To migrate a lightweight cluster to a different availability zone:

1. Make sure [security groups are configured](cluster-create.md#change-security-groups) in your network.
1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone you are migrating you cluster to.
1. [Set up a NAT gateway and link a route table](../../vpc/operations/create-nat-gateway.md) to the new subnet.
1. [Create a cluster](cluster-create.md#create) in the appropriate availability zone.
1. [Delete the cluster](cluster-delete.md) in the source availability zone.

{% include [zone-d-host-restrictions](../../_includes/mdb/ru-central1-d-broadwell.md) %}
