
# Selectors

* [General information](#common)
* [Available methods](#available-methods)
* [Available controls](#available-controls)
* [Updating parameters and re-rendering the chart](#changing-chart-parametrs)
* [Independent re-rendering of controls](#redrawing-controls)
* [Updating multiple parameters](#changing-several-parameters)
* [Line breaks](#switch-line)

## General information {#common}

When the [Controls](../architecture.md#controls) tab is executed, the data required to render the chart's controls need to be exported.

The controls are mainly designed for updating the parameters and re-rendering the chart.
To learn about the chart parameters, read the [section](../architecture.md#params).

For each specific control, you can specify an operator in the `OPERATIONS` dictionary. After that, a string defining the operator type will be added to the parameter. For example, a selector with the `GT` operator and the value `42` will define the parameter `__gt_42`.

The tab is available only for a [Chart](../widgets/chart/index.md), [Table](../widgets/table/index.md), and [Selector](../widgets/selector/index.md).

## Available methods {#available-methods}

* **`ChartEditor.getParams()`**: Returns an object with normalized parameters.

* **`ChartEditor.getParam(name)`**: Returns a normalized value of the parameter named as `name: string`.

* **`ChartEditor.getLoadedData()`**: Returns an object with the data requested in the Urls tab.

* **`ChartEditor.updateParams(params)`** adds the `params: object` argument to the chart parameters.
   The parameter values must be normalized (that is, single values must be wrapped in an array).
   Calling this method only makes sense when a control with [`postUpdateOnChange`](#changing-several-parameters) is updated.
   Otherwise, calling this method might cause malfunctioning of the component and its linked elements.

* **`ChartEditor.resolveOperation()`**: Enables you to parse the parameters and get the operator type and value separately.

## Available controls {#available-controls}

* [Input field](elements.md#input)
* [Textarea](elements.md#textarea)
* [Calendar](elements.md#calendar)
* [Calendar for interval](elements.md#calendar-interval)
* [Select](elements.md#select)
* [Checkbox](elements.md#checkbox)
* [Button](elements.md#button)
* [Line break](elements.md#switch-line)

## Updating parameters and re-rendering the chart {#changing-chart-parametrs}

{% include [params-dynamic-note](../../../_includes/datalens/params-dynamic-note.md) %}

All controls, except for the [button](elements.md#button) and [line break](elements.md#switch-line),
must be linked to some chart parameter.
When such a control is updated, the same value is assigned to the linked parameter when the chart is re-rendered next time.

For the updated control to start re-rendering of the chart, it needs to have the property `updateOnChange: true`.

### Example 1 {#changing-chart-parametrs-example-1}

When the select changes its value, for example, to `Day`, the chart is re-rendered with the parameter `{scale: ['d']}`.

Tab **Controls**

```js
module.exports = [
    {
        type: 'select',
        param: 'scale',
        content: [
            {title: 'Day', value: 'd'},
            {title: 'Week', value: 'w'},
            {title: 'Month', value: 'm'}
        ],
        updateOnChange: true
    },
];
```

### Example 2 {#changing-chart-parametrs-example-2}

The chart is re-rendered only on button click and will only reflect updates in the selector and calendar.
That is, when the select changes its value, for example, to `Day`, then when the calendar changes to `2020-01-21`
and the button is clicked, the chart is re-rendered with the parameters `{scale: ['d'], date: ['2020-01-21']}`.

Tab **Controls**

```js
module.exports = [
    {
        type: 'select',
        param: 'scale',
        content: [
            {title: 'Day', value: 'd'},
            {title: 'Week', value: 'w'},
            {title: 'Month', value: 'm'}
        ]
    },
    {
        type: 'datepicker',
        param: 'date'
    },
    {
        type: 'button',
        label: 'Show',
        updateOnChange: true
    }
];
```

## Independent re-rendering of controls {#redrawing-controls}

To re-render only the controls section without affecting the chart, the control needs to be assigned the property`updateControlsOnChange: true`.

Updating such a control initiates re-rendering where the server only executes the tabs 
[Shared](../architecture.md#shared),
[Params](../architecture.md#params),
[Urls](../architecture.md#urls), and 
[Controls](../architecture.md#controls).

Besides, the [Urls](../architecture.md#urls) tab only requests the sources with `ui: true`.
That's why calling the `ChartEditor.getLoadedData()` method after such a re-rendering only returns the data on repeatedly requested sources.

### Example {#redrawing-controls-example}

The `controls` source works so that if both parameters are empty, only the country list is returned.
If the `country` is specified, it returns a list of countries and a list of cities for the selected `country`.

The `data` source only returns data when both the `country` and `city` are specified.

Originally, the values of neither of the parameters are set.

When you set a value in the `country` selector, only the controls section is re-rendered and the `controls` source is requested again with the given value of the `country` parameter.

Selecting a value in the `city` selector re-renders the chart and repeats requests to all the sources with the given `country` and `city`.

**Params** tab:

```js
module.exports = {
    country: '',
    city: ''
}
```

**Urls** tab

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

Tab **Controls**

```js
const params = ChartEditor.getParams();
const country = params.country[0];
const city = params.city[0];

const loadedData = ChartEditor.getLoadedData();

// [{title: 'Russia', value: 'RU'},
// {title: 'Kazakhstan', value: 'KZ'},
// ...]
const countries = loadedData.countries;

// Depending on the selected country
// For example, for country=RU
// [{title: 'Moscow', value: 'MSC'},
// {title: 'Saint-Petersburg', value: 'SPB'},
// ...]
// If the country isn't selected, then cities = [];
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

## Updating multiple parameters {#changing-several-parameters}

To change multiple parameters per control update, use `postUpdateOnChange`.

Updating such a control initiates [independent re-rendering of controls](#redrawing-controls) 
with subsequent re-rendering of the entire chart.
Be sure to specify `ui: true` for the sources whose data will be rendered independently.
To update the parameters, the Controls tab needs to call the method `ChartEditor.updateParams`
with the new parameter values.

In other words, updating the control value initiates [independent re-rendering of controls](#redrawing-controls) with
executing the Controls tab by calling the `ChartEditor.updateParams` method. Then the 
entire chart is re-rendered in the context of the updated control value and the parameters passed in `ChartEditor.updateParams`.

You can also use a [button](elements.md#button) with `onClick`.

### Example 1 {#changing-several-parametrs-example-1}

[Example on Yandex Charts](https://charts.yandex-team.ru/navigation/fep0b5zmdy0qb)

### Example 2 {#changing-several-parametrs-example-2}

The `controls` source works so that if both parameters are empty, only the country list is returned.
If the `country` is specified, it returns a list of countries and a list of cities for the selected `country`.

The `data` source only returns data when both the `country` and `city` are specified.

Originally, the values of neither of the parameters are set.

When you set a value in the `country` selector, the controls section is re-rendered and the `controls `source is requested again with the given value of the `country` parameter.
Then the Controls tab for the `city` parameter will show the first available out of the possible values.
After that, the chart is re-rendered in the context of the selected `country` and `city`.

Selecting a value in the `city` selector re-renders the chart and repeats requests to all the sources with the given `country` and `city`.

**Params** tab:

```js
module.exports = {
    country: '',
    city: ''
}
```

**Urls** tab

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

Tab **Controls**

```js
const params = ChartEditor.getParams();
const country = params.country[0];
const city = params.city[0];

const loadedData = ChartEditor.getLoadedData();

// [{title: 'Russia', value: 'RU'},
// {title: 'Kazakhstan', value: 'KZ'},
// ...]
const countries = loadedData.countries;

// Depending on the selected country
// For example, for country=RU
// [{title: 'Moscow', value: 'MSC'},
// {title: 'Saint-Petersburg', value: 'SPB'},
// ...]
// If the country isn't selected, then cities = [];
const cities = loadedData.cities;

// If the country is already selected,
if (country) {
    // select the first available city
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

## Line breaks {#switch-line}

By default, the controls are shown as single-line (except for [Selectors](../widgets/selector/index.md)).
To avoid too wide controls and wrap them to the next line, use the `lineBreaks: wrap` property.

As an alternative, you can use the [line break](elements.md#switch-line) control.

### Example {#switch-line-example}

```javascript
module.exports = {
    lineBreaks: 'wrap',
    controls: [
        {
            type: 'select',
            param: 'scale',
            content: [
                {title: 'Day', value: 'd'},
                {title: 'Week', value: 'w'},
                {title: 'Month', value: 'm'}
            ]
        },
        {
            type: 'datepicker',
            param: 'date'
        },
        {
            type: 'button',
            label: 'Show',
            updateOnChange: true
        }
    ]
};
```
