
# ChartKit

`"@yandex-data-ui/chartkit": "^5.0.0"`

`"@yandex-data-ui/chartkit": "^6.0.0"`

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

### For Wiki text {#for-wiki-text}

```
https://yastatic.net/jquery/1.11.0/jquery.min.js
https://yastatic.net/tools-wf/5.0.15/v-5/wf.js
https://yastatic.net/tools-wf/5.0.15/v-5/wf.css
```

## Using {#using}

### Imports {#imports}

* Importing the built bundle

   ```js
   // Main component with charts
   import ChartKit from '@yandex-data-ui/chartkit/dist/chartkit';
   import '@yandex-data-ui/chartkit/dist/chartkit.css';

   // Additional Highcharts modules
   // highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph
   // annotations, seriesLabel
   // indicators, ema
   import extendHighcharts from '@yandex-data-ui/chartkit/dist/highcharts-extended';
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
   // Controls
   import renderControl from '@yandex-data-ui/chartkit/dist/control';
   import '@yandex-data-ui/chartkit/dist/control.css';
   // Holidays
   import useHolidays from '@yandex-data-ui/chartkit/dist/holidays';
   // markdown
   import renderMarkdown from '@yandex-data-ui/chartkit/dist/markdown';

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
       EDIT // Edit
   } from '@yandex-data-ui/chartkit/dist/menu-items';
   import '@yandex-data-ui/chartkit/dist/menu-items.css';

   extendHighcharts(ChartKit);
   renderTable(ChartKit);
   renderMap(ChartKit);
   renderYandexMap(ChartKit);
   renderMetric(ChartKit);
   renderText(ChartKit);
   renderControl(ChartKit);
   useHolidays(ChartKit);
   renderMarkdown(ChartKit);
   ```

   * `node_modules/@yandex-data-ui/chartkit` must be present in the includes of the style loader.

   * If you use the `control` extension, then for proper styling of items, you need to add the following:

      ```scss
      // For proper styling of the control extension in ChartKit
      @import '~@yandex-data-ui/common/styles/yc-theme-light.scss';
      @import '~@yandex-data-ui/common/styles/yc-theme-dark.scss';
      @import '~@yandex-data-ui/common/styles/redefine-lego/button/theme/button_theme_flat.scss';

      .class_for_body {
          @include button2_theme_flat;

          &_with_light_theme {
              @include yc-theme-light;
          }

          &_with_dark_theme {
              @include yc-theme-dark;
          }
      }
      ```

   * If you use the `markdown` extension, then for proper styling of items, you need the following:

      ```scss
      // For proper styling of the markdown extension in ChartKit
      @import '~@yandex-data-ui/common/styles/yfm.scss';
      ```

* Importing source files

   ```js
   // Main component with charts
   import ChartKit from '@yandex-data-ui/chartkit/lib';

   // Additional Highcharts modules
   // highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph
   // annotations, seriesLabel
   // indicators, ema
   import extendHighcharts from '@yandex-data-ui/chartkit/lib/extensions/highcharts-extended';
   // Boost (it must be the last imported Highcharts module)
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
   // Controls
   import renderControl from '@yandex-data-ui/chartkit/lib/extensions/control';
   // Holidays
   import useHolidays from '@yandex-data-ui/chartkit/lib/extensions/holidays';
     // markdown
   import renderMarkdown from '@yandex-data-ui/chartkit/lib/extensions/markdown';

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
       EDIT // Edit
   } from '@yandex-data-ui/chartkit/lib/extensions/menu-items';

   extendHighcharts(ChartKit);
   boostHighcharts(ChartKit);
   renderTable(ChartKit);
   renderMap(ChartKit);
   renderYandexMap(ChartKit);
   renderMetric(ChartKit);
   renderText(ChartKit);
   renderControl(ChartKit);
   useHolidays(ChartKit);
   renderMarkdown(ChartKit);
   ```

   * If you use the `control` extension, then for proper styling of items, you need to add the following:

      ```scss
      // For proper styling of the control extension in ChartKit
      @import '~@yandex-data-ui/common/styles/yc-theme-light.scss';
      @import '~@yandex-data-ui/common/styles/yc-theme-dark.scss';
      @import '~@yandex-data-ui/common/styles/redefine-lego/button/theme/button_theme_flat.scss';

      .class_for_body {
          @include button2_theme_flat;

          &_with_light_theme {
              @include yc-theme-light;
          }

          &_with_dark_theme {
              @include yc-theme-dark;
          }
      }
      ```

   * If you use the `control` extension, then to display icons properly in the components,
      you need to add dependencies, for example, `svg-sprite-loader` and a rule for `webpack`:
      ```js
      {
          test: /@yandex-data-ui\/common\/.*\.svg$/,
          loader: 'svg-sprite-loader'
      }
      ```

   * If you use the `markdown` extension, then for proper styling of items, you need the following:

      ```scss
      // For proper styling of the markdown extension in ChartKit
      @import '~@yandex-data-ui/common/styles/yfm.scss';
      ```

