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
    1. Change the name and description of the cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** and **{{ ui-key.yacloud.mdb.forms.base_field_description }}** fields.
    1. Add or delete cluster [labels](../../resource-manager/concepts/labels.md) in the **{{ ui-key.yacloud.component.label-set.label_labels }}** field:
    1. Update cluster settings:

        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: [Service account](../../iam/concepts/users/service-accounts.md) to which you need to grant access to the {{ dataproc-full-name }} cluster.

            Select an existing service account or [create a new one](../../iam/operations/sa/create.md).

        * **{{ ui-key.yacloud.mdb.forms.config_field_properties }}**: Cluster [component properties](../concepts/settings-list.md).

            Add, edit, or delete the required properties:

            {% note tip %}

            If you want a property to be included into a configuration file [relating to a specific component](../concepts/settings-list.md#available-properties), specify a [prefix](../concepts/settings-list.md) for the key.

            {% endnote %}

        * **{{ ui-key.yacloud.mdb.forms.config_field_form-bucket-type }}**: [Bucket](../../storage/concepts/bucket.md) name selection format, **{{ ui-key.yacloud.forms.label_form-list }}** or **{{ ui-key.yacloud.forms.label_form-id }}**.

        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: Name of the bucket that will be used by the cluster.

            Depending on the format you selected, either pick a name from the list or specify it manually. You can request the name of the bucket with the [list of buckets in the folder](../../storage/operations/buckets/get-info.md#get-information).

        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: [Security groups](../concepts/network.md#security-groups) that will be used by the cluster.

            Select one or more security groups. If the required security group is not in the list, [create it](../../vpc/operations/security-group-create.md).

            {% note warning %}

            Incorrect security group settings may cause {{ dataproc-full-name }} cluster performance issues. For more information on setting up security groups, see [Connecting to a cluster](./connect.md#configuring-security-groups).

            {% endnote %}

        * **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}**: Option that manages access to [component web interfaces](../concepts/interfaces.md) via [UI Proxy](./connect-interfaces.md#ui-proxy).

            {% include [ui-proxy-sg-warning](../../_includes/data-proc/ui-proxy-sg-warning.md) %}

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_log-group }}**: {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md) the cluster will send logs to.

            Select the default log group or another existing log group. If the required log group is not in the list, [create it](../../logging/operations/create-group.md).

            To enable the cluster to send logs, [assign](../../iam/operations/roles/grant.md) the `logging.writer` role to its service account. For more information, see the [{{ cloud-logging-full-name }} documentation](../../logging/security/index.md).

    1. In the advanced cluster settings, select the required **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** value.

        This option manages cluster protection against accidental deletion by a user.

        Enabled protection will not prevent a manual connection to the cluster and deletion of data.

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View a description of the update cluster CLI command:

        ```bash
        {{ yc-dp }} cluster update --help
        ```


    1. To edit the [log group](../../logging/concepts/log-group.md) the cluster logs go to, provide the log group ID in the `--log-group-id` parameter:

        ```bash
        {{ yc-dp }} cluster update <cluster_name_or_ID> \
           --log-group-id=<log_group_ID>
        ```

        You can request the log group ID with a [list of log groups in the folder](../../logging/operations/list.md).


    1. To protect a cluster from accidental deletion by a user of your cloud, add the `--deletion-protection` parameter:

        ```bash
        {{ yc-dp }} cluster update <cluster_name_or_ID> \
           --deletion-protection
        ```

        Enabled protection will not prevent a manual connection to the cluster and deletion of data.

    1. To update [component properties](../concepts/settings-list.md), provide the required properties in the `--property` parameter:

        ```bash
        {{ yc-dp }} cluster update <cluster_name_or_ID> \
           --property "<key_1_prefix>:<key_1>=<value>", "<key_2_prefix>:<key_2>=<value>", ...
        ```

        {% note warning %}

        Using the `--property` parameter will reset all component properties that were not explicitly provided in the parameter to their defaults. To save the previously updated properties, list them in your request along with the properties you want to update.

        {% endnote %}

    You can get the cluster ID and name with a [list of clusters in the folder](./cluster-list.md#list).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

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

    For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}
