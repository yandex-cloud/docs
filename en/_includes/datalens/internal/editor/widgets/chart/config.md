## Config {#config}

### General information {#common-config}

As a result of executing the Config tab, data responsible for additional display
configuration should be exported.

### Example {#example-config}

```js
module.exports = {
    // a chart of the Higcharts type or any custom type
    // 'stack' - stacked areas
    // 'stacked_column' - stacked columns
    // 'stacked_100p' - Stacked areas with a scale of 100%
    // 'stacked_column_100p' - Stacked columns with a scale of 100%
    type: 'line',
    // whether to show %% in the tooltip (relevant for chart types such as 'pie', 'funnel', and 'solidgauge' and charts with stack: 'normal')
    showPercentInTooltip: true,
    // number of decimal places for percentage values in the tooltip (relevant if showPercentInTooltip: true)
    tooltipPercentPrecision: 2, // defaults to 1
    // series sorting: 'byLastValue' by the last value, 'alphabet' by alphabet
    // series are displayed in the order they're set by default
    orderType: 'byLastValue',
    // series sorting direction: 'fromTop is a direct order, 'fromBottom' is a reverse order.
    orderSort: 'fromBottom',
    // hide comments when loading
    hideComments: true,
    // enable a sum in the tooltip
    // enabled by default for types such as 'stack', 'stacked_100p', 'stacked_column', 'stacked_column_100p'
    // the series to be included in the sum are set by the series property 'useInSum: true'
    enableSum: true,
    // round values
    precision: 2,
    // remove the "Hide all series" button
    removeShowHideAll: true,
    // remove vertical gray bars for weekends and holidays
    hideHolidaysBands: true,
    // don't overlay the chart with controls
    notOverlayControls: true,
    // navigator bar settings
    highstock: {
        // navigator's minimum start position in ms
        range_min : 1510458756080,
        // navigator's maximum start position in ms
        range_max : 1518458756080,
        // name of the series to be displayed in the navigator
        base_series_name: 'hits'
    },
    // comments settings
    comments: {
        // significant parameters are the names of chart parameters whose values will be factored in when generating a comment
        // (significant parameters are the basis for building the comment segment)
        matchedParams: ['service'],
        // method for matching comment parameters and significant parameters:
        // 'full' means full match of the parameters,
        // 'contains' means the comment parameters are a subset of the significant parameters
        // (defaults to 'full')
        // example:
        //     - chart parameters: {region: 'RU', scale: 'd', service: 'charts'}
        //     - significant parameters: ['region', 'scale']
        //     - 'full' matching method:
        //         - a comment with parameters {region: 'RU', scale: 'd'} is included in the list
        //         - a comment with parameters {region: 'RU'} is not included in the list
        //     - 'contains' matching method:
        //         - a comment with parameters {region: 'RU', scale: 'd'} is included in the list
        //         - a comment with parameters {region: 'RU'} is included in the list
        matchType: 'contains',
        // feed array
        // always contains {feed: <current chart's name>, matchedParams: <described above>}
        feeds: [
            {
                // feed name
                // (the name should be as unique as possible to avoid collissions)
                feed: 'service/login/regions',
                matchedParams: ['region']
            },
            {
                feed: 'service/login/versions'
            }
        ],
        // show comments that don't get in the current scale of the chart
        // (defaults to false)
        ignoreScale: false
    },
    // override information displayed in the tooltip (defaults to null)
    manageTooltipConfig: function (config, chart) {
        // an array with a series
        config.lines.forEach(function (line) {
            // a prefix
            line.valuePrefix = '-';
            // a suffix
            line.valueSuffix = 'kg';

            line.commentText = 'Comment on the line';

            // change the value (using division in this example)
            line.value = Highcharts.numberFormat(line.originalValue / 100, 1);
        });

        // configure a sum of series
        config.sum = 100;

        config.commentDateText = 'Comment on the date';

        // return overridden information
        return config;
    }
};
```

#### Additional features for overriding a tooltip {#additional-options-tooltip-config}
In addition to methods for overriding [pointFormat](https://api.highcharts.com/highcharts/tooltip.pointFormat)
 and [pointFormatter](https://api.highcharts.com/highcharts/tooltip.pointFormat) tooltip lines (see an [example](https://datalens-staging.yandex-team.ru/editor/5xzcv2k7ler61-tooltip-pointformat-example)), which are standard for Highcharts, two additional methods are supported at the [ChartKit](https://github.yandex-team.ru/data-ui/chartkit)
 library level, which can be set in the Config tab: ```replaceCellAt``` lets you override an individual cell rather than the entire line and ```insertCellAt``` lets you add
an additional cell:
* ```replaceCellAt``` accepts an object where the key is the index of the cell to override and the value is a string or function that returns a string that will be rendered in the position of the
   overriden cell.
* ```insertCellAt``` accepts an object where the key is the index in place of which a new cell will be inserted with the existing cells moved and the value is a string or function that returns a string  
   that will be rendered in the cell added.

**Example:**
For most visualization types, a data string in a tooltip consists of three cells: color, name, and value. For example, we're going to override the color cell by
increasing its size and adding the `new` text atop in some cases and want to add a new cell with the name and value to output additional information to. Below is the code
you need to implement this and a [link to an example in Chart Editor](https://datalens.yandex-team.ru/editor/kbyezcqk81xgg-tooltip-customization-example?_t=graph).
```js
module.exports = {
    // overriding the first cell that shows the line color
    replaceCellAt: {
        "0": function(data) {
            return (
                `<td>
                    <div style="background-color: ${data.seriesColor}; width: 32px; height: 16px; text-align: center; color: white; line-height: 16px">
                        ${data.isNew > 0.5 ? 'new' : ''}
                    </div>
                </td>`
            );
        },
    },
    // inserting a new cell between the name and value
    insertCellAt: {
        "2": function(data) {
            return (
                `<td>
                    ${data.note}
                </td>`
            );
        },
    },
};
```
