# Load test regressions

You can specify integral metrics for each test in {{ load-testing-name }}. Use them to quickly assess the quality of the test or the service you are testing.

Employ the visualization tools on the page ![image](../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}** to build integral indicator versus time graphs for the tests you performed.

Your regression dashboard presents widgets with regression graphs, headings, and explanatory texts. Use it to visualize your load test data.

On the dashboard, you can set up regression charts with metrics for [response time](load-test-results.md#quantiles), number of [testing threads](load-test-results.md#test-streams), or RPS breaking points.

At the top of the dashboard, there is a timeline: use it to set the preferred regression graph interval. Above the timeline, there is the interval length selection panel with three vertical lines:

* The interval boundaries are colored blue.
* The current moment is colored red. 

{% note info %}

The metric values that fall outside the time interval are not presented on regression graphs. No trend line will be drawn for extreme points on the chart.

{% endnote %}

## Regression types

### {{ ui-key.yacloud.load-testing.value_cumulative-quantiles-chart-type }}

This chart shows how different-level quantiles (percentiles, to be more exact) depend on time.
An N-level quantile indicates the time that N% responses fall within. The 50th quantile is a median value and the 100th quantile is the maximum one.

### {{ ui-key.yacloud.load-testing.value_instances-chart-type }}

This chart shows how the number of testing threads depends on time.
A testing thread is a separate instance of the load generator. It usually equals the number of connections established between the agent and the service being tested.

### {{ ui-key.yacloud.load-testing.value_imbalance_rps-chart-type }}

This chart plots RPS breaking point versus time.

### Thresholds for regression metrics {#check-regressions}

For each metric (line) on the regression dashboard charts, you can add a threshold value the excess of which should be considered abnormal. The chart areas where values exceed the thresholds are highlighted with the same color as the relevant metric line.

For individual tests, you can also use the `check-regressions` [command](../../cli/cli-ref/loadtesting/cli-ref/test/check-regression.md) in the {{ yandex-cloud }} CLI to check whether metric thresholds were exceeded. For more information, see [{#T}](../operations/check-regression.md).

## See also {#see-also}

[Creating a regression dashboard](../operations/regressions.md)
[Checking regression metrics for exceeded thresholds](../operations/check-regression.md)
[Managing a regression dashboard](../operations/regressions.md)
