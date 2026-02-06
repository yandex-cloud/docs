# Migrating an HDFS {{ dataproc-name }} cluster to a different availability zone


Subclusters of each {{ dataproc-name }} cluster reside in the same [cloud network](../../../vpc/concepts/network.md#network) and [availability zone](../../../overview/concepts/geo-scope.md). You can migrate a cluster to a different availability zone. The migration process depends on the cluster type:

* The following describes how to migrate HDFS clusters.
* For information on migrating [lightweight clusters](../../../data-proc/concepts/index.md#light-weight-clusters), check [this guide](../../../data-proc/operations/migration-to-an-availability-zone.md).

{% include [zone-d-host-restrictions](../../../_includes/mdb/ru-central1-d-broadwell.md) %}

To migrate an HDFS cluster:

1. [Create a cluster via import in {{ TF }}](#create).
1. [Copy the data to the new cluster](#copy).
1. [Delete the source cluster](#delete).

To get started, [create a subnet](../../../vpc/operations/subnet-create.md) in the availability zone to which you are migrating the cluster.


## Required paid resources {#paid-resources}

The support cost includes the fee for the {{ dataproc-name }} clusters (see [{{ dataproc-name }} pricing](../../../data-proc/pricing.md)).


## Create a cluster via import in {{ TF }} {#create}

To create a {{ dataproc-name }} cluster in a different availability zone with the same configuration as the source cluster, import the source cluster's configuration into {{ TF }}:

{% list tabs group=instructions %}

* {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}
   1. In your current working directory, create a `.tf` file with the following contents:

      ```hcl
      resource "yandex_dataproc_cluster" "old" { }
      ```

   1. Save the ID of the source cluster to an environment variable:

      ```bash
      export DATAPROC_CLUSTER_ID=<cluster_ID>
      ```

      You can get the cluster ID with the [list of clusters in the folder](../../../data-proc/operations/cluster-list.md#list).

   1. Import the source cluster configuration into {{ TF }}:

      ```bash
      terraform import yandex_dataproc_cluster.old ${DATAPROC_CLUSTER_ID}
      ```

   1. Get the imported configuration:

      ```bash
      terraform show
      ```

   1. Copy it from the terminal and paste it into the `.tf` file.
   1. Place the file in the new `imported-cluster` directory.
   1. Edit the copied configuration so that you can create a new cluster from it:

      * Specify the new cluster name in the `resource` string and the `name` parameter.
      * Delete `created_at`, `host_group_ids`, `id`, and `subcluster_spec.id`.
      * Change the availability zone in the `zone_id` parameter.
      * In `subnet_id` of the `subcluster_spec` sections, specify the ID of the new subnet created in the required availability zone.
      * Change the SSH key format in the `ssh_public_keys` parameter. Initial format:

         ```hcl
         ssh_public_keys = [
           <<-EOT
             <key>
           EOT,
         ]
         ```

         Required format:

         ```hcl
         ssh_public_keys = [
           "<key>"
         ]
         ```

   1. [Get the authentication credentials](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) in the `imported-cluster` directory.
   1. In the same directory, [configure and initialize the provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). [Download](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf) the provider configuration file rather than creating it manually.
   1. Place the configuration file in the `imported-cluster` directory and [specify the parameter values](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you have not set the authentication credentials as environment variables, specify them in the configuration file.
   1. Validate your {{ TF }} configuration files using this command:

      ```bash
      terraform validate
      ```

      {{ TF }} will display any configuration errors detected in your files.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Copy the data to the new cluster {#copy}

1. Make sure no operations or jobs are being performed on the HDFS files and directories you want to copy.

   To view a list of running operations and jobs:

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the source cluster name and select the **{{ ui-key.yacloud.dataproc.switch_operations }}** tab, then select **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.

   {% note info %}

   Do not run any operations or jobs modifying the HDFS files and directories you are copying until the migration is complete.

   {% endnote %}

1. [Connect over SSH](../../../data-proc/operations/connect-ssh.md) to the master host of the source cluster.
1. Get a list of directories and files to copy to the new cluster:

   ```bash
   hdfs dfs -ls /
   ```

   You can specify the directory you need instead of `/`.

1. To test copying data to the new {{ dataproc-name }} cluster, create test directories:

   ```bash
   hdfs dfs -mkdir /user/foo &&\
   hdfs dfs -mkdir /user/test
   ```

   For demonstration, the example below copies only the `/user/foo` and `/user/test` test directories.

1. Connect over SSH to the master host of the new cluster.
1. Create a file named `srclist`:

   ```bash
   nano srclist
   ```

1. Add to it a list of directories to migrate:

   ```text
   hdfs://<source_cluster_FQDN>:8020/user/foo
   hdfs://<source_cluster_FQDN>:8020/user/test
   ```

   In the command, specify the FQDN of the source cluster master host. Learn how to get an FQDN in [this guide](../../../data-proc/operations/fqdn.md).

1. Place the `srclist` file to the `/user` HDFS directory:

   ```bash
   hdfs dfs -put srclist /user
   ```

1. Create a directory to copy the data to. In this example, it is the `copy` directory nested in `/user`.

   ```bash
   hdfs dfs -mkdir /user/copy
   ```

1. Copy the data between clusters using [DistCp](https://hadoop.apache.org/docs/current/hadoop-distcp/DistCp.html):

   ```bash
   hadoop distcp -f hdfs://<new_cluster_FQDN>:8020/user/srclist \
   hdfs://<new_cluster_FQDN>:8020/user/copy
   ```

   In the command, specify the FQDN of the master host of the new cluster.

   As a result, all directories and files specified in `srclist` will be copied to the `/user/copy` directory.

   If you need to copy a large amount of data, use the `-m <maximum_simultaneous_copies>` flag in the command to limit network bandwidth consumption. For more information, see [this DistCp article](https://hadoop.apache.org/docs/r3.2.2/hadoop-distcp/DistCp.html#Command_Line_Options).

   You can check the data amount you copy in the HDFS web UI. To open it:

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the source cluster name.
   1. On the cluster page, click the **HDFS Namenode UI** link under **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**.

   The **DFS Used** field shows the source cluster's data amount in HDFS.

1. Make sure the data is copied:

   ```bash
   hdfs dfs -ls /user/copy
   ```

This way you can copy all the data you need. To do this, specify the required directories and files in `srclist`.

## Delete the source cluster {#delete}

Learn how to do this in [this guide](../../../data-proc/operations/cluster-delete.md).
