---
title: Viewing resource and application logs in {{ monium-name }}
description: Follow this guide to view the logs of resources residing in {{ yandex-cloud }} or another infrastructure, as well as the logs of your applications loaded via the API.
---

# Viewing logs

The log UI allows you to:

* Create queries for log search and filtering.
* View charts on logs with different query statuses.
* View the content of log lines.
* Navigate from logs to analysis of associated traces and spans using their IDs.

## Searching and viewing logs

{% list tabs group=instructions %}

- Management console {#console}

  1. Set up data delivery, e.g., with the [OTel Collector](../collector/opentelemetry.md).
  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}** on the left.
  1. At the top, set the search interval using the timeline, a preset interval, or by entering the time value directly.
  1. In the search bar, enter your [query](query.md) in the following format:

       ```
       { <key>="<value>", <key>="<value>", ... }
       ```
   
     In {{ monium-name }}, telemetry follows this hierarchy: project → cluster → service. Therefore, select the `project`, `cluster`, and `service` parameters in the query string first.

  1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.
  1. To analyze a particular log entry, expand it and select one of the following actions next to the log line of interest:
     * **=**: Add the line’s key label to the query.
     * **!=**: Exclude the line’s key label from the query.
     * ![image](../../_assets/console-icons/eye.svg): Hide the log line.
     * **Copy**: Copy the log line.
  1. To view log contents as a table, enable **Line breaks**.
  1. To view the `Error` level logs, go to the **Errors** tab.
  1. To view general info on logs, go to the **Statistics** tab.

{% endlist %}
