
# ChartKit

`"@yandex-data-ui/chartkit": "^3.0.0"`

[Yandex Charts](https://charts.yandex-team.ru) script rendering library.

## Installation {#install}

```bash
npm i @yandex-data-ui/chartkit
```

## Dependencies {#dependency}

```
"lego-on-react": "^3.0.0",
"react": "^16.0.0",
"react-dom": "^16.0.0"
```

```
ChartsAPI 5 or higher.
```

### For Wiki text / measure: {#for-indicator}

```
https://yastatic.net/jquery/1.11.0/jquery.min.js
```

### For Wiki text {#for-wiki-text}

[Versions](https://wf.yandex-team.ru/versions)

```
https://yastatic.net/tools-wf/5.0.15/v-5/wf.js
https://yastatic.net/tools-wf/5.0.15/v-5/wf.css
```

## Using {#using}

### Imports {#imports}

* Importing the bundle with
   `lego-on-react`, `@yandex-data-ui/dt100`, `@yandex-data-ui/react-components`.
   `node_modules/@yandex-data-ui/chartkit` must be present in the includes of the style loader.

   ```js
   // Main component with charts
   import ChartKit from '@yandex-data-ui/chartkit/dist/chartkit';
   import '@yandex-data-ui/chartkit/dist/chartkit.css';

   // Additional Highcharts modules
   // highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph
   // annotations, seriesLabel
   // indicators, ema
   import extendHighcharts from '@yandex-data-ui/chartkit/dist/highcharts-extended';
   // Boost (this must be the last imported Highcharts module)
   import boostHighcharts from '@yandex-data-ui/chartkit/dist/highcharts-boost';
   // Tables
   import renderTable from '@yandex-data-ui/chartkit/dist/table';
   import '@yandex-data-ui/chartkit/dist/table.css';
   // Maps
   import renderMap from '@yandex-data-ui/chartkit/dist/map';
   import '@yandex-data-ui/chartkit/dist/map.css';
   // Yandex Maps
   import renderYandexMap from '@yandex-data-ui/chartkit/dist/yandex-map';
   import '@yandex-data-ui/chartkit/dist/yandex-map.css';
   // Metric
   import renderMetric from '@yandex-data-ui/chartkit/dist/metric';
   import '@yandex-data-ui/chartkit/dist/metric.css';
   // Wiki text
   import renderText from '@yandex-data-ui/chartkit/dist/text';
   // Holidays
   import useHolidays from '@yandex-data-ui/chartkit/dist/holidays';

   // Predefined menu elements
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
       EDIT // Edit
   } from '@yandex-data-ui/chartkit/dist/menu-items';
   import '@yandex-data-ui/chartkit/dist/menu-items.css';

   extendHighcharts(ChartKit);
   boostHighcharts(ChartKit);
   renderTable(ChartKit);
   renderMap(ChartKit);
   renderYandexMap(ChartKit);
   renderMetric(ChartKit);
   renderText(ChartKit);
   useHolidays(ChartKit);
   ```

* Importing the source files to avoid a repeat import into the bundle
   `lego-on-react`, `@yandex-data-ui/dt100`, `@yandex-data-ui/react-components`.

   ```js
   // Main component with charts
   import ChartKit from '@yandex-data-ui/chartkit/lib';

   // Additional Highcharts modules
   // highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph
   // annotations, seriesLabel
   // indicators, ema
   import extendHighcharts from '@yandex-data-ui/chartkit/lib/extensions/highcharts-extended';
   // Boost (this Highcharts module is the last to be imported)
   import boostHighcharts from '@yandex-data-ui/chartkit/lib/extensions/highcharts-boost';
   // Tables
   import renderTable from '@yandex-data-ui/chartkit/lib/extensions/table';
   // Maps
   import renderMap from '@yandex-data-ui/chartkit/lib/extensions/map';
   // Yandex Maps
   import renderYandexMap from '@yandex-data-ui/chartkit/lib/extensions/yandex-map';
   // Metric
   import renderMetric from '@yandex-data-ui/chartkit/lib/extensions/metric';
   // Wiki text
   import renderText from '@yandex-data-ui/chartkit/lib/extensions/text';
   // Holidays
   import useHolidays from '@yandex-data-ui/chartkit/lib/extensions/holidays';

   // Predefined menu elements
   import {
       HIDE_COMMENTS, // Hide comments
       SHOW_COMMENTS, // Show comments
       COMMENTS, // Comments
       SCREENSHOT, // Save image
       EXPORT, // Export data
       NEW_WINDOW, // Open in the new window
       OPEN_AS_TABLE, // Open as table
       GET_LINK, // Get a link and code
       SOURCES, // View sources
       EDIT // Edit
   } from '@yandex-data-ui/chartkit/lib/extensions/menu-items';

   extendHighcharts(ChartKit);
   boostHighcharts(ChartKit);
   renderTable(ChartKit);
   renderMap(ChartKit);
   renderYandexMap(ChartKit);
   renderMetric(ChartKit);
   renderText(ChartKit);
   useHolidays(ChartKit);
   ```

### The available properties {#properties}

```js
<ChartKit
    // Yandex Charts script ID
    id="mazayqm22mzil"
    // Path to the Yandex Charts script
    source="/editor/Examples/parametrized-stat-graph"
    // Parameters
    params={{region: 'RU'}}
    // X-Request-ID header prefix
    requestIdPrefix="38671557e7914ecebfaee56181b8a835"
    // Don't show the loader during updates
    silentLoading={true}
    // Or show a simplified loader after 500 ms
    silentLoading={500}
    // Theme modifier
    theme="default"
    // Menu items array
    menu={[
        HIDE_COMMENTS,
        SHOW_COMMENTS,
        COMMENTS,
        SCREENSHOT,
        EXPORT,
        NEW_WINDOW,
        OPEN_AS_TABLE,
        GET_LINK,
        SOURCES,
        EDIT,
        {
            // Title
            title: 'My menu item',
            // Icon
            icon: <svg>...</svg>,
            // Visibility check
            isVisible: ({loadedData, propsData}) => true,
            // Action
            action: ({event, loadedData, propsData, anchorNode}) => {...}
        }
    ]}
    // Callback on end of rendering
    onLoad={({status, requestId, data}) => {
        if (status === 'success') {
            console.log(requestId, data)
        }
        if (status === 'error') {
            console.error(requestId, data);
        }
    }}
/>
```

### Theme description {#theme-description}

Updating the list of repainted elements.

```css
.chartkit_theme_default {
    // loader
    --ck-loader-active-color: #ffcc00;
    --ck-loader-off-color: #ffeba0;

    // chart
    --highcharts-grid-line: #f2f2f2;
    --highcharts-axis-line: #f2f2f2;
    --highcharts-tick: #ccd6eb;

    --highcharts-title: #333333;
    --highcharts-axis-labels: #969696;
    --highcharts-legend-item: #333333;

    --highcharts-holiday-band: #f5f5f5;

    // table
    --color-front: #000000;
    --color-back: #ffffff;
    --color-table-border: #ece9e7;
    --back-table-stripe: rgba(0, 0, 0, 0.03);
    --back-hover: rgba(0, 0, 0, 0.04);
    --back-table-footer: #000000;
}
```

### Settings {#settings}

```js
ChartKit.setSettings({
    // API Yandex Charts
    chartsEndpoint: 'https://charts.yandex-team.ru',
    // Request decorator (currently, only titles can be decorated)
    requestDecorator: request => {
        request.headers['My-Custom-Header'] = Math.random();
        return request;
    },
    // Language
    lang: 'ru',
    // Config of sources (for the sources error and the "View sources" menu item)
    // It will be downloaded (/api/private/fetch) when the page with ChartKit is loaded,
    // It won't be downloaded if the object is false or non-empty
    config: {
        charts: {
            dataEndpoint: 'https://charts.yandex-team.ru',
            description: {
                title: 'Charts'
            }
        }
    },
    // theme
    theme: 'default',
    menu: [
        // The array of the menu items is similar to the menu in the available properties
    ]
});
```
