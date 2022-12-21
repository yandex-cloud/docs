
# ChartKit

[![npm version](https://badger.yandex-team.ru/npm/yandex-chartkit/version.svg)](https://npm.yandex-team.ru/yandex-chartkit)

[Yandex Charts](https://charts.yandex-team.ru) script rendering library.

## Installation {#install}

```bash
npm i yandex-chartkit
```

## Dependencies {#dependency}

```
"islands": "^5.13.0",
"react": ">15.6.0",
"react-dom": ">15.6.0"
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

## Adding to a build {#connection-to-build}

This is to avoid duplicating `islands` in the final bundle.

### When using `"react-build-utils": "^0.15.5"` {#react-build-utils}

**DEPRECATED**

```js
const webpack = require('webpack');
const createConfig = require('@yandex-data-ui/react-build-utils/create-config');

module.exports = createConfig({
    ...
    includePaths: [
        ...
        './node_modules/@yandex-data-ui/react-components',
        './node_modules/dt100', // if you use tables
        './node_modules/yandex-chartkit',
    ],
    bemLevels: [
        ...
        './node_modules/@yandex-data-ui/react-components/lib/blocks',
        './node_modules/@yandex-data-ui/react-components/lib/components',
        './node_modules/yandex-chartkit/src/blocks'
    ]
});
```

### When using `"webpack-levels": "^0.4.0"` {#webpack-levels}

```js
const webpack = require('webpack');
const {ConfigBuilder, defaultLevel} = require('webpack-levels');

const configBuilder = new ConfigBuilder();

configBuilder.use(defaultLevel({
    ...
    rulesInclude: [
        ...
        './node_modules/@yandex-data-ui/react-components',
        './node_modules/dt100', // if you use tables
        './node_modules/yandex-chartkit',
    ],
    levels: [
        ...
        './node_modules/@yandex-data-ui/react-components/lib/blocks',
        './node_modules/@yandex-data-ui/react-components/lib/components',
        './node_modules/yandex-chartkit/src/blocks'
    ]
}));

module.exports = configBuilder.toJS();
```

### In other cases (`"webpack": "*"`) {#webpack}

Similar.

## Using {#using}

### If ChartKit is added to the build {#chartkit-to-build}

```js
// Main component with Node.js charts from Yandex Charts
import ChartKit from 'yandex-chartkit/src/bundles/chartkit';

// Menu
import menu from 'yandex-chartkit/src/bundles/menu';
// Comments section in the menu
import menuComments from 'yandex-chartkit/src/bundles/menu-comments';
// Browser-based Yandex Charts scripts
import chartsBrowser from 'yandex-chartkit/src/bundles/browser';
// ChartsWizard scripts
import chartsWizard from 'yandex-chartkit/src/bundles/wizard';
// Statistics charts
import stat from 'yandex-chartkit/src/bundles/stat';
// Additional chart modules
// highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph, annotations, seriesLabel
// indicators, ema
import renderGraphExtended from 'yandex-chartkit/src/bundles/graph-extended';
// Tables
import renderTable from 'yandex-chartkit/src/bundles/table';
// Maps
import renderMap from 'yandex-chartkit/src/bundles/map';
// Metric
import renderMetric from 'yandex-chartkit/src/bundles/metric';
// Wiki text
import renderText from 'yandex-chartkit/src/bundles/text';

// Adding extensions to the main component
menu(ChartKit);
menuComments(ChartKit);
chartsBrowser(ChartKit);
chartsWizard(ChartKit);
stat(ChartKit);
renderGraphExtended();
renderTable(ChartKit);
renderMap(ChartKit);
renderMetric(ChartKit);
renderText(ChartKit);
```

### Otherwise {#otherwise}

As we are importing `.css` files, in the `webpack` config, you need to add a path to the folder `node_modules/yandex-chartkit`.

```js
// Main component with Node.js charts from Yandex Charts
import ChartKit from 'yandex-chartkit';
import 'yandex-chartkit/dist/chartkit.css';
// Menu
import menu from 'yandex-chartkit/dist/menu';
import 'yandex-chartkit/dist/menu.css';
// Comments section in the menu
import menuComments from 'yandex-chartkit/dist/menu-comments';
import 'yandex-chartkit/dist/menu-comments.css';
// Browser-based Yandex Charts scripts
import chartsBrowser from 'yandex-chartkit/dist/browser';
// ChartsWizard scripts
import chartsWizard from 'yandex-chartkit/dist/wizard';
// Statistics charts
import stat from 'yandex-chartkit/dist/stat';
// Additional modules of charts
// highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph, annotations, seriesLabel
// indicators, ema
import renderGraphExtended from 'yandex-chartkit/dist/graph-extended';
// Tables
import renderTable from 'yandex-chartkit/dist/table';
import 'yandex-chartkit/dist/table.css';
// Maps
import renderMap from 'yandex-chartkit/dist/map';
import 'yandex-chartkit/dist/map.css';
// Metric
import renderMetric from 'yandex-chartkit/dist/metric';
import 'yandex-chartkit/dist/metric.css';
// Wiki text
import renderText from 'yandex-chartkit/dist/text';

// Adding extensions to the main component
menu(ChartKit);
menuComments(ChartKit);
chartsBrowser(ChartKit);
chartsWizard(ChartKit);
stat(ChartKit);
renderGraphExtended();
renderTable(ChartKit);
renderMap(ChartKit);
renderMetric(ChartKit);
renderText(ChartKit);
```

### The available properties {#properties}

```js
<ChartKit
    // Path to the Yandex Charts script (required)
    source="/editor/my/script?scale=d&region=TOT"
    // Parameters (they have priority over the parameters in `source`)
    // Default: {}
    params={{region: 'RU'}}
    // Type: bool or number
    // Don't show a loader during updates or show a simplified loader after number ms
    // Default: false
    silentLoading={500}
    // Show the menu (the extension must be imported)
    // By default: false
    showMenu={true}
    // Hide the Edit navigation in the menu in ChartEditor/ChartWizard
    // Default: false
    hideToCharts={true}
    // Hide the Yandex Charts copyright
    // Default: false
    hideCopyright={true}
    // X-Request-ID header prefix
    // Default: undefined
    requestIdPrefix="38671557e7914ecebfaee56181b8a835"
    // Callback on the end of script rendering
    // Default: undefined
    onLoad={({status, requestID, error}) => {
        if (status === 'ok') {
            console.log('done')
        }
        if (status === 'error') {
            console.error(error);
        }
    }}
/>
```

### Settings {#settings}

```js
// Below are the default values
ChartKit.setSettings({
    // Yandex Charts API
    chartsEndpoint: 'https://charts.yandex-team.ru',
    // Request decorator (presently, you can only decorate headers)
    requestDecorator: (request) => {
        request.headers['My-Custom-Header'] = Math.random();
        return request;
    },
    // Language
    lang: 'ru',
    // Config of sources (for the error about sources and the "View sources" menu item)
    // It will be downloaded (/api/private/fetch) when loading a page with ChartKit,
    // It won't be downloaded if equal to false or to a non-empty object
    config: {
        charts: {
            dataEndpoint: 'https://charts.yandex-team.ru',
            description: {
                title: 'Charts'
            }
        }
    }
});
```
