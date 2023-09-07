# Creating a {{ metastore-full-name }} cluster

{% include [Доступ по запросу](../../../_includes/note-preview-by-request.md) %}

To learn more about {{ metastore-name }} clusters in {{ dataproc-name }}, see [{#T}](../../concepts/metastore.md).

## Configure a network {#set-up-network}

[Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) in the subnet the cluster will connect to. It is needed for the cluster to interact with {{ yandex-cloud }} services.

## Configure security groups {#set-up-security-groups}

{% include [security-groups-note](../../../_includes/vpc/security-groups-note-services.md) %}

If the cloud network uses security groups, they can hinder the cluster's operation. Set up the default security group to work with {{ metastore-name }}. To do this, [add](../../../vpc/operations/security-group-add-rule.md) the following rules to it:

* For incoming client traffic:

   * Port range: `30000-32767`
   * Protocol: `Any`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

* For incoming load balancer traffic:

   * Port range: `10256`.
   * Protocol: `Any`.
   * Source: `Load balancer health checks`.

If you plan to use multiple security groups for a cluster, enable all traffic between these groups.

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

{% endnote %}

## Create a cluster {#create-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a server.
   1. Select **{{ dataproc-name }}**.
   1. In the left-hand panel, click ![image](../../../_assets/data-proc/metastore.svg) **Metastore server**.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. Enter a name for the cluster. It must be unique within the folder.
   1. (Optional) Enter a cluster description.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network and subnet to host the {{ metastore-name }} cluster.

      [Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) in the selected subnet. For more information, see [{#T}](#set-up-network).

   1. To enable a {{ metastore-name }} cluster to interact with the S3 object storage, under **{{ ui-key.yacloud.metastore.title_s3config }}**, specify the **{{ ui-key.yacloud.metastore.field_s3config-access-key-id }}** and **{{ ui-key.yacloud.metastore.field_s3config-secret-access-key }}** of the [AWS-compatible static access key](../../../iam/concepts/authorization/access-key.md).

   1. If required, enable protection of the cluster from accidental deletion by a user.

      {% include [Cluster deletion protection limits](../../../_includes/mdb/deletion-protection-limits-data.md) %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
