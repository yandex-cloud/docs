
# ChartKit

`"@yandex-data-ui/chartkit": "^5.0.0"`

`"@yandex-data-ui/chartkit": "^6.0.0"`

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

### Для вики-текста {#for-wiki-text}

```
https://yastatic.net/jquery/1.11.0/jquery.min.js
https://yastatic.net/tools-wf/5.0.15/v-5/wf.js
https://yastatic.net/tools-wf/5.0.15/v-5/wf.css
```

## Использование {#using}

### Импорты {#imports}

* Подключения собранного бандла

  ```js
  // основная компонента с графиками
  import ChartKit from '@yandex-data-ui/chartkit/dist/chartkit';
  import '@yandex-data-ui/chartkit/dist/chartkit.css';

  // дополнительные модули Highcharts
  // highstock, highchartsMore, solidGauge, funnel, histogramBellcurve, sankey, heatmap, treemap, variwide, streamgraph
  // annotations, seriesLabel
  // indicators, ema
  import extendHighcharts from '@yandex-data-ui/chartkit/dist/highcharts-extended';
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
  // контролы
  import renderControl from '@yandex-data-ui/chartkit/dist/control';
  import '@yandex-data-ui/chartkit/dist/control.css';
  // праздники
  import useHolidays from '@yandex-data-ui/chartkit/dist/holidays';
  // markdown
  import renderMarkdown from '@yandex-data-ui/chartkit/dist/markdown';

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
  renderTable(ChartKit);
  renderMap(ChartKit);
  renderYandexMap(ChartKit);
  renderMetric(ChartKit);
  renderText(ChartKit);
  renderControl(ChartKit);
  useHolidays(ChartKit);
  renderMarkdown(ChartKit);
  ```

  * `node_modules/@yandex-data-ui/chartkit` должен присутствовать в инклудах лоадера для стилей.

  * Если используется расширение `control`, то для корректной стилизации элементов нужно добавить следующее:

    ```scss
    // для корректной стилизации расширения control в ChartKit
    @import '~@yandex-data-ui/common/styles/yc-theme-light.scss';
    @import '~@yandex-data-ui/common/styles/yc-theme-dark.scss';
    @import '~@yandex-data-ui/common/styles/redefine-lego/button/theme/button_theme_flat.scss';

    .класс_на_body {
        @include button2_theme_flat;

        &_со_светлой_темой {
            @include yc-theme-light;
        }

        &_с_темной_темой {
            @include yc-theme-dark;
        }
    }
    ```

  * Если используется расширение `markdown`, то для корректной стилизации элементов нужно добавить следующее:

    ```scss
    // для корректной стилизации расширения markdown в ChartKit
    @import '~@yandex-data-ui/common/styles/yfm.scss';
    ```

* Подключение исходных файлов

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
  // контролы
  import renderControl from '@yandex-data-ui/chartkit/lib/extensions/control';
  // праздники
  import useHolidays from '@yandex-data-ui/chartkit/lib/extensions/holidays';
    // markdown
  import renderMarkdown from '@yandex-data-ui/chartkit/lib/extensions/markdown';

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
  renderControl(ChartKit);
  useHolidays(ChartKit);
  renderMarkdown(ChartKit);
  ```

  * Если используется расширение `control`, то для корректной стилизации элементов нужно добавить следующее:

      ```scss
      // для корректной стилизации расширения control в ChartKit
      @import '~@yandex-data-ui/common/styles/yc-theme-light.scss';
      @import '~@yandex-data-ui/common/styles/yc-theme-dark.scss';
      @import '~@yandex-data-ui/common/styles/redefine-lego/button/theme/button_theme_flat.scss';

      .класс_на_body {
          @include button2_theme_flat;

          &_со_светлой_темой {
              @include yc-theme-light;
          }

          &_с_темной_темой {
              @include yc-theme-dark;
          }
      }
      ```

  * Если используется расширение `control`, то для корректного отображения иконок в компонентах
  нужно добавить в зависимости, например, `svg-sprite-loader` и правило для `webpack`:
      ```js
      {
          test: /@yandex-data-ui\/common\/.*\.svg$/,
          loader: 'svg-sprite-loader'
      }
      ```

  * Если используется расширение `markdown`, то для корректной стилизации элементов нужно добавить следующее:

    ```scss
    // для корректной стилизации расширения markdown в ChartKit
    @import '~@yandex-data-ui/common/styles/yfm.scss';
    ```

### Доступные свойства {#properties}

```js
<ChartKit
    // id скрипта Yandex Charts
    id="mazayqm22mzil"
    // параметры
    params={{region: 'RU'}}
    // префикс заголовка X-Request-ID
    requestIdPrefix="38671557e7914ecebfaee56181b8a835"
    // не показывать лоадер при обновлении
    silentLoading={true}
    // или показывать лоадер после 500 мс
    silentLoading={500}
    // вместо стандартного лоадера по центру показывать небольшой лоадер в правом верхнем углу
    compactLoader={true}
    // необходимо выставить в true, если компонент используется в ситуации, когда скролл не на body (либо когда
    // компонент не синхронизирован со скроллом, например, расположен внутри модального окна)
    nonBodyScroll={false}
    // модификатор темы
    theme="light"
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
        if (status === ChartKit.STATUS.SUCCESS) {
            console.log(requestId, data)
        }
        if (status === ChartKit.STATUS.ERROR) {
            console.error(requestId, data);
        }
    }}
    // callback на начало отрисовки
    onLoadStart={() => console.log('Loading started')}
/>
```

### Описание темы {#theme-description}

Список перекрашиваемых элементов пополняется.

```css
.chartkit_theme_light {
    // лоадер
    --ck-loader-active: #027bf3;
    --ck-loader-inactive: rgba(2, 123, 243, 0.14);

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

    --highcharts-holiday-band: rgba(0, 0, 0, 0.04);

    // тултип
    --highcharts-tooltip-text: #000000;
    --highcharts-tooltip-text-complementary: rgba(0, 0, 0, 0.7); // дополнительный цвет текста, в частности для суммы
    --highcharts-tooltip-bg: rgba(255, 255, 255, 0.94);
    --highcharts-tooltip-alternate-bg: rgba(0, 0, 0, 0.04); // цвет фона чётных строк в тултипе

    // таблица
    --data-table-color-base: #ffffff;
    --data-table-color-stripe: #fafafa;
    --data-table-border-color: rgba(0, 0, 0, 0.15);
    --data-table-color-hover-area: rgba(0, 0, 0, 0.04);
    --data-table-color-footer-area: var(--data-table-color-base);
}
```

### Настройки {#settings}

```js
ChartKit.setSettings({
    // API Yandex Charts
    chartsEndpoint: 'https://charts.yandex-team.ru',
    // декоратор запросов
    // для декорирования доступны заголовки request.headers и тело запроса request.data
    requestDecorator: (request) => {
        request.headers['My-Custom-Header'] = Math.random();
        return request;
    },
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
    theme: 'light',
    menu: [
        // массив элементов меню аналогично menu в доступных свойствах
    ],
    // в частности меняет логику позиционирование тултипа
    // на мобильных устройствах в портретной ориентации тултип будет отображаться над графиком
    isMobile: true
});
```
