# Autostop

_Autostop_ is a plugin configurable during test creation that automatically stops the test depending on pre-defined criteria.

Autostop is used to limit time and resources allocated for testing or define certain events after which further testing is unneeded.

The triggered autostop criterion prematurely stops the test. To determine which criterion stopped the test, criteria are assigned _Termination codes_, which can be used for automatic evaluation of test results.

Format of the `autostop` section in the `yaml` configuration file:

```yaml
autostop:
  enabled: true
  package: yandextank.plugins.Autostop
  autostop:
    - <autostop_criterion>(<criterion_parameters>)
```

## Main criteria {#basic-criteria}

| Criterion | Description |
----- | -----
| `time` | The test stops if the average response time exceeds the pre-defined value for a specified period of time.</br>For example, `time(1s500ms,30s)`, `time(50,15)`.</br>Termination code: `21`. |
| `http` | The test stops if the number of responses with specific HTTP codes exceeds the pre-defined absolute or relative value. Use `xx` for all non-zero code values.</br>For example, `http(404,10,15)`, `http(5xx,10%,1m)`.</br>Termination code: `22`. |
| `net` | Similar to `http` for net codes.</br>Termination codes: `23`. |
| `quantile` | The test stops if the selected percentile of queries exceeds the pre-defined value for a specified period of time. Possible percentiles: `25`, `50`, `75`, `80`, `90`, `95`, `98`, `99`, `100`.</br>For example, the `quantile(95,100ms,10s)` criterion stops the test if the 95th percentile exceeds 100 milliseconds for 10 seconds (for 10 seconds, time to process 5% of queries exceeds 100 milliseconds). |
| `instances` | The test stops if the number of testing threads exceeds the pre-defined value for a specified period of time.</br>For example, `instances(80%,30)`, `instances(50,1m)`.</br>Termination code: `24`. |
| `steady_cumulative` | The test stops if the sum total of percentiles doesn't change for a specified period of time.</br>For example, `steady_cumulative(1m)`.</br>Termination code: `33`. |
| `limit` | The test stops in the pre-defined period of time.</br>For example, `limit(1m)`. |

Main criteria aren't averaged, they're assessed every second during the specified period. For example, the `autostop=time(50,15)` criterion stops the test if the average response time per second exceeds 50 milliseconds during 15 seconds.

## Additional criteria {#advanced-criteria}

| Criterion | Description |
----- | -----
| `total_time` | Similar to `time` but cumulatively for the entire period of time (responses meeting the criterion may be non-consecutive but come during the specified period of time).</br>For example, `total_time(300ms,70%,3s)`.</br>Termination code: `25`. |
| `total_http` | Similar to `http` but cumulatively for the entire period of time. See `total_time`.</br>For example, `total_http(5xx,10%,10s)`, `total_http(3xx,40%,10s)`.</br>Termination code: `26`. |
| `total_net` | Similar to `net` but cumulatively for the entire period of time. See `total_time`.</br>For example, `total_net(79,10%,10s)`, `total_net(11x,50%,15s)`.</br>Termination code: `27`. |
| `negative_http` | Inverted `total_http`. The test stops if the total number of responses with specific HTTP codes is less than the pre-defined absolute or relative value. Use the HTTP code `200` to make sure the server responds.</br>For example,: `negative_http(2xx,10%,10s)`.</br>Termination code: `28`. |
| `negative_net` | Inverted `total_net`. Similar to `negative_http` for net codes.</br>For example, `negative_net(0,10%,10s)`.</br>Termination code: `29`. |
| `http_trend` | The test stops if a trend for specific HTTP codes remains negative for the specified period of time. A trend is a sum of averaged coefficient of the linear function calculated for each pair of points for the last N seconds, and its standard deviation.</br>For example, `http_trend(2xx,10s)`.</br>Termination code: `30`. |

## Criteria for specific tags {#tag-criteria}

Except for `limit`, all other criteria can be applied to a specific URI labeled with a tag rather than the whole test.

For example, `time(1s,5s,/latest/index/)` stops the test if the average response time only from the URI address tagged `/latest/index/` exceeds 1 second for 5 seconds.

Any specific URI can be tested this way. For example:

```yaml
autostop:
  enabled: true
  package: yandextank.plugins.Autostop
  autostop:
    - http(4xx, 20%, 15s, case1)
    - http(4xx, 5%, 5s, case2)
```

This autostop stops the test if the number of URI responses tagged `case1` with the HTTP code `4xx` exceeds 20% for 15 seconds or the number of URI responses tagged `case2` with the HTTP code `4xx` exceeds 5%.