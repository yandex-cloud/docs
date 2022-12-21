# Working with logs

{{ dataproc-name }} cluster logs are collected and displayed by [{{ cloud-logging-full-name }}](../../logging).

To monitor the events on the cluster and its individual hosts, specify, in its settings, a relevant [log group](../../logging/concepts/log-group.md). You can do this when [creating](cluster-create.md) or [updating](cluster-update.md) the cluster. If no log group has been selected for the cluster, a default log group in the cluster directory will be used to send and store logs.

For more information, see [{#T}](../concepts/logs.md).

## Viewing log entries {#logging-cluster}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Click the name of the desired cluster and select the ![image](../../_assets/logs.svg) **Logs** tab.
   1. (optional) Specify the output settings:
      * [Message filter](../concepts/logs.md):
           * Getting the job start output {{ dataproc-name }}:

             ```ini
             job_id="<job ID>"
             ```

           * Getting the stdout output for all YARN application containers:

             ```ini
             application_id="<YARN application ID>" AND yarn_log_type="stdout"
             ```

           * Getting YARN container's stderr output:

             ```ini
             container_id="<container YARN ID>" AND yarn_log_type="stderr"
             ```

           * Getting the YARN Resource Manager service logs from the cluster's managing host:

             ```ini
             hostname="<FQDN of the managing host>" AND log_type="hadoop-yarn-resourcemanager"
             ```

      * Message logging levels: From `TRACE` to `FATAL`.
      * Number of messages per page.
      * Message interval (a standard or arbitrary one).

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   View a description of the CLI command to get logs:

   ```bash
   yc logging read --help
   ```

   Examples:

   * To get logs of the {{ dataproc-name }}cluster's HDFS NameNode service, run the command:

      ```bash
      yc logging read \
          --group-id "<ID of the log group>" \
          --resource-ids "<ID of the cluster>" \
          --filter "log_type=hadoop-hdfs-namenode"
      ```

   * To get logs for the last two hours from all {{ dataproc-name }} clusters assigned to a specific log group, run the command:

      ```bash
      yc logging read \
          --group-id "<ID of the log group>" \
          --resource-types "dataproc.cluster" \
          --since 2h
      ```

{% endlist %}

## Disabling sending logs {#disable-logs}

{% list tabs %}

- Management console

    When [creating](cluster-create.md) or [updating the cluster](cluster-update.md), add the `dataproc:disable_cloud_logging` property set to `true`.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    When [creating](cluster-create.md) or [updating the cluster](cluster-update.md) pass the `dataproc:disable_cloud_logging=true`  value in the `--property` parameter or pass an empty string (`""`) instead of the log group ID in the `--log-group-id` parameter:

    ```bash
    yc dataproc cluster create <cluster name> \
        ... \
        --log-group-id=""
    ```

    ```bash
    yc dataproc cluster update <cluster ID or name> \
        --property dataproc:disable_cloud_logging=true
    ```

{% endlist %}

## Storing logs {#logs-storage}

Receiving and storing logs is paid based on the [pricing rules](../../logging/pricing.md) in {{ cloud-logging-full-name }}. To edit the retention period and log access rules, [edit the log group settings](../../logging/operations/retention-period.md).

Learn more about working with logs in the [{{ cloud-logging-full-name }}documentation](../../logging/operations/index.md).
