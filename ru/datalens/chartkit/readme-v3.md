
# ChartKit

`"@yandex-data-ui/chartkit": "^3.0.0"`

Библиотека для рендеринга скриптов [Yandex Charts](https://charts.yandex-team.ru).

## Установка {#install}

```bash
npm i @yandex-data-ui/chartkit
```

## Зависимости {#dependency}

```
"lego-on-react": "^3.0.0",
"react": "^16.0.0",
"react-dom": "^16.0.0"
```

```
ChartsAPI версии 5 и выше
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

## Использование {#using}

### Импорты {#imports}

* Подключения бандла, в который включены
`lego-on-react`, `@yandex-data-ui/dt100`, `@yandex-data-ui/react-components`.
`node_modules/@yandex-data-ui/chartkit` должен присутствовать в инклудах лоадера для стилей.

  ```js
  // основная компонента с графиками
  import ChartKit from '@yandex-data-ui/chartkit/dist/chartkit';
  import '@yandex-data-ui/chartkit/dist/chartkit.css';

  // дополнительные модули Highcharts
  // highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph
  // annotations, seriesLabel
  // indicators, ema
  import extendHighcharts from '@yandex-data-ui/chartkit/dist/highcharts-extended';
  // boost (должен быть последним подключаемым Highcharts-модулем)
  import boostHighcharts from '@yandex-data-ui/chartkit/dist/highcharts-boost';
  // таблицы
  import renderTable from '@yandex-data-ui/chartkit/dist/table';
  import '@yandex-data-ui/chartkit/dist/table.css';
  // карты
  import renderMap from '@yandex-data-ui/chartkit/dist/map';
  import '@yandex-data-ui/chartkit/dist/map.css';
  // Яндекс Карты
  import renderYandexMap from '@yandex-data-ui/chartkit/dist/yandex-map';
  import '@yandex-data-ui/chartkit/dist/yandex-map.css';
  // показатель
  import renderMetric from '@yandex-data-ui/chartkit/dist/metric';
  import '@yandex-data-ui/chartkit/dist/metric.css';
  // вики-текст
  import renderText from '@yandex-data-ui/chartkit/dist/text';
  // праздники
  import useHolidays from '@yandex-data-ui/chartkit/dist/holidays';

  // предопределенные элементы меню
  import {
      HIDE_COMMENTS, // Скрыть комментарии
      SHOW_COMMENTS, // Показать комментарии
      COMMENTS, // Комментарии
      SCREENSHOT, // Сохранить картинку
      EXPORT, // Экспорт данных
      NEW_WINDOW, // Открыть в новом окне
      OPEN_AS_TABLE, // Открыть как таблицу
      GET_LINK, // Получить ссылку и код
      SOURCES, // Посмотрет источники
      EDIT // Редактировать
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

* Подключение исходных файлов, чтобы избежать повторного влючения в бандл
`lego-on-react`, `@yandex-data-ui/dt100`, `@yandex-data-ui/react-components`.

  ```js
  // основная компонента с графиками
  import ChartKit from '@yandex-data-ui/chartkit/lib';

  // дополнительные модули Highcharts
  // highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph
  // annotations, seriesLabel
  // indicators, ema
  import extendHighcharts from '@yandex-data-ui/chartkit/lib/extensions/highcharts-extended';
  // boost (должен быть последним подключаемым Highcharts-модулем)
  import boostHighcharts from '@yandex-data-ui/chartkit/lib/extensions/highcharts-boost';
  // таблицы
  import renderTable from '@yandex-data-ui/chartkit/lib/extensions/table';
  // карты
  import renderMap from '@yandex-data-ui/chartkit/lib/extensions/map';
  // Яндекс Карты
  import renderYandexMap from '@yandex-data-ui/chartkit/lib/extensions/yandex-map';
  // показатель
  import renderMetric from '@yandex-data-ui/chartkit/lib/extensions/metric';
  // вики-текст
  import renderText from '@yandex-data-ui/chartkit/lib/extensions/text';
  // праздники
  import useHolidays from '@yandex-data-ui/chartkit/lib/extensions/holidays';

  // предопределенные элементы меню
  import {
      HIDE_COMMENTS, // Скрыть комментарии
      SHOW_COMMENTS, // Показать комментарии
      COMMENTS, // Комментарии
      SCREENSHOT, // Сохранить картинку
      EXPORT, // Экспорт данных
      NEW_WINDOW, // Открыть в новом окне
      OPEN_AS_TABLE, // Открыть как таблицу
      GET_LINK, // Получить ссылку и код
      SOURCES, // Посмотрет источники
      EDIT // Редактировать
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

### Доступные свойства {#properties}

```js
<ChartKit
    // идентификатор скрипта Yandex Charts
    id="mazayqm22mzil"
    // путь до скрипта Yandex Charts
    source="/editor/Examples/parametrized-stat-graph"
    // параметры
    params={{region: 'RU'}}
    // префикс заголовка X-Request-ID
    requestIdPrefix="38671557e7914ecebfaee56181b8a835"
    // не показывать лоадер при обновлении
    silentLoading={true}
    // или показывать упрощенный лоадер после 500 мс
    silentLoading={500}
    // модификатор темы
    theme="default"
    // массив элементов меню
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
            // заголовок
            title: 'Мой пункт меню',
            // иконка
            icon: <svg>...</svg>,
            // проверка видимости
            isVisible: ({loadedData, propsData}) => true,
            // действие
            action: ({event, loadedData, propsData, anchorNode}) => {...}
        }
    ]}
    // callback на конец отрисовки
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

### Описание темы {#theme-description}

Список перекрашиваемых элементов пополняется.

```css
.chartkit_theme_default {
    // лоадер
    --ck-loader-active-color: #ffcc00;
    --ck-loader-off-color: #ffeba0;

    // график
    --highcharts-grid-line: #f2f2f2;
    --highcharts-axis-line: #f2f2f2;
    --highcharts-tick: #ccd6eb;

    --highcharts-title: #333333;
    --highcharts-axis-labels: #969696;
    --highcharts-legend-item: #333333;

    --highcharts-holiday-band: #f5f5f5;

    // таблица
    --color-front: #000000;
    --color-back: #ffffff;
    --color-table-border: #ece9e7;
    --back-table-stripe: rgba(0, 0, 0, 0.03);
    --back-hover: rgba(0, 0, 0, 0.04);
    --back-table-footer: #000000;
}
```

### Настройки {#settings}

```js
ChartKit.setSettings({
    // API Yandex Charts
    chartsEndpoint: 'https://charts.yandex-team.ru',
    // декоратор запросов (пока для декорирования доступны только заголовки)
    requestDecorator: request => {
        request.headers['My-Custom-Header'] = Math.random();
        return request;
    },
    // язык
    lang: 'ru',
    // конфиг источников (для ошибки об источниках и пункта меню "Посмотреть источники")
    // будет скачиваться (/api/private/fetch) при загрузке страницы с ChartKit,
    // не будет скачиваться - если равен false или равен непустому object
    config: {
        charts: {
            dataEndpoint: 'https://charts.yandex-team.ru',
            description: {
                title: 'Charts'
            }
        }
    },
    // тема
    theme: 'default',
    menu: [
        // массив элементов меню аналогично menu в доступных свойствах
    ]
});
```
