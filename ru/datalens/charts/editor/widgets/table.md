---
title: Как работать с таблицами в Editor
description: Из статьи вы узнаете, как работать с таблицами в Editor.
---

# Таблица


{% include [business-note](../../../../_includes/datalens/datalens-functionality-available-business-note.md) %}


Этот вид чарта поддерживает ту же функциональность, что и [таблица](../../../visualization-ref/table-chart.md) в визарде, есть возможность кастомизации стилей, настройки кросс-фильтрации, пагинации и т. п.

## Структура на вкладке Prepare {#prepare}

На вкладке **Prepare** в `module.exports` необходимо сформировать структуру:

```js
module.exports = {
    head: ...,
    rows: ...,
    footer: ...,
};
```

Обязательное поле `head` содержит конфигурацию ячеек заголовка таблицы.

Структура значения поля — массив JSON-объектов вида:

```json
[{
    id: "<string>",
    name: "<string>",
    formattedName: "<string>" | <markup configuration>,
    type: "<string>",
    hint: "<string>",
    format: "<string>",
    formatter: <object>,
    align: "<string>",
    min: <number>,
    max: <number>, 
    showLabel: <boolean>,
    barHeight: "<string>" | <number>,
    width: "<string>" | <number>,
    group: <boolean>,
    pinned: <boolean>, 
    css: <object>,
    sub: [<object>],
    custom: <object>,
}]
```

Где:

