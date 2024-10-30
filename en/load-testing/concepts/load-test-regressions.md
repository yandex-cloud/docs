# Load test regressions

For each test you run with {{ load-testing-full-name }}, you can specify a certain number of integral metrics, such as [response time](load-test-results.md#quantiles), [number of service responses with incorrect codes](load-test-results.md#network-codes), RPS disorders, etc. Integral metrics allow the user to quickly assess the quality of the test or the service being tested.

Using the visualization tools on the **Regressions** page, you can create graphs of dependencies of integral metrics on time for any performed tests.

## Regression dashboards

The regression dashboard allows you to conveniently compile information about a series of load tests. You can add widgets with regression graphs, headings, and explanatory texts to your dashboard.

## Time scale

The time scale at the top of the regressions page is used to customize the time interval for displaying the regression. The regression graph will show only those values of the load test metrics that fall within the specified interval.

{% note warning %}

Metric values that fall outside the time interval are not taken into account at all on regression graphs. As a consequence, for extreme points on the chart, a trend line to the edge will not be drawn, even if it is visible at other values of the time interval.

{% endnote %}

## Regression types

### {{ ui-key.yacloud.load-testing.value_cumulative-quantiles-chart-type }}

This chart shows how quantiles (to be more precise, percentiles) of different levels depend on time.
An N-level quantile indicates the time that N% responses fall within. The 50th quantile is a median value and the 100th quantile is the maximum one.

### {{ ui-key.yacloud.load-testing.value_instances-chart-type }}

This chart shows how the number of testing threads depends on time.
A testing thread is a separate instance of a load generator. It is usually equal to the number of connections established between the agent and the service being tested.

### {{ ui-key.yacloud.load-testing.value_imbalance_rps-chart-type }}

This chart displays the dependence of RPS disorder on time.

### Thresholds for regression metrics {#check-regressions}

For each metric (line) on the regression dashboard charts, you can add a threshold value the excess of which should be considered abnormal. The chart areas where values exceed the thresholds are highlighted with the same color as the relevant metric line.

For individual tests, you can also use the `check-regressions` [command](../../cli/cli-ref/managed-services/loadtesting/test/check-regression.md) in the {{ yandex-cloud }} CLI to check whether metric thresholds were exceeded. For more information, see [{#T}](../operations/check-regression.md).

## See also {#see-also}

[Creating a regression dashboard](../operations/regressions.md)
[Checking regression metrics for exceeded thresholds](../operations/check-regression.md)
