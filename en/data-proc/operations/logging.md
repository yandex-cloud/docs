# Working with logs

[{{ cloud-logging-full-name }}](../../logging) collects and displays {{ dataproc-name }} cluster logs.

To monitor the events on the cluster and its individual hosts, specify, in its settings, a relevant [log group](../../logging/concepts/log-group.md). You can do this when [creating](cluster-create.md) or [updating](cluster-update.md) the cluster. If no log group has been selected for the cluster, a default log group in the cluster directory will be used to send and store logs.

For more information, see [Logs](../concepts/logs.md).

## Viewing log entries {#logging-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the cluster name.
    1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_configuration }}**, click the name of the cluster log group. The {{ cloud-logging-name }} page will open.
    1. Click the row of the log group. This will open the cluster logs.
    1. (Optional) Specify the output settings:
        * [Message filter](../concepts/logs.md):
           * Getting the job start output {{ dataproc-name }}:

             ```ini
             job_id="<job_ID>"
             ```

           * Getting the stdout output for all YARN application containers:

             ```ini
             application_id="<YARN_app_ID>" AND yarn_log_type="stdout"
             ```

           * Getting YARN container's stderr output:

             ```ini
             container_id="<YARN_container_ID>" AND yarn_log_type="stderr"
             ```

           * Getting the YARN Resource Manager service logs from the cluster's master host:

             ```ini
             hostname="<master_host_FQDN>" AND log_type="hadoop-yarn-resourcemanager"
             ```

        * Message logging levels: from `TRACE` to `FATAL`.
        * Number of messages per page.
        * Message interval (one of the standard intervals or an ad-hoc one).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  See the description of the CLI command to get logs:

    ```bash
    yc logging read --help
    ```

  Examples:

    * To get logs of the {{ dataproc-name }} cluster's HDFS NameNode service, run this command:

      ```bash
      yc logging read \
         --group-id=<log_group_ID> \
         --resource-ids=<cluster_ID> \
         --filter=log_type=hadoop-hdfs-namenode
      ```

    * To get logs for the last two hours from all {{ dataproc-name }} clusters assigned to a specific log group, run the command:

      ```bash
      yc logging read \
         --group-id=<log_group_ID> \
         --resource-types=dataproc.cluster \
         --since=2h
      ```

    * To get your cluster's system log for a specific period, run this command:

      ```bash
      yc logging read \
         --group-id <log_group_ID> \
         --resource-ids=<cluster_ID> \
         --filter 'syslog' \
         --since 'YYYY-MM-DDThh:mm:ssZ' \
         --until 'YYYY-MM-DDThh:mm:ssZ'
      ```

      Set the logging period in the `--since` and `--until` parameters. Time format: `YYYY-MM-DDThh:mm:ssZ`. Example: `2020-08-10T12:00:00Z`. Use the UTC time zone.

    * To get a log for metrics sent from a specific host to [{{ monitoring-full-name }}](../../monitoring/index.yaml), run this command:

      ```bash
      yc logging read \
         --group-id <log_group_ID> \
         --resource-ids=<cluster_ID> \
         --filter 'telegraf and hostname="<host_FQDN>"' \
         --since 'YYYY-MM-DDThh:mm:ssZ' \
         --until 'YYYY-MM-DDThh:mm:ssZ'
      ```

   {% note info %}

   You can omit the `--group-id` parameter and specify the log group ID directly.

   {% endnote %}

      To get the host FQDN:

      1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
      1. Click the cluster name.
      1. Navigate to the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
      1. Copy the host FQDN.

{% endlist %}

## Disabling sending logs {#disable-logs}

{% list tabs group=instructions %}

- Management console {#console}

    When [creating](cluster-create.md) or [updating a cluster](cluster-update.md), add the `dataproc:disable_cloud_logging` property set to `true`.
    
- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    When [creating](cluster-create.md) or [updating](cluster-update.md) a cluster, specify `dataproc:disable_cloud_logging=true` in the `--property` parameter or provide an empty string (`""`) instead of the log group ID in the `--log-group-id` parameter:
    
    ```bash
    {{ yc-dp }} cluster create <cluster_name> \
       ... \
       --log-group-id=""
    ```

    ```bash
    {{ yc-dp }} cluster update <cluster_name_or_ID> \
       --property dataproc:disable_cloud_logging=true
    ```

{% endlist %}

## Storing logs {#logs-storage}

You pay for receiving and storing your logs based on the {{ cloud-logging-name }} [pricing policy](../../logging/pricing.md). The default log retention period is three days. To update the retention period, [edit the log group settings](../../logging/operations/retention-period.md).

For more information about logs, see the [{{ cloud-logging-name }} documentation](../../logging/operations/index.md).
