---
title: Viewing workflow monitoring charts in {{ sw-full-name }}
description: You can view a monitoring chart in {{ sw-full-name }} using the management console by selecting {{ sw-name }} and clicking the workflow whose monitoring charts you want to view.
---

# Viewing workflow monitoring charts

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [workflow](../../../concepts/workflows/workflow.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Select the workflow whose monitoring charts you want to view.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.
  1. The following charts will open on the page:

      * **Workflow Executions**: Total number of [workflow runs](../../../concepts/workflows/execution.md).
      * **Workflow Executions Inflight**: Number of workflow runs in progress.
      * **Workflow Executions Timings**: Workflow progress histogram.
      * **Workflow Steps**: Total number of started steps.
      * **Workflow Steps Inflight**: Number of steps in progress.
      * **Workflow Steps Timings**: Progress histogram for an individual step.

      You can select the time period to display information for: hour, day, week, month, or a custom interval.

{% endlist %}