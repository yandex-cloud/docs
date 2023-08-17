# Using parameters and limitations


Parameters in {{ datalens-short-name }} allow you to use visualization features more flexibly and adapt the use of the same dashboards for different purposes.

[Dashboard](#params-dash) parameters apply to all its charts.

Using the parameters might be handy, for example, when you want to post a link to a dashboard with an applied filter in another dashboard table, on a {{ wiki-full-name }} page, or somewhere else.


## Dashboard parameters {#params-dash}

In the dashboard settings section, you can set the [parameters](../operations/dashboard/add-parameters.md) to use. For each parameter, specify a key and value. The saved dashboard parameters are inserted into all widgets (including charts and selectors) once they are uploaded. When opening this dashboard, its data will be filtered based on the specified parameter values.

A parameter name must be the same as the name of the dataset field by which data is filtered.

{% note info %}

In some cases, you should use the field ID as the parameter name:

* If the field name contains Cyrillic characters or consists of two words.
* If you want to use the parameter value in a selector based on a dataset.

If the field ID changes, you should also update the parameter name. For more information, see [this guide](../operations/chart/add-guid.md).

{% endnote %}

You can also specify parameter values in dashboard links. In this case, clicking a link will open the dashboard with a filter applied.

The first address string parameter is separated from the dashboard path using `?` and the remaining parameters using `&`. For instance, `https://datalens.yandex.ru/test-dashboard?tab=test&OrderID=123456789` contains values for the `tab` and `OrderID` parameters.

The parameter values specified in the link will take priority. For example, if the dashboard settings have the `region` parameter set to `RU` and the dashboard link indicates `?region=KZ`, the `KZ` value is inserted into widgets.


## Parameter limitations {#params-restrictions}

The following limitations apply when using parameters:

* You can't use the following reserved keys:

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

   Parameters with these keys are ignored and not saved.

* Links can only use parameters that are set in the dashboard settings. Otherwise, they are ignored. For example, if a link contains `?product=Furniture`, but the dashboard settings have no `product` parameter (not even with a null value), this parameter is ignored.
* Dashboard parameters are applied to widgets anyway. This may lead to errors in data requests.
* Parameters can't be used when creating links. To create a link, you can add a manual selector with the appropriate parameter key, set links using this selector by the required parameters, and then delete it.
