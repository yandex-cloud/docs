---
title: "Managing Elasticsearch hosts"
description: "You can get a list of Elasticsearch cluster hosts and add or delete them. You can only manage hosts with the Data Node role."
keywords:
  - managing Elasticsearch hosts
  - Elasticsearch hosts
  - Elasticsearch
---

# Managing hosts

You can get a list of {{ ES }} cluster hosts and add or delete them.

{% note info %}

You can only add or delete hosts with the [_Data node_](../concepts/index.md) role.

{% endnote %}

## Getting a list of cluster hosts {#list-hosts}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.
   1. Click the name of the cluster you need and select the **Hosts** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-es }} host list --cluster-name <cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListHosts](../api-ref/grpc/cluster_service.md#ListHosts) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Adding hosts to a cluster {#add-hosts}

{% note warning %}

You can't assign a public IP address to it after it's been created.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.
   1. Click the name of the cluster you need and select the **Hosts** tab.
   1. Click **Add host**.
   1. Specify the host parameters:

      * Availability zone.
      * Subnet (if the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md)).
      * Select **Public access** if the host must be accessible from outside {{ yandex-cloud }}.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add hosts to a cluster, run the command:

   ```bash
   {{ yc-mdb-es }} host add \
      --cluster-name <cluster name> \
      --host zone-id=<availability zone>,subnet-name=<subnet name>,assign-public-ip=<true or false>,type=<host role: datanode or masternode>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   To add a host to the cluster:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

   1. Add a `host` block to the {{ mes-name }} cluster description.

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        host {
          name             = "<host name>"
          zone             = "<availability zone>"
          type             = "<host role: DATA_NODE or MASTER_NODE>"
          assign_public_ip = <public host access: true or false>
          subnet_id        = "<subnet ID>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

   To add hosts to a cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

   * New host settings in one or more `hostSpecs` parameters.

   {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}


{% note warning %}

If you can't [connect](cluster-connect.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host. The security groups feature is currently in the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}


## Deleting hosts from a cluster {#delete-hosts}

The following restrictions apply when deleting hosts:

* You can't delete a single host with the _Data node_ role.
* If a cluster consists of multiple hosts with the _Data node_ role, you can't delete the last two hosts.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.
   1. Click the name of the cluster you need and select the **Hosts** tab.
   1. Click the ![image](../../_assets/options.svg) icon in the same row as the desired host and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```bash
   {{ yc-mdb-es }} host delete <hostname> --cluster-name <cluster name>
   ```

   The host name can be requested with a [list of cluster hosts](#list-hosts), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

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

- API

   To delete a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

   * Name(s) of the host(s) to delete in the `hostNames` parameter.

{% endlist %}
