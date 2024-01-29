---
title: "Managing {{ ES }} hosts"
description: "You can get a list of {{ ES }} cluster hosts and add or delete them. You can only manage hosts with the Data node role."
keywords:
  - managing Elasticsearch hosts
  - Elasticsearch hosts
  - Elasticsearch
---

# Managing hosts

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

You can get a list of {{ ES }} cluster hosts and add or delete them. To move your cluster hosts to a different availability zone, read this [guide](host-migration.md).

{% note info %}

You can only add or delete hosts with the [_Data node_](../concepts/index.md) role.

{% endnote %}

## Getting a list of cluster hosts {#list-hosts}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-es }} host list --cluster-name <cluster_name>
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListHosts](../api-ref/grpc/cluster_service.md#ListHosts) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Adding hosts to a cluster {#add-hosts}

{% note warning %}

You cannot enable public access to a host once it is created.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-host }}**.
   1. Specify the host parameters:

      * Availability zone.
      * Subnet (if the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md)).
      * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}. You cannot change this setting after you create a host.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add hosts to a cluster, run the command:

   ```bash
   {{ yc-mdb-es }} host add \
      --cluster-name <cluster_name> \
      --host zone-id=<availability_zone>,`
             `subnet-name=<subnet_name>,`
             `assign-public-ip=<public_access>,`
             `type=<host_role>
   ```

   Where:

   * `assign-public-ip`: Public access to the host, `true` or `false`.
   * `type`: Host role, `datanode` or `masternode`.

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   To add a host to the cluster:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

   1. Add a `host` block to the {{ mes-name }} cluster description.

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster_name>" {
        ...
        host {
          name             = "<host_name>"
          zone             = "<availability_zone>"
          type             = "<host_role>"
          assign_public_ip = <public_access>
          subnet_id        = "<subnet_ID>"
        }
      }
      ```

      Where:

      * `type`: Host role, `DATA_NODE` or `MASTER_NODE`.
      * `assign_public_ip`: Public access to the host, `true` or `false`.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

   To add hosts to a cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter.

     {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

   * New host settings in one or more `hostSpecs` parameters.

{% endlist %}


{% note warning %}

If you cannot [connect](cluster-connect.md) to the added host, check that the cluster [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}


## Deleting hosts from a cluster {#delete-hosts}

The following restrictions apply when deleting hosts:

* You cannot delete a single host with the _Data node_ role.
* If a cluster consists of multiple hosts with the _Data node_ role, you cannot delete the last two hosts.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the required host row and select **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```bash
   {{ yc-mdb-es }} host delete <host_name> --cluster-name <cluster_name>
   ```

   You can request the host name with a [list of cluster hosts](#list-hosts), and the cluster name, with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   To remove a host from a cluster:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

   1. Delete the corresponding `host` block from the {{ mes-name }} cluster description.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the deletion of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

   To delete a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter.

     {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

   * Name(s) of the host(s) to delete in the `hostNames` parameter.

{% endlist %}
