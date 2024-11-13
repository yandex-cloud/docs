---
title: How to create a {{ metastore-full-name }} cluster
description: Follow this guide to create a {{ metastore-full-name }} cluster.
---

# Creating a {{ metastore-full-name }} cluster

{% include [Preview](../../../_includes/note-preview.md) %}

To learn more about {{ metastore-name }} clusters in {{ metadata-hub-name }}, see [{#T}](../../concepts/metastore.md).

Getting started:

1. [{#T}](#set-up-network).
1. [{#T}](#set-up-security-groups).
1. [{#T}](#prepare-access-key).

Next, [create a cluster](#create-cluster).

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

You can specify more detailed rules for your security groups, e.g., to allow traffic only in specific subnets.

{% endnote %}

## (Optional) Prepare a static access key {#prepare-access-key}

To enable a {{ metastore-name }} cluster to work with [{{ objstorage-full-name }}](../../../storage/index.yaml), prepare a [static access key](../../../iam/concepts/authorization/access-key.md):

1. [Create a service account](../../../iam/operations/sa/create.md).
1. [Assign the required roles](../../../iam/operations/sa/assign-role-for-sa.md) to the service account.

   The roles you need depend on your use case scenario. You can view the service roles in the [{{ metastore-name }} section](../../security/metastore-roles.md) and all the available roles in this [reference](../../../iam/roles-reference.md).

1. [Create a static access key](../../../iam/operations/sa/create-access-key.md) for the service account.
1. Save the ID and secret key. You will not be able to access them later.

## Create a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a server.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select the ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** page.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Enter a name for the cluster. It must be unique within the folder.
    1. (Optional) Enter a cluster description.
    1. (Optional) Add [{{ yandex-cloud }} labels](../../../resource-manager/concepts/labels.md) to break resources into logical groups.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network and subnet to host the {{ metastore-name }} cluster. Specify the security group you configured previously.
    1. (Optional) Under **{{ ui-key.yacloud.metastore.title_s3config }}**, specify **{{ ui-key.yacloud.metastore.field_s3config-access-key-id }}** and **{{ ui-key.yacloud.metastore.field_s3config-secret-access-key }}** of the static access key.
    1. If required, enable protection of the cluster from accidental deletion by a user.

        {% include [Cluster deletion protection limits](../../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
