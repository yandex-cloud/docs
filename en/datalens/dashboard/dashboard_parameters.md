---
title: Dashboard parameters in {{ datalens-full-name }}
description: In this article, you will learn what dashboard parameters are, take a look at the dashboard, chart, and special parameters, learn about the limitations in place and how to apply parameters in {{ datalens-full-name }}.
---

# Dashboard parameters in {{ datalens-full-name }}

A dashboard parameter is a variable used to filter widgets on the dashboard when you open it or use it in the calculated field formulas. Parameters allow you to use visualization features more flexibly and customize the same charts and widgets for different purposes. You may find parameters useful in situations like these:

* You want to post a link to a dashboard with a filter applied: in a table on another dashboard, on a {{ wiki-full-name }} page, or somewhere else.
* You want to post the same chart with different filters on the same dashboard tab.

You can add parameters either for the whole [dashboard](#params-dash) or an [individual chart](#params-chart) on the dashboard. Dashboard parameters apply to all its charts, whereas chart parameters apply to an individual widget.

You can see the examples of how to use the parameters in this {{ yandex-cloud }} YouTube channel [video](https://www.youtube.com/watch?v=fx0BR_RnLNs).

## Dashboard parameters {#params-dash}

You can use dashboard parameters to supply values to all charts while they are loading. When opening such a dashboard, its data will be filtered based on the specified values and [parameter application order](#params-applying). By default, dashboard parameter values are not supplied to selectors, but if you specify a selector parameter, you will be able to override its value in the dashboard [link](#params-in-url).

You can [add parameters](../operations/dashboard/add-parameters.md) in the dashboard settings. For each parameter, specify a name (key) and value. The parameter name must be the same as the name of the dataset field or parameter used to filter the data.

{% note info %}

In some cases, you should use the field ID as the parameter name:

* If the field name contains Cyrillic characters or consists of two words.
* If you want to use the parameter value in a selector based on a dataset.

If the field ID changes, you should also update the parameter name. For more information, see [this guide](../operations/chart/add-guid.md).

{% endnote %}

### Providing parameters in a dashboard link {#params-in-url}

If the parameters are added in the dashboard settings, you can also specify the parameter values in a dashboard link. In which case clicking a link will open the dashboard with a filter applied.

{% note info %}

To have the parameter value substituted into the dataset-based selector when you click the link, specify the field ID both as the parameter name and in the dashboard link.

{% endnote %}

The first parameter of the link is separated from the dashboard path with `?`, and the remaining parameters with `&`. For example, the `{{ link-datalens-main }}/test-dashboard?tab=test&OrderID=123456789` link contains the values for `tab` and `OrderID`.

Using [special prefixes](#parameter-prefixes), you can define an operation to apply to the provided parameter value.

The values in the link will take priority. For example, if the dashboard settings have `region` set to `RU`, and the dashboard link states `?region=KZ`, the `KZ` value will be fed to the widgets.


## Chart parameters {#params-chart}

Chart parameters apply only to the chart itself. Thus, you can view the same chart with different filters on the same dashboard tab. You can [add parameters for the chart](../operations/chart/add-parameters.md) in its settings on the dashboard.

You can transmit a parameter value to a wizard chart using field ID ([see the guide](../operations/chart/add-guid.md)).

{% include [datalens-chart-parameters-example](../../_includes/datalens/datalens-chart-parameters-example.md) %}

## Parameter prefixes {#parameter-prefixes}

Prefixes enable you to define an operation to apply to the provided parameter value. Use the `<parameter_name>=<prefix><parameter_value>` format to provide them in URLs.

Prefix | Operation
------- | --------
`__eq_` | Equal to
`__ne_` | Not equal to
`__gt_` | Greater than
`__lt_` | Less than
`__gte_` | Greater than or equal to
`__lte_` | Less than or equal to
`__istartswith_` | Starts with (case-insensetive)
`__startswith_` | Starts with (case-sensetive)
`__iendswith_` | Ends with (case-insensetive)
`__endswith_` | Ends with (case-sensetive)
`__icontains_` | Contains (case-insensetive)
`__contains_` | Contain (case-sensetive)
`__noticontains_` | Does not contain (case-insensetive)
`__notcontains_` | Does not contain (case-sensetive)
`__leneq_` | Length equal to
`__lengt_` | Length greater than
`__lengte_` | Length greater than or equal to
`__lenlt_` | Length less than
`__lenlte_` | Length less than or equal to
`__in_` | Belongs to a set
`__nin_` | Does not belong to a set
`__isnull_`    | Empty
`__isnotnull_` | Not empty

Examples of using parameters with prefixes:

* `{{ link-datalens-main }}/test-dashboard?price=__lte_1000`: `price` parameter value must be less than or equal to `1000`.
* `{{ link-datalens-main }}/test-dashboard?category=__istartswith_Hous`: Value of the `category` parameter must start with `Hous` or `hous`, e.g., `Housing`, `House`, or `house`.
* `{{ link-datalens-main }}/test-dashboard?category=__startswith_Hous`: Value of the `category` parameter must start with `Hous`, e.g., `Housing` or `House`.
* `{{ link-datalens-main }}/test-dashboard?category=__leneq_15`: Value of the `category` parameter must be exactly `15` characters long, e.g., `Garden supplies` or `Kitchen gadgets`.
* `{{ link-datalens-main }}/test-dashboard?category=__in_Garden%20supplies&__in_Kitchen%20gadgets`: Value of the `category` parameter must belong to the `Garden supplies` or `Kitchen gadgets` set.

## Special parameters {#special-parameters}

### Relative date {#relativedate}

This parameter is used to specify an offset relative to the current point in time in one of the following formats:

* `__relative_<symbol><amount><unit>`
* `__relative_<symbol><amount><unit>_<casting_type><unit>`

Where:

* `<symbol>`: `+` or `-`
* `<unit>`:
  * `y`: Year
  * `Q`: Quarter
  * `M`: Month
  * `w`: Week
  * `d`: Day
  * `h`: Hour
  * `m`: Minute
  * `s`: Second
  * `ms`: Millisecond
* `<casting_type>`:
  * `s`: To the start
  * `e`: To the end

For example, if the current time is `2020-03-24T23:30:39.874Z`, then:

* `__relative_-7d`: Seven days back, `2020-03-17T00:00:00.000Z`
* `__relative_+30m`: 30 minutes later, `2020-03-25T00:00:39.874Z`
* `__relative_-0d`: Today, `2020-03-24T00:00:00.000Z`
* `__relative_-0h`: Now, `2020-03-24T23:30:39.874Z`
* `__relative_-3M_sQ`: Minus 3 months (`2019-12-24T00:00:00.000Z`) cast to the start of the quarter: `2019-10-01T00:00:00.000Z`
* `__relative_+15s_em`: Plus 15 seconds (`2020-03-24T23:30:54.874Z`) cast to the end of the minute: `2020-03-24T23:30:59.999Z`

{% note info %}

If castings are not specified, then for units of day and longer, the time is cast to the start of the day, i.e., `00:00:00.000`; for shorter units the current time is used.

{% endnote %}

### Interval {#interval}

This parameter allows you to set a time interval in `__interval_<start>_<end>` format, where `start`/`end` is a [relative date](#relativedate) or [ISO date](https://ru.wikipedia.org/wiki/ISO_8601).

For example, if the current time is `2020-03-24T23:30:39.874Z`, then:

* `__interval_2019-03-11T09:35:48_2019-12-28T09:35:48`: From `2019-03-11T09:35:48` to `2019-12-28T09:35:48`
* `__interval_2019-01-17T09:35:48___relative_+0d`: From `2019-01-17T09:35:48` to today (`2020-03-24T23:59:59.999Z`)
* `__interval___relative_-2w_sM___relative_+1d`: Two weeks ago or more (`2020-03-10T00:00:00.000Z`) cast to the start of the month: `2020-03-01T00:00:00.000Z` until tomorrow (`2020-03-25T23:59:59.999Z`)

## Order of applying parameters {#params-applying}

Here is the order in which parameters are applied to dashboard widgets (values from the previous items are overridden by the subsequent ones):

1. [Dataset parameters](../dataset/create-dataset.md#add-parameters) for charts based on this dataset.
1. For charts:

   * Wizard: Dataset parameters with overridden values at the chart level and filters.
   * QL charts: Parameters.
   * Editor: Parameters specified on the [Params](../charts/editor/tabs.md#params) tab.

1. [Chart parameters](#params-chart) from dashboard settings.
1. [Dashboard parameters](#params-dash).
1. Dasboard [selector](./selector.md) values.
1. Parameters specified in a dashboard link, e.g., `{{ link-datalens-main }}/test-dashboard?OrderID=123456789`.
1. Values from the `state` parameter in the dashboard link. {{ datalens-short-name }} remembers the selector settings and writes them to a special parameter named `state` shown in the browser address bar. To share the current dashboard state, just copy the resulting link. This way, you can show the dashboard with required data directly instead of describing the filter settings.

   {% note info %}

   Changing the dashboard settings does not update the `state` parameter in the link, so the settings it contains become irrelevant. To get the link with relevant settings, copy it again from the browser address bar.

   {% endnote %}

For example, if a dashboard parameter has a default value, it overrides the parameter value in chart settings. If a dashboard selector has a parameter with the same name, its default value overrides the dashboard parameter value. If you specify the parameter value in the [dashboard link](#params-in-url), it overrides both the selector parameter with the same name and the parameter value in chart settings.

{% note info %}

Non-empty parameter values defined in QL and wizard charts will have higher priority than any empty parameter value.

{% endnote %}

## Limitations {#params-restrictions}

The following limitations apply when using parameters:

* You cannot use the following reserved keys:

  * `tab`
  * `state`
  * `mode`
  * `focus`
  * `grid`
  * `scale`
  * `tz`
  * `timezone`
  * `date`
  * `datetime`
  * `_action_params`
  * `_autoupdate`
  * `_opened_info`
  * `report_page`
  * `preview_mode`

  Parameters with these keys are ignored and not saved.

* Links can only use parameters that are set in the dashboard settings. Otherwise, they are ignored. For example, if a link contains `?product=Furniture`, but the dashboard settings have no `product` parameter (not even with an empty value), this parameter will be ignored.
* Dashboard parameters are applied to widgets anyway. This may lead to errors in data requests.
* Parameters cannot be used when creating links. To create a link, you can add a manual selector with the appropriate parameter key, set links using this selector by the required parameters, and then delete it. For example, for the dashboard parameter named `parameter`:

  1. [Add](../operations/dashboard/add-selector.md) a manual selector to the dashboard with `parameter` specified in **Field or parameter name**.
  1. [Establish](../operations/dashboard/create-alias.md) an outbound link between the new selector and the required widgets on the dashboard.
  1. Delete the selector you added from the dashboard.

  The dashboard's `parameter` value will now be applied to all the widgets the remote selector was connected to.

