---
title: "Managing {{ PG }} cluster hosts"
description: "In this tutorial, you will learn how to manage {{ PG }} cluster hosts. You can add and delete cluster hosts and manage their settings via the management console, CLI, and API."
---

# Managing {{ PG }} cluster hosts

You can add and remove cluster hosts and manage their settings.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click the name of the cluster you need and select the **Hosts** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-pg }} host list \
     --cluster-name <cluster name>
   ```

   Result:

   
   ```text
   +-----------------------+--------------+---------+--------+-------------------+
   |         NAME          |  CLUSTER ID  |  ROLE   | HEALTH |      ZONE ID      |
   +-----------------------+--------------+---------+--------+-------------------+
   | rc1b...{{ dns-zone }} | c9qp71dk1... | MASTER  | ALIVE  | {{ region-id }}-b |
   | rc1a...{{ dns-zone }} | c9qp71dk1... | REPLICA | ALIVE  | {{ region-id }}-a |
   +-----------------------+--------------+---------+--------+-------------------+
   ```


   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListHosts](../api-ref/grpc/cluster_service.md#ListHosts) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Adding a host {#add}

The number of hosts in {{ mpg-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ mpg-full-name }}**.

{% list tabs %}

- Management console

   To add a host to the cluster:
   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and go to the **Hosts** tab.
   1. Click **Add host**.

   
   1. Specify the host parameters:
      * Availability zone.
      * Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).
      * Replication source (if you use [cascading replication](../concepts/replication.md#replication-manual)).
      * Select **Public access** if the host must be accessible from outside {{ yandex-cloud }}.


- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a host to the cluster:

   
   1. Request a list of cluster subnets to select one for the new host:

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```text
      +-----------+-----------+------------+-------------------+------------------+
      |     ID    |   NAME    | NETWORK ID |       ZONE        |      RANGE       |
      +-----------+-----------+------------+-------------------+------------------+
      | b0cl69... | default-c | enp6rq7... | {{ region-id }}-c | [172.16.0.0/20]  |
      | e2lkj9... | default-b | enp6rq7... | {{ region-id }}-b | [10.10.0.0/16]   |
      | e9b0ph... | a-2       | enp6rq7... | {{ region-id }}-a | [172.16.32.0/20] |
      | e9b9v2... | default-a | enp6rq7... | {{ region-id }}-a | [172.16.16.0/20] |
      +-----------+-----------+------------+-------------------+------------------+
      ```

      If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).


   1. View a description of the CLI command for adding a host:

      ```bash
      {{ yc-mdb-pg }} host add --help
      ```

   1. Run the add host command:

      
      ```bash
      {{ yc-mdb-pg }} host add
        --cluster-name <cluster name>
        --host zone-id=<availability zone>,subnet-id=<subnet ID>
      ```


      
      The subnet ID should be specified if the availability zone contains multiple subnets, otherwise {{ mpg-short-name }} automatically selects a single subnet. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).


      You can also specify several additional options in the `--host` parameter to manage public access to a host and replication in a cluster:
      * Replication source for the host in the `replication-source` option to [manually manage replication threads](../concepts/replication.md#replication-manual).
      * External host visibility {{ yandex-cloud }} in the `assign-public-ip` option:
         * `true`: public access enabled.
         * `false`: public access disabled.

   {{ mpg-short-name }} will run the add host operation.

- {{ TF }}

   To add a host to the cluster:
   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).
   1. Add a `host` block to the {{ mpg-name }} cluster description.

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        host {
          name                    = "<hostname>"
          zone                    = "<availability zone>"
          subnet_id               = "<subnet ID>"
          replication_source_name = "<replication source: name attribute of appropriate host block>"
          assign_public_ip        = <public access to host: true or false>
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   To add a host to a cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}


{% note warning %}

If you can't [connect](connect.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}


## Changing a host {#update}

For each host in a {{ mpg-short-name }} cluster, you can specify the [replication](../concepts/replication.md) source and manage host [public access](../concepts/network.md#public-access-to-a-host).

{% list tabs %}

- Management console

   To change the parameters of the cluster host:
   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click the name of the cluster you need and select the **Hosts** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the same row as the desired host and select **Edit**.
   1. Set new settings for the host:
      1. Select the replication source for the host to [manually manage replication threads](../concepts/replication.md#replication-manual).
      1. Enable **Public access** if a host must be accessible from outside {{ yandex-cloud }}.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the parameters of a host in a cluster, run the command below:

   ```bash
   {{ yc-mdb-pg }} host update <hostname>
     --cluster-name <cluster name>
     --replication-source <source hostname>
     --assign-public-ip=<public access to host: true or false>
   ```

   The host name can be requested with a [list of cluster hosts](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

   To [manually manage replication threads](../concepts/replication.md#replication-manual) in the cluster, change the host's replication source in the `--replication-source` parameter.

- {{ TF }}

   To change the parameters of the cluster host:
   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).
   1. In the {{ mpg-name }} cluster description, change the attributes of the `host` block corresponding to the host to update.

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        host {
          replication_source_name = "<replication source>"
          assign_public_ip        = <host public access: true or false>
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   To update host parameters, use the [updateHosts](../api-ref/Cluster/updateHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/UpdateHosts](../api-ref/grpc/cluster_service.md#UpdateHosts) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * One or more objects containing the settings of the hosts to update in the `updateHostSpecs` parameter.

      For each host, specify:
      * Name in the `hostName` field.
      * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


{% note warning %}

If you can't [connect](connect.md) to the changed host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}


## Removing a host {#remove}

You can remove a host from a {{ PG }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host is the master when deleted, {{ mpg-short-name }} automatically assigns the next highest-priority replica as the master.

{% list tabs %}

- Management console

   To remove a host from a cluster:
   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click the name of the cluster you need and select the **Hosts** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the same row as the desired host and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```bash
   {{ yc-mdb-pg }} host delete <hostname>
     --cluster-name=<cluster name>
   ```

   The host name can be requested with a [list of cluster hosts](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   To remove a host from a cluster:
   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).
   1. Delete the corresponding `host` block from the {{ mpg-name }} cluster description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   To delete a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}