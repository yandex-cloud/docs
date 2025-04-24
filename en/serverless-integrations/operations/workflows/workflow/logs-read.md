---
title: Viewing the execution log in {{ sw-full-name }}
description: You can view monitoring charts in {{ sw-full-name }} using the management console. To do this, select {{ sw-name }} and click the workflow whose execution log you want to view. In the window that opens, go to Logs and specify the time period. The default time period is one hour. All times in the log are UTC.
---

# Viewing workflow logs

All times in the log are [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [workflow](../../../concepts/workflows/workflow.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Select a workflow whose logs you want to view.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**.
  1. Specify the period to view the logs for. The default period is 1 hour.

{% endlist %}

Learn more about working with logs in the [{{ cloud-logging-full-name }}](../../../../logging/) documentation.