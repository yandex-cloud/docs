# ChartKit

[![npm version](https://badger.yandex-team.ru/npm/@yandex-data-ui/chartkit/version.svg)](https://npm.yandex-team.ru/@yandex-data-ui/chartkit)

Библиотека для рендеринга скриптов [Yandex Charts](https://charts.yandex-team.ru).

## Установка {#install}

```bash
npm i @yandex-data-ui/chartkit
```

## Зависимости {#dependency}

```
"lego-on-react": "^3.0.0",
"react": "^16.8.0",
"react-dom": "^16.8.0"
"react-router-dom": "^5.0.0" // если подключается дополнительный модуль control
```

## Сообщить о проблеме {#bug-report}

Если вы хотите сообщить об ошибке или предложить улучшение, то заведите тикет [по ссылке](https://st.yandex-team.ru/createTicket?queue=CHARTS&components%5B%5D=43028&followers%5B%5D=1120000000020711&followers%5B%5D=1120000000046495&followers%5B%5D=1120000000167368&priority=2&type=2).

## Использование {#using}

### Импорты {#imports}

#### Собранный бандл {#bundle}

* `node_modules/@yandex-data-ui/chartkit` должен присутствовать в инклудах лоадера для стилей.

```js
// общая часть
import '@yandex-data-ui/chartkit/lib/commons';
import '@yandex-data-ui/chartkit/lib/commons.css';

// основная компонента с графиками
import ChartKit from '@yandex-data-ui/chartkit/lib/chartkit';

// дополнительные модули Highcharts
// highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph
// annotations, seriesLabel
// indicators, ema
import extendHighcharts from '@yandex-data-ui/chartkit/lib/highcharts-extended';
// таблицы
import renderTable from '@yandex-data-ui/chartkit/lib/table';
import '@yandex-data-ui/chartkit/lib/table.css';
// карты
import renderMap from '@yandex-data-ui/chartkit/lib/map';
import '@yandex-data-ui/chartkit/lib/map.css';
// Яндекс Карты
import renderYandexMap from '@yandex-data-ui/chartkit/lib/yandex-map';
import '@yandex-data-ui/chartkit/lib/yandex-map.css';
// показатель
import renderMetric from '@yandex-data-ui/chartkit/lib/metric';
// контролы
import renderControl from '@yandex-data-ui/chartkit/lib/control';
import '@yandex-data-ui/chartkit/lib/control.css';
// праздники
import useHolidays from '@yandex-data-ui/chartkit/lib/holidays';
// markdown
import renderMarkdown from '@yandex-data-ui/chartkit/lib/markdown';
import '@yandex-data-ui/chartkit/lib/markdown.css';

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
  SOURCES, // Посмотреть источники
  EDIT, // Редактировать,
  Inspector, // Тайминги загрузки/рендеринга и информацией про источники
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

#### Исходные файлы {#files}

* Если используется дополнительный модуль `control`, то для корректного отображения иконок в компонентах
нужно добавить в зависимости, например, `svg-sprite-loader` и правило для `webpack` следующего вида:

  ```js
  {
      test: /@yandex-data-ui\/common\/.*\.svg$/,
      loader: 'svg-sprite-loader'
  }
  ```

```js
// основная компонента с графиками
import ChartKit from '@yandex-data-ui/chartkit';

// дополнительные модули Highcharts
// highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph
// annotations, seriesLabel
// indicators, ema
import extendHighcharts from '@yandex-data-ui/chartkit/build/extensions/highcharts-extended';
// таблицы
import renderTable from '@yandex-data-ui/chartkit/build/extensions/table';
// карты
import renderMap from '@yandex-data-ui/chartkit/build/extensions/map';
// Яндекс Карты
import renderYandexMap from '@yandex-data-ui/chartkit/build/extensions/yandex-map';
// показатель
import renderMetric from '@yandex-data-ui/chartkit/build/extensions/metric';
// контролы
import renderControl from '@yandex-data-ui/chartkit/build/extensions/control';
// markdown
import renderMarkdown from '@yandex-data-ui/chartkit/build/extensions/markdown';
// праздники
import useHolidays from '@yandex-data-ui/chartkit/build/extensions/holidays';

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
  SOURCES, // Посмотреть источники
  EDIT, // Редактировать
  Inspector, // Тайминги загрузки/рендеринга и информацией про источники
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

### Стилизация {#style}

**Важно**: все новые возможности разрабатываются с требованием, что `<ChartKit/>` будет использован вместе с [`<ThemeProvider/>`](https://github.yandex-team.ru/data-ui/common/tree/master/src/components/theme):

```jsx
import {ThemeProvider} from '@yandex-data-ui/common';

<ThemeProvider theme="light">
  <ChartKit .../>
</ThemeProvider>
```

Если вы используете дополнительный модуль `control` или предопределенный элемент меню `Inspector`,
то вместе с `<ChartKit/>` должен быть использован [`<ThemeProvider/>`](https://github.yandex-team.ru/data-ui/common/tree/master/src/components/theme)

#### Описание темы {#theme-description}

**DEPRECATED**: данный способ является устаревшим и не будет поддержан в следующей мажорной версии.
Используйте [`<ThemeProvider/>`](https://github.yandex-team.ru/data-ui/common/tree/master/src/components/theme).

**Важно**: если использовать разные названия для тем, то изменение темы через вызов `ChartKit.setGeneralSettings`
с новым значением в `theme` или обновление `theme` в `props` полностью будет применено только при перерендеринге компоненты.
В частности потому что новые значения должны быть явно проставлены в конфиг Highcharts.
Рекомендуется использовать одно имя темы, но с CSS-переменными, которые принимают новые значения, например, при изменении
класса на `body`

**Важно**: CSS-переменные кастомной темы или сама тема (если не используются CSS-переменные) должны быть прописаны на уровне `body`.
В частности из-за того, что тултип Highcharts рендерится на `body`.

```css
.chartkit-theme_custom {
    // вейл лоадера
    --ck-veil-background: rgba(255, 255, 255, 0.35);

    // фон блока с контролами
    --ck-controls-backgound: rgba(0, 0, 0, 0.04);

    // показатель
    --ck-metric-title: #000000;
    --ck-metric-value: #027bf3;

    // навигатор
    --highcarts-navigator-border: rgba(0, 0, 0, 0.07);
    --highcarts-navigator-track: #fafafa;
    --highcarts-navigator-body: rgba(0, 0, 0, 0.2);

    // график
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

    // для "парящих" элементов, например, легенды и тултипа
    --highcharts-floating-bg: rgba(255, 255, 255, 0.95);

    // полоска праздника
    --highcharts-holiday-band: rgba(0, 0, 0, 0.05);

    // тултип
    --highcharts-tooltip-text: #000000;
    --highcharts-tooltip-text-complementary: rgba(0, 0, 0, 0.7); // дополнительный цвет текста, в частности для суммы
    --highcharts-tooltip-bg: var(--highcharts-floating-bg);
    --highcharts-tooltip-alternate-bg: rgba(0, 0, 0, 0.04); // цвет фона чётных строк в тултипе

    // таблица
    --data-table-color-base: #ffffff;
    --data-table-color-stripe: #fafafa;
    --data-table-border-color: rgba(0, 0, 0, 0.15);
    --data-table-color-hover-area: rgba(0, 0, 0, 0.04);
    --data-table-color-footer-area: var(--data-table-color-base);

    // yandex карты
    --ck-ymap-chips-label-color: #ffffff;
}
```

### Доступные свойства {#properties}

```jsx
<ChartKit
    // id скрипта Yandex Charts
    id="mazayqm22mzil"
    // параметры
    params={{region: 'RU'}}
    // префикс заголовка X-Request-ID
    requestIdPrefix="38671557e7914ecebfaee56181b8a835"
    // вместо стандартного лоадера по центру показывать небольшой лоадер в правом верхнем углу
    compactLoader={true}
    // скрыть лоадер
    noLoader={false}
    // показывать лоадер после задержки в 500 мс
    loaderDelay={500}
    // необходимо выставить в true, если компонент используется в ситуации, когда скролл не на body (либо когда
    // компонент не синхронизирован со скроллом, например, расположен внутри модального окна)
    nonBodyScroll={false}
    // микс для chartkit__body ноды для возможности переопределения стилей, по умолчанию не передаётся
    widgetBodyClassName="class-name-mix"
    // отложенная инициализация - при установки в true чарт будет загружен только если оказался в зоне либо
    // вблизи зоны вьюпорта, по умолчанию false
    deferredInitialization={false}
    // размер (в пикселях) зоны ниже вьюпорта при попаданию в которую виджет начинает загружаться, работает при
    // deferredInitialization={true}, по умолчанию window.innerHeight
    deferredInitializationMargin={window.innerHeight}
    // модификатор темы
    theme="common"
    // массив элементов меню
    menu={[
        HIDE_COMMENTS, // Скрыть комментарии
        SHOW_COMMENTS, // Показать комментарии
        COMMENTS, // Комментарии
        SCREENSHOT, // Сохранить картинку
        EXPORT, // Экспорт данных
        NEW_WINDOW, // Открыть в новом окне
        OPEN_AS_TABLE, // Открыть как таблицу
        GET_LINK, // Получить ссылку и код
        SOURCES, // Посмотреть источники
        EDIT, // Редактировать
        Inspector, // Тайминги загрузки/рендеринга и информацией про источники
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
    // callback на начало отрисовки
    onLoadStart={() => console.log('Loading started')}
/>
```

### Общие настройки {#main-settings}

```jsx
ChartKit.setGeneralSettings({
    // функция для генерации X-Request-ID заголовка
    requestIdGenerator: (requestIdPrefix) => Math.random(),
    // префикс заголовка X-Request-ID
    requestIdPrefix: '38671557e7914ecebfaee56181b8a835',
    // язык
    lang: 'ru',
    // конфиг источников (для ошибки об источниках и пункта меню "Посмотреть источники")
    // если true - будет скачиваться из /api/private/fetch при загрузке страницы с ChartKit
    config: {
        charts: {
            dataEndpoint: 'https://charts.yandex-team.ru',
            description: {
                title: 'Charts'
            }
        }
    },
    // тема
    theme: 'common',
    menu: [
        // массив элементов меню аналогично menu в доступных свойствах
    ],
    // в частности меняет логику позиционирование тултипа
    // на мобильных устройствах в портретной ориентации тултип будет отображаться над графиком
    isMobile: true,
    // компонента для отображения ошибки
    ErrorComponent: ({error}) => <div>{error.message}</div>,
});
```

### Настройки провайдера данных Charts {#provider-settings}

```js
ChartKit.setDataProviderSettings({
    // Хост Charts API, поддерживается массив строк
    endpoint: 'https://charts.yandex-team.ru',
    // язык
    lang: 'ru',
    // декоратор запросов
    // для декорирования доступны заголовки request.headers и тело запроса request.data
    requestDecorator: (request) => {
        request.headers['My-Custom-Header'] = Math.random();
        return request;
    },
    // API не будет возвращать логи
    includeLogs: false,
    // использовать JSON.parse вместо JSONfn.parse
    noJsonFn: false,
    // ограничение максимального количества параллельных запросов за данными чарта, если не задано, применяются
    // дефолтные ограничения браузера
    maxConcurrentRequests: 6,
    // не делать ретрай на запрос в API, который ответил ошибкой 5xx
    noRetry: false,
});
```

### Data Provider {#data-provider}

```jsx
import {ChartKitBase} from '@yandex-data-ui/chartkit';

<ChartKitBase
    id="1"
    dataProvider={{
        // получить токен, который можно использовать, чтобы отменить текущие запросы
        getRequestCancellation: () => axios.CancelToken.source(),
        // отменить текущие запросы
        cancelRequests: (requestCancellation) => {
            if (requestCancellation) {
                requestCancellation.cancel('REQUEST_CANCELED');
            }
        },
        // сравнить текущие и новые props
        isEqualProps: lodash.isEqual,
        // получить данные виджета для отрисовки
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
