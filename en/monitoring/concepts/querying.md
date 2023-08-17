---
title: "Query language in {{ monitoring-full-name }}"
description: "This section describes the\_query language used in {{ monitoring-full-name }}. It's used to convert metrics when you configure dashboards and alerts, as well as in the MetricsData.read API method."
---

# Query language in {{ monitoring-name }}


This section describes the {{monitoring-full-name}} query language. It's used to convert metrics when you configure [dashboards](./visualization/dashboard.md) and [alerts](./alerting.md), as well as in the [MetricsData.read](../api-ref/MetricsData/read.md) API method.

## Uploading metrics {#selectors}

Select a set of metrics using the metric name and a set of _selectors_ filtering label values (for more information, see [{#T}](./data-model.md#label)). You can use the resulting sets of metrics in alerts or pass them to a function as an argument.

> Specify the name of a metric and required labels such as `folderId` and `service`. Then the `cpu_usage{folderId="zoeu2rgjpqakq377q1h6", service="compute"}` query returns metrics named `cpu_usage` for all {{compute-full-name}} VMs in the folder with the `zoeu2rgjpqakq377q1h6` ID.

{% note warning %}

The `folderId` label value must always match the selected folder. It is not allowed to query data from other folders. This restriction applies to any query language use case: when building charts in Metric Explorer or on dashboards, creating alerts, or calling API methods.

{% endnote %}

_Selector_ consists of a label name, a statement, and an expression that describes a set of label values.

The {{monitoring-full-name}} query language supports the following expressions for filtering label values:

- `label="*"`: Returns all metrics that have the specified label.

   > The `host="*"` selector returns all metrics that have the `host` label.

- `label="<glob>"`: Returns all the metrics that have labels that match a [glob expression](https://en.wikipedia.org/wiki/Glob_(programming)).
   - `*`: Any number of characters (including none).

      > `name="folder*"` returns all metrics that have the `name` label whose value starts with the `folder` prefix.

   - `?`: One arbitrary character.

      > `name="metric?"` returns all labels in which the `name` label value contains one character the `metric`.

   - `|`: All specified options.

      > `name="metric1|metric2"` returns two metrics with the `name=metric1` and `name=metric2` label values.

## Using query names as variables {#query-name-as-variable}

The query language supports links to the results of executing other queries as to names of variables.

E.g.:

A: `"temperature"{folderId="my_folder_id", service="custom", room="bedroom", building="home", sensor="sensor1" }`

B: `"temperature"{folderId="my_folder_id", service="custom", room="bedroom", building="home", sensor="sensor2" }`

C: `(A + B) / 2`

These links can only refer by name in text mode, and only to higher-level queries in the same alert or chart. You can apply any supported arithmetic operations and query language [functions](#functions) to variables.

## Data types {#data-types}

The {{monitoring-full-name}} query language supports the following data types:

* _timeseries_vector_: Set of timeseries (metrics).
* _number_: Real number.
* _string_: String in single or double quotes.
* _duration_: Time period in the format `15s, 10m, 3h, 7d, 2w`. (without quotation marks).
* _bool_: Boolean type which is either `true` or `false`.
* _scalar_: Real double-precision floating point number based on the [IEEE 754 standard](https://en.wikipedia.org/wiki/IEEE_754-2008_revision), including the special `NaN` value.

{% note info %}

The real number type supports scientific notation with the fraction and power of ten and the following suffixes:

* `k`: 10^3^
* `M`: 10^6^
* `G`: 10^9^
* `T`: 10^12^
* `P`: 10^15^
* `E`: 10^18^

{% endnote %}

## Functions {#functions}

- [Aggregation](#aggregation-functions)
   - [avg](#avg)
   - [count](#count)
   - [integrate](#integrate)
   - [iqr](#iqr)
   - [last](#last)
   - [max](#max)
   - [median](#median)
   - [min](#min)
   - [percentile](#percentile)
   - [random](#random)
   - [std](#std)
   - [sum](#sum)
- [Combine](#combine-functions)
   - [histogram_avg](#histogram_avg)
   - [histogram_cdfp](#histogram_cdfp)
   - [histogram_count](#histogram_count)
   - [histogram_percentile](#histogram_percentile)
   - [histogram_sum](#histogram_sum)
   - [series_avg](#series_avg)
   - [series_max](#series_max)
   - [series_min](#series_min)
   - [series_percentile](#series_percentile)
   - [series_sum](#series_sum)
- [Rank](#rank-functions)
   - [bottom_avg](#bottom_avg)
   - [bottom_count](#bottom_count)
   - [bottom_last](#bottom_last)
   - [bottom_max](#bottom_max)
   - [bottom_min](#bottom_min)
   - [bottom_sum](#bottom_sum)
   - [top_avg](#top_avg)
   - [top_count](#top_count)
   - [top_last](#top_last)
   - [top_max](#top_max)
   - [top_min](#top_min)
   - [top_sum](#top_sum)
- [Transform](#transform-functions)
   - [abs](#abs)
   - [asap](#asap)
   - [ceil](#ceil)
   - [derivative](#derivative)
   - [diff](#diff)
   - [drop_above](#drop_above)
   - [drop_below](#drop_below)
   - [drop_nan](#drop_nan)
   - [exp](#exp)
   - [floor](#floor)
   - [fract](#fract)
   - [heaviside](#heaviside)
   - [integral](#integral)
   - [log](#log)
   - [moving_avg](#moving_avg)
   - [moving_percentile](#moving_percentile)
   - [moving_sum](#moving_sum)
   - [non_negative_derivative](#non_negative_derivative)
   - [pow](#pow)
   - [ramp](#ramp)
   - [replace_nan](#replace_nan)
   - [round](#round)
   - [shift](#shift)
   - [sign](#sign)
   - [sqrt](#sqrt)
   - [trunc](#trunc)
- [Other](#other-functions)
   - [alias](#alias)
   - [constant_line](#constant_line)
   - [drop_empty_series](#drop_empty_series)

### Aggregation {#aggregation-functions}

Aggregation functions aggregate values of a timeseries in the current time range.

{% note warning %}

As an input argument, aggregation functions accept a vector of metrics (_timeseries_vector_). It must only include a single timeseries. Otherwise, the function returns a runtime error.

When using aggregation functions, make sure that the selector returns a single timeseries. Use [combining functions](#combine-functions) if needed.

{% endnote %}

#### avg

Returns an average value (for timeseries, a weighted average) or `NaN` for an empty timeseries.

The **avg** function has the following function overloading options depending on the type of the input _arg0_ parameter (an array of numbers, a metric, or a vector of metrics):

* **avg**(_arg0_: _scalar[]_): _scalar_
* **avg**(_arg0_: _timeseries_vector_): _scalar_

#### count

Returns the number of points in a metric or the number of items in a vector of numbers.

The **count** function has the following function overloading options depending on the type of the input _arg0_ parameter (an array of numbers, a metric, or a vector of metrics):

* **count**(_arg0_: _scalar[]_): _scalar_
* **count**(_arg0_: _timeseries_vector_): _scalar_

#### integrate

Returns an integrated sum of values or 0 for an empty timeseries.

The **integrate** function has the following function overloading options depending on the type of the input _arg0_ parameter (an array of numbers, a metric, or a vector of metrics):

* **integrate**(_arg0: scalar[]_): _scalar_
* **integrate**(_arg0_: _timeseries_vector_): _scalar_

#### iqr

Returns the [interquartile range](https://en.wikipedia.org/wiki/Interquartile_range) for a set of values.

The **iqr** function has the following function overloading options depending on the type of the input _arg0_ parameter (an array of numbers, a metric, or a vector of metrics):

* **iqr**(_arg0_: _scalar[]_): _scalar_
* **iqr**(_arg0_: _timeseries_vector_): _scalar_

#### last

Returns the last value different from `NaN` or `NaN` for an empty timeseries.

The **last** function has the following function overloading options depending on the type of the input _arg0_ parameter (an array of numbers, a metric, or a vector of metrics):

* **last**(_arg0_: _scalar[]_): _scalar_
* **last**(_arg0_: _timeseries_vector_): _scalar_

#### max

Returns the maximum value (or `NaN` for an empty timeseries).

The **max** function has the following function overloading options depending on the type of the input _arg0_ parameter (an array of numbers, a metric, or a vector of metrics):

* **max**(_arg0_: _scalar[]_): _scalar_
* **max**(_arg0_: _timeseries_vector_): _scalar_

#### median

Returns the median of values (or `NaN` for an empty timeseries).

The **median** function has the following function overloading options depending on the type of the input _arg0_ parameter (an array of numbers, a metric, or a vector of metrics):

* **median**(_arg0_: _scalar[]_): _scalar_
* **median**(_arg0_: _timeseries_vector_): _scalar_

#### min

Returns the minimum value (or `NaN` for an empty timeseries).

The **min** function has the following function overloading options depending on the type of the input _arg0_ parameter (an array of numbers, a metric, or a vector of metrics):

* **min**(_arg0_: _scalar[]_): _scalar_
* **min**(_arg0_: _timeseries_vector_): _scalar_

#### percentile

Returns the percentile value for a set of values. The percentile level is set in the required _level_ parameter as a number between 0 and 100.

The **percentile** function has the following function overloading options depending on the type of the input *values* parameter (an array of numbers, a metric, or a vector of metrics):

* **percentile**(_level_: _scalar_, _values: scalar[]_): _scalar_
* **percentile**(_level_: _scalar_, _values: timeseries_vector_): _scalar_

#### random

Returns a random item from a set of values.

The **random** function has the following function overloading options depending on the type of the input _arg0_ parameter (an array of numbers, a metric, or a vector of metrics):

* **random**(_arg0_: _scalar[]_): _scalar_
* **random**(_arg0_: _timeseries_vector_): _scalar_

#### std

Returns an unbiased estimation of standard deviation for a set of values (or `NaN` for an empty timeseries). The calculation is made by the following formula:

$$\begin{array}{c}
s=\sqrt{\frac{1}{n-1}\sum_{i=1}^n\left(x_i-\bar{x}\right)^2}
\end{array}{}
,
$$

Where:
* $x_i$: A value from the vector of values (or points in a timeseries).
* $\bar{x}$: Average value.
* $n$: Number of values.

The **std** function has the following function overloading options depending on the type of the input _arg0_ parameter (an array of numbers, a metric, or a vector of metrics):

* **std**(_arg0_: _scalar[]_): _scalar_
* **std**(_arg0_: _timeseries_vector_): _scalar_

#### sum

Returns a sum of all values of a set (or 0 for an empty timeseries).

The **sum** function has the following function overloading options depending on the type of the input _arg0_ parameter (an array of numbers, a metric, or a vector of metrics):

* **sum**(_arg0_: _scalar[]_): _scalar_
* **sum**(_arg0_: _timeseries_vector_): _scalar_

### Combine {#combine-functions}

The combine functions aggregate a metric vector into a single metric or a metric vector.

#### histogram_avg

**histogram_avg**(*[bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*

Calculates the average value of the distribution set by the histogram. The optional _bucketLabel_ parameter specifies which label contains the values of histogram intervals.

#### histogram_cdfp

The **histogram_cdfp** function has the following use cases (function overloading) depending on the type of _from_ and _to_ input parameters (a number or an array of numbers):

- **histogram_cdfp**(*from: number*, *to: number*, *bucketLabel: string***, source: timeseries_vector): timeseries_vector
- **histogram_cdfp**(*[from: number*, *to: number[]*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*
- **histogram_cdfp**(*[from: number[]*, *to: number*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*
- **histogram_cdfp**(*[from: number[]*, *to: number[]*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*

Calculates the percentage of values in the histogram between the intervals specified in the _from_ and _to_ optional parameters. If no parameters are specified, the first and last intervals are used, respectively. The optional _bucketLabel_ parameter specifies which label contains the values of histogram intervals.

#### histogram_count

The **histogram_count** function has the following use cases (function overloading) depending on the type of _from_ and _to_ input parameters (a number or an array of numbers):

- **histogram_count**(*[from: number*, *to: number*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*
- **histogram_count**(*[from: number*, *to: number[]*, *bucketLabel: string*], *source: timeseries_vector*): *timeseries_vector*
- **histogram_count**(*[from: number[]*, *to: number*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*
- **histogram_count**(*[from: number[]*, *to: number[]*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*

Counts the number of values in the histogram between the intervals specified in the _from_ and _to_ optional parameters. If no parameters are specified, the first and last intervals are used, respectively. The optional _bucketLabel_ parameter specifies which label contains the values of histogram intervals.

#### histogram_percentile

The **histogram_percentile** function has the following use cases (function overloading) depending on the type of _from_ and _to_ input parameters (a number or an array of numbers):

- **histogram_percentile**(*percentileLevel: number*, *[bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*
- **histogram_percentile**(*percentileLevel: number[]*, *[bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*

Calculates the percentile values of the distribution set by the histogram. The percentile level is set in the required _percentileLevel_ parameter as a single number or an array of numbers from 0 to 100. The optional _bucketLabel_ parameter specifies which label contains the values of histogram intervals.

#### histogram_sum

**histogram_sum**(*[bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*

Calculates the sum of histogram values. The optional _bucketLabel_ parameter specifies which label contains the values of histogram intervals.

#### series_avg

The **series_avg** function has the following use cases (function overloading) depending on the type of _key_ input parameter (a string or an array of strings):

- **series_avg**(*[key: string]*, *source: timeseries_vector*): *timeseries_vector*
- **series_avg**(*[key: string[]]*, *source: timeseries_vector*): *timeseries_vector*

Aggregates timeseries into one (or multiple ones) by applying the avg (average) aggregation function for each time point. The optional _key_ parameter contains a string or an array of strings with a list of labels to group by.

For example, the `series_avg({...})` query calculates the average value among all uploaded metrics at each point.

The `series_avg("host", {...})` query calculates the average value among all uploaded metrics for each value of the `host` label.

The `series_avg(["host", "disk"], {...})` query calculates the average value among all uploaded metrics for each combination of `host` and `disk` label values.


#### series_max

The **series_max** function has the following use cases (function overloading) depending on the type of _key_ input parameter (a string or an array of strings):

- **series_max**(*[key: string]*, *source: timeseries_vector*): *timeseries_vector*
- **series_max**(*[key: string[]]*, *source: timeseries_vector*): *timeseries_vector*

Aggregates timeseries into one (or multiple ones) by applying the max aggregation function for each time point. The optional _key_ parameter contains a string or an array of strings with a list of labels to group by. See examples of queries using the _key_ parameter in [series_avg](#series_avg).

#### series_min

The **series_min** function has the following use cases (function overloading) depending on the type of _key_ input parameter (a string or an array of strings):

- **series_min**(*[key: string]*, *source: timeseries_vector*): *timeseries_vector*
- **series_min**(*[key: string[]]*, *source: timeseries_vector*): *timeseries_vector*

Aggregates timeseries into one (or multiple ones) by applying the min aggregation function for each time point. The optional _key_ parameter contains a string or an array of strings with a list of labels to group by. See examples of queries using the _key_ parameter in [series_avg](#series_avg).

#### series_percentile

The **series_percentile** function has the following use cases (function overloading) depending on the type of _rank_ input parameter (a number or an array of numbers):

- **series_percentile**(*rank: number*, *source: timeseries_vector*): *timeseries_vector*
- **series_percentile**(*rank: number[]*, *source: timeseries_vector*): *timeseries_vector*

Aggregates timeseries into one (or multiple ones) by applying the percentile aggregation function for each time point.

#### series_sum

The **series_sum** function has the following use cases (function overloading) depending on the type of _key_ input parameter (a string or an array of strings):

- **series_sum**(*[key: string]*, *source: timeseries_vector*): *timeseries_vector*
- **series_sum**(*[key: string[]]*, *source: timeseries_vector*): *timeseries_vector*

Aggregates timeseries into one (or multiple ones) by applying the sum aggregation function for each time point. The optional _key_ parameter contains a string or an array of strings with a list of labels to group by. See examples of queries using the _key_ parameter in [series_avg](#series_avg).


### Rank {#rank-functions}

The rank functions order a metric vector by the aggregation function value in the current time window and return some of the first (upper) or last (lower) timeseries from it. The _limit_ parameter specifies how many metrics a function returns.

#### bottom_avg

**bottom_avg**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Returns the _limit_ of metrics with a minimum average value.

#### bottom_count

**bottom_count**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Returns the _limit_ of metrics with a minimum number of values.

#### bottom_last

**bottom_last**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Returns the _limit_ of metrics with the minimum last value.

#### bottom_max

**bottom_max**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Returns the _limit_ of metrics with the lowest max value.

#### bottom_min

**bottom_min**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Returns the _limit_ of metrics with the lowest min value.

#### bottom_sum

**bottom_sum**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Returns the _limit_ of metrics with the lowest sum value.

#### top_avg

**top_avg**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Returns the _limit_ of metrics with the top average value.

#### top_count

**top_count**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Returns the _limit_ of metrics with a maximum number of values.

#### top_last

**top_last**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Returns the _limit_ of metrics with the top last value.

#### top_max

**top_max**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Returns the _limit_ of metrics with the top max value.

#### top_min

**top_min**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Returns the _limit_ of metrics with the top minimum value.

#### top_sum

**top_sum**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Returns the _limit_ of metrics with the top sum value.


### Transform {#transform-functions}

The transform metric functions calculate a new value in each point for each timeseries from a set of metrics.

#### abs

**abs**(*source: timeseries_vector*): *timeseries_vector*

Calculates the absolute value.

#### asap

**asap**(*source: timeseries_vector*): *timeseries_vector*

Smooths timeseries based on the [ASAP algorithm](http://futuredata.stanford.edu/asap/).
Timeseries points are averaged using a moving average with a dynamic window. The window width is automatically selected so as to remove as much noise as possible while retaining important information.

#### ceil

**ceil**(*source: timeseries_vector*): *timeseries_vector*

Rounds the point values up to the nearest integer.

#### derivative

**derivative**(*source: timeseries_vector*): *timeseries_vector*

Calculates the derivative: the difference between the values of neighboring points divided by the interval between them.

#### diff

**diff**(*source: timeseries_vector*): *timeseries_vector*

Calculates the difference between the values of each pair of neighboring points.

#### drop_above

**drop_above**(*source: timeseries_vector*, *threshold: number*): *timeseries_vector*

Drops points with a value above the _threshold_ (not including the value itself). In dropped points, the metric value is equal to `NaN`.

#### drop_below

**drop_below**(*source: timeseries_vector*, *threshold: number*): *timeseries_vector*

Drops points with a value above the _threshold_ (not including the value itself). In dropped points, the metric value is equal to `NaN`.

#### drop_nan

**drop_nan**(*source: timeseries_vector*): *timeseries_vector*

Drops points with the `NaN` value.

#### exp

Calculates an exponential function: raises _e_ to a power equal to the value of points, where _e=2.718281..._ is the base of the natural logarithm.

#### floor

**floor**(*source: timeseries_vector*): *timeseries_vector*

Rounds point values down to the nearest integer.

#### fract

**fract**(*source: timeseries_vector*): *timeseries_vector*

Selects the real part of point values.

#### heaviside

**heaviside**(*source: timeseries_vector*): *timeseries_vector*

Calculates the [Heaviside step function](https://en.wikipedia.org/wiki/Heaviside_step_function). The function is 1 if the point values are positive, and 0 if the point values are negative.

#### integral

**integral**(*source: timeseries_vector*): *timeseries_vector*

Calculates an indefinite integral using the [trapezoidal rule](https://en.wikipedia.org/wiki/Trapezoidal_rule).

#### log

**log**(*source: timeseries_vector*): *timeseries_vector*

Calculates the natural logarithm.

#### moving_avg

**moving_avg**(*source: timeseries_vector*, *window: duration*): *timeseries_vector*

Calculates the moving average across a window _window_ width.

For example, the `moving_avg({...}, 1d)` query returns the moving average with a window of 1 day.

#### moving_percentile

**moving_percentile**(*source: timeseries_vector*, *window: duration*, *rank: number*): *timeseries_vector*

Calculates the moving percentile: the percentile of the _rank_ level (from 0 to 100) among the points in a window with a _window_ width.

For example, the `moving_percentile({...}, 1h, 99.9)` query returns the moving 99.9 percentile with a window of 1 hour.

#### moving_sum

**moving_sum**(*source: timeseries_vector*, *window: duration*): *timeseries_vector*

Calculates the moving sum across a _window_ window width.

For example, the `moving_sum({...}, 1d)` query will return a moving sum with a window of 1 day.

#### non_negative_derivative

**non_negative_derivative**(*source: timeseries_vector*): *timeseries_vector*

Calculates the derivative: the difference between the values of neighboring points divided by the interval between them. If the derivative value is negative, it's substituted with the `NaN` value.

#### pow

**pow**(*source: timeseries_vector*, *power: number*): *timeseries_vector*

Calculates the power function: raises the point value to the *power* power.

#### ramp

**ramp**(*source: timeseries_vector*): *timeseries_vector*

Resets points with a negative value to 0.

#### replace_nan

**replace_nan**(*source: timeseries_vector*, *replace: number*): *timeseries_vector*

Replaces points with the `NaN` value with the `replace` value.

#### round

**round**(*source: timeseries_vector*): *timeseries_vector*

Rounds values to the nearest integer.

#### shift

**shift**(*source: timeseries_vector*, *window: duration*): *timeseries_vector*

Adds the `window` value to point timestamps. This function lets you compare current metric values with the values for a different time interval.

For example, `shift({...}, 1w)` returns metrics shifted a week ahead, meaning that the chosen time window will contain values that are week old.

#### sign

**sign**(*source: timeseries_vector*): *timeseries_vector*

Calculates the *sgn(x)* function. The function is 1 for positive point values, 0 for zero values, and -1 for negative values.

#### sqrt

**sqrt**(*source: timeseries_vector*): *timeseries_vector*

Calculates the square root of point values.

#### trunc

**trunc**(*source: timeseries_vector*): *timeseries_vector*

Truncates the real part of point values.


### Other {#other-functions}

#### alias

**alias**(*source: timeseries_vector*, *arg1: string*): *timeseries_vector*

Renames metrics. As an argument, you can use [mustache templates](https://mustache.github.io/) in the `not_var{{label}}` format to substitute a label value in a new metric name.

#### constant_line

Returns a constant line consisting of two points in the beginning and end of the interval equal to *value*

**constant_line**(*value: scalar*): *timeseries_vector*

When you specify an optional *grid* parameter, the function populates the current time interval with points with the value of *value* and the step of *grid* between the points.

**constant_line**(*value: scalar*, *grid: duration*): *timeseries_vector*

{% note warning %}

Use the **constant_line** function only to show lines on charts. The use of this function in calculations will produce an incorrect result, because the function returns a timeseries of only two points: at the beginning and end of the definition interval.

{% endnote %}

#### drop_empty_series

**drop_empty_series**(*source: timeseries_vector*): *timeseries_vector*

Drops timeseries where either there are no points in the specified time range or all points have the `NaN` value.


