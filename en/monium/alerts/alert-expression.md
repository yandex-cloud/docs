---
title: Expressions in {{ monium-name }} alerts
description: An expression alert is a type of alert that evaluates a random expression in the {{ monium-name }} query language to determine the alert status. In this tutorial, you will learn how to manage alert statuses and work with alert evaluation history.
---

# Expression alerts

An expression alert evaluates a random [query language](../concepts/querying.md) expression to determine the alert status. For example, you can use expressions to trigger alerts based on percentiles across multiple metrics.

## Creating an expression alert {#create-alert-expression}

An expression consolidates data loading, processing, and alert trigger logic. This makes expression alerts different from [regular alerts](../concepts/alerting/alert.md), where the query and trigger conditions are configured separately.

The creation process is identical to [regular alerts](../operations/alert/create-alert.md), except:

* Instead of a query, you specify an expression.
* In trigger conditions, only two parameters are available: **{{ ui-key.yacloud_monitoring.alert-template.field.evaluation-window-key-value }}** and **{{ ui-key.yacloud_monitoring.alert-template.field.delay-key-value }}**.

{% note info %}

Single [alerts](../concepts/glossary.md#alert) or [sub-alerts](../concepts/glossary.md#subalert) support up to {{ alerting-metrics-limit }} metrics. To evaluate more metrics, do one of the following:

* Create a [multialert](../concepts/alerting/alert.md#multi-alerts).
* Apply [aggregation functions](../concepts/querying-functions.md#aggregation-functions) to metrics provided to {{ metrics-name }}.
* Aggregate metrics client-side before sending, e.g., in the app.

{% endnote %}

## Expression structure {#structure-expression}

An expression is a program that sequentially loads data, transforms it, and calculates the final value or alert status. Typically, an expression consists of metric selectors, variables, aggregation and transformation functions, arithmetic and logical operations, and status management functions.

Expressions use the [query language](../concepts/querying.md) with these extra features:

* Variables enable you to load data and break down expressions into logical steps:

    ```js
    let <var_name> = <expression>;
    ```

    You can load data from the current project or other projects you have access to. To do this, specify the `project` label:

    ```js
    let data = { project='my_project', cluster='default', service='my_service', host='*', load_state='DONE' };
    ```

* Comments:

    ```js
    let a = 10 + 20; // my comment
    ```

* Data type: Vector.

    The complex _Vector<T>_ type is a vector of values of a specific type, e.g., a vector of metrics (`Vector<Timeseries>`) or a vector of numbers (`Vector<Scalar>`).

    For example, this expression will return the `Vector<Timeseries>` metric vector with different `host` label values.

    ```
    {cluster='proxy', service='frontend', host='*', name='exceptionCount'}
    ```

### Managing alert statuses {#status-functions}

To manage alert statuses, use the following [functions](#alert-functions):

```js
alarm_if(condition: Boolean): Void
warn_if(condition: Boolean): Void
no_data_if(condition: Boolean): Void
ok_if(condition: Boolean): Void
```

If the `condition` is met, the function stops the program and switches the alert to the appropriate status. These functions do not return a value, so their result cannot be assigned to a variable.

{% note warning %}

Always call `alarm_if` before `warn_if`. Otherwise, `warn_if` halts execution and sets the status to `OK` if the threshold is not met, since the condition for switching to the `Warning` status will not be met and the alert will not transition to the `Alarm` status.

{% endnote %}

### Example program for an expression {#example}

```js
// If no matching metrics are found for the selector, the alert status will change to _No data_ before the program starts.
let data = {project="my_project", cluster="default", service="my_service", name="sinusoid"};

// If there is a metric, but no points were included in the alert evaluation window, change the alert status to _No data_.
no_data_if(count(data) == 0);

// Calculate the average metric value
let value = avg(data);

alarm_if(value > 100); // Change the alert status to _Alarm_ if the value exceeds 100.
warn_if(value > 10);   // Change the alert status to _Warning_ if the value exceeds 10.
```

Based on the evaluation result, the alert switches to one of the following statuses:

* `No data`: The metric does not exist in {{ monium-name }} (e.g., removed by [TTL](../concepts/glossary.md#ttl)) or there are no points in the time window.
* `Alarm`: The `value` exceeds `100`. The `alarm_if` function interrupts the program.
* `Warning`: The `value` falls within the `(10, 100]` range. The `warn_if` function interrupts the program.
* `OK`: The `value` does not exceed `10`. The program runs until it is complete.

## Description of functions {#alert-functions}

### Status management functions {#status-functions}

{% note info %}

After the alert status changes, evaluation stops. Therefore, check the condition for `alarm_if` before `warn_if`.

{% endnote %}

For example, in the program below, `alarm_if` will never trigger because the program will terminate at the `warn_if` line:

```js
let x = 10;

warn_if(x > 5);
alarm_if(x > 6);
```

#### alarm_if {#alarm-if}

Changes the alert status to `Alarm` when the `condition` is met.

```js
alarm_if(condition: Boolean): Void
```

#### warn_if {#warn-if}

Changes the alert status to `Warning` when the `condition` is met.

```js
warn_if(condition: Boolean): Void
```

#### no_data_if {#no-data-if}

Changes the alert status to `No data` when the `condition` is met.

```js
no_data_if(condition: Boolean): Void
```

#### ok_if {#ok-if}

Changes the alert status to `OK` when the `condition` is met.

```js
ok_if(condition: Boolean): Void
```

### Functions for evaluation history management {#history-functions}

#### alert_evaluation_history {#alert-evaluation-history}

Returns the evaluation history for an alert or subalert as a time series. The time series points appear with a delay of up to one minute.

{% note info %}

If an alert or subalert was [muted](./mutes.md), `128` is added to its raw status metric value. For example, for an alert with the `Alarm` status and the `4` value, the metric value will be `132` (`4 + 128`).

The `alert_evaluation_history` function discards the added mute value and returns a time series whose values match the calculated statuses.

{% endnote %}

The function has the following use cases (function overloading) depending on the number of input parameters:

* **alert_evaluation_history**(): *Timeseries*: Current alert’s evaluation history.
* **alert_evaluation_history**(*projectId: String*, *alertId: String*): *Timeseries*: Evaluation history of a specific project alert that is not a multi-alert. `alertId` is the alert ID, `projectId` is the project ID.
* **alert_evaluation_history**(*projectId: String*, *alertId: String*, *parentId: String*): *Timeseries*: Evaluation history of a specific project subalert. `projectId` is the project ID, `alertId` is the subalert ID, `parentId` is the parent multi-alert ID.

The `projectId`, `alertId`, and `parentId` values support [patterns (glob expressions)](https://en.wikipedia.org/wiki/Glob_(programming)). When patterns are used, the function returns multiple time series for all matching alerts.

Here is a possible use case:

```js
let alert_statuses = alert_evaluation_history();
let problems = heaviside(alert_statuses - 1); // Maps the points with the _No data_ and _OK_ statuses to 0, and maps the _Alarm_, _Warning_, and _Error_ statuses to 1.
let good_points = drop_if(problems, data);    // Removes points where the alert had the _Alarm_, _Warning_, or _Error_ status from the time series.
```

#### multi_alert_evaluation_history {#multi-alert-evaluation-history}

Returns the history of multi-alert statuses as a time series. The time series points appear with a delay of up to one minute.

{% note info %}

If the subalert was [muted](./mutes.md), the `:MUTED` suffix is added to the `status` label value. For example, a muted alert with the `Alarm` status will have a metric with the `status=ALARM:MUTED` label value.

{% endnote %}

The **multi_alert_evaluation_history** function has the following use cases (function overloading) depending on the number of input parameters:

* **multi_alert_evaluation_history**(): *Vector\<Timeseries\>*: All metrics with the count of subalerts in all statuses.
* **multi_alert_evaluation_history**(*status: String*): *Timeseries*: Subalert evaluation history for a given multi-alert with the specified `status`, e.g., `ALARM`.
* **multi_alert_evaluation_history**(*alertId: String*, *status: String*): *Timeseries*: Subalert evaluation history for a different multi-alert in the current project with the specified status. `alertId` is the alert ID, and `status` is the subalert status, e.g., `ALARM`.
* **multi_alert_evaluation_history**(*projectId: String*, *alertId: String*, *status: String*): *Timeseries*: Subalert evaluation history for a different multi-alert in another project with the specified status. `projectId` is the project ID, `alertId` is the alert ID, and `status` is the subalert status, e.g., `ALARM`.

The `projectId`, `alertId`, and `status` values support [patterns (glob expressions)](https://en.wikipedia.org/wiki/Glob_(programming)). When patterns are used, the function returns multiple time series for all matching alerts.

Here is a possible use case:

```js
let alert_statuses = multi_alert_evaluation_history('ALARM'); // Number of alerts in _Alarm_ status.
alarm_if(last(alert_statuses) > 10);                          // Changes the alert status to _Alarm_ if the number of alerts in the _Alarm_ status exceeds 10.
```

### Specifics of using status management functions {#features}

1. Order of calling `alarm_if` and `warn_if`.

    In the example below, the `Alarm` status will never be set. When `value > 100`, the `value > 10` condition evaluates first, i.e., the alert will switch to the `Warning` status:

    ```js
    let data = {project="my_project", cluster="default", service="my_service", name="sinusoid"};

    no_data_if(count(data) == 0);
    let value = avg(data);

    warn_if(value > 10);
    alarm_if(value > 100);
    ```

    To get the expected behavior, restrict the `warn_if` condition to a specific range or change the function call order:

    ```js
    let data = {project="my_project", cluster="default", service="my_service", name="sinusoid"};

    no_data_if(count(data) == 0);
    let value = avg(data);

    alarm_if(value > 100);
    warn_if((value > 10) && (value <= 100));
    ```

1. Variables declared after status management functions.

    If a variable is declared after calling `alarm_if`, `warn_if`, `no_data_if`, or `ok_if`, its value will be unavailable in the annotations when the program is interrupted.

    For example, in the program below, the `not_var{{ expression.valuePretty }}` value will be substituted into the annotations only for the `OK` status. For other statuses, the annotation will render as an empty string:

    ```js
    let data = {project="my_project", cluster="default", service="my_service", name="sinusoid"};

    no_data_if(count(data) == 0);
    let value = avg(data);

    alarm_if(value > 100);
    warn_if(value > 10);

    let valuePretty = to_fixed(100 * value, 2) + '%';
    ```

1. Breaking down a complex condition.

    You can use multiple separate `alarm_if` calls to split a complex trigger condition into several simple conditions and add an explanation to each of them.

    For example, you can write the `(requests < 100) || (errors > 20)` condition as follows:

    ```js
    ...
    let reason = 'Number of requests is low!';
    alarm_if(requests < 100);
    let reason = 'Number of errors is large!';
    alarm_if(errors > 20);
    let reason = 'Everything is ok';
    ```

    To retain information about the condition that triggered the alert, add an annotation to the alert with the `not_var{{ expression.reason }}` variable value.
