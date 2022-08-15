---
title: "Viewing monitoring graphs in Yandex API Gateway"
description: "You can see the monitoring graphs in Yandex API Gateway for the following indicators, such as the number of requests to the API gateway, the number of errors that occurred when accessing the API gateway. To see the graph, open the API Gateway section in the API gateway directory, information about which you want to get. In the window that opens, select the API gateway whose monitoring graphs you want to view."
---

# Monitoring

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

         ![image](../../_assets/api-gateway/requests.png)

      * **Errors**: The number of API gateway access errors.

         ![image](../../_assets/api-gateway/errors.png)

      * **Latency**: Amount of time its takes for an API gateway request to run.

         ![image](../../_assets/api-gateway/latency.png)

      You can select a time period to display information for on a graph, such as an hour, three hours, a day, a week, a month, or a custom interval.

{% endlist %}
