# Dashboard parameters

The dashboard parameter is a variable used to filter widgets on the dashboard when you open it. Parameters allow you to use visualization features more flexibly and customize the same charts and widgets for different purposes. Parameters may help if:

* You want to post a link to a dashboard with a filter applied: in another dashboard table, on a {{ wiki-full-name }} page, or somewhere else.
* You want to post the same chart with different filters on the same dashboard tab.

You can add parameters both for the entire [dashboard](#params-dash) and for a [separate chart](#params-chart) on the dashboard. Dashboard parameters apply to all its charts, while chart parameters apply to an individual widget.

Watch [this video tutorial](https://www.youtube.com/watch?v=fx0BR_RnLNs) on how to use parameters on the {{ yandex-cloud }} YouTube channel.

## Dashboard parameters {#params-dash}

Dashboard parameters are inserted into all widgets (including charts and selectors) when they are uploaded. When opening such a dashboard, its data will be filtered based on the specified parameter values. You can [add parameters](../operations/dashboard/add-parameters.md) in the dashboard settings. For each parameter, specify a name (key) and value. A parameter name must be the same as the name of the dataset field by which data is filtered.

{% note info %}

In some cases, you should use the field ID as the parameter name:

* If the field name contains Cyrillic characters or consists of two words.
* If you want to use the parameter value in a selector based on a dataset.

If the field ID changes, you should also update the parameter name. For more information, see [this guide](../operations/chart/add-guid.md).

{% endnote %}

You can also specify parameter values in dashboard links. In this case, clicking a link will open the dashboard with a filter applied.

{% note info %}

To have the parameter value inserted into the dataset-based selector when you click the link, specify the field ID both as the parameter name and in the dashboard link.

{% endnote %}

The first address string parameter is separated from the dashboard path using `?` and the remaining parameters using `&`. For instance, `{{ link-datalens-main }}/test-dashboard?tab=test&OrderID=123456789` contains values for the `tab` and `OrderID` parameters.

The parameter values specified in the link will take priority. For example, if the dashboard settings have the `region` parameter set to `RU` and the dashboard link indicates `?region=KZ`, the `KZ` value is inserted into widgets.


## Chart parameters {#params-chart}

Chart parameters apply only to the chart itself. Thus, you can view the same chart with different filters on the same dashboard tab. You can [add parameters for the chart](../operations/chart/add-parameters.md) in its settings on the dashboard.

You can transmit a parameter value to a wizard chart using a field's ID ([see the guide](../operations/chart/add-guid.md)).

{% include [datalens-chart-parameters-example](../../_includes/datalens/datalens-chart-parameters-example.md) %}

## Special parameters {#special-parameters}

### Relative date {#relativedate}

This parameter is used to specify an offset relative to the current point in time in one of the following formats:

* `__relative_<sign><number><unit>`
* `__relative_<sign><number><unit>_<casting_type><unit>`

Where:

* `<sign>`: `+` or `-`
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
* `__relative_+30m`: In 30 minutes, `2020-03-25T00:00:39.874Z`
* `__relative_-0d`: Today, `2020-03-24T00:00:00.000Z`
* `__relative_-0h`: Now, `2020-03-24T23:30:39.874Z`
* `__relative_-3M_sQ`: Minus 3 months (`2019-12-24T00:00:00.000Z`) cast to the start of the quarter: `2019-10-01T00:00:00.000Z`
* `__relative_+15s_em`: Plus 15 seconds (`2020-03-24T23:30:54.874Z`) cast to the end of the minute: `2020-03-24T23:30:59.999Z`

{% note info %}

If the casting is not specified, then for the units of day and longer, the time is cast to the start of the day, i.e., `00:00:00.000`, and shorter units cast to the current time.

{% endnote %}

### Interval {#interval}

This parameter is used to set a time interval in `__interval_<start>_<end>` format, where `<start>`/`<end>` are [relative dates](#relativedate) or [ISO dates](https://ru.wikipedia.org/wiki/ISO_8601).

E.g., if the current time is `2020-03-24T23:30:39.874Z`, then:

* `__interval_2019-03-11T09:35:48_2019-12-28T09:35:48`: From `2019-03-11T09:35:48` to `2019-12-28T09:35:48`
* `__interval_2019-01-17T09:35:48___relative_+0d`: From `2019-01-17T09:35:48` until today (`2020-03-24T23:59:59.999Z`)
* `__interval___relative_-2w_sM___relative_+1d`: Two weeks ago or more (`2020-03-10T00:00:00.000Z`) cast to the start of the month (`2020-03-01T00:00:00.000Z`) until tomorrow (`2020-03-25T23:59:59.999Z`)

## Order of applying parameters {#params-applying}

For dashboard widgets, parameters are applied in the following order (values from the previous items are overridden by the subsequent ones):

1. [Chart parameters](#params-chart) from dashboard settings.
1. [Dashboard parameters](#params-dash).
1. Dasboard [selector](./selector.md) values.
1. Parameters specified in a dashboard link, e.g, `{{ link-datalens-main }}/test-dashboard?OrderID=123456789`.
1. Values from the `state` parameter in a dashboard link. {{ datalens-short-name }} remembers the selector settings and writes them to a special parameter named `state` and shown in the browser address bar. To share the current dashboard state, just copy the resulting link. This way, you can show the dashboard with required data directly instead of describing the filter settings.

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

   Parameters with these keys are ignored and not saved.

* Links can only use parameters that are set in the dashboard settings. Otherwise, they are ignored. For example, if a link contains `?product=Furniture`, but the dashboard settings have no `product` parameter (not even with a null value), this parameter is ignored.
* Dashboard parameters are applied to widgets anyway. This may lead to errors in data requests.
* Parameters cannot be used when creating links. To create a link, you can add a manual selector with the appropriate parameter key, set links using this selector by the required parameters, and then delete it. For example, for the dashboard's `parameter`:

   1. [Add](../operations/dashboard/add-selector.md) a manual selector to the dashboard with `parameter` specified in **Field or parameter name**.
   1. [Establish](../operations/dashboard/create-alias.md) an outbound link between the new selector and the required widgets on the dashboard.
   1. Delete the selector you added from the dashboard.

   The dashboard's `parameter` value will now be applied to all the widgets the remote selector was connected to.

