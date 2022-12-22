## JavaScript {#javascript}

### General information {#common-javascript}

As a result of executing the JavaScript tab, data required for chart rendering should be exported.

### Available methods {#available-methods-javascript}

* **`ChartEditor.getParams()`**: Returns an object with normalized parameters.

* **`ChartEditor.getLoadedData()`**: Returns an object with data requested in the URLs tab.

* **`ChartEditor.updateConfig(config)`**: Extends the definition of the [Config](config.md) tab output with the `config` argument.

* **`ChartEditor.updateHighchartsConfig(config)`**: Extends the definition of the [Highcharts](highcharts.md) tab output with the `config` argument.

### Data formats {#data-formats-javascript}

#### Time series {#time-row-javascript}

If the X-axis shows the **time**, one of the following formats is available:

* `[x, y]`:
   ```js
   // array of series (lines, columns, bands, and so on)
   module.exports = [
       // series description
       {
           // ID
           id: 'identifier',
           // title
           title: Title',
           // points in the order of increasing X
           data: [
               // [x, y]
               [1514764800000, 1],
               [1514851200000, 2],
               [1514937600000, 3]
           ]
       }
   ];
   ```
   **Note**: The Highcharts tab must specify:
   ```js
   module.exports = {
       xAxis: {
           type: 'datetime'
       }
   };
   ```

* `{x: ..., y: ...}`:
   ```js
   // array of series (lines, columns, bands, and so on)
   module.exports = [
       // series description
       {
           // ID
           id: 'identifier',
           // title
           title: 'Title',
           // points in the order of increasing X
           data: [
               {x: 1514764800000, y: 1},
               {x: 1514851200000, y: 2},
               {x: 1514937600000, y: 3}
           ]
       }
   ];
   ```
   **Note**: The Highcharts tab must specify:
   ```js
   module.exports = {
       xAxis: {
           type: 'datetime'
       }
   };
   ```

* `graphs/categories_ms`:
   ```js
   module.exports = {
       // array of series (lines, columns, bands, and so on)
       graphs: [
           // series description
           {
               // ID
               id: 'identifier',
               // title
               title: 'Title',
               // data array
               // each value by index corresponds to a timestamp
               // if there is no value for a certain timestamp, data by this index should contain null
               data: [1, 2, 3]
           }
       ],
       // array of timestamps in ascending order
       categories_ms: [1514764800000, 1514851200000, 1514937600000]
   };
   ```

#### Category series {#category-row-javascript}

If the X-axis shows **text labels**, one of the following formats is available:

* `[x, y]`:
   ```js
   // array of series (lines, columns, bands, and so on)
   module.exports = [
       // series description
       {
           // ID
           id: 'identifier',
           // title
           title: 'Title',
           // points
           data: [
               // [x, y]
               ['Expenses', 1],
               ['Revenue', 2],
               ['Profit', 3]
           ]
       }
   ];
   ```
   **Note**: The Highcharts tab must specify:
   ```js
   module.exports = {
       xAxis: {
           type: 'category'
       }
   };
   ```

* `graphs/categories`:
   ```js
   module.exports = {
       // array of series (lines, columns, bands, and so on)
       graphs: [
           // series description
           {
               // ID
               id: 'identifier',
               // title
               title: 'Title',
               // points
               data: [1, 2, 3]
           }
       ],
       // array of text labels
       categories: ['Expenses', 'Revenue', 'Profit']
   };
   ```

#### Other {#other-javascript}

For other chart types, the following data format is available:

```js
// array of series (lines, columns, bands, and so on)
module.exports = [
    // series description
    {
        // type
        type: 'pie',
        // ID
        id: 'identifier',
        // title
        title: 'Title',
        // points
        // in value array format
        data: [100, 100],
        // in object array format
        /*
        data: [
            {
                name: 'First half',
                y: 100
            },
            {
                name: 'Second half',
                y: 100
            }
        ]
        */
    }
];
```

#### Series description {#description-row-javascript}

You can extend a series description with additional properties:

```js
{
    // type (defaults to 'line')
    type: 'pie',
    // ID
    id: 'identifier',
    // title
    title: 'Title',
    // line color
    color: '#ffeba0',
    // use/do not use the series in a sum
    useInSum: true,
    // precision
    precision: 3
    // line visibility on the chart
    visible: false,
    // points
    data: ...
}
```

See a full list of additional properties (for the corresponding `type`) in the [documentation](https://api.highcharts.com/highcharts/series).

#### Static comments {#static-comments-javascript}

You can add static comments to a chart with a **time series**.

```js
module.exports = {
    graphs: ...
    categories_ms: ...,
    // array of comments
    comments: [
        {
            // comment type: band
            type: 'band-x',
            // interval start in ms
            from: 1514764800000,
            // interval end in ms
            to: 1514851200000,
            // timestamp (for a single-point band)
            // x: 1514937600000,
            // text
            text: 'band from the editor',
            // color
            color: '#f9e79f',
            // whether to show it at chart full height
            visible: true,
        },
        {
            // comment type: flag
            type: 'flag-x',
            // timestamp
            x: 1514764800000,
            // color
            color: '#840f3a',
            // text
            text: 'flag from the editor',
            // shape
            shape: 'flag',
            // height  (enter a negative value to increase the height)
            y: -60
        },
        {
            // comment type: line
            type: 'line-x',
            // timestamp
            x: 1514851200000,
            // dash style
            dashStyle: 'dash',
            // text
            text: 'line from the editor',
            // color
            color: 'red',
            // width
            width: 1
        },
        {
            // comment type: dot
            type: 'dot-x-y',
            // timestamp
            x: 1514937600000,
            // series ID
            graphId: 'all-id-and-fname',
            // tooltip fill color
            fillColor: '#32426d',
            // tooltip text color
            textColor: '#ffff7f',
            // dot color
            color: 'black',
            // text
            text: 'text from the editor',
            // whether to show the tooltip
            visible: true,
        }
    ]
};
```
