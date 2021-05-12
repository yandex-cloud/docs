
# ChartKit

[![npm version](https://badger.yandex-team.ru/npm/yandex-chartkit/version.svg)](https://npm.yandex-team.ru/yandex-chartkit)

Библиотека для рендеринга скриптов [Yandex Charts](https://charts.yandex-team.ru).

## Установка {#install}

```bash
npm i yandex-chartkit
```

## Зависимости {#dependency}

```
"islands": "^5.13.0",
"react": ">15.6.0",
"react-dom": ">15.6.0"
```

### Для вики-текста/показателя: {#for-indicator}

```
https://yastatic.net/jquery/1.11.0/jquery.min.js
```

### Для вики-текста {#for-wiki-text}

[Версии](https://wf.yandex-team.ru/versions)

```
https://yastatic.net/tools-wf/5.0.15/v-5/wf.js
https://yastatic.net/tools-wf/5.0.15/v-5/wf.css
```

## Подключение в сборку {#connection-to-build}

Чтобы избежать дублирования `islands` в итоговом бандле.

### При использовании `"react-build-utils": "^0.15.5"` {#react-build-utils}

**DEPRECATED**

```js
const webpack = require('webpack');
const createConfig = require('@yandex-data-ui/react-build-utils/create-config');

module.exports = createConfig({
    ...
    includePaths: [
        ...
        './node_modules/@yandex-data-ui/react-components',
        './node_modules/dt100', // если используете таблицы
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

### При использовании `"webpack-levels": "^0.4.0"` {#webpack-levels}

```js
const webpack = require('webpack');
const {ConfigBuilder, defaultLevel} = require('webpack-levels');

const configBuilder = new ConfigBuilder();

configBuilder.use(defaultLevel({
    ...
    rulesInclude: [
        ...
        './node_modules/@yandex-data-ui/react-components',
        './node_modules/dt100', // если используете таблицы
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

### В остальных случаях (`"webpack": "*"`) {#webpack}

Аналогично.

## Использование {#using}

### Если ChartKit подключен в сборку {#chartkit-to-build}

```js
// основная компонента с Node.js графиками из Yandex Charts
import ChartKit from 'yandex-chartkit/src/bundles/chartkit';

// меню
import menu from 'yandex-chartkit/src/bundles/menu';
// раздел Комментарии в меню
import menuComments from 'yandex-chartkit/src/bundles/menu-comments';
// браузерные Yandex Charts скрипты
import chartsBrowser from 'yandex-chartkit/src/bundles/browser';
// скрипты ChartsWizard
import chartsWizard from 'yandex-chartkit/src/bundles/wizard';
// графики Статистики
import stat from 'yandex-chartkit/src/bundles/stat';
// дополнительные модули графиков
// highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph, annotations, seriesLabel
// indicators, ema
import renderGraphExtended from 'yandex-chartkit/src/bundles/graph-extended';
// таблицы
import renderTable from 'yandex-chartkit/src/bundles/table';
// карты
import renderMap from 'yandex-chartkit/src/bundles/map';
// показатель
import renderMetric from 'yandex-chartkit/src/bundles/metric';
// вики-текст
import renderText from 'yandex-chartkit/src/bundles/text';

// добавляем расширения в основную компоненту
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

### В ином случае {#otherwise}

Т.к. подключаются `.css` файлы, в конфиге `webpack`-а нужно добавить путь до папки `node_modules/yandex-chartkit`.

```js
// основная компонента с Node.js графиками из Yandex Charts
import ChartKit from 'yandex-chartkit';
import 'yandex-chartkit/dist/chartkit.css';
// меню
import menu from 'yandex-chartkit/dist/menu';
import 'yandex-chartkit/dist/menu.css';
// раздел Комментарии в меню
import menuComments from 'yandex-chartkit/dist/menu-comments';
import 'yandex-chartkit/dist/menu-comments.css';
// браузерные Yandex Charts скрипты
import chartsBrowser from 'yandex-chartkit/dist/browser';
// скрипты ChartsWizard
import chartsWizard from 'yandex-chartkit/dist/wizard';
// графики Статистики
import stat from 'yandex-chartkit/dist/stat';
// дополнительные модули графиков
// highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph, annotations, seriesLabel
// indicators, ema
import renderGraphExtended from 'yandex-chartkit/dist/graph-extended';
// таблицы
import renderTable from 'yandex-chartkit/dist/table';
import 'yandex-chartkit/dist/table.css';
// карты
import renderMap from 'yandex-chartkit/dist/map';
import 'yandex-chartkit/dist/map.css';
// показатель
import renderMetric from 'yandex-chartkit/dist/metric';
import 'yandex-chartkit/dist/metric.css';
// вики-текст
import renderText from 'yandex-chartkit/dist/text';

// добавляем расширения в основную компоненту
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

### Доступные свойства {#properties}

```js
<ChartKit
    // путь до скрипта Yandex Charts (обязательно)
    source="/editor/my/script?scale=d&region=TOT"
    // параметры (имеют приоритет над параметрами в `source`)
    // по умолчанию: {}
    params={{region: 'RU'}}
    // тип: bool или number
    // не показывать лоадер при обновлении или показывать упрощенный лоадер после number мс
    // по умолчанию: false
    silentLoading={500}
    // показывать меню (должно быть подключено расширение)
    // по умолчанию: false
    showMenu={true}
    // скрыть переход Редактировать в ChartEditor/ChartWizard в меню
    // по умолчанию: false
    hideToCharts={true}
    // скрыть копирайт Yandex Charts
    // по умолчанию: false
    hideCopyright={true}
    // префикс хедера X-Request-ID
    // по умолчанию: undefined
    requestIdPrefix="38671557e7914ecebfaee56181b8a835"
    // callback на конец отрисовки скрипта
    // по умолчанию: undefined
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

### Настройки {#settings}

```js
// далее перечислены значения по умолчанию
ChartKit.setSettings({
    // API Yandex Charts
    chartsEndpoint: 'https://charts.yandex-team.ru',
    // декоратор запросов (пока для декорирования доступны только заголовки)
    requestDecorator: (request) => {
        request.headers['My-Custom-Header'] = Math.random();
        return request;
    },
    // язык
    lang: 'ru',
    // конфиг источников (для ошибки об источниках и пункта меню "Посмотреть источники")
    // будет скачиваться (/api/private/fetch) при загрузке страницы с ChartKit,
    // не будет скачиватьcя - если равен false или равен непустому object
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
