# Managing hosts in a cluster


You can add and remove cluster hosts and manage their settings.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.

   1. Click on the name of the cluster you need and select the **Hosts** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of databases in a cluster, run the command:

   ```
   {{ yc-mdb-pg }} host list \
      --cluster-name <cluster name>
   ```

   
   ```text
   +----------------------------+--------------+---------+--------+---------------+
   |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
   +----------------------------+--------------+---------+--------+---------------+
   | rc1b...{{ dns-zone }} | c9qp71dk1... | MASTER  | ALIVE  | {{ region-id }}-b |
   | rc1a...{{ dns-zone }} | c9qp71dk1... | REPLICA | ALIVE  | {{ region-id }}-a |
   +----------------------------+--------------+---------+--------+---------------+
   ```


   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).


- API

   To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) method.

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
      - Availability zone.
      - Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).
      - Priority of the host as a {{ PG }} replica.

         Change the priority to modify the [selection of the master in the cluster](../concepts/replication.md#selecting-the-master):
         - The host with the highest priority in the cluster becomes the master.
         - If the cluster has multiple hosts with the highest priority, the master host is elected from among them.
         - The lowest priority is `0` (default), the highest is `100`.

      - Replication source (if you use [cascading replication](../concepts/replication.md#replication-manual)).
      - Select **Public access** if the host must be accessible from outside {{ yandex-cloud }}.


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
      | b0cl69... | default-c | enp6rq7... | {{ region-id }}-c | [172.16.0.0/20]  |
      | e2lkj9... | default-b | enp6rq7... | {{ region-id }}-b | [10.10.0.0/16]   |
      | e9b0ph... | a-2       | enp6rq7... | {{ region-id }}-a | [172.16.32.0/20] |
      | e9b9v2... | default-a | enp6rq7... | {{ region-id }}-a | [172.16.16.0/20] |
      +-----------+-----------+------------+---------------+------------------+
      ```

      If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).


   1. View a description of the CLI command for adding a host:

      ```
      $ {{ yc-mdb-pg }} host add --help
      ```

   1. Run the add host command:

      
      ```
      $ {{ yc-mdb-pg }} host add
           --cluster-name <cluster name>
           --host zone-id=<availability zone>,subnet-id=<subnet ID>
      ```


      
      The subnet ID should be specified if the availability zone contains multiple subnets, otherwise {{ mpg-short-name }} automatically selects a single subnet. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).


      You can also specify several additional options in the `--host` parameter to manage public access to a host and replication in a cluster:
      - Replication source for the host in the `replication-source` option to [manually manage replication threads](../concepts/replication.md#replication-manual).
      - Host priority in the `priority` option in order to [modify the selection of master](../concepts/replication.md#selecting-the-master):
         - The host with the highest priority value in the cluster becomes the master.
         - If the cluster has multiple hosts with the highest priority, the master host is elected from among them.
         - The lowest priority is `0` (default), the highest is `100`.
      - External host visibility {{ yandex-cloud }} in the `assign-public-ip` option:
         - `true`: public access enabled.
         - `false`: public access disabled.

   {{ mpg-short-name }} will run the add host operation.

- Terraform

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
          priority                = <priority for selecting master>
          replication_source_name = "<replication source: name attribute of appropriate host block>"
          assign_public_ip        = <public access to host: true or false>
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   To add a host to the cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) method.

{% endlist %}

{% note warning %}

If you can't [connect](connect.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}

## Changing a host {#update}

For each host in a {{ mpg-short-name }} cluster, you can change the priority, specify the [replication](../concepts/replication.md) source, and manage host [public access](../concepts/network.md#public-access-to-a-host).

{% list tabs %}

- Management console

   To change the parameters of the cluster host:

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the same row as the desired host and select **Edit**.
   1. Set new settings for the host:
      1. Set the priority to modify the [selection of the master in the cluster](../concepts/replication.md#selecting-the-master):
         - The host with the highest priority in the cluster becomes the master.
         - If the cluster has multiple hosts with the highest priority, the master host is elected from among them.
         - The lowest priority is `0` (default), the highest is `100`.
      1. Select the replication source for the host to [manually manage replication threads](../concepts/replication.md#replication-manual).
      1. Enable **Public access** if a host must be accessible from outside {{ yandex-cloud }}.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the parameters of a host in a cluster, run the command below:

   ```
   $ {{ yc-mdb-pg }} host update <hostname>
        --cluster-name <cluster name>
        --replication-source <source hostname>
        --priority <replica priority>
        --assign-public-ip=<public access to host: true or false>
   ```

   The host name can be requested with a [list of cluster hosts](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

   To manage replication in the cluster, change in the `--host` parameter:
   - Replication source for the host in the `replication-source` option to [manually manage replication threads](../concepts/replication.md#replication-manual).
   - Host priority in the `priority` option in order to [modify the selection of master](../concepts/replication.md#selecting-the-master):
      - The host with the highest priority value in the cluster becomes the master.
      - If the cluster has multiple hosts with the highest priority, the master host is elected from among them.
      - The lowest priority is `0` (default), the highest is `100`.
   - External host visibility {{ yandex-cloud }} in the `assign-public-ip` option:

- Terraform

   To change the parameters of the cluster host:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. In the {{ mpg-name }} cluster description, change the attributes of the `host` block corresponding to the host to update.

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        host {
          priority                = <priority for selecting a master>
          replication_source_name = "<replication source>"
          assign_public_ip        = <public access to host: true or false>
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   To change the parameters of the host, use the [updateHosts](../api-ref/Cluster/updateHosts.md) API method and pass the following in the query:
   1. In the `clusterId` parameter, the ID of the cluster where you want to change the host.
   1. In the `updateHostSpecs.hostName` parameter, the name of the host you want to change.

   You can request the host name with a [list of hosts in the cluster](#list), and the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

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

   1. Click on the name of the cluster you want and select the **Hosts** tab.

   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the same row as the desired host and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```
   $ {{ yc-mdb-pg }} host delete <hostname>
        --cluster-name <cluster name>
   ```

   The host name can be requested with a [list of cluster hosts](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

   To remove a host from a cluster:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. Delete the corresponding `host` block from the {{ mpg-name }} cluster description.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the deletion of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   To remove a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method.

{% endlist %}
