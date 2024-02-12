# Migrating a {{ dataproc-name }} cluster to a different availability zone

Subclusters of each {{ dataproc-name }} cluster reside in the same [cloud network](../../vpc/concepts/network.md#network) and [availability zone](../../overview/concepts/geo-scope.md). To migrate a cluster to another availability zone, create a new cluster in the zone you need, and then another one in the initial zone.

{% note info %}

Currently, you can only migrate [lightweight clusters](../concepts/index.md#light-weight-clusters) to another availability zone. You cannot migrate HDFS and {{ metastore-full-name }} clusters. If you use such clusters located in the `{{ region-id }}-c` availability zone, the {{ yandex-cloud }} tech support will notify you once the relevant migration guide is available.

{% endnote %}

To move {{ dataproc-name }} subclusters to a different availability zone:

1. Make sure [security groups are configured](cluster-create.md#change-security-groups) in your network.
1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone you want to move your subclusters to.
1. [Set up a NAT gateway and link a route table](../../vpc/operations/create-nat-gateway.md) to the new subnet.
1. [Create a cluster](cluster-create.md#create) in the appropriate availability zone.
1. [Delete the cluster](cluster-delete.md) in the source availability zone.

{% include [zone-d-host-restrictions](../../_includes/mdb/ru-central1-d-broadwell.md) %}
