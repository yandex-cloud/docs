---
title: "Creating an {{ OS }} cluster"
description: "A cluster of Yandex Managed Service for {{ OS }} is a group of multiple linked {{ OS }} hosts."
keywords:
  - Creating an OpenSearch cluster
  - OpenSearch cluster
  - OpenSearch
---

# Creating a {{ OS }} cluster

A {{ mos-name }} cluster is a group of multiple linked {{ OS }} and [Dashboards]({{ os.docs }}/dashboards/index/) hosts. A cluster provides high search performance by distributing search and indexing tasks across all cluster hosts with the `DATA` role. To learn more about roles in the cluster, see [Host roles](../concepts/host-roles.md).

Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

For more information, see [{#T}](../concepts/index.md).

## Creating a cluster {#create-cluster}

When creating a cluster, you need to specify individual parameters for each [host group](../concepts/host-groups.md).

{% list tabs %}

- Management console

   To create a cluster:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      1. Enter a name for the cluster. It must be unique within the folder.
      1. (Optional) Enter a cluster description.
      1. Select the environment where you want to create the cluster (you cannot change the environment once the cluster is created):

         * `PRODUCTION`: For stable versions of your apps.
         * `PRESTABLE`: For testing, including the {{ mos-full-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

      1. Select the {{ OS }} version.
      1. Select the [plugins](plugins.md#supported-plugins) you want to install in the cluster.

   
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may also need to [set up security groups](connect.md#security-groups) to connect to the cluster.

      {% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}


   1. Under **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }} 1**, configure the[`{{ OS }}` host group](../concepts/host-groups.md):

      1. Select the host group type: `{{ OS }}`

      1. Enter a name for the host group, which must be unique within the cluster.

      1. Select the [host roles](../concepts/host-roles.md) `DATA` and `MANAGER`.

      1. Select the platform, host type, and host class.

         The host class defines the technical characteristics of virtual machines that {{ OS }} nodes are deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).

      1. Select the [disk type](../concepts/storage.md) and data storage size.

         {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

      1. Specify how hosts should be distributed across availability zones and subnets.

      1. Select the number of hosts to create.

      
      1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if you want to allow [connecting](connect.md) to hosts over the internet.

         {% note tip %}

         It is not recommended to enable public access for hosts with the `MANAGER` role, because this might be unsafe.

         {% endnote %}


      {% note warning %}

      After creating your cluster, you can only change the host configuration using the API. However, you can also create a new host group with a different configuration if needed.

      {% endnote %}

   1. If needed, configure the `Dashboards` [host group](../concepts/host-groups.md) under **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }} 2**:

      1. Select the platform, host type, and host class.
      1. Set up storage in the same way as for `{{ OS }}` hosts.
      1. Specify how hosts should be distributed across availability zones and subnets.
      1. Select the number of hosts to create.

      
      1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if you want to allow [connecting](connect.md) to hosts over the internet.

         {% include [mos-tip-public-dashboards](../../_includes/mdb/mos/public-dashboards.md) %}


   1. If required, click **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_add-virtual-node-group }}** to add another host group or more.

   1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**:

      1. Enter the password for the `admin` user.

         {% include [Superuser](../../_includes/mdb/mos/superuser.md) %}

      1. Configure additional cluster settings, if required:

         {% include [Extra settings](../../_includes/mdb/mos/extra-settings.md) %}

   1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- API

   To create a cluster, use the [create](../api-ref/Cluster/create.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) gRPC API call and provide the following in the request:

   * ID of the folder where the cluster should be placed, in the `folderId` parameter.
   * Cluster name in the `name` parameter.
   * {{ OS }} version in the `configSpec.version` parameter.
   * `admin` user password in the `configSpec.adminPassword` parameter.
   * Configuration of one or more groups of hosts with the `DATA` and `MANAGER` (optional) [roles](../concepts/host-roles.md) in the `configSpec.opensearchSpec.nodeGroups` parameter.
   * Configuration of one or more groups of hosts with the `DASHBOARDS` [role](../concepts/host-roles.md#dashboards) in the `configSpec.dashboardsSpec.nodeGroups` parameter.
   * List of plugins in the `configSpec.opensearchSpec.plugins` parameter.
   * Settings for access from other services in the `configSpec.access` parameter.
   * Network ID in the `networkId` parameter.

   
   * Security group identifiers in the `securityGroupIds` parameter. You may also need to [set up security groups](connect.md#security-groups) to connect to the cluster.
   * ID of the [service account](../../iam/concepts/users/service-accounts.md) used for cluster operations in the `serviceAccountId` parameter.


   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

   * Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled clusters) in the `maintenanceWindow` parameter.

{% endlist %}
