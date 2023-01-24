
# Селекторы

* [Общая информация](#common)
* [Доступные методы](#available-methods)
* [Доступные контролы](#available-controls)
* [Изменение параметров и перерисовка чарта](#changing-chart-parametrs)
* [Независимая перерисовка контролов](#redrawing-controls)
* [Изменение нескольких параметров](#changing-several-parameters)
* [Переходы на новую строку](#switch-line)

## Общая информация {#common}

В результате выполнения вкладки [Controls](../architecture.md#controls) должны быть экпортированы данные для отрисовки элементов управления (контролов) чарта.

Основное назначение контролов — изменение параметров и перерисовка чарта.
Про параметры чарта можно подробнее почитать в [соответствующем разделе](../architecture.md#params).

Для каждого отдельного контрола можно указать оператор через словарь `OPERATIONS`. После этого к параметру будет добавляться строка, определяющая тип оператора. Например, селектор с оператором `GT` и значением `42` будет задавать параметр `__gt_42`. 

Вкладка доступна только для [Графика](../widgets/chart/index.md), [Таблицы](../widgets/table/index.md) и [Селектора](../widgets/selector/index.md).

## Доступные методы {#available-methods}

* **`ChartEditor.getParams()`** — возвращает объект с нормализованными параметрами.

* **`ChartEditor.getParam(name)`** — возвращает нормализованное значение параметра с именем `name: string`.

* **`ChartEditor.getLoadedData()`** — возвращает объект с данными по источникам, запрошенным на вкладке Urls.

* **`ChartEditor.updateParams(params)`** — доопределяет параметры чарта аргументом `params: object`.
  Значения параметров должны быть в нормализованном виде (т.е. одиночные значения должны быть обернуты в массив).
  Вызов данного метода имеет смысл только при изменении значения у контрола с [`postUpdateOnChange`](#changing-several-parameters).
  В противном случае вызов этого метода может привести к некорректной работе компоненты и связанных элементов.

* **`ChartEditor.resolveOperation()`** — позволяет распарсить параметры и получить отдельно тип оператора и его значение.

## Доступные контролы {#available-controls}

* [Поле ввода](elements.md#input)
* [Textarea](elements.md#textarea)
* [Календарь](elements.md#calendar)
* [Календарь на интервал](elements.md#calendar-interval)
* [Селект](elements.md#select)
* [Чекбокс](elements.md#checkbox)
* [Кнопка](elements.md#button)
* [Переход на новую строку](elements.md#switch-line)

## Изменение параметров и перерисовка чарта {#changing-chart-parametrs}

{% include [params-dynamic-note](../../../_includes/datalens/params-dynamic-note.md) %}

Все контролы, за исключением [кнопки](elements.md#button) и [перехода на новую строку](elements.md#switch-line),
обязательно связаны с каким-либо параметром чарта.
При изменении значения такого контрола такое же значение будет у связанного параметра при следующей перерисовке чарта .

Чтобы контрол при изменении значения запустил перерисовку чарта, у него должно быть выставлено свойство `updateOnChange: true`.

### Пример 1 {#changing-chart-parametrs-example-1}

При изменении значения селекта, например на `День`, чарт будет перерисован c параметром `{scale: ['d']}`.

Вкладка **Controls**

```js
module.exports = [
    {
        type: 'select',
        param: 'scale',
        content: [
            {title: 'День', value: 'd'},
            {title: 'Неделя', value: 'w'},
            {title: 'Месяц', value: 'm'}
        ],
        updateOnChange: true
    },
];
```

### Пример 2 {#changing-chart-parametrs-example-2}

Чарт будет перерисовываться только по клику на кнопку и будет учитывать измененные значения в селекторе и календаре.
Т.е. при изменении значения селекта, например на `День`, затем изменении значения календаря, например на `2020-01-21`,
и клике на кнопку, чарт будет перерисован с параметрами `{scale: ['d'], date: ['2020-01-21']}`.

Вкладка **Controls**

```js
module.exports = [
    {
        type: 'select',
        param: 'scale',
        content: [
            {title: 'День', value: 'd'},
            {title: 'Неделя', value: 'w'},
            {title: 'Месяц', value: 'm'}
        ]
    },
    {
        type: 'datepicker',
        param: 'date'
    },
    {
        type: 'button',
        label: 'Показать',
        updateOnChange: true
    }
];
```

## Независимая перерисовка контролов {#redrawing-controls}

Чтобы перерисовать только блок контролов и не перерисовывать весь чарт целиком, у контрола должно быть выставлено свойство `updateControlsOnChange: true`.

Изменение значения такого контрола инициирует перерисовку, при которой на сервере будут выполнены только вкладки
[Shared](../architecture.md#shared),
[Params](../architecture.md#params),
[Urls](../architecture.md#urls),
[Controls](../architecture.md#controls).

Кроме этого на вкладке [Urls](../architecture.md#urls) будут запрошены только те источники, у которых выставлено свойство `ui: true`.
Соответственно вызов метода `ChartEditor.getLoadedData()` после такой перерисовки вернет данные только по перезапрошенным источникам.

### Пример {#redrawing-controls-example}

Источник `controls` работает так, что если оба параметра пустые, то возвращается только список стран.
Если `country` указана, то возвращается список стран и список городов для выбранного `country`.

Источник `data` возвращает данные, только когда указаны `country` и `city`.

Изначально значение обоих параметров не заданы.

При выборе значения в селекторе `country` будет перерисован только блок контролов и перезапрошен источник `controls` с соответствующим значением параметра `country`.

При выборе значения в селекторе `city` будет перерисован чарт и перезапрошены все источники с выбранными значениями параметров `country` и `city`.

Вкладка **Params**

```js
module.exports = {
    country: '',
    city: ''
}
```

Вкладка **Urls**

```js
const params = ChartEditor.getParams();
const country = params.country[0];
const city = params.city[0];

module.exports = {
    controls: {
        url: `...&country=${country}&city=${city}`,
        ui: true,
    },
    data: `...&country=${country}&city=${city}`
};
```

Вкладка **Controls**

```js
const params = ChartEditor.getParams();
const country = params.country[0];
const city = params.city[0];

const loadedData = ChartEditor.getLoadedData();

// [{title: 'Россия', value: 'RU'},
// {title: 'Казахстан', value: 'KZ'},
// ...]
const countries = loadedData.countries;

// в зависимости от выбранного country
// например, для country=RU
// [{title: 'Москва', value: 'MSC'},
// {title: 'Санкт-Петербург', value: 'SPB'},
// ...]
// если country не выбран, то cities = [];
const cities = loadedData.cities;

module.exports = [
    {
        type: 'select',
        param: 'country',
        content: countries,
        updateControlsOnChange: true
    },
    {
        type: 'select',
        param: 'city',
        content: cities,
        updateOnChange: true
    }
];
```

## Изменение нескольких параметров {#changing-several-parameters}

Если за одно изменение контрола нужно поменять значения нескольких параметров, то нужно использовать свойство `postUpdateOnChange`.

Изменение значения такого контрола инициирует [независимую перерисовку контролов](#redrawing-controls),
с последующей перерисовкой всего чарта.
Не забудьте указать `ui: true` для источников, чьи данные будут использованы при независимой перерисовке.
Для изменения параметров на вкладке Controls должен быть вызван метод `ChartEditor.updateParams`,
где будут перечислены новые значение параметров.

Другими словами, при изменении значения контрола происходит [независимая перерисовка контролов](#redrawing-controls),
при которой выполняется вкладка Controls с вызовом метода `ChartEditor.updateParams`, после чего происходит перерисовка
всего чарта с учетом измененного значения контрола и переданных в `ChartEditor.updateParams` параметров.

Также можно использовать [кнопку](elements.md#button) с `onClick`.

### Пример 1 {#changing-several-parameters-example-1}

[Пример на Yandex Charts](https://charts.yandex-team.ru/navigation/fep0b5zmdy0qb)

### Пример 2 {#changing-several-parameters-example-2}

Источник `controls` работает так, что если оба параметра пустые, то возвращается только список стран.
Если `country` указана, то возвращается список стран и список городов для выбранного `country`.

Источник `data` возвращает данные, только когда указаны `country` и `city`.

Изначально значение обоих параметров не заданы.

При выборе значения в селекторе `country` будет перерисован блок контролов и перезапрошен источник `controls` с соответствующим значением параметра `country`.
Затем на вкладке Controls для параметра `city` будет выставлено первое доступное значение из возможных.
После этого чарт будет перерисован с учетом выбранного `country` и выставленного `city` параметров.

При выборе значения в селекторе `city` будет перерисован чарт и перезапрошены все источники с выбранными значениями параметров `country` и `city`.

Вкладка **Params**

```js
module.exports = {
    country: '',
    city: ''
}
```

Вкладка **Urls**

```js
const params = ChartEditor.getParams();
const country = params.country[0];
const city = params.city[0];

module.exports = {
    controls: {
        url: `...&country=${country}&city=${city}`,
        ui: true,
    },
    data: `...&country=${country}&city=${city}`
};
```

Вкладка **Controls**

```js
const params = ChartEditor.getParams();
const country = params.country[0];
const city = params.city[0];

const loadedData = ChartEditor.getLoadedData();

// [{title: 'Россия', value: 'RU'},
// {title: 'Казахстан', value: 'KZ'},
// ...]
const countries = loadedData.countries;

// в зависимости от выбранного country
// например, для country=RU
// [{title: 'Москва', value: 'MSC'},
// {title: 'Санкт-Петербург', value: 'SPB'},
// ...]
// если country не выбран, то cities = [];
const cities = loadedData.cities;

// если страна уже выбрана
if (country) {
    // то выбираем первый доступный город
    ChartEditor.updateParams({city: [cities[0].value]});
}

module.exports = [
    {
        type: 'select',
        param: 'country',
        content: countries,
        postUpdateOnChange: true
    },
    {
        type: 'select',
        param: 'city',
        content: cities,
        updateOnChange: true
    }
];
```

## Переходы на новую строку {#switch-line}

По умолчанию контролы отображаются в одну строку (исключением являются [Селекторы](../widgets/selector/index.md)).
Для того, чтобы контролы не растягивались по ширине и переходили на новую строку, доступно свойство `lineBreaks: wrap`.

Также можно воспользоваться контролом [перехода на новую строку](elements.md#switch-line).

### Пример {#switch-line-example}

```javascript
module.exports = {
    lineBreaks: 'wrap',
    controls: [
        {
            type: 'select',
            param: 'scale',
            content: [
                {title: 'День', value: 'd'},
                {title: 'Неделя', value: 'w'},
                {title: 'Месяц', value: 'm'}
            ]
        },
        {
            type: 'datepicker',
            param: 'date'
        },
        {
            type: 'button',
            label: 'Показать',
            updateOnChange: true
        }
    ]
};
```
