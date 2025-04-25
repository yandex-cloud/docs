# Migrating an HDFS {{ dataproc-name }} cluster to a different availability zone


Subclusters of each {{ dataproc-name }} cluster reside in the same [cloud network](../../../vpc/concepts/network.md#network) and [availability zone](../../../overview/concepts/geo-scope.md). You can migrate a cluster to a different availability zone. The migration process depends on the cluster type:

* The following describes how to migrate HDFS clusters.
* For information on migrating [lightweight clusters](../../../data-proc/concepts/index.md#light-weight-clusters), follow the [tutorial](../../../data-proc/operations/migration-to-an-availability-zone.md).

{% include [zone-d-host-restrictions](../../../_includes/mdb/ru-central1-d-broadwell.md) %}

To migrate an HDFS cluster:

1. [Create a cluster via import in {{ TF }}](#create).
1. [Copy the data to the new cluster](#copy).
1. [Delete the initial cluster](#delete).

Before you begin, [create a subnet](../../../vpc/operations/subnet-create.md) in the availability zone to which you are migrating the cluster.


## Required paid resources {#paid-resources}

The support cost includes the fee for the {{ dataproc-name }} clusters (see [{{ dataproc-name }} pricing](../../../data-proc/pricing.md)).


## Create a cluster via import in {{ TF }} {#create}

To create a {{ dataproc-name }} cluster in a different availability zone with the same configuration as the initial cluster, import the initial cluster's configuration into {{ TF }}:

{% list tabs group=instructions %}

* {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}
   1. In the same working directory, place a `.tf` file with the following contents:

      ```hcl
      resource "yandex_dataproc_cluster" "old" { }
      ```

   1. Write the initial cluster ID to the environment variable:

      ```bash
      export DATAPROC_CLUSTER_ID=<cluster_ID>
      ```

      You can request the ID with the [list of clusters in the folder](../../../data-proc/operations/cluster-list.md#list).

   1. Import the initial cluster settings into the {{ TF }} configuration:

      ```bash
      terraform import yandex_dataproc_cluster.old ${DATAPROC_CLUSTER_ID}
      ```

   1. Get the imported configuration:

      ```bash
      terraform show
      ```

   1. Copy it from the terminal and paste it into the `.tf` file.
   1. Place the file in the new `imported-cluster` directory.
   1. Modify the copied configuration so that you can create a new cluster from it:

      * Specify the new cluster name in the `resource` string and the `name` parameter.
      * Delete the `created_at`, `host_group_ids`, `id`, and `subcluster_spec.id` parameters.
      * Change the availability zone in the `zone_id` parameter.
      * In the `subnet_id` parameters of the `subcluster_spec` sections, specify the ID of the new subnet created in the required availability zone.
      * Change the SSH key format in the `ssh_public_keys` parameter. Source format:

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
   1. In the same directory, [configure and initialize a provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). There is no need to create a provider configuration file manually, you can [download it](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
   1. Place the configuration file in the `imported-cluster` directory and [specify the parameter values](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you did not add the authentication credentials to environment variables, specify them in the configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Copy the data to the new cluster {#copy}

1. Make sure no operations or jobs are being performed on the HDFS files and directories you want to copy.

   To see a list of running operations and jobs:

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the initial cluster name and select the **{{ ui-key.yacloud.dataproc.switch_operations }}** tab, then select **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.

   {% note info %}

   Until you have completed the migration, do not run any operations or jobs modifying the HDFS files and directories you are copying.

   {% endnote %}

1. [Connect via SSH](../../../data-proc/operations/connect.md#data-proc-ssh) to the master host of the initial cluster.
1. Get a list of directories and files to be copied to the new cluster:

   ```bash
   hdfs dfs -ls /
   ```

   Instead of the `/` symbol, you can specify the directory you need.

1. To test copying data to the new {{ dataproc-name }} cluster, create test directories:

   ```bash
   hdfs dfs -mkdir /user/foo &&\
   hdfs dfs -mkdir /user/test
   ```

   In the example below, only the `/user/foo` and `/user/test` test directories are copied for demonstration purposes.

1. Connect via SSH to the master host of the new cluster.
1. Create a file named `srclist`:

   ```bash
   nano srclist
   ```

1. Add to it a list of directories intended for migration:

   ```text
   hdfs://<initial_cluster_FQDN>:8020/user/foo
   hdfs://<initial_cluster_FQDN>:8020/user/test
   ```

   In the command, specify the FQDN of the master host of the initial cluster. For information on how to obtain an FQDN, read the [tutorial](../../../data-proc/operations/connect.md#fqdn).

1. Put the `srclist` file into the `/user` HDFS directory:

   ```bash
   hdfs dfs -put srclist /user
   ```

1. Create a directory to copy the data to. In the example, it is the `copy` directory, nested in `/user`.

   ```bash
   hdfs dfs -mkdir /user/copy
   ```

1. Copy the data between clusters using [DistCp](https://hadoop.apache.org/docs/current/hadoop-distcp/DistCp.html):

   ```bash
   hadoop distcp -f hdfs://<new_cluster_FQDN>:8020/user/srclist \
   hdfs://<new_cluster_FQDN>:8020/user/copy
   ```

   In the command, specify the FQDN of the master host of the new cluster.

   As a result, all directories and files specified in the `srclist` will be copied to the `/user/copy` directory.

   If copying a large volume of data, use the `-m <maximum_simultaneous_copies>` flag in the command to limit network bandwidth consumption. For more information, see the [DistCp documentation](https://hadoop.apache.org/docs/r3.2.2/hadoop-distcp/DistCp.html#Command_Line_Options).

   You can view the data volume you copy in the HDFS web interface. To open it:

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the initial cluster name.
   1. On its page, in the **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}** section, click the **HDFS Namenode UI** link.

   The **DFS Used** field states the initial cluster's data volume in HDFS.

1. Make sure the data is copied:

   ```bash
   hdfs dfs -ls /user/copy
   ```

This way you can copy all the data you need. To do this, specify the required directories and files in `srclist`.

## Delete the initial cluster {#delete}

By following [this guide](../../../data-proc/operations/cluster-delete.md).
