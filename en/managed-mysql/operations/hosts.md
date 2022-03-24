# Managing hosts in a cluster

You can add and remove cluster hosts and manage their settings.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the **Hosts** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of databases in a cluster, run the command:

  ```
  $ {{ yc-mdb-my }} host list
       --cluster-name=<cluster name>
  ```

  {% if audience == "external" %}

  ```
  +----------------------------+--------------+---------+--------+---------------+
  |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
  +----------------------------+--------------+---------+--------+---------------+
  | rc1b...{{ dns-zone }} | c9q5k4ve7... | MASTER  | ALIVE  | ru-central1-b |
  | rc1c...{{ dns-zone }} | c9q5k4ve7... | REPLICA | ALIVE  | ru-central1-c |
  +----------------------------+--------------+---------+--------+---------------+
  ```

  {% else %}

  ```text
  +----------------------+--------------+---------+--------+---------------+
  |         NAME         |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
  +----------------------+--------------+---------+--------+---------------+
  | rc1b...{{ dns-zone }} | c9q5k4ve7... | MASTER  | ALIVE  | ru-central1-b |
  | rc1c...{{ dns-zone }} | c9q5k4ve7... | REPLICA | ALIVE  | ru-central1-c |
  +----------------------+--------------+---------+--------+---------------+
  ```

  {% endif %}

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  Use the [listHosts](../api-ref/Cluster/listHosts.md) API method and pass the cluster ID in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).

{% endlist %}

## Adding a host {#add}

The number of hosts in {{ mmy-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find the **Managed Databases** section.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.

  1. Click on the name of the cluster you need and go to the **Hosts** tab.

  1. Click **Add host**.

  1. Specify the host parameters:
     * Availability zone.
     * Subnet (if the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md)).
     * Priority of the host as a {{ MY }} replica.
     * Replication source (if you use cascading replication).
     * Select the **Public access** option if the host must be accessible from outside {{ yandex-cloud }}.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a host to the cluster:

  1. Request a list of cluster subnets to select one for the new host:

      ```
      $ yc vpc subnet list
      
      +-----------+-----------+------------+---------------+------------------+
      |     ID    |   NAME    | NETWORK ID |     ZONE      |      RANGE       |
      +-----------+-----------+------------+---------------+------------------+
      | b0cl69... | default-c | enp6rq7... | ru-central1-c | [172.16.0.0/20]  |
      | e2lkj9... | default-b | enp6rq7... | ru-central1-b | [10.10.0.0/16]   |
      | e9b0ph... | a-2       | enp6rq7... | ru-central1-a | [172.16.32.0/20] |
      | e9b9v2... | default-a | enp6rq7... | ru-central1-a | [172.16.16.0/20] |
      +-----------+-----------+------------+---------------+------------------+
      ```

      If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).

  1. View a description of the CLI command for adding a host:

     ```
     $ {{ yc-mdb-my }} host add --help
     ```

  1. Run the add host command:

     ```
     $ {{ yc-mdb-my }} host add
          --cluster-name=<cluster name>
          --host zone-id=<availability zone>,subnet-id=<subnet ID>
     ```

     {{ mmy-short-name }} will run the add host operation.

     The subnet ID should be specified if the availability zone contains multiple subnets, otherwise {{ mmy-short-name }} automatically selects a single subnet. You can retrieve the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](cluster-create.md).

  1. Add the `host` block to the {{ mmy-name }} cluster description.

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        host {
          zone             = "<availability zone>"
          subnet_id        = <subnet ID>
          assign_public_ip = <public access to the host: true or false>
          ...
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

- API

    Use the [addHosts](../api-ref/Cluster/addHosts.md) API method and pass the following in the request:
    * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
    * New host settings in one or more `hostSpecs` parameters.

{% endlist %}

{% note warning %}

If you can't [connect](connect.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}

## Changing a host {#update}

For each host in a {{ mmy-short-name }} cluster, specify the [replication](../concepts/replication.md) source and manage host [public access](../concepts/network.md#public-access-to-a-host).

{% list tabs %}

- Management console

  To change the parameters of the cluster host:

    1. Go to the folder page and select **{{ mmy-name }}**.
    1. Click on the name of the cluster you want and select the **Hosts** tab.
    1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the row next to the desired host and select **Edit**.
    1. Set new settings for the host:
        1. Select a replication source for the host to manually control replication threads.
        1. Enable **Public access** if a host must be accessible from outside {{ yandex-cloud }}.
    1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the parameters of a host in a cluster, run the command below:

  ```
  $ {{ yc-mdb-my }} host update <host name>
       --cluster-name <cluster name>
       --replication-source <source host's name>
       --assign-public-ip=<public access to the host: true or false>
  ```

  You can request a host name with a [list of cluster hosts](#list), and a cluster name with a [list of clusters in a folder](cluster-list.md#list-clusters).

  To manage replication in the cluster, change in the `--host` parameter:
    - Replication source for the host in the `replication-source` option to manually control replication threads.
    - External host visibility {{ yandex-cloud }} in the `assign-public-ip` option.

- Terraform

  To change the parameters of the cluster host:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

       For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mmy-name }} cluster description, change the attributes of the `host` block corresponding to the host to update.

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<cluster name>" {
          ...
          host {
            replication_source_name = "<replication source>"
            assign_public_ip        = <host public access: true or false>
          }
        }
        ```

    1. Make sure the settings are correct.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [provider documentation {{ TF }}]({{ tf-provider-mmy }}).

- API

  To modify host parameters, use the API [updateHosts](../api-ref/Cluster/updateHosts.md) method and pass the following in the call:
    1. In the `clusterId` parameter, the ID of the cluster where you want to change the host.
    1. In the `updateHostSpecs.hostName` parameter, the name of the host you want to change.

  You can request a host name with a [list of cluster hosts](#list), and a cluster ID with a [list of clusters in a folder](cluster-list.md#list-clusters).

{% endlist %}

{% note warning %}

If you can't [connect](connect.md) to the changed host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}

## Removing a host {#remove}

You can remove a host from a {{ MY }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host is the master when deleted, {{ mmy-short-name }} automatically assigns the next highest-priority replica as the master.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you want and select the **Hosts** tab.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the line of the desired host and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a host from the cluster, run:

  ```
  $ {{ yc-mdb-my }} host delete <host name>
       --cluster-name=<cluster name>
  ```

  The host name can be requested with a [list of cluster hosts](#list-hosts), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](cluster-create.md).

  1. Delete the `host` block from the {{ mmy-name }} cluster description.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the deletion of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

- API

    Use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) API method and pass the following in the request:
    * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
    * The name(s) of the host(s) to delete, in the `hostNames` parameter.

{% endlist %}
