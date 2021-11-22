# Working with logs

You can monitor {{ dataproc-name }} cluster events in the management console. To use this feature, specify the [log group](../../logging/concepts/log-group.md) in the cluster settings. You can do this when [creating a cluster](./cluster-create.md) or [updating its settings](./cluster-update.md).

Cluster logs are collected and displayed by [{{ cloud-logging-name }}](../../logging/).

## Viewing cluster log entries {#logging-cluster}

{% list tabs %}

* Management console

    1. Go to the folder page and select **{{ dataproc-name }}**.

    1. Click on the name of the cluster and select the **Logs** tab.

    1. (Optional) Specify the output settings:
        * [Message filter](../../logging/concepts/filter.md).
        * Message logging levels: From `TRACE` to `FATAL`.
        * Number of messages per page.
        * Message interval (a standard or arbitrary one).

{% endlist %}

Learn more about working with logs in the [{{ cloud-logging-full-name }} documentation](../../logging/operations/index.md).

