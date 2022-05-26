# Updating clusters

After creating a cluster, you can modify its basic and advanced settings.

{% note info %}

You can disable sending cluster logs to {{ cloud-logging-full-name }}. For more information, see [Working with logs](logging.md#disable-logs).

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. To edit the [log group](../../logging/concepts/log-group.md) that cluster logs are sent to, select a new log group from the list. If necessary, [create a new log group](../../logging/operations/create-group.md).

      To enable this functionality, assign the [cluster service account](../../iam/operations/roles/grant.md#access-to-sa) the `logging.writer` role. For more information, see the [{{ cloud-logging-full-name }} documentation](../../logging/security/index.md).

   1. Change additional cluster settings:

      **Deletion protection**: Manages cluster protection from accidental deletion by a user.

      Enabled protection will not prevent a manual connection to a cluster to delete data.

   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI's update cluster command:

      ```bash
      yc dataproc cluster update --help
      ```

   1. To edit the [log group](../../logging/concepts/log-group.md) that cluster logs are sent to, pass the log group ID in the `--log-group-id` parameter:

      ```bash
      yc dataproc cluster update <cluster ID or name> \
        --log-group-id=<log group ID>
      ```

      You can request the log group ID with a [list of log groups in the folder](../../logging/operations/list.md).

   1. To protect a cluster from accidental deletion by a user of your cloud, set `--deletion-protection` to `true`:

      ```bash
      yc dataproc cluster update <cluster ID or name> \
        --deletion-protection=<cluster deletion protection: true or false>
      ```

      Enabled protection will not prevent a manual connection to a cluster to delete data.

   You can find out the cluster ID and name in a [list of clusters in the folder](./cluster-list.md#list).

{% endlist %}
