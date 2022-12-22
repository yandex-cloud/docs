## JavaScript {#javascript}

### General information {#common}

As a result of executing the JavaScript tab, data required for rendering a table should be exported.

### Available methods {#available-methods}

* **`ChartEditor.getParams()`**: Returns an object with normalized parameters.

* **`ChartEditor.getLoadedData()`**: Returns an object with data requested in the URLs tab.

* **`ChartEditor.updateConfig(config)`**: Extends the definition of the [Config](#config) tab output with the `config` argument.

### Example {#example}

```js
// describe the table head
const head = [
    {
        // ID
        id: 'uid',
        // title
        name: 'Text',
        // type: text
        type: 'text',
        // group into a single cell all identical successive cells in a column
        group: false,
    },
    {
        id: 'date',
        name: 'Date',
        // type: date (in ms)
        type: 'date',
        // date output format
        // (the time will be in the browser time zone)
        format: 'DD/MM/YY HH:mm:ss',
        // group into a single cell all identical successive cells in a column
        group: true,
    },
    // column with a two-level head
    {
        name: 'Two-level head',
        // subsections
        sub: [
            {
                id: 'number',
                name: 'Number',
                // type: number
                type: 'number',
                // formatting
                formatter: {
                    // suffix
                    suffix: '%',
                    // prefix
                    prefix: '#',
                    // multiplier
                    multiplier: 100,
                    // precision
                    precision: 0
                },
                // precision, a short entry
                // precision: 2,
                // group into a single cell all identical successive cells in a column
                group: false,
            },
            {
                id: 'diff',
                name: 'Difference',
                // type: difference
                type: 'diff_only',
                // formatting
                diff_formatter: {
                    // suffix
                    suffix: '@',
                    // prefix
                    prefix: '№',
                    // multiplier
                    multiplier: 0.1,
                    // precision
                    precision: 2
                },
                // precision, a short entry
                // precision: 2
                // group into a single cell all identical successive cells in a column
                group: false,
            }
        ]
    },
    {
        id: 'number-diff',
        name: 'Number and difference',
        // type: number and difference
        type: 'diff',
        // number formatting
        formatter: {multiplier: 100},
        // difference formatting
        diff_formatter: {multiplier: 100},
        // precision, a short entry
        // precision: 2
        // group into a single cell all identical successive cells in a column
        group: false,
    }
];

// describe table rows
const rows = [
    // a short entry, only the values of the types corresponding to the columns
    {
        values: ['Google', 1524260756186, 0.01, 16, [-2, -4]]
    },
    // a detailed entry
    {
        cells: [
            {
                // value matching the column type
                value: 'Yandex',
                // link (for columns with "type: 'text'")
                link: {
                    // url
                    href: 'https://yandex.ru',
                    // open in a new window
                    newWindow: true
                },
                // cell CSS styles
                css: {'font-size': '16px'}
            },
            {
                value: 1524260756186,
                // action to be performed upon a click on a cell
                onClick: {
                    // action type
                    // possible values: setParams
                    action: 'setParams',
                    // static arguments
                    args: {
                        min: 1524260578346
                    }
                },
            },
            {
                value: 0.2,
                css: {color: 'blue'}
            },
            {
                value: -128
            },
            {
                value: [32, 16],
                css: {'background-color': '#999' }
            }
        ]
    }
];

// In a way similar to rows, describe the table footer
const footer = [
    // a short entry, only the values of the types corresponding to the columns
    {
        values: ['Total', null, 0.21, -112, [30, 12]]
    },
    // a detailed entry
    {
        cells: [
            {
                // value matching the column type
                value: 'Total',
                // link (for columns with "type: 'text'")
                link: {
                    // url
                    href: 'https://yandex.ru',
                    // open in a new window
                    newWindow: true
                },
                // cell CSS styles
                css: {'font-size': '16px'}
            },
            {
                value: ''
            },
            {
                value: 0.21,
                css: {color: 'blue'}
            },
            {
                value: -112
            },
            {
                value: [30, 12],
                css: {'background-color': '#999' }
            }
        ]
    }
];

module.exports = {
    head: head,
    rows: rows,
    footer: footer
};
```
