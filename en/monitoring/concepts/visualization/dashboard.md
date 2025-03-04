---
title: '{{ monitoring-full-name }} dashboard'
description: A dashboards in {{ monitoring-full-name }} consists of widgets, charts, text blocks, and titles. Metrics on dashboard charts are displayed for a certain time interval, the same for all charts. Parameters allow you to create dashboards with customizable interactive content. For example, a dashboard presenting aggregated VM status information can be parameterized using the VM ID.
---

# Dashboards in {{ monitoring-name }}

*Dashboards* consist of widgets. You can group the widgets in a convenient order, set their size, and add comments. Dashboards allow you to track metric changes in real time and analyze accumulated metrics over time. Metrics on dashboard charts are displayed for a certain time interval, the same for all charts.

The default interval is one day. You can specify a different interval using preset ranges (`1h 3h 1d 1w 1mo`). You can also set the start and end of the interval.

To set the time interval more precisely, you can use the timeline located above the dashboard.

{{ yandex-cloud }} users can use service dashboards containing preset widgets with metrics reporting the status of cloud resources. Service dashboards are created automatically.

## Dashboard parameters {#parameterization}

Parameters allow you to create dashboards with customizable interactive content. For example, a dashboard presenting aggregated VM status information can be parameterized using the VM ID.

Parameters are displayed as drop-down menus above dashboard widgets. When you select a parameter value, the dashboard is updated and the selected value is substituted in data queries. [How to add a dashboard parameter](../../operations/dashboard/add-parameters.md).

{% include [dash-parameters](../../../_includes/monitoring/dash-parameters.md) %}

For parameters of the *{{ ui-key.yacloud_monitoring.component.parametrizer.type.query }}* and *{{ ui-key.yacloud_monitoring.component.parametrizer.type.custom }}* type, the *{{ ui-key.yacloud_monitoring.component.parametrizer.dashboard.multivalue-key-value }}* setting is available to select multiple parameter values at the same time.

For all parameter types, you can set the *{{ ui-key.yacloud_monitoring.component.parametrizer.default-value }}* that will be used when loading a dashboard in the {{ monitoring-full-name }} web interface.

### Parameter substitution {#templates}

Dashboard parameter values are used in widget headings and queries to metrics to filter label values. Parameter values are substituted using [mustache template](https://mustache.github.io/).

{% note info %}

You can only use parameter value substitution in label values when making queries to metrics.

{% endnote %}

#### Examples of parameter value substitution {#templates-examples}

* Substituting values in widget headings.
    > In the `CPU usage on not_var{{ host }}` widget heading, the `host` parameter value will be substituted.
* Substituting label values in queries.
    > In the `"cpu.iowait"{folderId="aoe6mk1r3b47********", service="not_var{{ myparm }}", host="*"}` query, the `service` label will get the `myparm` parameter value.

Substituting parameter values in query strings when [adding a widget to the dashboard](../../operations/dashboard/add-widget.md) looks like this:

![Substituting parameter values in query strings](../../../_assets/monitoring/query_string_templating_2023.png "Substituting parameter values in query strings")

### Label value filter {#common-labels-filter}

The label value filter enables you to limit the list of possible parameter values of the *{{ ui-key.yacloud_monitoring.component.parametrizer.type.query }}* type. The filter specifies labels and their values. The filter is applied to all parameters of the *{{ ui-key.yacloud_monitoring.component.parametrizer.type.query }}* type at the same time.

#### Examples of filtering label values {#common-labels-filter-example}

Let's assume a dashboard has a specified *{{ ui-key.yacloud_monitoring.component.parametrizer.type.query }}* type parameter for the `cluster` label which takes the `prod`, `preprod-1`, `preprod-2`, and `testing` values.

Filtering settings and result:

* The `cluster=*prod*` filter will limit the parameter values to `prod` and `preprod-1`.
* The `cluster=preprod-1|preprod-2` filter will limit the values to `preprod-1` and `preprod-2`.
* The `cluster=testing` filter will limit the values to a single value, `testing`.

Below is a more complex example. Let's say the system has the following metrics: 

* `usage{cluster="prod", account="prodaccount"}`
* `usage{cluster="preprod", account="preprodaccount"}`
* `usage{cluster="testing", account="testingaccount"}`
* `usage{cluster="prod", account="multiaccount"}`
* `usage={cluster="testing", account="multiaccount"}`

Filtering settings:

* The filter contains the `cluster=*prod*` value.
* The dashboard has the *{{ ui-key.yacloud_monitoring.component.parametrizer.type.query }}* type parameters specified for the `cluster` and `account` labels.

Result:

* The only possible values of the `cluster` parameter will be `prod` and `preprod`. The `testing` value will be excluded as not matching the `cluster=*prod*` rule.
* The only possible values of the `account` parameter will be `prodaccount`, `preprodaccount`, and `multiaccount`. The `testingaccount` value will be excluded as there is no metric with a combination of `account="testingaccount"` and `cluster` labels matching the `cluster=*prod*` rule (for `multiaccount`, there is such a combination).

### Chart repetition by parameter {#repeated-graphs}

Chart repetition based on a specific parameter allows you to build several similar charts but with different values of this parameter. This can facilitate anomaly and issue analysis: you can split a metric into several metrics and examine each one separately.

For example, configure repetition by the `host` parameter to view CPU utilization charts for each one of your VMs. With a separate chart for each VM, it will be so much easier to localize your problem. By adding the `cpu` parameter, you can build utilization charts for each one of your VM's vCPUs.

For VMs, we recommend you to regularly monitor such parameters as CPU and RAM utilization and disk errors.

For more on chart repetition, see [{#T}](../../operations/dashboard/add-parameters.md#repeated-graphs).