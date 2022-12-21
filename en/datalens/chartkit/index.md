# ChartKit

[![npm version](https://badger.yandex-team.ru/npm/@yandex-data-ui/chartkit/version.svg)](https://npm.yandex-team.ru/@yandex-data-ui/chartkit)

[Yandex Charts](https://charts.yandex-team.ru) script rendering library.

## Installation {#install}

```bash
npm i @yandex-data-ui/chartkit
```

## Dependencies {#dependency}

```
"lego-on-react": "^3.0.0",
"react": "^16.8.0",
"react-dom": "^16.8.0"
"react-router-dom": "^5.0.0" // If the additional control module is imported
```

## To report a problem {#bug-report}

To report an error or suggest an improvement, follow the [link](https://st.yandex-team.ru/createTicket?queue=CHARTS&components%5B%5D=43028&followers%5B%5D=1120000000020711&followers%5B%5D=1120000000046495&followers%5B%5D=1120000000167368&priority=2&type=2).

## Using {#using}

### Imports {#imports}

#### Built bundle {#bundle}

* `node_modules/@yandex-data-ui/chartkit` must be present in the includes of the style loader.

```js
// Common part
import '@yandex-data-ui/chartkit/lib/commons';
import '@yandex-data-ui/chartkit/lib/commons.css';

// Main component with charts
import ChartKit from '@yandex-data-ui/chartkit/lib/chartkit';

// Additional Highcharts modules
// highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph
// annotations, seriesLabel
// indicators, ema
import extendHighcharts from '@yandex-data-ui/chartkit/lib/highcharts-extended';
// Tables
import renderTable from '@yandex-data-ui/chartkit/lib/table';
import '@yandex-data-ui/chartkit/lib/table.css';
// Maps
import renderMap from '@yandex-data-ui/chartkit/lib/map';
import '@yandex-data-ui/chartkit/lib/map.css';
// Yandex Maps
import renderYandexMap from '@yandex-data-ui/chartkit/lib/yandex-map';
import '@yandex-data-ui/chartkit/lib/yandex-map.css';
// Metric
import renderMetric from '@yandex-data-ui/chartkit/lib/metric';
// Controls
import renderControl from '@yandex-data-ui/chartkit/lib/control';
import '@yandex-data-ui/chartkit/lib/control.css';
// Holidays
import useHolidays from '@yandex-data-ui/chartkit/lib/holidays';
// markdown
import renderMarkdown from '@yandex-data-ui/chartkit/lib/markdown';
import '@yandex-data-ui/chartkit/lib/markdown.css';

// Predefined menu items
import {
  HIDE_COMMENTS, // Hide comments
  SHOW_COMMENTS, // Show comments
  COMMENTS, // Comments
  SCREENSHOT, // Save image
  EXPORT, // Export data
  NEW_WINDOW, // Open in a new window
  OPEN_AS_TABLE, // Open as a table
  GET_LINK, // Get a link and code
  SOURCES, // View sources
  EDIT, // Edit,
  Inspector, // Timings of loading/rendering and information about sources
} from '@yandex-data-ui/chartkit/lib/menu-items';
import '@yandex-data-ui/chartkit/lib/menu-items.css';

ChartKit.registerPlugins(
  renderTable,
  renderMap,
  renderYandexMap,
  renderMetric,
  renderControl,
  renderMarkdown,
  useHolidays,
);

extendHighcharts(ChartKit);
```

#### Source files {#files}

* If the additional module `control` is used, then to display icons properly in the components,
   you need to add dependencies, for example, `svg-sprite-loader` and the following rule for `webpack`:

   ```js
   {
       test: /@yandex-data-ui\/common\/.*\.svg$/,
       loader: 'svg-sprite-loader'
   }
   ```

```js
// Main component with charts
import ChartKit from '@yandex-data-ui/chartkit';

// Additional Highcharts modules
// highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph
// annotations, seriesLabel
// indicators, ema
import extendHighcharts from '@yandex-data-ui/chartkit/build/extensions/highcharts-extended';
// Tables
import renderTable from '@yandex-data-ui/chartkit/build/extensions/table';
// Maps
import renderMap from '@yandex-data-ui/chartkit/build/extensions/map';
// Yandex Maps
import renderYandexMap from '@yandex-data-ui/chartkit/build/extensions/yandex-map';
// Metric
import renderMetric from '@yandex-data-ui/chartkit/build/extensions/metric';
// Controls
import renderControl from '@yandex-data-ui/chartkit/build/extensions/control';
// markdown
import renderMarkdown from '@yandex-data-ui/chartkit/build/extensions/markdown';
// Holidays
import useHolidays from '@yandex-data-ui/chartkit/build/extensions/holidays';

// Predefined menu items
import {
  HIDE_COMMENTS, // Hide comments
  SHOW_COMMENTS, // Show comments
  COMMENTS, // Comments
  SCREENSHOT, // Save image
  EXPORT, // Export data
  NEW_WINDOW, // Open in a new window
  OPEN_AS_TABLE, // Open as a table
  GET_LINK, // Get a link and code
  SOURCES, // View sources
  EDIT, // Edit
  Inspector, // Timings of loading/rendering and information about sources
} from '@yandex-data-ui/chartkit/build/extensions/menu-items';

ChartKit.registerPlugins(
  renderTable,
  renderMap,
  renderYandexMap,
  renderMetric,
  renderControl,
  renderMarkdown,
  useHolidays,
);

extendHighcharts(ChartKit);
```

### Styling {#style}

**Important**: All the new features are developed with the requirement that `<ChartKit/>` will be used together with [`<ThemeProvider/>`](https://github.yandex-team.ru/data-ui/common/tree/master/src/components/theme):

```jsx
import {ThemeProvider} from '@yandex-data-ui/common';

<ThemeProvider theme="light">
  <ChartKit .../>
</ThemeProvider>
```

If you use the additional module `control` or the predefined `Inspector` menu item,
then make sure to use [`<ThemeProvider/>`](https://github.yandex-team.ru/data-ui/common/tree/master/src/components/theme) together with `<ChartKit/>`.

#### Theme description {#theme-description}

**DEPRECATED**: This method is deprecated and won't be supported in the next major version.
Use [`<ThemeProvider/>`](https://github.yandex-team.ru/data-ui/common/tree/master/src/components/theme).

**Important**: If you use different names for themes, then changing a theme by calling `ChartKit.setGeneralSettings`
with a new `theme` value or updating `theme` in `props` will fully apply only when the component is re-rendered.
This is because the new values must be defined explicitly in the Highcharts config.
We recommend using the same name for a theme, but with CSS variables that take upon new values, for example, when changing
the class to `body`

**Important**: CSS variables of a custom theme or the theme itself (if CSS variables aren't used) must be defined inside the `body`.
For example, because the Highcharts tooltip is rendered in `body`.

```css
.chartkit-theme_custom {
    // Loader veil
    --ck-veil-background: rgba(255, 255, 255, 0.35);

    // Background of the controls block
    --ck-controls-backgound: rgba(0, 0, 0, 0.04);

    // Metric
    --ck-metric-title: #000000;
    --ck-metric-value: #027bf3;

    // Navigator
    --highcarts-navigator-border: rgba(0, 0, 0, 0.07);
    --highcarts-navigator-track: #fafafa;
    --highcarts-navigator-body: rgba(0, 0, 0, 0.2);

    // Chart
    --highcharts-series-border: #ffffff;

    --highcharts-grid-line: rgba(0, 0, 0, 0.07);
    --highcharts-axis-line: rgba(0, 0, 0, 0.07);
    --highcharts-tick: rgba(0, 0, 0, 0.07);

    --highcharts-title: #000000;
    --highcharts-axis-labels: rgba(0, 0, 0, 0.5);
    --highcharts-data-labels: rgba(0, 0, 0, 0.7);
    --highcharts-plot-line-label: rgba(0, 0, 0, 0.7);

    --highcharts-legend-item: rgba(0, 0, 0, 0.5);
    --highcharts-legend-item-hover: #000000;
    --highcharts-legend-item-hidden: rgba(0, 0, 0, 0.3);

    // For "floating" items, for example, a legend and a tooltip
    --highcharts-floating-bg: rgba(255, 255, 255, 0.95);

    // Holiday band
    --highcharts-holiday-band: rgba(0, 0, 0, 0.05);

    // Tooltip
    --highcharts-tooltip-text: #000000;
    --highcharts-tooltip-text-complementary: rgba(0, 0, 0, 0.7); // Complementary text color, for example, for the amount
    --highcharts-tooltip-bg: var(--highcharts-floating-bg);
    --highcharts-tooltip-alternate-bg: rgba(0, 0, 0, 0.04); // Background color of even lines in the tooltip

    // Table
    --data-table-color-base: #ffffff;
    --data-table-color-stripe: #fafafa;
    --data-table-border-color: rgba(0, 0, 0, 0.15);
    --data-table-color-hover-area: rgba(0, 0, 0, 0.04);
    --data-table-color-footer-area: var(--data-table-color-base);

    // Yandex Maps
    --ck-ymap-chips-label-color: #ffffff;
}
```

### The available properties {#properties}

```jsx
<ChartKit
    // ID of the Yandex Charts script
    id="mazayqm22mzil"
    // Parameters
    params={{region: 'RU'}}
    // X-Request-ID header prefix
    requestIdPrefix="38671557e7914ecebfaee56181b8a835"
    // Show a small loader in the upper-right corner instead of the standard centered loader
    compactLoader={true}
    // Hide the loader
    noLoader={false}
    // Show the loader after a delay of 500 ms
    loaderDelay={500}
    // Set to true when you use the component but the scroll isn't in the body (or
    // the component isn't in-sync with the scroll, for example, it's inside a modal window)
    nonBodyScroll={false}
    // a mix for the chartkit__body of the node for overriding styles, isn't transmitted by default
    widgetBodyClassName="class-name-mix"
    // Deferred initialization: when set to true, the chart is loaded only if it's within the viewport area
    // or near the viewport area, defaults to false
    deferredInitialization={false}
    // Size (in pixels) of the area below the viewport that, when the widget gets into it, initiates loading the widget; applies when
    // deferredInitialization={true}, defaults to window.innerHeight
    deferredInitializationMargin={window.innerHeight}
    // Theme modifier
    theme="common"
    // Array of menu items
    menu={[
        HIDE_COMMENTS, // Hide comments
        SHOW_COMMENTS, // Show comments
        COMMENTS, // Comments
        SCREENSHOT, // Save image
        EXPORT, // Export data
        NEW_WINDOW, // Open in a new window
        OPEN_AS_TABLE, // Open as a table
        GET_LINK, // Get a link and code
        SOURCES, // View sources
        EDIT, // Edit
        Inspector, // Timings of loading/rendering and information about sources
        {
            // Title
            title: 'My menu item',
            // icon
            icon: <svg>...</svg>,
            // Visibility check
            isVisible: ({loadedData, propsData}) => true,
            // Action
            action: ({event, loadedData, propsData, anchorNode}) => {...}
        }
    ]}
    // Callback on the end of rendering
    onLoad={({status, requestId, data}) => {
        if (status === 'success') {
            console.log(requestId, data)
        }
        if (status === 'error') {
            console.error(requestId, data);
        }
    }}
    // Callback on the beginning of rendering
    onLoadStart={() => console.log('Loading started')}
/>
```

### General settings {#main-settings}

```jsx
ChartKit.setGeneralSettings({
    // Function to generate an X-Request-ID header
    requestIdGenerator: (requestIdPrefix) => Math.random(),
    // Prefix of the X-Request-ID header
    requestIdPrefix: '38671557e7914ecebfaee56181b8a835',
    // Language
    lang: 'ru',
    // Config of sources (for the error about sources and the "View sources" menu item)
    // If true, it will be downloaded from /api/private/fetch when loading the page with ChartKit
    config: {
        charts: {
            dataEndpoint: 'https://charts.yandex-team.ru',
            description: {
                title: 'Charts'
            }
        }
    },
    // Theme
    theme: 'common',
    menu: [
        // Menu elements menu similar to the menu in the available properties
    ],
    // For example, the logic of tooltip positioning is changed
    // On mobile devices, in the portrait orientation, the tooltip will be shown above the chart
    isMobile: true,
    // Component for displaying errors
    ErrorComponent: ({error}) => <div>{error.message}</div>,
});
```

### Charts data provider settings {#provider-settings}

```js
ChartKit.setDataProviderSettings({
    // Charts API host, string array is supported
    endpoint: 'https://charts.yandex-team.ru',
    // language
    lang: 'ru',
    // Request decorator
    // You can decorate request.headers and the request body - request.data
    requestDecorator: (request) => {
        request.headers['My-Custom-Header'] = Math.random();
        return request;
    },
    // API won't return logs
    includeLogs: false,
    // Use JSON.parse instead of JSONfn.parse
    noJsonFn: false,
    // Restricting the maximum number of parallel requests for the chart data, if not specified,
    // the browser's default restrictions are used
    maxConcurrentRequests: 6,
    // Don't retry the API request that returned error 5xx
    noRetry: false,
});
```

### Data Provider {#data-provider}

```jsx
import {ChartKitBase} from '@yandex-data-ui/chartkit';

<ChartKitBase
    id="1"
    dataProvider={{
        // Get the tocken that can be used to cancel current requests
        getRequestCancellation: () => axios.CancelToken.source(),
        // Cancel current requests
        cancelRequests: (requestCancellation) => {
            if (requestCancellation) {
                requestCancellation.cancel('REQUEST_CANCELED');
            }
        },
        // Compare the current and new props
        isEqualProps: lodash.isEqual,
        // Get the widget data to be rendered
        getWidget: () => {
            return {
                type: 'graph',
                data: [{
                    data: [
                        [1558915200000, 1165523823],
                        [1559520000000, 1133116710],
                        [1560124800000, 1123291656],
                    ],
                }],
                libraryConfig: {
                    xAxis: {
                        type: 'datetime',
                        endOnTick: false,
                        startOnTick: false
                    },
                },
            };
        },
    }}
/>
```
