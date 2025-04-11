---
title: Доступные методы в Editor
description: Из статьи вы узнаете про доступные методы в Editor.
---

# Доступные методы в Editor

{% include [business-note](../../../_includes/datalens/datalens-functionality-available-business-note.md) %}

Поддерживаются методы:

* [Editor.generateHtml(arg)](#gen-html)
* [Editor.getActionParams()](#get-action-params)
* [Editor.getCurrentPage()](#get-current-page)
* [Editor.getId(arg)](#get-id)
* [Editor.getLoadedData()](#get-loaded-data)
* [Editor.getParam(name)](#get-param)
* [Editor.getParams()](#get-params)
* [Editor.getWidgetConfig()](#get-widget-config)
* [Editor.resolveInterval(arg)](#resolve-interval)
* [Editor.resolveOperation(args)](#resolve-oper)
* [Editor.resolveRelative(arg)](#resolve-relative)
* [Editor.setChartsInsights(args)](#set-insights)
* [Editor.updateActionParams()](#update-action-params)
* [Editor.updateParams(params)](#update-params)
* [Editor.wrapFn(conf)](#wrap)

## Editor.generateHtml(arg) {#gen-html}

Формирует безопасную HTML-разметку в чарте.

{% cut "Поддерживаемые HTML-теги" %}

* `a`
* `abbr`
* `b`
* `br`
* `button`
* `caption`
* `circle`
* `clipPath`
* `code`
* `dd`
* `defs`
* `div`
* `dl`
* `dt`
* `ellipse`
* `em`
* `feComponentTransfer`
* `feDropShadow`
* `feFuncA`
* `feFuncB`
* `feFuncG`
* `feFuncR`
* `feGaussianBlur`
* `feOffset`
* `feMerge`
* `feMergeNode`
* `filter`
* `g`
* `h1`
* `h2`
* `h3`
* `h4`
* `h5`
* `h6`
* `hr`
* `i`
* `img`
* `li`
* `line`
* `linearGradient`
* `marker`
* `ol`
* `p`
* `path`
* `pattern`
* `polyline`
* `polygon`
* `pre`
* `rect`
* `small`
* `span`
* `stop`
* `strong`
* `sub`
* `sup`
* `svg`
* `table`
* `text`
* `textPath`
* `thead`
* `title`
* `tbody`
* `tspan`
* `td`
* `th`
* `tr`
* `u`
* `ul`

{% endcut %}

{% cut "Поддерживаемые атрибуты тегов" %}

* `alt`
* `aria-controls`
* `aria-describedby`
* `aria-expanded`
* `aria-haspopup`
* `aria-hidden`
* `aria-label`
* `aria-labelledby`
* `aria-live`
* `aria-pressed`
* `aria-readonly`
* `aria-roledescription`
* `aria-selected`
* `clip-path`
* `clip-rule`
* `color`
* `colspan`
* `cx`
* `cy`
* `d`
* `dx`
* `dy`
* `disabled`
* `fill`
* `fill-rule`
* `filterUnits`
* `flood-color`
* `flood-opacity`
* `height`
* `href`
* `in`
* `offset`
* `opacity`
* `orient`
* `padding`
* `points`
* `r`
* `refX`
* `refY`
* `role`
* `rx`
* `ry`
* `scope`
* `slope`
* `src`
* `stroke`
* `stroke-linecap`
* `stroke-linejoin`
* `stroke-width`
* `result`
* `rowspan`
* `summary`
* `target`
* `tabindex`
* `text-align`
* `text-anchor`
* `title`
* `transform`
* `type`
* `valign`
* `viewBox`
* `width`
* `x`
* `x1`
* `x2`
* `xlink:href`
* `xmlns`
* `y`
* `y1`
* `y2`
* `zIndex`
* `data-tooltip-content`
* `data-tooltip-placement`

{% endcut %}

#### Поддерживаемые виды чартов {#gen-html-charts}

* [График (Gravity Charts)](./widgets/chart.md)
* [Таблица](./widgets/table.md)
* [Advanced-чарт](./widgets/advanced.md)

#### Аргументы {#gen-html-args}

`arg` — строка или JSON-объект вида:

```json
{
  "tag": "<string>",
  "style": "<object>",
  "content": "<string> / <object> / <array_of_objects>"
}
```

Где:

* `tag` (_строка_) — тип HTML-тега, обязательное поле.
* `style` (_JSON-объект_) — описание CSS-свойств вида:

  ```json
  {
    "key": "value"
  }
  ```

  Где:

  * `key` (_строка_) — название CSS-свойства.
  * `value` (_строка_) — значение CSS-свойства.

* `content` (_строка_, _JSON-объект_, _массив объектов_) — строка, JSON-объект или массив объектов вида:

  ```json
  {
    "tag": "<string>",
    "style": "<object>",
    "content": "<string> / <object> / <array_of_objects>"
  }
  ```

#### Отображение тултипа по наведению {#dl-tooltip}

В разметке можно использовать специальный тег `dl-tooltip` со следующими атрибутами:

* `data-tooltip-content` (_строка_, _JSON-объект_) — содержимое тултипа. Задается в виде строки или по аналогии с [аргументом](#gen-html-args) `arg`.
* `data-tooltip-placement` (_строка_) — местоположение тултипа:

  * `top` — над содержимым.
  * `bottom` — под содержимым.
  * `left` — слева от содержимого.
  * `right` — справа от содержимого.

* `data-tooltip-open-delay` (_целое число_) — задержка перед отображением тултипа. Задается в миллисекундах.
* `data-tooltip-hide-delay` (_целое число_) — задержка перед скрытием тултипа. Задается в миллисекундах.

#### Стили для цветовых тем {#css}

Поддерживается использование CSS-переменных для каждой из четырех цветовых схем:

* Каждая переменная должна быть определена и для светлой (`light`), и для темной (`dark`) темы.
* Если значения для светлой контрастной (`light-hc`) и/или темной контрастной (`dark-hc`) темы не определены, они будут взяты из соответствующих неконтрастных тем.
* Название переменной должно начинаться с префикса `--ce-theme`, чтобы избежать переопределения системных переменных {{ datalens-short-name }} и переменных, которые используются в [Gravity UI](https://gravity-ui.com/).
* Переменная действует только в области элемента, в рамках которого она определена, а также в области его потомков.

#### Примеры {#gen-html-example}

{% cut "Пример разметки" %}

```js
const result = {
    tag: 'div',
    style: {
        display: 'flex',
        'flex-direction': 'row',
    },
    content: [
        {
            tag: 'a',
            style: {
                display: 'inline-block',
                'vertical-align': 'baseline',
                width: '10px',
                'margin-right': '10px',
            },
            attributes: {
                href: 'https://ya.ru',
                target: '_blank',
            },
            content: {
                tag: 'img',
                attributes: {
                    src: 'https://storage.yandexcloud.net/datalens-public-demo-assets/logo-new.svg',
                    width: '238',
                    height: '32',
                },
                styles: {
                    display: 'block',
                },
            },
        },
        {
            tag: 'span',
            style: {
                'font-style': 'italic',
                color: 'var(--g-color-text-info)',
                'line-height': '1',
                'margin-right': '10px',
            },
         content: 'some text',
        },
        {
            tag: 'svg',
            attributes: {
                'xmlns': 'http://www.w3.org/2000/svg',
                width: 16,
                height: 16,
                fill: 'var(--g-color-text-complementary)',
                viewBox: '0 0 16 16',
            },
            content: {
                tag: 'path',
                attributes: {
                    d: 'M4.355.522a.5.5 0 0 1 .623.333l.291.956A4.979 4.979 0 0 1 8 1c1.007 0 1.946.298 2.731.811l.29-.956a.5.5 0 1 1 .957.29l-.41 1.352A4.985 4.985 0 0 1 13 6h.5a.5.5 0 0 0 .5-.5V5a.5.5 0 0 1 1 0v.5A1.5 1.5 0 0 1 13.5 7H13v1h1.5a.5.5 0 0 1 0 1H13v1h.5a1.5 1.5 0 0 1 1.5 1.5v.5a.5.5 0 1 1-1 0v-.5a.5.5 0 0 0-.5-.5H13a5 5 0 0 1-10 0h-.5a.5.5 0 0 0-.5.5v.5a.5.5 0 1 1-1 0v-.5A1.5 1.5 0 0 1 2.5 10H3V9H1.5a.5.5 0 0 1 0-1H3V7h-.5A1.5 1.5 0 0 1 1 5.5V5a.5.5 0 0 1 1 0v.5a.5.5 0 0 0 .5.5H3c0-1.364.547-2.601 1.432-3.503l-.41-1.352a.5.5 0 0 1 .333-.623zM4 7v4a4 4 0 0 0 3.5 3.97V7H4zm4.5 0v7.97A4 4 0 0 0 12 11V7H8.5zM12 6a3.989 3.989 0 0 0-1.334-2.982A3.983 3.983 0 0 0 8 2a3.983 3.983 0 0 0-2.667 1.018A3.989 3.989 0 0 0 4 6h8z',
                },
            },
        },
    ],
};
...
title: Editor.generateHtml(result),
...
```

{% endcut %}

{% cut "Пример разметки с шаблонными строками в графике" %}

```js
...
dataLabelsFormat: Editor.generateHtml({
    tag: 'i',
    content: '{point.yLabel}'
}),
...
```

{% endcut %}

{% cut "Пример разметки тултипов" %}

```js
...
text: Editor.generateHtml({
    tag: 'div',
    content: [
        {
            tag: 'dl-tooltip',
            content: 'Tooltip trigger 1',
            attributes: {
                'data-tooltip-content': {
                    tag: 'i',
                    content: 'Italic content',
                },
                'data-tooltip-placement': ['top']
            }
        },
        {
            tag: 'dl-tooltip',
            content: 'Tooltip trigger 2',
            style: { 'font-weight': 'normal' },
            attributes: {
                'data-tooltip-content': 'Hey!',
                'data-tooltip-placement': 'right'
            }
        },
        {
            tag: 'div',
            content: 'Without tooltip',
        },
        {
            tag: 'dl-tooltip',
            content: {
                tag: 'img',
                attributes: {
                    src: 'https://storage.yandexcloud.net/datalens-public-demo-assets/logo-new.svg',
                    width: 238,
                    height: 32,
                },
                style: {
                    'display': 'inline-block',
                    'vertical-align': 'middle',
                },
            },
            attributes: {
                'data-tooltip-content': {
                    tag: 'a',
                    attributes: {
                        href: 'https://ya.ru',
                    },
                    content: 'go to link',
                    style: {
                        'display': 'inline-block',
                        'vertical-align': 'middle',
                    },
                },
                'data-tooltip-placement': 'bottom'
            },
            style: {
                'display': 'inline-block',
                'vertical-align': 'middle',
            },
        },
        {
            tag: 'dl-tooltip',
            content: {
                tag: 'a',
                attributes: {
                    href: 'https://ya.ru',
                },
                style: {
                    'display': 'inline-block',
                    'vertical-align': 'middle',
                },
                content: [{
                    tag: 'img',
                    attributes: {
                        src: 'https://storage.yandexcloud.net/datalens-public-demo-assets/logo-new.svg',
                        width: 238,
                        height: 32,
                    },
                    style: {
                        'display': 'inline-block',
                        'vertical-align': 'middle',
                    },
                }],
            },
            style: {
                'display': 'inline-block',
                'vertical-align': 'middle',
                'margin-left': '20px',
            },
            attributes: {
                'data-tooltip-content': {
                    tag: 'img',
                    attributes: {
                        src: 'https://storage.yandexcloud.net/datalens-public-demo-assets/logo-new.svg',
                    },
                    content: 'some image desc',
                },
                'data-tooltip-placement': 'bottom'
            }
        },
    ]
}),
...
```

{% endcut %}

{% cut "Пример разметки с описанием стилей для разных цветовых тем" %}

```js
module.exports = {
    title: {
        text: Editor.generateHtml({
            tag: 'div',
            content: [
                {
                    tag: 'div',
                    theme: {
                        dark: {
                            '--ce-theme-bg': 'purple',
                            '--ce-theme-text': 'yellow',
                        },
                        light: {
                            '--ce-theme-bg': 'pink',
                            '--ce-theme-text': 'orange',
                        },
                    },
                    style: {
                        'background-color': 'var(--ce-theme-bg)',
                    },
                    content: {
                        tag: 'div',
                        style: {
                            color: 'var(--ce-theme-text)',
                        },
                        content: 'I can use --ce-theme-text variable',
                    },
                },
                {
                    tag: 'div',
                    style: {
                        color: 'var(--ce-theme-text)',
                    },
                    content: 'I cannot use --ce-theme-text variable',
                },
            ]
        }),
    },
};
```

{% endcut %}

{% cut "Пример разметки с описанием стилей для разных цветовых тем (вариант 2)" %}

```js
module.exports = {
    title: {
        text: Editor.generateHtml({
            tag: 'div',
            style: {
                'display': 'flex',
                'flex-direction': 'column',
                'align-items': 'center'
            },
            theme: {
                dark: {
                    '--ce-theme-bg': '#BF90EE',
                    '--ce-theme-text': '#F5D629',
                },
                light: {
                    '--ce-theme-bg': '#9658D5',
                    '--ce-theme-text': '#26FFD9',
                },
            },
            content: [
                {
                    tag: 'div',
                    style: {
                        'margin-bottom': '10px',
                    },
                    content: 'Use settings to switch the theme',
                },
                {
                    tag: 'div',
                    style: {
                        'width': '100%',
                        'height': '300px',
                        'background-color': 'var(--ce-theme-bg)',
                        'color': 'var(--ce-theme-text)',
                        'text-align': 'center',
                        'display': 'flex',
                        'justify-content': 'center',
                        'align-items': 'center',
                    },
                    content: 'Some text',
                },
            ]
        }),
    },
};
```

{% endcut %}

## Editor.getActionParams() {#get-action-params}

Возвращает объект с нормализованными [фильтрующими (action) параметрами](./cross-filtration.md).

#### Поддерживаемые виды чартов {#get-action-params-charts}

* [График (Gravity Charts)](./widgets/chart.md)
* [Таблица](./widgets/table.md)
* [Advanced-чарт](./widgets/advanced.md)

#### Аргументы {#get-action-params-args}

Нет.

#### Возвращаемый результат {#get-action-params-result}

JSON-объект вида:

```json
{
  "key": "value"
}
```

Где:

* `key` (_строка_) — имя параметра.
* `value` (_массив строк_) — значения параметров, которыми фильтрует текущий чарт.

{% note info %}

{% include [parameter-types](../../../_includes/datalens/internal/editor/parameter-types.md) %}

{% endnote %}

{% note tip %}

Для включения отладки режима с фильтрующими параметрами необходимо добавить в URL страницы параметр `_action_params` со значением  `1`.

{% endnote %}

#### Пример {#get-action-params-example}

{% list tabs %}

- Примененные параметры

  К чарту применены фильтрующие параметры — нажат фильтрующий элемент или в URL чарта указан параметр с префиксом:

  ```js
  _ap_City=Moscow
  ```

- Вкладка Params

  Содержимое вкладки [Params](./tabs.md#params):

  ```js
  module.exports = {
      "Year": "2024",
      "City": ["Moscow", "Sochi"]
  };
  ```

- Вкладка Prepare

  Содержимое вкладки [Prepare](./tabs.md#prepare):

  ```js
  const actionParams = Editor.getActionParams();
  ```

- Результат

  Значение переменной `actionParams` после выполнения вкладки **Prepare**:

  ```json
  {
    "City": ["Moscow"]
  }
  ```

{% endlist %}

#### Примеры чартов {#get-action-params-chart-examples}

[Пример кросс-фильтрации](https://datalens.yandex/nvkfwnekf9xy9#Editor.getActionParams()%2C%20Editor.updateActionParams(args)%2C%20Editor.getParam(args)) — клик по Advanced-чарту слева фильтрует Markdown справа.

## Editor.getCurrentPage() {#get-current-page}

Возвращает текущее значение номера страницы в таблице с включенной пагинацией.

#### Поддерживаемые виды чартов {#get-current-page-charts}

[Таблица](./widgets/table.md).

#### Аргументы {#get-current-page-args}

Нет.

#### Возвращаемый результат {#get-current-page-result}

Число, соответствующее номеру страницы.

#### Пример {#get-current-page-example}

{% list tabs %}

- Вкладка Config

  Содержимое вкладки [Config](./tabs.md#config):

  ```js
  module.exports = {
      paginator: {
          enabled: true,
          limit: 5
      }
  };
  ```

- Вкладка Prepare

  Содержимое вкладки [Prepare](./tabs.md#prepare):

  ```js
  const page = Editor.getCurrentPage();
  ```

- Результат

  ![screenshot](../../../_assets/datalens/editor/table-pagination.png)

{% endlist %}

## Editor.getId(arg) {#get-id}

Возвращает id объекта из поля `links` со вкладки [Meta](./tabs.md#meta).

#### Поддерживаемые виды чартов {#get-id-charts}

Все.

#### Аргументы {#get-action-params-args}

`arg` (_строка_) — строка с названием ключа (имя-алиас) в объекте `links` на вкладке **Meta**.

#### Возвращаемый результат {#get-id-result}

Строка со значением id.

#### Пример {#get-id-example}

{% list tabs %}

- Вкладка Meta

  Содержимое вкладки [Params](./tabs.md#params):

  ```js
  module.exports = {
    "links": {
        "myBestDataset": "tlzr1t5kto9cg"
    }
  };
  ```

- Вкладка Sources

  Содержимое вкладки [Sources](./tabs.md#sources) с получением значения со вкладки **Meta**:

  ```js
  module.exports = {
    'myDatasetSource': {
        datasetId: Editor.getId('myBestDataset'),
        data: {
            fields: [
                {
                    ref: {
                        type: "title",
                        title: "PaymentType",
                    },
                },
		        {
                    ref: {
                        type: "title",
                        title: "OrderYear",
                    },
                },
		        {
                    ref: {
                        type: "title",
                        title: "OrderMonth",
                    },
                },
            ],
        },
    },
  };
  ```

{% endlist %}

## Editor.getLoadedData() {#get-loaded-data}

Возвращает объект с данными, запрошенными на вкладке [Sources](./tabs.md#sources).

#### Поддерживаемые виды чартов {#get-loaded-data-charts}

Все.

#### Аргументы {#get-loaded-data-args}

Нет.

#### Возвращаемый результат {#get-loaded-data-result}

Зависит от источника данных и типа визуализации.

#### Пример {#get-loaded-data-example}

Пример для таблицы с источником на основе датасета.

{% list tabs %}

- Вкладка Sources

  Содержимое вкладки [Sources](./tabs.md#sources):

  ```js
  const {buildSource} = require('libs/dataset/v2');
  const datasetId = Editor.getId('myDatasetKeyName');
  module.exports = {
      'myChartDataSource': buildSource({
          id: datasetId,
          columns: ['Year', 'Country', 'City'],
          where,
          order_by: [{
              direction: 'ASC',
              column: 'Year',
          }],
      }),
  };
  ```

- Вкладка Prepare

  Содержимое вкладки [Prepare](./tabs.md#prepare):

  ```js
  const data = Editor.getLoadedData();
  ```

- Результат

  Значение переменной `data` после выполнения вкладки **Prepare**:

  ```json
  {
      "travelSet": {
          "result": {
              "data": {
                  "Data": [
                      [
                          "2013",
                          "Russia",
                          "Moscow"
                      ],
                      [
                          "2014",
                          "Russia",
                          "Sochi"
                      ]
                  ],
                  "Type": [
                      "ListType",
                      [
                          "StructType",
                          [
                              [
                                  "Year",
                                  [
                                      "OptionalType",
                                      [
                                          "DataType",
                                          "Int64"
                                      ]
                                  ]
                              ],
                              [
                                  "Country",
                                  [
                                      "OptionalType",
                                      [
                                          "DataType",
                                          "String"
                                      ]
                                  ]
                              ],
                              [
                                  "City",
                                  [
                                      "OptionalType",
                                      [
                                          "DataType",
                                          "String"
                                      ]
                                  ]
                              ]
                          ]
                      ]
                  ]
              },
              "query": "SELECT `A`, `D`, `C`\n LIMIT 1000001",
              "data_export_forbidden": false,
              "fields": [
                  {
                      "guid": "34ca4a89-f609-4e00-83af-4ae0********",
                      "title": "DateStart",
                      "data_type": "date",
                      "calc_mode": "direct"
                  },
                  {
                      "guid": "50927ab0-3a7e-11ec-965f-71d2********",
                      "title": "Year",
                      "data_type": "integer",
                      "calc_mode": "formula"
                  },
                  {
                      "guid": "13dbfc8f-b649-4201-b3d0-fb8b********",
                      "title": "City",
                      "data_type": "string",
                      "calc_mode": "direct"
                  },
                  {
                      "guid": "d079937f-6bc4-4133-9171-4009********",
                      "title": "Country",
                      "data_type": "string",
                      "calc_mode": "direct"
                  }
              ]
          }
      }
  }
  ```

{% endlist %}

#### Примеры чартов {#get-loaded-data-charts-example}

[Пример использования Editor.getLoadedData() в таблице с источником на основе датасета](https://datalens.yandex/nvkfwnekf9xy9#Editor.getLoadedData())

## Editor.getParam(name) {#get-param}

Возвращает нормализованное значение параметра с именем `name`.

#### Поддерживаемые виды чартов {#get-param-charts}

Все.

#### Аргументы {#get-param-args}

`name` (_строка_) — имя параметра.

#### Возвращаемый результат {#get-param-result}

Массив строк, возвращающий значение параметра.

#### Пример {#get-param-example}

Пример для таблицы с источником на основе датасета.

{% list tabs %}

- Вкладка Params

  Содержимое вкладки [Params](./tabs.md#params):

  ```js
  module.exports = {
      "Year": "2024",
      "City": ["Moscow", "Sochi"]
  };
  ```

- Вкладка Prepare

  Содержимое вкладки [Prepare](./tabs.md#prepare):

  ```js
  const params = Editor.getParam('Year');
  ```

- Результат

  Значение переменной `params` после выполнения вкладки [Prepare](./tabs.md#prepare):

  ```json
  ["2024"]
  ```

{% endlist %}

#### Примеры чартов {#get-param-charts-example}

[Пример чарта с обращением к параметру по имени](https://datalens.yandex/nvkfwnekf9xy9#Editor.getActionParams()%2C%20Editor.updateActionParams(args)%2C%20Editor.getParam(args))

## Editor.getParams() {#get-params}

Возвращает объект с нормализованными параметрами.

#### Поддерживаемые виды чартов {#get-params-charts}

Все.

#### Аргументы {#get-params-args}

Нет.

#### Возвращаемый результат {#get-params-result}

JSON-объект вида:

```json
{
  "key": "value"
}
```

Где:

* `key` (_строка_) — имя параметра.
* `value` (_массив строк_) — значения параметров.

{% note info %}

{% include [parameter-types](../../../_includes/datalens/internal/editor/parameter-types.md) %}

{% endnote %}

#### Пример {#get-params-example}

Пример для таблицы с источником на основе датасета.

{% list tabs %}

- Вкладка Params

  Содержимое вкладки [Params](./tabs.md#params):

  ```js
  module.exports = {
      "Year": "2024",
      "City": ["Moscow", "Sochi"]
  };
  ```

- Вкладка Prepare

  Содержимое вкладки [Prepare](./tabs.md#prepare):

  ```js
  const params = Editor.getParams();
  ```

- Результат

  Значение переменной `params` после выполнения вкладки [Prepare](./tabs.md#prepare):

  ```json
  {
      "Year": ["2024"],
      "City": ["Moscow", "Sochi"]
  }
  ```

{% endlist %}

#### Примеры чартов {#get-params-charts-example}

[Пример использования функции получения всех примененных параметров](https://datalens.yandex/nvkfwnekf9xy9#Editor.getParams())

## Editor.getWidgetConfig() {#get-widget-config}

Возвращает текущее значение настроек виджета с дашборда или отчета. Может использоваться для отладки кастомного отображения чарта при состоянии фильтрации этим чартом.

#### Поддерживаемые виды чартов {#get-widget-config-charts}

* [График (Gravity Charts)](./widgets/chart.md)
* [Таблица](./widgets/table.md)
* [Advanced-чарт](./widgets/advanced.md)

#### Аргументы {#get-widget-config-args}

Нет.

#### Возвращаемый результат {#get-widget-config-result}

JSON-объект вида:

```json
{
  "widgetConfig": {
    ...
    "actionParams": {
      "enable": "<boolean>",
      "fields": "<string[]>"
    }
  }
}
```

Где:

* `actionParams` — настройки фильтрации чарта чартом:

  * `enable` (_логический_) — флаг, включена ли фильтрация.
  * `fields` (_массив строк_) — поля, по которым фильтрует чарт.

#### Пример {#get-widget-config-example}

Пример для таблицы с источником на основе датасета.

{% list tabs %}

- Вкладка Config

  Содержимое вкладки [Config](./tabs.md#config):

  ```js
  module.exports = {
      events: {
          click: {
              handler: [{type: 'setActionParams'}],
              scope: 'point',
          },
      },
  };
  ```

- Вкладка Prepare

  Содержимое вкладки [Prepare](./tabs.md#prepare):

  ```js
  const seriesData = [
      [
          {
              y: 5,
              custom: {actionParams: {'Apples': 'John'}},
          },
          {
              y: 3,
              custom: {actionParams: {'Oranges': 'John'}},
          },
          {
              y: 4,
              custom: {actionParams: {'Pears': 'John'}},
          },
          {
              y: 7,
              custom: {actionParams: {'Grapes': 'John'}},
          },
          {
              y: 2,
              custom: {actionParams: {'Bananas': 'John'}},
          },
      ],
      [
          {
              y: 2,
              custom: {actionParams: {'Apples': 'Jane'}},
          },
          {
              y: 2,
              custom: {actionParams: {'Oranges': 'Jane'}},
          },
          {
              y: 3,
              custom: {actionParams: {'Pears': 'Jane'}},
          },
          {
              y: 2,
              custom: {actionParams: {'Grapes': 'Jane'}},
          },
          {
              y: 1,
              custom: {actionParams: {'Bananas': 'Jane'}},
          },
      ],
      [
          {
              y: 3,
              custom: {actionParams: {'Apples': 'Joe'}},
          },
          {
              y: 4,
              custom: {actionParams: {'Oranges': 'Joe'}},
          },
          {
              y: 4,
              custom: {actionParams: {'Pears': 'Joe'}},
          },
          {
              y: 2,
              custom: {actionParams: {'Grapes': 'Joe'}},
          },
          {
              y: 5,
              custom: {actionParams: {'Bananas': 'Joe'}},
          },
      ]

  ];

  const widgetSettings = Editor.getWidgetConfig();
  if ('widgetConfig' in widgetSettings && 'enable' in widgetSettings.widgetConfig) {
      Editor.updateConfig({title: ...});
  }

  module.exports = {
      graphs: [
          {
              name: 'John',
              data: seriesData[0],
          },
          {
              name: 'Jane',
              data: seriesData[1],
          },
          {
              name: 'Joe',
              data: seriesData[2],
          },
      ],
      categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas'],
  };
  ```

- Результат

  Если на дашборде включена фильтрация чартом, то в результате выполнения в `widgetSettings` придет конфигурация с настройкой включенной фильтрации.

{% endlist %}


## Editor.resolveInterval(arg) {#resolve-interval}

Преобразовывает интервал времени в пару значений с началом и концом этого интервала.

#### Поддерживаемые виды чартов {#resolve-interval-charts}

Все.

#### Аргументы {#gresolve-interval-args}

`arg` (_строка_) — строка в формате интервала.

#### Возвращаемый результат {#resolve-interval-result}

Объект `{from, to}`, где `from/to` — ISO дата, если строка соответствует формату, иначе — `null`.

#### Пример {#resolve-interval-example}

```js
// время на данный момент: 2020-02-26T07:05:52.552Z
const {from, to} = Editor.resolveInterval('__interval___relative_-1y___relative_+10d_eM');
// from === 2019-02-26T00:00:00.000Z
// to === 2020-03-31T23:59:59.999Z
```

```js
// время на данный момент: 2020-02-26T07:05:52.552Z
const interval = Editor.resolveInterval('__interval_2019-01-01T07:08:25.941Z___relative_+1h');
// interval.from === 2019-01-01T07:08:25.941Z
// interval.to === 2020-02-26T08:05:52.552Z
```

```js
// время на данный момент: 2020-02-26T07:05:52.552Z
const interval = Editor.resolveInterval('__interval_2020.01.15___relative_-0d');
// interval === null
```

**Примечание:** начало и конец интервала, прописанного на вкладке [Params](./tabs.md#params) или указанного в URL, будут автоматически пропущены через вспомогательный метод для [относительной даты](#relativedate).
Однако в случае, если значение `начала`/`конца` интервала не соответствует формату, то вместо `null` будет возвращено исходное значение.
Например:

Вкладка **Params:**
```js
module.exports = {
    first: '__interval_2020-01-01T12:30:11.324Z___relative_+1d',
    second: '',
    incorrect: '__inteval_01.01.2020___relative_-1d'
}
```

Параметры **url:** `...?second=__interval___relative_-1y_eQ_2021`
```js
// время на данный момент: 2020-02-20T12:30:11.324Z
const params = Editor.getParams();
// params === {
//   first: ['__interval_2020-01-01T12:30:11.324Z_2020-02-21T23:59:59.999Z'],
//   second: ['__interval_2019-03-31T23:59:59.999Z_2021'],
//   incorrect: ['__inteval_01.01.2020___relative_-1d']
// }
```

## Editor.resolveOperation() {#resolve-oper}

Значение параметра с операции приходит в специальном значении. Для дальнейшей работы с ним можно для удобства использовать текущий метод. Он служит для преобразования значение к параметру и операции.

#### Поддерживаемые виды чартов {#resolve-oper-charts}

Все.

#### Аргументы {#resolve-oper-args}

Нет.

#### Пример {#resolve-oper-example}

Пример для таблицы с источником на основе датасета.

{% list tabs %}

- Вкладка Prepare

  Содержимое вкладки [Prepare](./tabs.md#prepare):

  ```js
  Editor.resolveOperation("__gt_42");
  ```

- Результат

  ```json
      operation: "GT", 
      value: "42",
  ```

{% endlist %}

## Editor.resolveRelative(arg) {#resolve-relative}

Принимает строку в формате относительной даты, возвращает ISO дату, если строка соответствует формату, иначе — `null`.

#### Поддерживаемые виды чартов {#resolve-relative-charts}

Все.

#### Аргументы {#gresolve-relative-args}

`arg` (_строка_) — строка в формате относительной даты.

#### Возвращаемый результат {#resolve-relative-result}

ISO дата, если переданный аргумент `arg` соответствует формату, иначе — `null`.

#### Пример {#resolve-relative-example}

```js
// время на данный момент: 2020-02-18T09:14:56.123Z
const date = Editor.resolveRelative('__relative_-7d');
// date === 2020-02-11T00:00:00.000Z
```

```js
// время на данный момент: 2020-02-18T09:14:56.123Z
const date = Editor.resolveRelative('__relative_+30m_sh');
// date === 2020-02-18T09:00:00.000Z
```

```js
const date = Editor.resolveRelative('2020-01-01');
// date === null
```

**Примечание:** относительные даты, прописанные на вкладке [Params](./tabs.md#params) или указанные в URL, будут автоматически пропущены через вспомогательный метод.
Однако в случае, если значение параметра не соответствует формату относительной даты, вместо `null` будет возвращено исходное значение.
Например:

Вкладка **Params:**
```js
module.exports = {
    date_min: '2020-01-01',
    date_max: '__relative_+1d_sw',
    incorrect: '_relative_d1',
}
```

Параметры **url:** `...?date_min=__relative_-7d`
```js
// время на данный момент: 2020-02-20T12:30:11.324Z
const params = Editor.getParams();
// params === {
//   date_min: ['2020-02-13T00:00:00.000Z'],
//   date_max: ['2020-02-17T00:00:00.000Z'],
//   incorrect: ['_relative_d1']
// }
```

## Editor.setChartsInsights(args) {#set-insights}

Добавляет уведомление в чарт.

#### Поддерживаемые виды чартов {#set-insights-charts}

Все.

#### Аргументы {#set-insights-args}

`args` — массив JSON-объектов вида:

```json
{
  "title": "<string>",
  "message": "<string>",
  "level": "<string>",
  "locator": "<string>",
}
```

Где:

* `title` (_строка_) — заголовок уведомления.
* `message` (_строка_) — текст уведомления на языке разметки [Markdown](./widgets/markdown.md).
* `level` (_строка_) — тип уведомления:

  * `info` — примечание.
  * `warning` — предостережение.
  * `critical` — ограничение.

  Тип уведомления определяет его приоритет и отображаемый значок. Если в чарт добавлено более одного уведомления, в свернутом виде отображается значок только одного уведомления.

* `locator` (_строка_) — уникальный идентификатор для каждого уведомления в пределах чарта.

#### Пример {#set-insights-example}

{% list tabs %}

- Вкладка Prepare

  Содержимое вкладки [Prepare](./tabs.md#prepare):

  ```js
  Editor.setChartsInsights([
      {
          title: 'markdown',
          message: 'Используй [markdown](https://datalens.yandex-team.ru/docs/editor/widgets/markdown/)',
          level: 'critical',
          locator: '1'
      },
      {
          title: 'Список',
          message: 'Для перехода на новую строку используй разделитель \\n \n- раз\n- два\n- три',
          level: 'info',
          locator: '4'
      },
      {
          title: 'Таблица',
          message: 'Заголовок | Заголовок \n:--- | :--- |\nТекст | Текст ',
          level: 'warning',
          locator: '2'
      },
      {
          title: 'Внимание',
          message: 'Данные будут недоступны во время завтрашних учений',
          level: 'critical',
          locator: 'qaz'
      }
  ]);
  ```

- Результат

  ![screenshot](../../../_assets/datalens/editor/notifications.png)

{% endlist %}

#### Примеры чартов {#set-insights-charts-example}

[Пример чарта с уведомлениями](https://datalens.yandex/nvkfwnekf9xy9#Editor.%20setChartsInsights(args)) 

## Editor.updateActionParams() {#update-action-params}

Обновляет объект с [фильтрующими (action) параметрами](./cross-filtration.md).

#### Поддерживаемые виды чартов {#update-action-params-charts}

* [График (Gravity Charts)](./widgets/chart.md)
* [Таблица](./widgets/table.md)
* [Advanced-чарт](./widgets/advanced.md)

#### Аргументы {#update-action-params-args}

JSON-объект вида:

```json
{
  "key": "value"
}
```

Где:

* `key` (_строка_) — имя параметра.
* `value` (_массив строк_) — значения параметров, которыми фильтрует текущий чарт.

{% note info %}

{% include [parameter-types](../../../_includes/datalens/internal/editor/parameter-types.md) %}

{% endnote %}

#### Возвращаемый результат {#update-action-params-result}

Нет.

#### Пример {#update-action-params-example}

{% list tabs %}

- Вкладка Params

  Содержимое вкладки [Params](./tabs.md#params):

  ```js
  module.exports = {
      "Year": "2024",
      "City": ["Moscow", "Sochi"]
  };
  ```

- Вкладка Prepare

  Содержимое вкладки [Prepare](./tabs.md#prepare):

  ```js
  const actionParams = Editor.updateActionParams({"City": "Moscow"});
  ```

- Результат

  Значение фильтрующих параметров (через Editor.getActionParams) после выполнения вкладки [Sources](./tabs.md#sources):

  ```json
  {
    "City": ["Moscow"]
  }
  ```

{% endlist %}

#### Примеры чартов {#get-action-params-chart-examples}

[Пример кросс-фильтрации](https://datalens.yandex/nvkfwnekf9xy9#Editor.getActionParams()%2C%20Editor.updateActionParams(args)%2C%20Editor.getParam(args)) — клик по Advanced-чарту слева фильтрует Markdown справа.

## Editor.updateParams(params) {#update-params}

Доопределяет параметры чарта аргументом `params`.

Не рекомендуем обновлять параметры внутри чартов и контролов, т.к. могут возникнуть проблемы в работе компоненты и связанных элементов. Но в случае крайней необходимости стоит использовать этот метод вместо мутации исходного объекта `params`. В случае мутации не гарантируется стабильность работы чарта.

#### Поддерживаемые виды чартов {#update-params-charts}

Все.

{% note info %}

Рекомендуется использовать только для [контролов](./widgets/controls.md).

{% endnote %}

#### Аргументы {#update-params-args}

`params` — JSON-объект вида:

```json
{
  "key": "value"
}
```

Где:

* `key` (_строка_) — имя параметра.
* `value` (_массив строк_) — значения параметра. Одиночные значения также передаются внутри массива.

#### Пример {#update-params-example}

Пример для таблицы с источником на основе датасета.

{% list tabs %}

- Вкладка Params

  Содержимое вкладки [Params](./tabs.md#params):

  ```js
  module.exports = {
      "Year": "2024",
      "City": ["Moscow", "Sochi"]
  };
  ```

- Вкладка Prepare

  Содержимое вкладки [Prepare](./tabs.md#prepare):

  ```js
  Editor.updateParams({"City": ["Vladimir"]});
  ```

- Результат

  Объект с параметрами чарта после выполнения вкладки **Prepare**:

  ```json
  {
    "Year": ["2024"],
    "City": ["Vladimir"]
  }
  ```

{% endlist %}

## Editor.wrapFn(conf) {#wrap}

Функция для формировании обработчика чарта, исполняется в браузере в песочнице с ограниченным доступом к API браузера. Избегайте тяжелых вычислений, которые могут замедлить отображение чарта. А также следует минимизировать объем передаваемой информации в `args`.

Функция `Editor.wrapFn` чувствительна к ошибкам синтаксиса. Поэтому при возникновении проблем с использованием функции в первую очередь проверьте синтаксис на валидность.

#### Поддерживаемые виды чартов {#wrap-charts}

* [График (Gravity Charts)](./widgets/chart.md)
* [Advanced-чарт](./widgets/advanced.md)

#### Аргументы {#wrap-args}

`conf` — объект вида:

```js
fn: function(highchartsArgs1, …, highchartsArgsN, arg1, …, argN) {
    ...
},
args: [arg1, …, argN],
libs: [lib1, …, libN],
```

Где:

* `fn` — функция-обработчик. Не может быть ссылкой или содержать ссылки на сторонние переменные (в том числе функции).
* `args` — массив аргументов для функции-обработчика. Эти аргументы передаются после всех встроенных аргументов метода.

  {% note info %}

  Передаваемые в `args` объемные параметры снижают скорость выполнения скрипта, поэтому рекомендуется передавать в них минимально возможный объем информации.

  {% endnote %}

* `libs` — массив строк, в которых указываются библиотеки, используемые в функции-обработчике. Рекомендуется указывать имя библиотеки вместе с версией, например, `date-utils@2.3.0` или `date-utils@2.5.3`. Если указать имя библиотеки без версии, например, `date-utils`, будет использоваться последняя версия (`latest`), которая опубликована в [npm registry](https://www.npmjs.com/).

  Доступные значения библиотек для подключения: `date-utils@2.3.0`, `date-utils@2.5.3`(алиас `date-util`), `d3@7.9.0` (алиас `d3`), `d3-chord@3.0.1` (алиас `d3-chord`), `d3-sankey@0.12.3` (алиас `d3-sankey`).

  {% note warning %}

  * Указание нескольких версий одной библиотеки может привести к неожиданному поведению или ее полной неработоспособности.
  * В некоторых случаях использование библиотеки без указания версии может привести к непредсказуемым результатам в работе функции-обработчика.

  {% endnote %}

#### Примеры {#wrap-example}

Пример для Advanced-чарта:

{% list tabs %}

- Вкладка Prepare

  ```js
   module.exports = {
      render: Editor.wrapFn({
          fn: function() {
              return 'Hello world';
          },
      }),
  };
  ```

{% endlist %}

#### Примеры чартов {#wrap-charts-example}

[Вариант использования с подключением d3 библиотеки на примере визуализации Advanced-чарт](https://datalens.yandex/nvkfwnekf9xy9#Editor.%20wrapFn(args))
