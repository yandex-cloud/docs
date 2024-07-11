# Updating a {{ dataproc-name }} cluster

After creating a cluster, you can change its basic and advanced settings.


You can disable sending cluster logs to {{ cloud-logging-full-name }}. For more information, see [Working with logs](logging.md#disable-logs).


You can also move a {{ dataproc-name }} cluster to a different availability zone. The process depends on the cluster type:

* [Migrating a lightweight cluster to a different availability zone](migration-to-an-availability-zone.md).
* [Migrating an HDFS cluster to a different availability zone](../tutorials/hdfs-cluster-migration.md).

To change {{ dataproc-name }} cluster settings:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.

   
   1. To edit the [log group](../../logging/concepts/log-group.md) that cluster logs are sent to, select a new log group from the list. If necessary, [create a new log group](../../logging/operations/create-group.md).

      For the function to work, [assign](../../iam/operations/roles/grant.md) the `logging.writer` role to the service account of the cluster. For more information, see the [{{ cloud-logging-full-name }} documentation](../../logging/security/index.md).


   1. To update your cluster [component properties](../concepts/settings-list.md), enter the component key and its new value in the **{{ ui-key.yacloud.mdb.forms.config_field_properties }}** field.

   1. Change additional cluster settings:

      **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}**: Manages cluster protection against accidental deletion by a user.

      Enabled protection will not prevent a manual connection to the cluster and deletion of data.

   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-dp }} cluster update --help
      ```

   
   1. To edit the [log group](../../logging/concepts/log-group.md) that cluster logs are sent to, provide the log group ID in the `--log-group-id` parameter:

      ```bash
      {{ yc-dp }} cluster update <cluster_name_or_ID> \
         --log-group-id=<log_group_ID>
      ```

      You can request the log group ID with a [list of log groups in the folder](../../logging/operations/list.md).


   1. To protect a cluster from accidental deletion by a user of your cloud, set `--deletion-protection` to `true`:

      ```bash
      {{ yc-dp }} cluster update <cluster_name_or_ID> \
         --deletion-protection=true
      ```

      Enabled protection will not prevent a manual connection to the cluster and deletion of data.

   1. To update the [component properties](../concepts/settings-list.md), provide the required property values in the `--property` parameter:

      ```bash
      {{ yc-dp }} cluster update <cluster_name_or_ID> \
         --property "<key_1_prefix>:<key_1>=<value>", "<key_2_prefix>:<key_2>=<value>", ...
      ```

      {% note warning %}

      Using the `--property` parameter will reset any component properties that were not explicitly provided in the parameter to their defaults. To save the previously updated properties, list them in your request along with the properties you want to update.

      {% endnote %}

   You can get the cluster ID and name with a [list of clusters in the folder](./cluster-list.md#list).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. To activate cluster deletion protection and access to {{ dataproc-name }} [component web interfaces](../concepts/interfaces.md), update the values in the appropriate fields of the {{ dataproc-name }} cluster description:

      ```hcl
      resource "yandex_dataproc_cluster" "data_cluster" {
        ...
        deletion_protection = true
        ui_proxy            = true
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}
