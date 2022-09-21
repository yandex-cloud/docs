# {{ PG }} version upgrade

You can upgrade a {{ mpg-name }} cluster to any supported version.

{% note info %}

* Upgrades are unavailable for {{ mpg-name }} clusters optimized for <q>1C:Enterprise</q>. The names of these versions end in `-1c`.
* You can't upgrade a regular cluster version to a version optimized for <q>1C:Enterprise</q> (such as from version 14 to version 14-1c).

{% endnote %}

You can only upgrade to a version that immediately follows the current one, such as version 11 to 12. Upgrades to higher versions are performed in steps. To upgrade {{ PG }} from version 11 to version 13, for instance, follow the steps: 11 → 12 → 13.

In single-host clusters, the only master host is brought out of its running state for upgrades. During an upgrade, these clusters are unavailable.

In multi-host clusters, upgrades follow the procedure below:

1. The master is unavailable during upgrades. During this time, the replicas continue running in read-only mode. No [failover](../concepts/replication.md#replication-auto) occurs. After an upgrade, the master is not returned to a running state until all the replicated hosts are upgraded. It is temporarily unavailable even for reading.
1. The replicas are sequentially made unavailable and upgraded. The replicas are queued randomly. Following an upgrade, the replicas are returned to a running state in read-only mode.

   A two-host cluster is unavailable while its replica is upgrading. In a cluster of three or more hosts, at least one replica will be available for reading.

1. The master returns to a running state.

To learn more about updates within one version and host maintenance, see [{#T}](../concepts/maintenance.md).

## Before upgrading {#before-update}

Prior to upgrading a cluster, make sure this doesn't affect your applications:

1. Review the [change log](https://www.postgresql.org/docs/release/) for the {{ PG }} versions that you are upgrading your cluster to, and make sure they do not affect your applications or the [{{ PG }} extensions](./extensions/cluster-extensions.md) installed.
1. Try upgrading a test cluster (you can try [deploying](cluster-backups.md#restore) it from a backup of the main cluster).
1. [Back up](cluster-backups.md#create-backup) the main cluster prior to upgrading.

## Upgrading a cluster {#start-update}

{% note alert %}

* Once your DBMS is upgraded, you cannot roll a cluster back to the previous version.
* The success of {{ PG }} version upgrade depends on multiple factors, including cluster settings and data stored in databases. We recommend that you first [upgrade a test cluster](#before-update) that uses the same data and settings.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Select the cluster from the list and click **Edit cluster**.
   1. In the **Version** field, select a new version number.
   1. Click **Save changes**.

   Once the upgrade is launched, the cluster status changes to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Get a list of your {{ PG }} clusters using the command:

      ```bash
      {{ yc-mdb-pg }} cluster list
      ```

   1. Get information about a cluster and check the {{ PG }} version in the `config.version` parameter:

      ```bash
      {{ yc-mdb-pg }} cluster get <cluster ID or name>
      ```

   1. Start the {{ PG }} upgrade:

      ```bash
      {{ yc-mdb-pg }} cluster update <cluster ID or name> \
         --postgresql-version <new version number>
      ```

   Once the upgrade is launched, the cluster status changes to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. Under `cluster_config` of the desired {{ mpg-name }} cluster, add the `version` field or edit it if it already exists:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        cluster_config {
          version = "<PostgreSQL version>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * The {{ PG }} version number in the `configSpec.version` parameter.
   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Examples {#examples}

Let's say you need to upgrade your cluster from version 11 to version 12.

{% list tabs %}

- CLI

   1. To get a list of clusters and find out their IDs and names, run the command:

      ```bash
      {{ yc-mdb-pg }} cluster list
      ```

      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih8iti42mh |   postgre406  | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. To get information about a cluster named `postgre406`, run the command:

      ```bash
      {{ yc-mdb-pg }} cluster get postgre406
      ```

      ```text
        id: c9q8p8j2gaih8iti42mh
        ...
        config:
          version: "11"
          ...
      ```

   1. To upgrade the `postgre406` cluster to version 12, run the command:

      ```bash
      {{ yc-mdb-pg }} cluster update postgre406 --postgresql-version 12
      ```

{% endlist %}
