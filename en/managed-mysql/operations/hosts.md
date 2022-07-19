# Managing hosts in a cluster

{% if product == "cloud-il" %}

{% include [one-az-disclaimer](../../_includes/overview/one-az-disclaimer.md) %}

{% endif %}

You can add and remove cluster hosts and manage their settings.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click on the name of the cluster you need and select the **Hosts** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-my }} host list\
      --cluster-name <cluster name>
   ```

   Result:

   {% if audience == "external" %}

   ```text
   +----------------------------+--------------+---------+--------+---------------+
   |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
   +----------------------------+--------------+---------+--------+---------------+
   | rc1b...{{ dns-zone }} | c9q5k4ve7... | MASTER  | ALIVE  | {{ region-id }}-b |
   | rc1a...{{ dns-zone }} | c9q5k4ve7... | REPLICA | ALIVE  | {{ region-id }}-a |
   +----------------------------+--------------+---------+--------+---------------+
   ```

   {% else %}

   ```text
   +----------------------+--------------+---------+--------+---------------+
   |         NAME         |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
   +----------------------+--------------+---------+--------+---------------+
   | rc1b...{{ dns-zone }} | c9q5k4ve7... | MASTER  | ALIVE  | {{ region-id }}-b |
   | rc1a...{{ dns-zone }} | c9q5k4ve7... | REPLICA | ALIVE  | {{ region-id }}-a |
   +----------------------+--------------+---------+--------+---------------+
   ```

   {% endif %}

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [listHosts](../api-ref/Cluster/listHosts.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).

{% endlist %}

## Adding a host {#add}

The number of hosts in {{ mmy-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **Managed Databases**.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click on the name of the cluster you need and go to the **Hosts** tab.
   1. Click **Add host**.
   1. Specify the host parameters:

      {% if audience != "internal" %}

      * Availability zone.
      * Subnet (if the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md)).
         {% else %}
      * Subnet (if the necessary subnet is not in the list, create it).
         {% endif %}
      * Select the **Public access** option if the host must be accessible from outside {{ yandex-cloud }}.
      * Priority for assigning the host as a master.
      * Host priority as a {{ MY }} replica for creating backups.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a host to a cluster:

   1. Request a list of cluster subnets to select one for the new host:

      ```
      yc vpc subnet list
      ```

      Result:

      ```
      +-----------+-----------+------------+---------------+------------------+
      |     ID    |   NAME    | NETWORK ID |     ZONE      |      RANGE       |
      +-----------+-----------+------------+---------------+------------------+
      | b0cl69... | default-c | enp6rq7... | {{ region-id }}-c | [172.16.0.0/20]  |
      | e2lkj9... | default-b | enp6rq7... | {{ region-id }}-b | [10.10.0.0/16]   |
      | e9b0ph... | a-2       | enp6rq7... | {{ region-id }}-a | [172.16.32.0/20] |
      | e9b9v2... | default-a | enp6rq7... | {{ region-id }}-a | [172.16.16.0/20] |
      +-----------+-----------+------------+---------------+------------------+
      ```
      {% if audience != "internal" %}

      If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).

      {% else %}

      If the required subnet is not on the list, create it.

      {% endif %}

   1. View a description of the CLI command for adding a host:

      ```
      {{ yc-mdb-my }} host add --help
      ```

   1. Execute the add host command (the example does not provide an exhaustive parameter list):

      ```bash
      {{ yc-mdb-my }} host add \
        --cluster-name=<cluster name> \
        --host zone-id=<availability zone ID>,
        --subnet-id=<subnet ID>,
        --backup-priority=<host priority for backups>
        --priority=<priority for assigning the host as a master: from 0 to 100>

      ```

      {{ mmy-short-name }} will run the add host operation.

      The subnet ID should be specified if the availability zone contains multiple subnets, otherwise {{ mmy-short-name }} automatically selects a single subnet. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   Use the [addHosts](../api-ref/Cluster/addHosts.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * New host settings in one or more `hostSpecs` parameters.

{% endlist %}

{% note warning %}

If you can't [connect](connect.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}

## Changing a host {#update}

For each host in a {{ mmy-short-name }} cluster, you can:

* Set the [replication source](../concepts/replication.md#manual-source).
* Manage [public access](../concepts/network.md#public-access-to-host).
* Set a [priority](../concepts/backup.md#size) for backups.
* Set a priority for assigning the host as a master if the [primary master fails](../concepts/replication.md#master-failover).

{% list tabs %}

- Management console

   To change the parameters of the cluster host:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the same row as the desired host and select **Edit**.
   1. Set new settings for the host:
      1. Select a replication source for the host to control replication threads manually.
      1. Enable **Public access** if a host must be accessible from outside {{ yandex-cloud }}.
      1. Enter a value in the **Master priority** field.
      1. Enter a value in the **Backup priority** field.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To modify host parameters, execute the command below (the parameter list in the example is not exhaustive):

   ```bash
   {{ yc-mdb-my }} host update <host name> \
     --cluster-name=<cluster name> \
     --replication-source=<source host name> \
     --assign-public-ip=<public access to the host: true or false> \
     --backup-priority=<host priority for backups: from 0 to 100>
     --priority=<priority for assigning the host as a master: from 0 to 100>

   ```

   Where:

   * `--cluster-name` is the name of a {{ mmy-name }} cluster.
   * `--replication-source` is the [replication](../concepts/replication.md) source for the host.
   * `--assign-public-ip` indicates whether the host is reachable from the internet over a public IP address.
   * `--backup-priority` is host priority for [backups](../concepts/backup.md#size).
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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   To change the parameters of the host, use the [updateHosts](../api-ref/Cluster/updateHosts.md) API method and pass the following in the query:
   1. In the `clusterId` parameter, the ID of the cluster where you want to change the host.
   1. In the `updateHostSpecs.hostName` parameter, the name of the host you want to change.
   1. New host settings in one or more `hostSpecs` parameters.

   You can request the host name with a [list of hosts in the cluster](#list), and the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

{% note warning %}

If you can't [connect](connect.md) to the changed host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}

## Removing a host {#remove}

You can remove a host from a {{ MY }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host is the master when deleted, {{ mmy-short-name }} automatically assigns the next highest-priority replica as the master.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the same row as the desired host and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```bash
   {{ yc-mdb-my }} host delete <hostname>
      --cluster-name=<cluster name>
   ```

   The host name can be requested with a [list of cluster hosts](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Delete the `host` block from the {{ mmy-name }} cluster description.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the deletion of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   Use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * The name(s) of the host(s) to delete, in the `hostNames` parameter.

{% endlist %}
