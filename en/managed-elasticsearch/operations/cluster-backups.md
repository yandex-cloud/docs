# Managing backups

{{ mes-short-name }} enables you to create [index](../concepts/indexing.md) backups using both {{ yandex-cloud }} tools and the {{ ES }} [snapshot](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html) mechanism.

## Creating backups with {{ yandex-cloud }} tools {#cloud-backups}

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

### Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. You can control restore speed [{{ ES }} tools](https://www.elastic.co/guide/en/elasticsearch/reference/current/recovery.html).

When creating a new cluster, set all required parameters.

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:
   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon for the required backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. Click **Restore cluster**.

   To restore a previously deleted cluster from a backup:
   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click the **Backups** tab.
   1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon for the required backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. Click **Restore cluster**.

   {{ mes-name }} launches the operation to create a cluster from the backup.

{% if audience == "draft" %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To restore a cluster from a backup:

   1. View a description of the CLI restore {{ ES }} cluster command:

      ```
      {{ yc-mdb-es }} cluster restore --help
      ```

   1. Getting a list of available {{ ES }} cluster backups:

      ```
      {{ yc-mdb-es }} backup list
      ```

      Result:

      ```
      +--------------------------+----------------------+----------------------+----------------------+
      |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
      +--------------------------+----------------------+----------------------+----------------------+
      | c9qlk4v13uq79r9cgcku... | 2020-08-10T12:00:00Z | c9qlk4v13uq79r9cgcku | 2020-08-10T11:55:17Z |
      | ...                                                                                           |
      +--------------------------+----------------------+----------------------+----------------------+
      ```
      The time when the backup was completed is shown in the `CREATED AT` column of a list of available backups, in `yyyy-mm-ddThh:mm:ssZ` format (`2020-08-10T12:00:00Z` in the example above).

   1. Request creation of a cluster from a backup:

      ```bash
      {{ yc-mdb-es }} cluster restore \
             --backup-id c9qlk4v13uq79r9cgcku:base_000000010000000000000002 \
             --name mynewes \
             --environment=PRODUCTION \
             --network-name {{ network-name }} \
             --host {{ host-net-example }} \
             --disk-size 20 \
             --disk-type {{ disk-type-example }} \
             --resource-preset {{ host-class }}
      ```

      This results in a new {{ ES }} cluster with the following characteristics:

      {% if audience != "internal" %}

      - Named `mynewes`.
      - In the `PRODUCTION` environment.
      - In the `{{ network-name }}` network.
      - With a single `{{ host-class }}` class host in the `b0rcctk2rvtr8efcch63` subnet of the `{{ region-id }}-a` availability zone.
      - With databases and users that existed in the cluster at the time of recovery.
      - With 20 GB fast network storage (`{{ disk-type-example }}`).

      {% else %}

      - Named `mynewes`.
      - In the `PRODUCTION` environment.
      - With a single `{{ host-class }}` class host in the `{{ region-id }}-a` availability zone.
      - With databases and users that existed in the cluster at the time of recovery.
      - With 20 GB fast network storage (`network-ssd`).

      {% endif %}

- {{ TF }}

   Use {{ TF }} to restore:

   * An existing cluster from a backup.
   * A cluster created and deleted via the management console, CLI, or API.

   To restore a cluster, you'll need the backup ID. Retrieve a list of available {{ ES }} cluster backups [using the CLI](#list-backups):

   ```bash
   {{ yc-mdb-es }} backup list
   ```

   Result:

   ```
   +--------------------------+----------------------+----------------------+----------------------+
   |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
   +--------------------------+----------------------+----------------------+----------------------+
   | c9qlk4v13uq79r9cgcku...  | 2020-08-10T12:00:00Z | c9qlk4v13uq79r9cgcku | 2020-08-10T11:55:17Z |
   | ...                                                                                           |
   +--------------------------+----------------------+----------------------+----------------------+
   ```

   **To restore an existing cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for a new cluster.

      {% note info %}

      Do not specify DB and user settings under `database` and `user`, they will be restored from the backup.

      {% endnote %}

   1. Add a block named `restore` to the configuration file:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        restore {
          backup_id = "<required backup name>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} creates a copy of the existing cluster. The databases and users are deployed from the selected backup.

   **To restore a previously deleted cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for a new cluster.

      {% note info %}

      Do not specify DB and user settings under `database` and `user`, they will be restored from the backup.

      {% endnote %}

   1. In the configuration file, add a `restore` block with the name of the backup to restore the cluster from:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        restore {
            backup_id = "<remote cluster backup ID>"
        }
      }
      ```

   {{ TF }} creates a new cluster. The databases and users are deployed from the backup.

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

   {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

{% endif %}

{% endlist %}

### Creating a backup {#create-backup}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click **Create a backup**.

{% if audience == "draft" %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster backup:

   1. View a description of the CLI create {{ ES }} backup command:

      ```
      {{ yc-mdb-es }} cluster backup --help
      ```
   1. Request creation of a backup specifying the cluster name or ID:

      ```
      {{ yc-mdb-es }} cluster backup my-es-cluster
      ```

      The cluster name and ID can be retrieved with the [list of clusters](cluster-list.md#list-clusters).

{% endif %}

{% endlist %}

### Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

   To get a list of cluster backups:
   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.

   To get a list of all backups in a folder:
   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click the **Backups** tab.

{% if audience == "draft" %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of {{ ES }} cluster backups available in the default folder, run the command:

   ```
   {{ yc-mdb-es }} backup list
   ```

   Result:

   ```
   +----------+----------------------+----------------------+----------------------+
   |    ID    |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
   +----------+----------------------+----------------------+----------------------+
   | c9qlk... | 2020-08-10T12:00:00Z | c9qlk4v13uq79r9cgcku | 2020-08-10T11:55:17Z |
   | c9qpm... | 2020-08-09T22:01:04Z | c9qpm90p3pcg71jm7tqf | 2020-08-09T21:30:00Z |
   +----------+----------------------+----------------------+----------------------+
   ```

{% endif %}

{% endlist %}

### Getting information about backups {#get-backup}

{% list tabs %}

- Management console

   To get information about the backup of an existing cluster:
   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.

   To get information about the backup of a previously deleted cluster:
   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click the **Backups** tab.

{% if audience == "draft" %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ ES }} cluster backup, run the command:

   ```
   {{ yc-mdb-es }} backup get <backup ID>
   ```

   You can retrieve the backup ID with the [backup list](#list-backups).

{% endif %}

{% endlist %}

{% if audience == "draft" %}

### Setting the backup start time {#set-backup-window}

{% list tabs %}

- Management console

   In the management console, you can set the backup start time when [creating](cluster-create.md) or [updating a cluster](cluster-update.md).

- CLI

   To set the backup start time, use the `-- backup-window-`start flag. Time is given in `HH:MM:SS` format.

   ```bash
   {{ yc-mdb-es }} cluster create \
      --cluster-name <cluster name> \
      --environment <environment, prestable or production> \
      --network-name <network name> \
      --host zone-id=<availability zone>,subnet-id=<subnet ID> \
      --resource-preset <host class> \
      --user name=<user name>,password=<user password> \
      --database name=<database name>,owner=<DB owner name> \
      --disk-size <storage size, GB>
      --backup-window-start 10:00:00
   ```

   To change the backup start time in an existing cluster, use the `update` command:

   ```bash
   {{ yc-mdb-es }} cluster update \
      --cluster-name <cluster name> \
      --backup-window-start 11:25:00
   ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add a block named `backup_window_start` to the {{ mes-name }} cluster description under `config`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        config {
          ...
          backup_window_start {
            hours   = <backup start hour (UTC)>
            minutes = <backup start minute (UTC)>
          }
          ...
        }
        ...
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

   {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

{% endlist %}

{% endif %}

## Backups using snapshots {#snapshot-backups}

To work with snapshots, use the [{{ ES }} public API](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore-apis.html) and a bucket in {{ objstorage-name }} to store them.

### Retrieving a snapshot list {#list-snapshots}

1. Find the repository containing snapshot backups in the {{ ES }} repository list:

   ```http
   GET https://admin:<password>@<host_FQDN_or_IP-address>:9200/_snapshot/_all
   ```

   If the desired repository is not on the list, [connect it](./s3-access.md).

1. Get a list of snapshots in the repository:

   ```http
   GET https://admin:<password>@<host_FQDN_or_IP_ address>:9200/_snapshot/<repository>/_all
   ```

   Each snapshot is a single backup.


### Creating a snapshot {#create-snapshot}

1. In the {{ ES }} repository list, find the repository where you want to create the snapshot:

   ```http
   GET https://admin:<password>@<host_FQDN_or_IP-address>:9200/_snapshot/_all
   ```

   If the desired repository is not on the list, [connect it](./s3-access.md).

1. [Create a snapshot](https://www.elastic.co/guide/en/elasticsearch/reference/current/create-snapshot-api.html) of the desired data or cluster in the selected repository:

   ```http
   PUT https://admin:<password>@<host_FQDN_or_IP-address>:9200/_snapshot/<repository>/<snapshot>
   ```

### Restoring a cluster from a snapshot {#restore-from-snapshot}

{% note warning %}

When restoring from snapshots, the following restrictions apply:

* The {{ ES }} version in the cluster must be equal to or higher than the {{ ES }} version where the snapshot was taken.
* To restore the indexes, be sure that the major {{ ES }} version in the cluster is no more than one unit higher than the major {{ ES }} version where the snapshot was taken. For example, you can use version 6.0 (but not 7.0) to recover indexes created in version 5.0.

{% endnote %}

1. [Create a new {{ ES }} cluster](./cluster-create.md) in the desired configuration, but don't populate it with data.

   When creating a cluster, select:

   * The number and class of hosts as well as the size and type of storage based on snapshot size and performance requirements. If necessary, [upgrade your host class](./cluster-update.md#change-resource-preset) or [increase cluster storage size](./cluster-update.md#change-disk-size).

   * The {{ ES }} version used to make the snapshot or higher.

1. Close the open indexes using the [{{ES}} API](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-close.html):

   ```http
   POST: https://admin:<password>@<host_FQDN_or_IP-address>:9200/<index>/_close
   ```

   To restore an entire cluster, close all open indices. To restore individual indices, close only those indices.

1. [Retrieve a list of backups](#list-snapshots) and find the desired snapshot.
1. [Start restoring](https://www.elastic.co/guide/en/elasticsearch/reference/current/restore-snapshot-api.html) an entire cluster or individual data indexes and streams from the desired snapshot.

For more information about restoring from snapshots, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html).
