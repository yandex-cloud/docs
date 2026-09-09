# Viewing {{ SPRK }} cluster logs

{{ msp-full-name }} allows you to [get a cluster log snippet](#get-log) for the selected period.

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Getting a cluster log {#get-log}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the cluster name and navigate to **{{ ui-key.yacloud.common.logs }}**.
    1. Specify the logging **{{ ui-key.yacloud.logging.label_filter-levels }}** and the log time window.

- CLI {#cli}

    With YC CLI, you can get {{ SPRK }} cluster logs from a {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md).

    1. {% include [cli-install](../../_includes/cli-install.md) %}

    1. {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. To view the log group entries, run this command:

        ```
        yc logging read --group-name <log_group_name> --follow
        ```

        You can look up the log group name in the **{{ ui-key.yacloud.common.overview }}** section of your {{ SPRK }} cluster.

{% endlist %}
