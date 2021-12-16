# Working with logs

You can monitor {{ dataproc-name }} cluster events in the management console. To do this, during [creating](cluster-create.md) or [updating a cluster](cluster-update.md) specify the [log group](../../logging/concepts/log-group.md) in its settings.

If no log group is specified then the default log group for the folder of the cluster will be used. The default log group will be automatically created if there is no default log group in the folder.

Cluster logs are collected and displayed by [{{ cloud-logging-name }}](../../logging/).

See details in section [{#T}](../concepts/logs.md).

## Viewing cluster log entries {#logging-cluster}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster and select the **Logs** tab.
    1. (Optional) Specify the output settings:
        * [Message filter](../concepts/logs.md).
            * Get job runner output {{ dataproc-name }}:

              ```ini
              job_id="<dataproc_job_id>"
              ```

            * Get YARN application containers stdout:

              ```ini
              application_id="<YARN application_id>" AND yarn_log_type="stdout"
              ```

            * Get stderr of a specific YARN container:

              ```ini
              container_id="<YARN container_id>" AND yarn_log_type="stderr"
              ```

            * Ger YARN Resource Manager logs:

              ```ini
              hostname="<master host FQDN>" AND log_type="hadoop-yarn-resourcemanager"
              ```

        * Message logging levels: from `TRACE` to `FATAL`.
        * Number of messages per page.
        * Message interval (pre-defined or arbitrary one).

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  Take a look at CLI command for collecting logs:

    ```bash
    yc logging read --help
    ```

  Examples:

    * Get logs of HDFS NameNode of the {{ dataproc-name }} cluster:

      ```bash
      yc logging read \
          --group-id "<log_group_id>" \
          --resource-ids "<dataproc_cluster_id>" \
          --filter "log_type=hadoop-hdfs-namenode"
      ```

    * Get log messages in the last two hours for all {{ dataproc-name }} clusters, that sent logs to specified log group:

      ```bash
      yc logging read \
          --group-id "<log_group_id>" \
          --resource-types "dataproc.cluster" \
          --since 2h
      ```

{% endlist %}

#### Disabling log sending to the cloud {##disable-logs}

To disable sending logs to {{ cloud-logging-name }}, set {{ dataproc-name }} cluster property `dataproc:disable_cloud_logging` to `true` when [creating](cluster-create.md) or [updating a cluster](cluster-update.md).

#### Storing logs {#logs-storage}

Receiving and storing logs is subject to [pricing](../../logging/pricing.md) of the {{ cloud-logging-name }}. To change logs retention time and access control rules, [edit the log group' settings](../../logging/operations/retention-period.md).

Learn more about working with logs in the [{{ cloud-logging-full-name }} documentation](../../logging/operations/index.md).