### The available properties {#properties}

```js
<ChartKit
    // ID of the Yandex Charts script
    id="mazayqm22mzil"
    // Parameters
    params={{region: 'RU'}}
    // Prefix of the X-Request-ID header
    requestIdPrefix="38671557e7914ecebfaee56181b8a835"
    // Don't show a loader on refresh
    silentLoading={true}
    // or show a loader after 500 ms
    silentLoading={500}
    // Show a small loader in the upper-right corner instead of a standard loader in the center
    compactLoader={true}
    // Set to true if you use the component when the scroll is not in the body (or when
    // the component isn't in-sync with the scroll, for example, it's is inside a modal window)
    nonBodyScroll={false}
    // Theme modifier
    theme="light"
    // Array of menu items
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
            // viewability check
            isVisible: ({loadedData, propsData}) => true,
            // Action
            action: ({event, loadedData, propsData, anchorNode}) => {...}
        }
    ]}
    // Callback on the end of rendering
    onLoad={({status, requestId, data}) => {
        if (status === ChartKit.STATUS.SUCCESS) {
            console.log(requestId, data)
        }
        if (status === ChartKit.STATUS.ERROR) {
            console.error(requestId, data);
        }
    }}
    // Callback on the beginning of rendering
    onLoadStart={() => console.log('Loading started')}
/>
```

### Theme description {#theme-description}

Updating the list of repainted elements.

```css
.chartkit_theme_light {
    // loader
    --ck-loader-active: #027bf3;
    --ck-loader-inactive: rgba(2, 123, 243, 0.14);

    // loader veil
    --ck-veil-background: rgba(255, 255, 255, 0.35);

    // block background with controls
    --ck-controls-backgound: rgba(0, 0, 0, 0.04);

    // measure
    --ck-metric-title: #000000;
    --ck-metric-value: #027bf3;

    // navigator
    --highcarts-navigator-border: rgba(0, 0, 0, 0.07);
    --highcarts-navigator-track: #fafafa;
    --highcarts-navigator-body: rgba(0, 0, 0, 0.2);

    // chart
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

    --highcharts-holiday-band: rgba(0, 0, 0, 0.04);

    // tooltip
    --highcharts-tooltip-text: #000000;
    --highcharts-tooltip-text-complementary: rgba(0, 0, 0, 0.7); // additional text color, in particular for sum
    --highcharts-tooltip-bg: rgba(255, 255, 255, 0.94);
    --highcharts-tooltip-alternate-bg: rgba(0, 0, 0, 0.04); // background color of even lines in tooltip

    // table
    --data-table-color-base: #ffffff;
    --data-table-color-stripe: #fafafa;
    --data-table-border-color: rgba(0, 0, 0, 0.15);
    --data-table-color-hover-area: rgba(0, 0, 0, 0.04);
    --data-table-color-footer-area: var(--data-table-color-base);
}
```

### Settings {#settings}

```js
ChartKit.setSettings({
    // Yandex Charts API
    chartsEndpoint: 'https://charts.yandex-team.ru',
    // Request decorator
    // You can decorate the headers - request.headers and the request body - request.data
    requestDecorator: (request) => {
        request.headers['My-Custom-Header'] = Math.random();
        return request;
    },
    // Function to generate the X-Request-ID header
    requestIdGenerator: (requestIdPrefix) => Math.random(),
    // Prefix of the X-Request-ID header
    requestIdPrefix: '38671557e7914ecebfaee56181b8a835',
    // Language
    lang: 'ru',
    // Config of sources (for the error about sources and the "View sources" menu item)
    // If true, it will be downloaded from /api/private/fetch when loading a page with ChartKit
    config: {
        charts: {
            dataEndpoint: 'https://charts.yandex-team.ru',
            description: {
                title: 'Charts'
            }
        }
    },
    // Theme
    theme: 'light',
    menu: [
        // Array of menu items, similar to menu in the available properties
    ],
    // For example, it changes the logic of tooltip positioning
    // In portrait orientation on mobile devices, the tooltip will be shown above the chart
    isMobile: true
});
```
