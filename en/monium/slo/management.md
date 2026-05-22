# Managing SLOs in {{ monium-name }}

To work with SLOs, on the [{{ monium-name }} home page]({{ link-monium }}), select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.slo.title }}** on the left.

## SLO statuses {#status}

Depending on the calculation results and its preset target value, an SLO can switch to one of the following statuses:

* **OK**: Successful calculation; the SLI has not gone below the specified SLO.

* **Alarm**: Successful calculation; the SLI has gone below the specified SLO.

* **No data**: At least one metric the SLO is based upon does not exist. For example, there is an error in the metric name and such metric does not exist, or the metric was deleted by TTL.

    {% note warning %}

    If metrics have no points, the SLO calculation will continue.

    {% endnote %}

* **Error**: User or system error. For example, the SLO has been misconfigured and cannot be calculated.

## Configuring SLOs {#config}

### Basic parameters {#base-config}

* **Name**: Any name for the SLO, e.g., `API Availability`.
* **Description**: Additional description of the SLO.
* **Labels**: List of `key-value` pairs to label the SLO with additional metadata for search and filtering, e.g., when selecting a list of SLOs to display in a widget.
* **Calculation method** (required): Event-based SLI calculation method:
    * **Good Events / Total Events**: Good events and general events, e.g., successful service responses and total received queries.
    * **Bad Events / Total Events**: Bad events and general events, e.g., service error responses and total received queries.
    * **Good Events / Bad Events**: Good events and bad events, e.g., successful service responses and service responses with errors.
    
    The system automatically calculates unspecified events for any selected method. For example, if you choose to calculate only good and bad events, the total number of events will be the sum of those two categories.
* **Evaluation window**: SLO calculation period. This is a required parameter. The default value is `30d` (30 days).

    {% note info %}

    Currently, only 1, 7, or 30-day windows are available; going forward, custom evaluation windows of up to one year will be supported.

    {% endnote %}

    {% include [ttl_warning](../../_includes/monium/ttl_warning.md) %}

* **Evaluation delay**: Back-shift of the time window in seconds. This is a required parameter. The default value is `1m` (one minute).

    {% note info %}

    We recommend you set a delay of at least one minute to avoid inconsistencies in the metric collection period and prolonged last point aggregation: to calculate the last point, you need values of all metrics for which the aggregation rule is met. However, when calculating the SLO, only partial data will be obtained, and the point’s value will be lower than expected. For this reason, set a calculation delay for SLOs that is long enough to prevent all adverse effects during metric collection.

    {% endnote %}

* **SLO**: Service reliability target metric. The default value is `99%`.

### List of queries {#queries}

{% note info %}

The calculation method you select when creating an SLO determines which queries are available.

{% endnote %}

#### Good Events {#good-events}

These are queries that return a line or multiple lines for calculating the *Good Events* section. For each query, you can:

* Disable query calculation by selecting *Deactivate* in the context menu after an ellipsis. Links to queries that are not calculated will return errors.
* Exclude a query from calculation of the final result and hide query calculation results on the chart by clicking ![image](../../_assets/monium/eye.svg).
* Reference query names as variables within a single section.

{% note info %}

The result for the *Good Events* section is always calculated as the total of all query results within the section. Queries that were hidden or deactivated are excluded from the final result. Calculation of hidden queries will continue, and you can reference them in other queries within a single section.

{% endnote %}

#### Bad Events {#bad-events}

These are queries that return a line or multiple lines for calculating the *Bad Events* section. For each query, you can:

* Disable query calculation by selecting *Deactivate* in the context menu after an ellipsis. Links to queries that are not calculated will return errors.
* Exclude a query from calculation of the final result and hide query calculation results on the chart by clicking ![image](../../_assets/monium/eye.svg).
* Reference query names as variables within a single section.

{% note info %}

The result for the *Bad Events* section is always calculated as the total of all query results within the section. Queries that were hidden or deactivated are excluded from the final result. Calculation of hidden queries will continue, and you can reference them in other queries within a single section.

{% endnote %}

#### Total Events {#total-events}

These are queries that return a line or multiple lines for calculating the *Total Events* section. For each query, you can:

* Disable query calculation by selecting *Deactivate* in the context menu after an ellipsis. Links to queries that are not calculated will return errors.
* Exclude a query from calculation of the final result and hide query calculation results on the chart by clicking ![image](../../_assets/monium/eye.svg).
* Reference query names as variables within a single section.

{% note info %}

The result for the *Total Events* section is always calculated as the total of all query results within the section. Queries that were hidden or deactivated are excluded from the final result. Calculation of hidden queries will continue, and you can reference them in other queries within a single section.

{% endnote %}

### Preview area {#preview}

The preview area displays current calculated SLI and remaining Error Budget values based on queries in the *Good Events* and *Total Events* sections. There is a separate metric chart for each query section. When any of the SLO parameters are changed, these values are automatically recalculated.

For each metric chart, you can select a visualization type:
* Line (default)
* Area
* Column
* Points

You can close the preview area at any moment and reopen it by clicking *Preview* at the top-right corner of the page.

## Viewing the SLO {#view}

The SLO view page displays its main properties, status, and current calculated values.

{% note info %}

From the SLO view page, click **Go to Metrics** to open the metrics overview. This page displays all queries used in the SLO calculation, as well as the metrics with calculated Good, Bad, and Total event counts.

{% endnote %}

Under *Evaluation history*, the following elements are available:

* **Timeline**: Component for managing the chart view interval. The default interval matches the evaluation window. Changes to the timeline affect all charts.
* **SLI**: History of the calculated SLI value and SLO changes. This is a chart with auto-scaling based on measure values.
* **Error Budget burndown**: Chart for the error budget consumption rate during the interval equal to the evaluation window. This chart has a fixed time range equal to the evaluation window. When changing the interval on the timescale, this chart’s range will not change, and the right boundary of the X axis will match the right boundary of the selected interval.
* **Good Events / Bad Events** or **Bad Events / Total Events** metrics: Chart displaying the calculation results for metrics which are used for SLI calculation. Normalization and the `Area` visualization type are enabled for this chart by default. You can disable normalization so the chart displays absolute metric values. Supported visualization types: line, area (default), column, and points.

Under *Query list* in the view mode, you can see queries used to calculate *Good Events*, *Bad Events*, and *Total Events*. Your selected calculation method determines which queries are available.