* `id` — содержит уникальное id колонки таблицы. Поле обязательное, тип значения строка.
* `name` — выводит значение в ячейку заголовка таблицы, если только не задано поле `formattedName`. Поле необязательное, тип значения строка.
* `formattedName` — выводит значение в ячейку заголовка таблицы, игнорируя значение поля name. Поле необязательное, тип значения строка или результат разметки, заданную с помощью функции [Editor.generateHtml(args)](../methods.md#gen-html).
* `type` — задает тип данных колонки. Поле необязательное, тип значения строка с возможными значениями:
  
  * `text` — строка;
  * `number` — число;
  * `date` — дата (в миллисекундах), время будет в часовом поясе браузера;
  * `bar` — индикатор.
  
  Значение по умолчанию: text.

* `hint` — подсказка в ячейке заголовка таблицы, значение поля выводится в тултипе при наведении на знак вопроса. Поле необязательное, тип значения строка (поддерживается markdown-разметка).
* `format` — задает форматирование содержимого колонки. Поле необязательное, тип значения строка, доступно для поля с типом `date`. Пример значения формата:

  ```
  format: "DD/MM/YY HH:mm:ss"
  ```

* `formatter` — задает форматирование содержимого колонки. Поле необязательное, тип значения объект вида:

  ```
  {
      precision: <number>,
      multiplier: <number>,
      suffix: "<string>",
      prefix: "<string>",
  }
  ```

  Где:

  * `precision` — точность округления (количество знаков после запятой) для всех значений колонки. Доступно для полей с типом `number`.
  * `multiplier` — множитель для всех значений колонки. Доступно для полей с типом `number`.
  * `suffix` — текст, выводимый после значения в ячейке для всей колонки.
  * `prefix` — текст, выводимый до значения в ячейке для всей колонки.

* `align` — выравнивание индикатора внутри ячейки. Поле необязательное, доступно для полей с типом `bar`, тип значения строка с возможными значения: `right`, `left`. Значение по умолчанию: `right`.

  {% note info %}

  При указании только `max` бар рисуется слева направо, можно изменить с помощью значения `align: 'right'`.

  При указании только `min` бар рисуется справа налево, можно изменить с помощью значения `align: 'left'`.

  При указании и `max`, и `min` появляется плавающий ноль, от которого бар рисуется направо для положительных значений и налево для отрицательных значений. В этом случае игнорируется значение `align`.

  {% endnote %}

* `min` — минимальное пороговое значение для индикатора. Поле необязательное, тип значения число, доступно для полей с типом `bar`.
* `max` — максимальное пороговое значение для индикатора. Поле необязательное, тип значения число, доступно для полей с типом `bar`.
* `showLabel` — отображение подписи для индикатора. Поле необязательное, тип значения число, доступно для полей с типом `bar`. Значение по умолчанию: `true`.
* `barHeight` — css-стиль для высоты индикатора. Поле необязательное, доступно для полей с типом bar. Тип значения число или строка из доступных значений css-стиля высоты. Значение по умолчанию: `100%`.
* `width` — ширина ячеек колонки. Поле необязательное. Тип значения число или строка из доступных значений css-стиля ширины. Значение по умолчанию: `auto`.
* `group` — признак группировки в одну ячейку, работает для идущих подряд одинаковых значений ячейки в колонке. Поле необязательное, тип значения `boolean`. Значение по умолчанию: `false`.
* `pinned` — признак, зафиксирован ли столбец при горизонтальной прокрутке содержимого. Поле необязательное, тип значения `boolean`. Значение по умолчанию: `false`.
* `css` — описание CSS стилей для ячейки заголовка таблицы. Поле необязательное, тип значения объект из css-свойств.
* `sub` — массив ячеек заголовка таблицы для задания двух-уровневой шапки. В качестве элемента массива — объект с полями как у поля head.
* `custom` — конфигурация параметров ячейки для кросс-фильтрации. Подробнее см. в разделе [{#T}](../cross-filtration.md).

Поле rows содержит конфигурацию ячеек содержимого таблицы, является обязательным.

Структура значения поля — JSON-объект вида:

```json
{
    cells: [{
    	value: "<string>" | <number> | <date>,
    	formattedValue: "<string>" | <markup configuration>,
    	type: "<string>",
    	align: "<string>",
    	min: <number>,
    	max: <number>, 
    	showLabel: <boolean>,
    	barHeight: "<string>" | <number>,
        barColor: "<string>",
    	width: "<string>" | <number>,
        link: <object>,
        onClick: <object>,
    }, ...]
}
```

Где:

* `value` — значение содержимого ячейки таблицы, если только не задано поле `formattedValue`. Поле обязательное, тип значения строка, число или дата. Для ячеек с типом bar является значением индикатора.
* `formattedValue` — значение содержимого ячейки таблицы, игнорируя значение поля `value`. Поле необязательное, тип значения строка, число, дата или результат разметки, заданную с помощью функции [Editor.generateHtml(args)](../methods.md#gen-html). Для ячеек с типом `bar` используется для лейбла индикатора.
* `type` — переопределяет значение, заданное в head, для конкретной ячейки. Подробнее о поле см выше.
* `align` — задает значение выравнивания для индикаторов, если не задано в `head`. Подробнее о поле см выше.
* `min` — задает значение минимального пороговое значение для индикатора, если не задано в `head`. Подробнее о поле см выше.
* `max` — задает значение максимальное пороговое значение для индикатора, если не задано в head. Подробнее о поле см выше.
* `showLabel` — задает отображение подписи для индикатора, если не задано в head. Подробнее о поле см выше.
* `barHeight` — задает css-стиль для высоты индикатора, если не задано в head. Подробнее о поле см выше.
* `css` — описание CSS стилей для ячейки таблицы. Поле необязательное, тип значения объект из css-свойств.
* `link` — задает отображение всего содержимого ячейки как ссылка для колонок с типом text. Поле необязательное, тип значения объект вида:

  ```json
  {
      href: "<string>",
      newWindow: <boolean>,
  }
  ```

  Где:

  * `href` — значение URL ссылки для перехода.
  * `newWindow` — признак, открывать ли ссылку в новом окне.

* `onClick` — действие по клику на ячейку. Поле необязательное, тип значения объект вида:

  ```json
  {
      action: "<string>",
      args: <object>,
  }
  ```

  Где:

  * `action` — тип действия, возможные значения: `setParams` (устанавливает новые значения параметров по клику).
  * `args` — статические аргументы для действия (например, для действия `setParams` аргументами является объект с ключем и новым значением параметра для установки).

  Поле `footer` содержит конфигурацию ячеек футера таблицы, является необязательным. Формат идентичен полю rows.

### Доступные методы {#methods}

Поддерживает ту же функциональность, что и [таблица](../../../visualization-ref/table-chart.md) в визарде.

## Структура на вкладке Config {#config}

На этой вкладке описываются настройки визуализации. На вкладке **Config** в `module.exports` необходимо сформировать структуру:


```js
module.exports = {
    title: <object>,
    sort: "<string>",
    order: "<string>",
    paginator: <object>,
    size: "<string>",
    events: {
        click: [{
        // Также можно определить как массив объектов
            handler: {type: 'setActionParams'},
        // На данный момент поддержан только один scope 'row'
            scope: 'row',
      }
    ]},
};
```

Где все поля являются необязательными:

* `title` — объект вида:

  ```json
  {
      text: "<string>",
      style: <object>,
          // CSS-стили заголовка
          style: {
              'text-align': 'center',
              'font-size': '20px'
          }
  ```
  
  Где:

  * `text` — заголовок таблицы.
  * `style` — описание CSS стилей для заголовка таблицы. Тип значения — объект из css-свойств.

* `order` — порядок сортировки. Тип значения строка из возможных значений: acs (прямой), desc (обратный).
* `paginator` — конфигурация пагинации таблицы. Тип объект вида:

  ```json
  {
      enabled: <boolean>,
      limit: <number>,
  }
  ```
  
  Где:

  * `enabled` — признак включенной пагинации. Тип значения boolean.
  * `limit` — значение количества строк для пагинации. Тип значения число.

    {% note info %}
    
    Установка значения поля `limit` влияет только на количество отображаемых строк в самом компоненте пагинации. Не влияет на количество отображаемых строк в теле таблицы. Это необходимо реализовать в коде на вкладке **Prepare** при помощи вспомогательного метода [Editor.getCurrentPage()](../methods.md#get-current-page).

    {% endnote %}

* `size` — размер таблицы (включает в себя размет шрифта, межстрочного интервала и отступов внутри ячеек). Тип значения строка из возможных значений: `l`, `m`, `s`.
* `events` — позволяет задать конфигурацию для кросс-фильтрации для таблицы, которую можно переопределить на урочне конкретной ячейки с помощью поля `custom`. Подробнее см. в разделе [{#T}](../cross-filtration.md).

## Примеры {#examples}

* [Таблица с дополнительным форматированием и вставкой специальных элементов в ячейках чарта](https://datalens.yandex/nvkfwnekf9xy9?tab=OXk#Пример%20Таблицы%20с%20дополнительными%20форматированием%20и%20вставкой%20спец%20элементов%20в%20ячейках%20чарта)
* [Таблица с динамическим набором столбцов](https://datalens.yandex/nvkfwnekf9xy9?tab=OXk#Пример%20Таблицы%20с%20динамическим%20набором%20столбцов)
* [Таблица с индикаторами в ячейках](https://datalens.yandex/nvkfwnekf9xy9?tab=OXk#Пример%20Таблицы%20с%20индикаторами%20в%20ячейках)