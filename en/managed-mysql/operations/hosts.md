---
title: "Managing {{ MY }} cluster hosts"
description: "In this tutorial, you will learn how to manage {{ MY }} cluster hosts and their settings."
---

# Managing {{ MY }} cluster hosts

You can add and remove cluster hosts and manage their settings.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-my }} host list \
      --cluster-name=<cluster name>
   ```

   Result:

   ```text
   +----------------------------+--------------+---------+--------+---------------+
   |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
   +----------------------------+--------------+---------+--------+---------------+
   | rc1b...{{ dns-zone }} | c9q5k4ve7... | MASTER  | ALIVE  | {{ region-id }}-b |
   | rc1a...{{ dns-zone }} | c9q5k4ve7... | REPLICA | ALIVE  | {{ region-id }}-a |
   +----------------------------+--------------+---------+--------+---------------+
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListHosts](../api-ref/grpc/cluster_service.md#ListHosts) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).

{% endlist %}

## Adding a host {#add}

The number of hosts in {{ mmy-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and go to the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-host }}**.
   1. Specify the host parameters:

      
      * Availability zone.
      * Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).


      * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.
      * Priority for assigning the host as a master.
      * Host priority as a {{ MY }} replica for creating backups.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a host to a cluster:
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
      {{ yc-mdb-my }} host add --help
      ```

   1. Run the add host command (the example does not show all the available parameters):

      ```bash
      {{ yc-mdb-my }} host add \
        --cluster-name=<cluster name> \
        --host zone-id=<availability zone ID>,`
          `subnet-id=<subnet ID>,`
          `assign-public-ip=<public access to the subcluster host: true or false>,`
          `replication-source=<source host name>,`
          `backup-priority=<host priority for backups: from 0 to 100>,`
          `priority=<priority for assigning the host as master: from 0 to 100>
      ```

      Where:
      * `--cluster-name`: Name of {{ mmy-name }} cluster.
      * `--host`: Host parameters:
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). It must be specified if the selected availability zone includes two or more subnets.
         * `assign-public-ip`: Host accessibility from the internet.
         * `replication-source`: [Replication](../concepts/replication.md) source for the host.
         * `backup-priority`: Host priority for [backups](../concepts/backup.md#size).
         * `priority`: Priority for selecting the host as a master if the [primary master fails](../concepts/replication.md#master-failover).

      The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Add a `host` block to the {{ mmy-name }} cluster description.

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        host {
          zone             = "<availability zone>"
          subnet_id        = <subnet ID>
          assign_public_ip = <public access to the host: true or false>
          priority         = <priority for assigning the host as a master: from 0 to 100>
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   To add a host, use the [addHosts](../api-ref/Cluster/addHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * New host settings in one or more `hostSpecs` parameters.

{% endlist %}


{% note warning %}

If you cannot [connect](connect.md) to the added host, check that the cluster [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}


## Changing a host {#update}

For each host in a {{ mmy-name }} cluster, you can:
* Setting the [replication source](../concepts/replication.md#manual-source).
* Managing [public access](../concepts/network.md#public-access-to-host).
* Setting [priority](../concepts/backup.md#size) for backups.
* Set a priority for assigning the host as a master if the [primary master fails](../concepts/replication.md#master-failover).

{% note info %}

You cannot restart a separate cluster host. To restart hosts, [stop and restart the cluster](cluster-stop.md).

{% endnote %}

{% list tabs %}

- Management console

   To change the parameters of the cluster host:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the required host row and select **{{ ui-key.yacloud.common.edit }}**.
   1. Set new settings for the host:
      1. Select a replication source for the host to control replication threads manually.
      1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.
      1. Set the value of the **{{ ui-key.yacloud.mysql.field_priority }}** field.
      1. Set the value of the **{{ ui-key.yacloud.mysql.field_backup_priority }}** field.
   1. Click **{{ ui-key.yacloud.postgresql.hosts.dialog.button_choose }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To modify host parameters, execute the command below (the parameter list in the example is not exhaustive):

   ```bash
   {{ yc-mdb-my }} host update <host name> \
     --cluster-name=<cluster name> \
     --replication-source=<source host name> \
     --assign-public-ip=<public access to the host: true or false> \
     --backup-priority=<host priority for backups: from 0 to 100> \
     --priority=<priority for assigning the host as a master: from 0 to 100>
   ```

   Where:
   * `--cluster-name`: Name of {{ mmy-name }} cluster.
   * `--replication-source`: [Replication](../concepts/replication.md) source for the host.
   * `--assign-public-ip`: Host accessibility from the internet.
   * `--backup-priority`: Host priority for [backups](../concepts/backup.md#size).
   * `--priority`: Priority for selecting the host as a master if the [primary master fails](../concepts/replication.md#master-failover).

   The host name can be requested with a [list of cluster hosts](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   To change the parameters of the cluster host:
   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. In the {{ mmy-name }} cluster description, change the attributes of the `host` block corresponding to the host to update.

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        host {
          replication_source_name = "<replication source>"
          assign_public_ip        = <public access to the host: true or false>
          priority                = <priority for assigning the host as a master: from 0 to 100>
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   To update host parameters, use the [updateHosts](../api-ref/Cluster/updateHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/UpdateHosts](../api-ref/grpc/cluster_service.md#UpdateHosts) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Configuration array for hosts to update in the `updateHostsSpecs` parameter.

      For each host, specify:
      * Name in the `hostName` field.
      * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


{% note warning %}

If you can't [connect](connect.md) to the changed host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}


## Removing a host {#remove}

You can remove a host from a {{ MY }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host is the master when deleted, {{ mmy-name }} automatically assigns the next highest-priority replica as the master.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the required host row and select **{{ ui-key.yacloud.common.delete }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```bash
   {{ yc-mdb-my }} host delete <hostname> \
      --cluster-name=<cluster name>
   ```

   The host name can be requested with a [list of cluster hosts](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Delete the `host` block from the {{ mmy-name }} cluster description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   To delete a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * Name(s) of the host(s) to delete in the `hostNames` parameter.

{% endlist %}