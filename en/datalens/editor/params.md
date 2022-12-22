
# Parameterizing charts

The **Params** tabs describes the default parameters.
These are the parameters used by the chart by default.

```js
module.exports = {
    period: '20',
    metric: ['judged-pfound-5'],
    id: ['1215', '1217', '979', '483']
};
```

Parameters can be both regular values (strings or numbers) and arrays.

When running a script, the parameters of the URL that launched the script override
the default parameters, and you can use the resulting object in the 
*ChartEditor* tabs.

To get the parameter value, use the method `ChartEditor.getParams()`:

```js
const params = ChartEditor.getParams();
if (params.period[0] === '20') {
    // your code
}
```

You can override the parameters using the chart's URL. For example:

```
&period=40&metric=2012&metric=2014
```

When such a URL overrides the above default parameters, you get the following `params` object:

```js
{
  period: 40,
  metric: ['2012', '2014'],
  id: ['1215', '1217', '979', '483']
}
```

During the original dashboard rendering, the parameters linking the external selector with the charts on the dashboard remain static. If the parameter is dynamically calculated in the selector code, then the chart re-renders with the updated parameter value only when the selector changes next time.

## Special parameters {#special-parameters}

### Relative date {#relativedate}

**Formats:**

* `__relative_<sign><amount><unit>`
* `__relative_<sign><amount><unit>_<casting type><unit>`

- Sign: `+` or `-`
- units:
   - `y` — a year
   - `Q` — a quarter
   - `M` — a month
   - `w` — a week
   - `d` — a day
   - `h` — a hour
   - `m` — a minute
   - `s` — a second
   - `ms` — a millisecond
- Casting type:
   - `s`: To the start
   - `e`: To the end

**Example:**

If the current time is `2020-03-24T23:30:39.874Z`, then
- `__relative_-7d`: Seven days back - ` 2020-03-17T00:00:00.000Z`
- `__relative_+30m` - 30 minutes later - ` 2020-03-25T00:00:39.874Z`
- `__relative_-0d`: Today - `2020-03-24T00:00:00.000Z`
- `__relative_-0h`: Now - `2020-03-24T23:30:39.874Z`
- `__relative_-3M_sQ`
   * 3 months back - `2019-12-24T00:00:00.000Z`
      * Cast to the start of the quarter - `2019-10-01T00:00:00.000Z`
- `__relative_+15s_em`
   * 15 seconds later - `2020-03-24T23:30:54.874Z`
      * Cast to the end of the minute - `2020-03-24T23:30:59.999Z`

**Note:** If the casting is not specified, then for the units of day and higher, the time is cast to the start of the day
, that is, `00:00:00.000`, and smaller units cast to the current time.

**Helper method:** `ChartEditor.resolveRelative`
- Accepts a string in a relative date format
- Returns an ISO date if the string matches the format, otherwise, returns `null`

```js
// Current time: 2020-02-18T09:14:56.123Z
const date = ChartEditor.resolveRelative('__relative_-7d');
// date === 2020-02-11T00:00:00.000Z
```

```js
// Current time: 2020-02-18T09:14:56.123Z
const date = ChartEditor.resolveRelative('__relative_+30m_sh');
// date === 2020-02-18T09:00:00.000Z
```

```js
const date = ChartEditor.resolveRelative('2020-01-01');
// date === null
```

**Note:** The relative dates set in the `Params` tab or specified in the URL are automatically processed by the helper method.
However, if the parameter value mismatches the relative date format, then the original value is returned instead of `null`.
For example:

**Params** tab:
```js
module.exports = {
    date_min: '2020-01-01',
    date_max: '__relative_+1d_sw',
    incorrect: '_relative_d1',
}
```

Parameters **url:** `...?date_min=__relative_-7d`
```js
// Current time: 2020-02-20T12:30:11.324Z
const params = ChartEditor.getParams();
// params === {
//   date_min: ['2020-02-13T00:00:00.000Z'],
//   date_max: ['2020-02-17T00:00:00.000Z'],
//   incorrect: ['_relative_d1']
// }
```

### Interval {#interval}

**Format:** `__interval_<start>_<end>`

`Start`/`End`: A [relative date ](#relativedate) or ISO date.

**Example:**

If the current time is `2020-03-24T23:30:39.874Z`, then
- `__interval_2019-03-11T09:35:48_2019-12-28T09:35:48`
   * From `2019-03-11T09:35:48` till `2019-12-28T09:35:48`
- `__interval_2019-01-17T09:35:48___relative_+0d`
   * From `2019-01-17T09:35:48` till today (`2020-03-24T23:59:59.999Z`)
- `__interval___relative_-2w_sM___relative_+1d`
   * Two weeks ago or more: `2020-03-10T00:00:00.000Z`
      * cast to the start of the month`2020-03-01T00:00:00.000Z`
   * Until tomorrow: `2020-03-25T23:59:59.999Z`

**A helper method:** `ChartEditor.resolveInterval`
- Accepts a string in the interval format
- Returns the `{from, to}` object, where `from/to` is an ISO date, if the string matches the parameter, otherwise – ⁣`null`

```js
// Current time: 2020-02-26T07:05:52.552Z
const {from, to} = ChartEditor.resolveInterval('__interval___relative_-1y___relative_+10d_eM');
// from === 2019-02-26T00:00:00.000Z
// to === 2020-03-31T23:59:59.999Z
```

```js
// Current time: 2020-02-26T07:05:52.552Z
const interval = ChartEditor.resolveInterval('__interval_2019-01-01T07:08:25.941Z___relative_+1h');
// interval.from === 2019-01-01T07:08:25.941Z
// interval.to === 2020-02-26T08:05:52.552Z
```

```js
// Current time: 2020-02-26T07:05:52.552Z
const interval = ChartEditor.resolveInterval('__interval_2020.01.15___relative_-0d');
// interval === null
```

**Note:** The start and end of the interval specified in the `Params` tab and in the URL is automatically processed by the helper method for the [relative date](#relativedate).
However, if the interval's `start`/`end` value mismatches the relative date format, then the original value is returned instead of `null`.
For example:

**Params** tab:
```js
module.exports = {
    first: '__interval_2020-01-01T12:30:11.324Z___relative_+1d',
    second: '',
    incorrect: '__inteval_01.01.2020___relative_-1d'
}
```

Parameters **url:** `...?second=__interval___relative_-1y_eQ_2021`
```js
// Current time: 2020-02-20T12:30:11.324Z
const params = ChartEditor.getParams();
// params === {
//   first: ['__interval_2020-01-01T12:30:11.324Z_2020-02-21T23:59:59.999Z'],
//   second: ['__interval_2019-03-31T23:59:59.999Z_2021'],
//   incorrect: ['__inteval_01.01.2020___relative_-1d']
// }
```
