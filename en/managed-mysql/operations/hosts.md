---
title: "Managing {{ MY }} cluster hosts"
description: "In this tutorial, you will learn how to manage {{ MY }} cluster hosts and their settings."
---

# Managing {{ MY }} cluster hosts

You can add and remove cluster hosts and manage their settings. For information about moving cluster hosts to a different [availability zone](../../overview/concepts/geo-scope.md), see [this guide](host-migration.md).

## Getting a list of cluster hosts {#list}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-my }} host list \
      --cluster-name=<cluster_name>
   ```

   Result:

   ```text
   +----------------------------+----------------------+---------+--------+---------------+
   |            NAME            |      CLUSTER ID      |  ROLE   | HEALTH |    ZONE ID    |
   +----------------------------+----------------------+---------+--------+---------------+
   | rc1b...{{ dns-zone }} | c9q5k4ve7ev4******** | MASTER  | ALIVE  | {{ region-id }}-b |
   | rc1a...{{ dns-zone }} | c9q5k4ve7ev4******** | REPLICA | ALIVE  | {{ region-id }}-a |
   +----------------------------+----------------------+---------+--------+---------------+
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListHosts](../api-ref/grpc/cluster_service.md#ListHosts) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).

{% endlist %}

## Adding a host {#add}

The number of hosts in {{ mmy-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and go to the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-host }}**.
   1. Specify the host parameters:

      
      * Availability zone.
      * Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).


      * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.
      * Priority for assigning the host as a master.
      * Host priority as a {{ MY }} replica for creating backups.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a host to a cluster:
   1. Request a list of cluster subnets to select one for the new host:

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```text
      +----------------------+-----------+-----------------------+---------------+------------------+
      |          ID          |   NAME    |       NETWORK ID      |       ZONE    |      RANGE       |
      +----------------------+-----------+-----------------------+---------------+------------------+
      | b0cl69a2b4c6******** | default-d | enp6rq72rndgr******** | {{ region-id }}-d | [172.**.*.*/20]  |
      | e2lkj9qwe762******** | default-b | enp6rq72rndgr******** | {{ region-id }}-b | [10.**.*.*/16]   |
      | e9b0ph42bn96******** | a-2       | enp6rq72rndgr******** | {{ region-id }}-a | [172.**.**.*/20] |
      | e9b9v22r88io******** | default-a | enp6rq72rndgr******** | {{ region-id }}-a | [172.**.**.*/20] |
      +----------------------+-----------+-----------------------+---------------+------------------+
      ```

      
      If the required subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).


   1. View a description of the CLI command for adding a host:

      ```bash
      {{ yc-mdb-my }} host add --help
      ```

   1. Run the add host command (the example does not show all the available parameters):

      ```bash
      {{ yc-mdb-my }} host add \
        --cluster-name=<cluster_name> \
        --host zone-id=<availability_zone_ID>,`
          `subnet-id=<subnet_ID>,`
          `assign-public-ip=<public_access_to_subcluster_host>,`
          `replication-source=<source_host_name>,`
          `backup-priority=<host_backup_priority>,`
          `priority=<priority_of_assigning_host_as_master>
      ```

      Where:
      * `--cluster-name`: Name of a {{ mmy-name }} cluster.
      * `--host`: Host parameters:
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
         * `assign-public-ip`: Internet access to the host, `true` or `false.`
         * `replication-source`: [Replication](../concepts/replication.md) source for the host.
         * `backup-priority`: Host [backup](../concepts/backup.md#size) priority, between `0` and `100`.
         * `priority`: Priority for assigning the host as master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

      You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Add the `host` block to the {{ mmy-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        host {
          zone             = "<availability_zone>"
          subnet_id        = <subnet_ID>
          assign_public_ip = <public_access_to_host>
          priority         = <priority_of_assigning_host_as_master>
          ...
        }
      }
      ```

      Where:

      * `assign_public_ip`: Public access to the host, `true` or `false`.
      * `priority`: Priority of assigning the host as master, between `0` and `100`.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API {#api}

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
* Setting backup [priority](../concepts/backup.md#size).
* Set a priority for assigning the host as a master if the [primary master fails](../concepts/replication.md#master-failover).

{% note info %}

You cannot restart a separate cluster host. To restart hosts, [stop and restart the cluster](cluster-stop.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   To change the parameters of the cluster host:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
   1. Click the ![image](../../_assets/console-icons/ellipsis.svg) icon in the required host row and select **{{ ui-key.yacloud.common.edit }}**.
   1. Set new settings for the host:
      1. Select a replication source for the host to control replication threads manually.
      1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.
      1. Set the value of the **{{ ui-key.yacloud.mysql.field_priority }}** field.
      1. Set the value of the **{{ ui-key.yacloud.mysql.field_backup_priority }}** field.
   1. Click **{{ ui-key.yacloud.postgresql.hosts.dialog.button_choose }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To modify host parameters, execute the command below (the parameter list in the example is not exhaustive):

   ```bash
   {{ yc-mdb-my }} host update <host_name> \
     --cluster-name=<cluster_name> \
     --replication-source=<source_host_name> \
     --assign-public-ip=<public_access_to_host> \
     --backup-priority=<host_backup_priority> \
     --priority=<priority_of_assigning_host_as_master>
   ```

   Where:
   * `--cluster-name`: Name of a {{ mmy-name }} cluster.
   * `--replication-source`: [Replication](../concepts/replication.md) source for the host.
   * `--assign-public-ip`: Internet access to the host, `true` or `false`.
   * `--backup-priority`: Host [backup](../concepts/backup.md#size) priority, between `0` and `100`.
   * `priority`: Priority of assigning the host as master if the [primary master host fails](../concepts/replication.md#master-failover), between `0` and `100`.

   You can request the host name with a [list of cluster hosts](#list), and the cluster name, with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   To change the parameters of the cluster host:
   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. In the {{ mmy-name }} cluster description, change the attributes of the `host` block corresponding to the host to update.

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        host {
          replication_source_name = "<replication_source>"
          assign_public_ip        = <public_access_to_host>
          priority                = <priority_of_assigning_host_as_master>
        }
      }
      ```

      Where:

      * `assign_public_ip`: Public access to the host, `true` or `false`.
      * `priority`: Priority of assigning the host as master, between `0` and `100`.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API {#api}

   To update host parameters, use the [updateHosts](../api-ref/Cluster/updateHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/UpdateHosts](../api-ref/grpc/cluster_service.md#UpdateHosts) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Configuration array for hosts to update in the `updateHostsSpecs` parameter.

      For each host, specify:
      * Name in the `hostName` field.
      * List of settings to update, in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


{% note warning %}

If you can't [connect](connect.md) to the changed host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}


## Removing a host {#remove}

You can remove a host from a {{ MY }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host is the master when deleted, {{ mmy-name }} automatically assigns the next highest-priority replica as the master.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
   1. Click the ![image](../../_assets/console-icons/ellipsis.svg) icon in the required host row and select **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```bash
   {{ yc-mdb-my }} host delete <host_name> \
      --cluster-name=<cluster_name>
   ```

   You can request the host name with a [list of cluster hosts](#list), and the cluster name, with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Delete the `host` block from the {{ mmy-name }} cluster description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API {#api}

   To delete a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * Name(s) of the host(s) to delete in the `hostNames` parameter.

{% endlist %}