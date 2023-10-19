---
title: "Viewing monitoring charts in {{ api-gw-full-name }}"
description: "You can view monitoring charts in {{ api-gw-full-name }} for such measures as the number of queries to an API gateway, number of errors accessing the API gateway, and the time of requests to the API server. To view the chart, click {{ api-gw-name }} in the folder with the API gateway you want to get details about. In the window that opens, select the API gateway that you want to view monitoring charts for."
---

# Viewing monitoring charts in {{ api-gw-name }}

You can monitor the status of API gateways using the monitoring tools in the management console. These tools display diagnostic information in the form of charts.

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing the API gateway.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Select the API gateway whose monitoring charts you want to view.
   1. Go to the **{{ ui-key.yacloud.serverless-functions.gateways.item.switch_monitoring }}** tab.
   1. The following charts will open on the page:

   * **Requests**: Number of API gateway requests. Metrics contain the following labels:
      * **stable**: Events handled by the current {{ api-gw-short-name }} release.
      * **canary**: Events handled by the [canary release](../concepts/extensions/canary.md).
      * **total**: Events handled by the canary or current release.
   * **Errors**: Number of API gateway access errors. Metrics contain the following labels:
      * **stable**: Events that are not handled by the current {{ api-gw-short-name }} release.
      * **canary**: Events that are not handled by the canary release.
      * **total**: Events that are not handled by the canary or current release.
   * **Latency**: Amount of time it takes for an API gateway request to run.

   * **Connections**: Number of web sockets connected to an API gateway.

   * **Disconnections**: Web socket disconnections per second.

   * **Incoming messages count**: Number of incoming web socket messages.

   * **Incoming messages bytes**: Incoming web socket traffic in bytes.

   * **Outgoing messages count**: Number of outgoing web socket messages.

   * **Outgoing messages bytes**: Outgoing web socket traffic in bytes.

      You can select a time period to display information for on a graph, such as an hour, three hours, a day, a week, a month, or a custom interval.

{% endlist %}
