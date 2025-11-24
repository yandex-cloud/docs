---
title: Viewing {{ maf-full-name }} cluster logs
description: In this guide, you will learn how to view {{ maf-name }} cluster logs.
---

# Viewing {{ maf-name }} cluster logs

Cluster logs are stored in the {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md) specified in the cluster settings. You can change the log group parameters, including [log retention period](../../logging/operations/retention-period.md).

## Getting a cluster log {#get-log}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
    1. Click the name of your cluster and open the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}** tab.
    1. Specify the logging **Level** and time period for which you want to display the log.

- CLI {#cli}

    1. {% include [cli-install](../../_includes/cli-install.md) %}

    1. {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. To read logs, run this command:

        ```
        yc logging read --group-name <log_group_name> --follow
        ```

        You can get the log group name with the [cluster info](./cluster-list.md#get-cluster).

{% endlist %}