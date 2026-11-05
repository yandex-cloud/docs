---
title: Context links
description: Context links in {{ monium-name }} allow you to navigate from charts to linked dashboards and external systems.
---

# Context links

_Context links_ provide quick navigation from the chart data. They appear in tooltips in the [metric explorer](../../metrics/metric-explorer.md) and on [dashboards](dashboard.md) if the chart point satisfies the link criteria.

Context links help you quickly navigate from a metric to a related source of information. For example, from a host metric, you can open the host’s dashboard, service management system, or incident page.

## Display conditions {#display-conditions}

Display conditions determine when the link appears in the tooltip. You can set a condition based on whether [labels](../data-model.md#label) are available or on their values in the query result.

Here are some condition examples:

* `host=*`: Link is displayed if the query result contains the `host` label.
* `{service="alerting", host="*vla*"}`: Link is displayed if the result contains the `service` label set to `alerting` and the `host` label containing the `vla` string in its value.

Use conditions to avoid showing irrelevant links. For example, the host dashboard link should appear only for metrics with the `host` label, and the cluster dashboard link, only for metrics with the `cluster` label.

## Link parameters {#parameters}

Context links have the following general parameters:

* **Link name**: Text displayed in the tooltip.
* **Context link display conditions**: Rule that determines when {{ monium-name }} shows the link for a chart point.
* **Context link type**: Link destination, either a dashboard or an external URL.

The link name should explain the action. For example, use _Open host dashboard_, not _Link_.

## Types of context links {#type}

### Dashboard link {#dashboard}

A dashboard link opens another dashboard in the current project. Use it to navigate from the overview chart to the details page.

For example, you can add a link to a specific host’s dashboard to the CPU metric on the general dashboard. When you follow the link, {{ monium-name }} will provide the parameter values and open the dashboard with a relevant filter.

For a dashboard link, specify the following:

* **Dashboard**: Target dashboard in the current project.
* **Dashboard parameters**: Parameter values if used by the target dashboard.

A dashboard parameter can be either static or dynamic. Static values are set directly, e.g., `production`. Dynamic values are taken from labels in the query result.

To provide a label value, specify its name in double curly braces. For example, `not_var{{cluster}}` is replaced with the `cluster` label value from the chart point.

### External link {#url}

An external link opens a URL of your choice. Use it to navigate to an operations system, repository, ticket, another system's chart, or page within the service.

Specify the **URL** for the external link. You can use dynamic values from labels in the URL. For example, the `https://example.com/hosts/not_var{{host}}` link will open the page of the host specified in the `host` label.

External links can use special time parameters:

#|
|| **Parameter** | **Description** | **Value example** ||
|| `__from:iso` | Start of time interval in ISO 8601 format | `2024-05-30T13:12:56Z` ||
|| `__to:iso` | End of time interval in ISO 8601 format | `2024-05-30T14:12:56Z` ||
|| `__from:seconds` | Start of time interval in seconds from the beginning of Unix Epoch | `1717076276` ||
|| `__to:milliseconds` | End of time interval in milliseconds from the beginning of Unix Epoch | `1717079876000` ||
|#

For example, the  `https://example.com/logs?host=not_var{{host}}&from=not_var{{__from:iso}}&to=not_var{{__to:iso}}` link will open the logs of the selected host for the same time interval used in the chart.
