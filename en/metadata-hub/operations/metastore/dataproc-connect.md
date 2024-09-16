---
title: "How to connect {{ dataproc-name }} to {{ metastore-name }}"
description: "Follow this guide to connect {{ dataproc-name }} to {{ metastore-name }}."
---

# Connecting {{ dataproc-name }} to {{ metastore-name }}

{% note info %}

To use the {{ metastore-name }} cluster, a [{{ dataproc-full-name }} cluster](../../../data-proc/concepts/index.md) must include `SPARK` and `YARN` components.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. [Create a {{ metastore-name }} cluster](cluster-create.md).
   1. When [creating](../../../data-proc/operations/cluster-create.md) or [updating](../../../data-proc/operations/cluster-update.md) a {{ dataproc-name }} cluster, specify the following [property](../../../data-proc/concepts/settings-list.md):

      ```text
      spark:spark.hive.metastore.uris : thrift://<{{ metastore-name }}_cluster_IP_address>:{{ port-metastore }}
      ```

      To find out the {{ metastore-name }} cluster IP address, select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** in the [management console]({{ link-console-main }}) and then select the ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** page in the left-hand panel. You will see the cluster IP address under **{{ ui-key.yacloud.common.section-base }}**.

   1. If the {{ metastore-name }} cluster and {{ dataproc-name }} cluster are hosted in different cloud networks, set up routing between these cloud networks so that the {{ metastore-name }} subnet is accessible from the {{ dataproc-name }} subnet.

      There are [multiple ways](../../../tutorials/routing/index.md) to configure routing. For example, you can [create an IPsec tunnel](../../../tutorials/routing/ipsec/ipsec-vpn.md).

   1. If the cloud network uses [security groups](../../../vpc/concepts/security-groups.md), set up the security group of the {{ dataproc-name }} cluster to work with {{ metastore-name }}. To do this, [add](../../../vpc/operations/security-group-add-rule.md) the following rule for outgoing traffic:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-metastore }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

{% endlist %}

For an example of using {{ dataproc-name }} with a {{ metastore-name }} cluster connected, see the [{#T}](../../tutorials/sharing-tables.md) tutorial.
