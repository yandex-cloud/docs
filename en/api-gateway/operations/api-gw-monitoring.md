---
title: Viewing API gateway monitoring charts in {{ api-gw-full-name }}
description: You can view monitoring charts in {{ api-gw-full-name }} for such metrics as the number of API gateway requests, number of API gateway access errors, and the time for executing API gateway requests. To view the chart, click {{ api-gw-name }} in the folder with the API gateway you want to get details about. In the window that opens, select the API gateway for which you want to view monitoring charts.
---

# Viewing monitoring charts in {{ api-gw-name }}

You can monitor the state of API gateways using the monitoring tools in the management console. These tools display diagnostic information as charts.

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the API gateway. 
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Select the API gateway whose monitoring charts you want to view.
    1. Navigate to the **{{ ui-key.yacloud.serverless-functions.gateways.item.switch_monitoring }}** tab.
    1. The following charts will open on the page:

        * **Requests**: Number of API gateway requests. Metrics contain the following labels:
            * **stable**: Events processed by the {{ api-gw-short-name }} current release. 
            * **canary**: Events processed by the [canary release](../concepts/extensions/canary.md).
            * **total**: Events processed by the canary or current release.
        * **Errors**: Number of API gateway access errors. Metrics contain the following labels:
            * **stable**: Events not processed by the {{ api-gw-short-name }} current release. 
            * **canary**: Events not processed by the canary release.
            * **total**: Events not processed by the canary or current release.
        * **Latency**: Time for executing API gateway requests.

        * **Connections**: Number of web sockets connected to the API gateway.

        * **Disconnections**: Web socket disconnections per second.

        * **Incoming messages count**: Number of incoming web socket messages.

        * **Incoming messages bytes**: Incoming web socket traffic in bytes.

        * **Outgoing messages count**: Number of outgoing web socket messages.

        * **Outgoing messages bytes**: Outgoing web socket traffic in bytes.

    	You can select a time period to display information for on a graph. It can be an hour, three hours, a day, a week, a month, or a custom interval.

{% endlist %}

