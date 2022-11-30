---
title: "Viewing monitoring charts in {{ api-gw-full-name }}"
description: "You can view monitoring charts in {{ api-gw-full-name }} for such measures as the number of queries to an API gateway, number of errors accessing the API gateway, and the time of requests to the API server. To view the chart, click {{ api-gw-name }} in the folder with the API gateway you want to get details about. In the window that opens, select the API gateway that you want to view monitoring charts for."
---

# Monitoring in {{ api-gw-name }}

You can monitor the status of API gateways using the monitoring tools in the management console. These tools display diagnostic information in the form of charts.

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing the API gateway.
   1. Select **{{ api-gw-name }}**.
   1. Select the API gateway whose monitoring charts you want to view.
   1. Go to the **Monitoring** tab.
   1. The following charts open on the page:

      * **Requests**: The number of API gateway requests.

      * **Errors**: The number of API gateway access errors.

      * **Latency**: Amount of time its takes for an API gateway request to run.

      * **Connections**: Number of web sockets connected to API gateway.

      * **Disconnections**: Web socket disconnections per second.

      * **Incoming messages count**: Number of incoming web socket messages.

      * **Incoming messages bytes**: Incoming web socket traffic in bytes.

      * **Outgoing messages count**: Number of outgoing web socket messages.

      * **Outgoing messages bytes**: Outgoing web socket traffic in bytes.

      You can select a time period to display information for on a graph, such as an hour, three hours, a day, a week, a month, or a custom interval.

{% endlist %}
