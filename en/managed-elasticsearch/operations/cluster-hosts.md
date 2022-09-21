---
title: Managing Elasticsearch hosts
description: 'You can get a list of hosts in the Elasticsearch cluster, and add and remove hosts from the cluster. You can only manage hosts with the Data Node role.'
keywords:
  - management of Elasticsearch hosts
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

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster you need and select the **Hosts** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-es }} host list --cluster-name <cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the `listHosts` API method: pass the ID of the desired cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Adding hosts to a cluster {#add-hosts}

{% note warning %}

You can't assign a public IP address to it after it's been created.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster you need and select the **Hosts** tab.
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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

   Use the `addHosts` API method: pass the ID of the required cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

   Add the required number of `hostSpecs` parameters with the host's settings (one parameter for each new host).

{% endlist %}

{% note warning %}

If you can't [connect](cluster-connect.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}

## Deleting hosts from a cluster {#delete-hosts}

The following restrictions apply when deleting hosts:

* You can't delete a single host with the _Data node_ role.
* If a cluster consists of multiple hosts with the _Data node_ role, you can't delete the last two hosts.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster you need and select the **Hosts** tab.
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

   Use the `deleteHosts` API method: pass the ID of the required cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

   In one or more `hostNames[]` parameters, specify the names of the hosts you wish to delete from the cluster.

{% endlist %}
