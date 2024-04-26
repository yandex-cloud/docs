# FQDNs of {{ CH }} hosts

To connect to a cluster host, you need its fully qualified domain name ([FQDN](../../concepts/network.md#hostname)). You can obtain it in one of the following ways:

* [Request a list of cluster hosts](../../operations/hosts.md#list-hosts).
* In the [management console]({{ link-console-main }}), copy the command for connecting to the cluster. This command contains the host FQDN. To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-connect }}**.
* Look up the FQDN in the management console:

   1. Go to the cluster page.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

Cluster hosts also use [special FQDNs](#auto).

### Selecting an available host automatically {#auto}

To avoid connecting to another host manually if the current one becomes unavailable, use a special FQDN. It can be in one of the following formats:

* `c-<cluster_ID>.rw.{{ dns-zone }}`: To connect to an available cluster host.

* `<shard_name>.c-<cluster_ID>.rw.{{ dns-zone }}`: To connect to an available [shard](../../concepts/sharding.md) host.

If the host an FQDN points to becomes unavailable, there may be a slight delay before the FQDN starts pointing to another available host.

{% note warning %}

If, during [cluster maintenance](../../concepts/maintenance.md#maintenance-order), a special FQDN points to a host without public access, the cluster will not be available for connection from the internet. To avoid this, [enable public access](../hosts.md#update) for all cluster hosts.

{% endnote %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
