## JavaScript {#javascript}

### General information {#common}

As a result of executing the JavaScript tab, data required for rendering a measure should be exported.

### Available methods {#available-methods}

* **`ChartEditor.getParams()`**: Returns an object with normalized parameters.

* **`ChartEditor.getLoadedData()`**: Returns an object with data requested in the URLs tab.

### Example {#example}

```js
module.exports = {
    // title (defaults to null)
    title: 'Title',
    content: {
        //current data (required)
        current: {
            // value
            // (defaults to null)
            value: 50.15,
            // unit
            // (defaults to null)
            unit: 'km',
            // text color
            // (defaults to 'black')
            color: 'darkcyan',
            // title
            text: 'Now',
            // using the internal formatter
            // (converts large values into short ones)
            // (defaults to false)
            formatted: true
        },
        // previous data
        last: {
            value: 43.15,
            unit: 'km',
            color: '#ee11aa',
            text: 'Yesterday',
            formatted: false
        },
        // difference
        // (defaults to null)
        // (if diff: {}, the difference is calculated automatically)
        diff: {
            value: 7,
            unit: 'km',
            formatted: false,
            // difference sign
            sign: '+',
            // text color
            // (defaults to 'black'; 'green' if the difference sign is '+'; 'darkred' if the difference sign is '-' )
            color: 'green',
        },
        // difference in percentage
        // (defaults to null)
        // (if diffPercent: {}, the difference in percentage is calculated automatically)
        diffPercent: { // difference in percentage displayed (set manually or automatically if the formatted option is selected)
            value: 16.2,
            unit: '%',
            formatted: false,
            sign: '+',
            color: 'green'
        }
    },
    chart: {
        graphs: [
            {
                // point values
                data: [50.15, 50.03, 49.93, 49.91, 49.84, 50.16, 50.33, 50.29, 50.26, 43.15],
                // line color
                // (defaults to 'black')
                color: '#008800',
                // line type
                // (line, spline, column, area)
                // (defaults to 'line')
                type: 'spline'
            }
        ]
    },
    // background color: 'white')
    background: '#ffdb4d',
    // background color depending on the difference
    // * 'more-green' means that '+' values will be green and '-' values will be red
    // * 'less-green' is vice versa
    // (defaults to null)
    colorize: 'more-green'
}
```
