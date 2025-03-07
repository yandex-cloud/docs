# Autostop

_Autostop_ is a plugin configurable during test creation that automatically stops the test depending on pre-defined criteria.

Autostop is used to limit time and resources allocated for testing or define certain events after which further testing is unneeded.

The triggered autostop criterion prematurely stops the test. To determine which criterion stopped the test, criteria are assigned _Termination codes_, which can be used for automatic evaluation of test results.

`autostop` section format in the `yaml` test configuration file:

```yaml
autostop:
  enabled: true
  package: yandextank.plugins.Autostop
  autostop:
    - <autostop_criterion>(<criterion_parameters>)
```

{% note warning %}

In the configuration file, `autostop` is a required section; otherwise, the test will not run in new system versions.
In this section, you must specify at least the `limit` criterion, which is the time limit for the test.
The `limit` value should be slightly greater than the expected test duration to prevent autostopping the regular flow of the test.

{% endnote %}

## Main criteria {#basic-criteria}

Criterion | Description
----- | -----
`limit` | This is a required criterion.</br>The test will stop after the specified period of time.</br>Example: `limit(1m)`.
`time` | The test will stop if the average response time exceeds the specified value within the defined period.</br>Examples: `time(1s500ms,30s)`, `time(50,15)`.</br>Termination code: `21`.
`http` | The test will stop if the number of responses with particular HTTP codes exceeds the specified absolute or relative values within the defined period. Use `xx` for all non-zero code values.</br>For example, `http(404,10,15)`, `http(5xx,10%,1m)`.</br>Termination code: `22`.
`net` | Similar to `http` for net codes.</br>Termination codes: `23`.
`quantile` | The test will stop if the selected percentile of queries exceeds the specified value within the defined period. Possible percentiles: `25`, `50`, `75`, `80`, `90`, `95`, `98`, `99`, `100`.</br>For example, the `quantile(95,100ms,10s)` criterion stops the test if the 95th percentile exceeds 100 milliseconds for 10 seconds (for 10 seconds, the time to process 5% of queries exceeds 100 milliseconds).
`instances` | The test will stop if the number of testing threads exceeds the specified value within the defined period.</br>For example, `instances(80%,30)`, `instances(50,1m)`.</br>Termination code: `24`.
`steady_cumulative` | The test will stop if the cumulative percentiles do not change within a defined period.</br>For example, `steady_cumulative(1m)`.</br>Termination code: `33`.

Main criteria aren't averaged, they're assessed every second during the specified period. For example, the `autostop=time(50,15)` criterion stops the test if the average response time per second exceeds 50 milliseconds during 15 seconds.

## Additional criteria {#advanced-criteria}

Criterion | Description
----- | -----
`total_time` | Similar to `time` but cumulatively for the whole time period (responses meeting the criterion may be non-consecutive but coming during the specified period).</br>For example, `total_time(300ms,70%,3s)`.</br>Termination code: `25`.
`total_http` | Similar to `http` but cumulatively for the whole time period. See `total_time`.</br>For example, `total_http(5xx,10%,10s)`, `total_http(3xx,40%,10s)`.</br>Termination code: `26`.
`total_net` | Similar to `net` but cumulatively for the whole time period. See `total_time`.</br>For example, `total_net(79,10%,10s)`, `total_net(11x,50%,15s)`.</br>Termination code: `27`.
`negative_http` | Inverted `total_http`.</br>The test will stop if the total number of responses with HTTP codes falling short of the specified mask exceeds the specified absolute or relative values within the specified timeframe. Use the HTTP code `200` to make sure the server responds.</br>For example,: `negative_http(2xx,10%,10s)`.</br>Termination code: `28`.
`negative_net` | Inverted `total_net`.</br>The test will stop if the total number of responses with net codes falling short of the specified mask exceeds the specified absolute or relative values within the specified timeframe.</br>For example, `negative_net(0,10%,10s)`.</br>Termination code: `29`.
`http_trend` | The test will stop if a trend for specific HTTP codes remains negative for a defined period. A trend is a sum of an averaged coefficient of the linear function, calculated for each pair of points for the last N seconds, and its standard deviation.</br>For example, `http_trend(2xx,10s)`.</br>Termination code: `30`.

## Criteria for specific tags {#tag-criteria}

Except for `limit`, all other criteria can be applied to a specific URI labeled with a tag, not the whole test.

For example, `time(1s,5s,/latest/index/)` stops the test if the average response time only from the URL tagged `/latest/index/` exceeds 1 second for 5 seconds.

Any specific URI can be tested this way. Here is an example:

```yaml
autostop:
  enabled: true
  package: yandextank.plugins.Autostop
  autostop:
    - limit(5m)
    - http(4xx, 20%, 15s, case1)
    - http(4xx, 5%, 5s, case2)
```

Such autostop will stop the test if the number of URI responses tagged `case1` with HTTP code `4xx` exceeds 20% for 15 seconds, or the number of URI responses tagged `case2` with HTTP code `4xx` exceeds 5%.

## Use cases {#examples}

* [{#T}](../tutorials/loadtesting-https-phantom.md)
* [{#T}](../tutorials/loadtesting-https-pandora.md)
* [{#T}](../tutorials/loadtesting-gitlab-ci.md#add-loadtesting-ci)
* [{#T}](../tutorials/loadtesting-multiply.md)
* [{#T}](../tutorials/loadtesting-http-scenario-pandora.md)
* [{#T}](../tutorials/loadtesting-grpc-autoscaling.md)
* [{#T}](../tutorials/loadtesting-grpc.md)