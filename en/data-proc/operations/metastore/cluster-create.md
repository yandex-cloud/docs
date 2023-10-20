---
title: "How to create a {{ metastore-full-name }} cluster"
description: "This guide describes how you can create a {{ metastore-full-name }} cluster."
---

# Creating a {{ metastore-full-name }} cluster

{% include [Доступ по запросу](../../../_includes/note-preview-by-request.md) %}

To learn more about {{ metastore-name }} clusters in {{ dataproc-name }}, see [{#T}](../../concepts/metastore.md).

## Configure a network {#set-up-network}

[Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) in the subnet the cluster will connect to. It is needed for the cluster to interact with {{ yandex-cloud }} services.

## Configure security groups {#set-up-security-groups}

If the cloud network uses security groups, they can hinder the cluster's operation. Set up the default security group to work with {{ metastore-name }}. To do this, [add](../../../vpc/operations/security-group-add-rule.md) the following rules to it:

* For incoming client traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `30000-32767`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

* For incoming load balancer traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `10256`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`

If you plan to use multiple security groups for a cluster, enable all traffic between these groups.

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

{% endnote %}

## Create a cluster {#create-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a server.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. In the left-hand panel, select ![image](../../../_assets/data-proc/metastore.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
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
