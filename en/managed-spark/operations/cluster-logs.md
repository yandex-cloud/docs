# Viewing {{ SPRK }} cluster logs

{{ msp-full-name }} allows you to [get a cluster log snippet](#get-log) for the selected period.

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Getting a cluster log {#get-log}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the name of your cluster and open the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}** tab.
    1. Specify the logging **Level** and time period for which you want to display the log.

- CLI {#cli}

    With YC CLI, you can get {{ SPRK }} cluster logs from a {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md).

    1. {% include [cli-install](../../_includes/cli-install.md) %}

    1. {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. To view records in the log group, run this command:

        ```
        yc logging read --group-name <log_group_name> --follow
        ```

        You can view the log group name on the **{{ ui-key.yacloud.common.overview }}** tab of the {{ SPRK }} cluster.

{% endlist %}
