---
title: Advanced chart
description: In this article, you will learn about advanced charts in {{ datalens-full-name }}.
---

# Advanced chart

{% include [business-note](../../../../_includes/datalens/datalens-functionality-available-business-note.md) %}

With this type of visualization, you can create HTML with secure markup using the [Editor.generateHtml(args)](../methods.md#gen-html) function and flexible SVG visualizations using the `d3`, `d3-chord`, and `d3-sankey` libraries.

On the **Prepare** tab, you need to create a structure:

```js
module.exports = {
    render: Editor.wrapFn(...),
};
```

Learn more about the [Editor.wrapFn](../methods.md#wrap) method.

{% note info %}

Advanced charts are slower than other visualizations. We recommend using them only when required, e.g., where regular charts fall short.

{% endnote %}

## Getting started with advanced charts {#begin}

1. To render a chart, define the `render` function:

    ```js
    module.exports = {
        render: Editor.wrapFn({
            fn: function() {
                return 'Hello, world!';
            },
        })
    };
    ```

1. Add the required markup:

    ```js
    module.exports = {
        render: Editor.wrapFn({
            fn: function() {
                const content = 'Hello, world!';
    
                return Editor.generateHtml(`
                  <div style="display: flex; background: black;">
                    ${content}
                  </div>
                `);
            },
        })
    };
    ```

1. To use data from the server, set up the arguments and provide them to the function:

    ```js
    // Prepare the data for chart rendering.  
    const content = 'Hello, world!';
    
    module.exports = {
        render: Editor.wrapFn({
	    // The first argument will always contain the chart parameters.
	    // The variables from `args` come next.
            fn: function(options, content) {
                const {width, height} = options;
    
                return Editor.generateHtml(`
                  <div style="width: ${width}; height: ${height}">
                    ${content}
                  </div>
                `);
            },
            args: [content],
        })
    };
    ```

To reduce the client's browser load, we recommend sorting and grouping data before sending it to the `render` function.

## Connecting third-party libraries {#outer-libs}

You can add third-party libraries to the chart function using the `libs` parameter in `wrapFn`:

```js
module.exports = {
    render: Editor.wrapFn({
        fn: function(options) {
            const {width, height} = options;
            const element = d3.create('svg')
                .attr('width', width)
                .attr('height', height);

            element
                .append('g')
                .append('text')
                    .text('Hello, world!')
                    .style('alignment-baseline', 'before-edge');

            return Editor.generateHtml(element.node());
        },
        libs: ['d3'],
    })
};
```

Available libraries:

```
'date-utils@2.3.0'
'date-utils@2.5.3' (alias: 'date-utils')
'd3@7.9.0' (alias: 'd3')
'd3-chord@3.0.1' (alis: 'd3-chord')
'd3-sankey@0.12.3' (alias: 'd3-sankey')
```

## Available methods {#methods}

The entire advanced chart code runs in a QuickJs-based sandbox, limiting access to browser API methods and the DOM. Synthetic `document` elements which are not connected to the external environment are available to work with the element tree.

To facilitate data management internally, extra methods are supported:

```js
// Equivalent of browser `console.log` for code debugging
console.log(..args: unknown[])

/ Equivalent of browser `setTimeout` and `clearTimeout`
setTimeout: (handler: TimerHandler, timeout: number)
clearTimeout(timeoutId)

// For working with HTML
// When returning a string from a function without wrapping it in `generateHtml`, the data will be escaped.
Editor.generateHtml(value: string | object)

// In a chart, you can declare additional parameters that will affect the display, e.g., when working with events. 
// State management methods:
// Getting the chart state
Chart.getState()
// Updating the chart state
// Calling the method will run the `render` method. To update the state without re-rendering, include {silent: true} as the second argument.
Chart.setState(state: object, options?: {silent: boolean})

// Setting parameters
Editor.updateParams(params)

// Setting cross-filtering parameters. To learn more, see the chart cross-filtering section.
Editor.updateActionParams(params)
```

## Events {#actions}

Available events:

```js
events: {
    click: Editor.wrapFn({
        fn: function(event) {
            ...
        },
    }),
    keydown: Editor.wrapFn({
        fn: function(event) {
            ...
        },
    }),
},
```

## Tooltip {#tooltip}

Here is an example:

```js
module.exports = {
    render: Editor.wrapFn({
        fn: function() {
            ...
        },
    }),
    tooltip: {
        renderer: Editor.wrapFn({
            fn: function(event, config) {
                const name = event.target?.getAttribute('data-id');

                if (!name) {
                    return null;
                }

                const item = config.chartData.data.find((d) => d.name === name);
                return Editor.generateHtml(`<div style="padding: 20px;">${item.name}</div>`);
            },
            args: [chartConfig],
        }),
    }
};
```

## Chart cross-filtering {#chart-chart-filtration}

Here is an example:

```js
const chartData = [{id: '1', OrderYear: '2024'}];
```

```js
render: Editor.wrapFn({
    fn: function(dimensions, data) {
        ...
            svg.append("g")
                .selectAll()
                .data(data)
                .enter().append('rect')
                .attr('data-id', (d) => d.id)
        ...
    },
    args: [chartData],
    libs: ['d3'],
}),
events: {
        click: Editor.wrapFn({
            fn: function(event, data) {
                const dataId = event.target.getAttribute('data-id');
                const selectedItem = data.find(d => d.id === dataId);

                if (selectedItem) {
                    Chart.updateActionParams({OrderYear: selectedItem.OrderYear});
                }
            },
            args: [chartData],
        }),
    },
...
```

## Examples {#examples}

Examples on the [demo dashboard](https://datalens.yandex/2aztx9jtm06ko?tab=Az) in the Advanced tab.
