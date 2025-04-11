---
title: Advanced-чарт
description: Из статьи вы узнаете, что такое Advanced-чарт в {{ datalens-full-name }}.
---

# Advanced-чарт

{% include [business-note](../../../../_includes/datalens/datalens-functionality-available-business-note.md) %}

Этот тип визуализации позволяет создавать HTML с безопасной разметкой через функцию [Editor.generateHtml(args)](../methods.md#gen-html) и гибкие SVG-визуализации с использованием библиотек `d3`, `d3-chord` и `d3-sankey`.

На вкладке **Prepare** необходимо сформировать структуру:

```js
module.exports = {
    render: Editor.wrapFn(...),
};
```

Подробнее о методе [Editor.wrapFn](../methods.md#wrap).

{% note info %}

Advanced-чарты работают медленнее других визуализаций. Рекомендуем использовать их только при необходимости, когда не хватает возможностей обычных чартов.

{% endnote %}

## Как начать работу с Advanced-чартом {#begin}

1. Для отрисовки чарта определите функцию `render`:

    ```js
    module.exports = {
        render: Editor.wrapFn({
            fn: function() {
                return 'Hello, world!';
            },
        })
    };
    ```

1. Добавьте необходимую верстку:

    ```js
    module.exports = {
        render: Editor.wrapFn({
            fn: function() {
                const content = 'Hello, world!';
    
                return Editor.generateHtml(`
                  <div style="display: flex; background: black;">
                    ${content}
                  </div>
                `);
            },
        })
    };
    ```

1. Для использования данных с сервера подготовьте и передайте аргументы в функцию:

    ```js
    // Подготовьте данные для отрисовки чарта.  
    const content = 'Hello, world!';
    
    module.exports = {
        render: Editor.wrapFn({
	    // Первым аргументом всегда будут параметры чарта
	    // переменные из args идут далее
            fn: function(options, content) {
                const {width, height} = options;
    
                return Editor.generateHtml(`
                  <div style="width: ${width}; height: ${height}">
                    ${content}
                  </div>
                `);
            },
            args: [content],
        })
    };
    ```

Лучше выполнять сортировку и группировку данных до передачи их в функцию `render`, чтобы снизить нагрузку на браузер клиента.

## Подключение сторонних библиотек {#outer-libs}

В функцию чарта можно добавить сторонние библиотеки через параметр `libs` в `wrapFn`:

```js
module.exports = {
    render: Editor.wrapFn({
        fn: function(options) {
            const {width, height} = options;
            const element = d3.create('svg')
                .attr('width', width)
                .attr('height', height);

            element
                .append('g')
                .append('text')
                    .text('Hello, world!')
                    .style('alignment-baseline', 'before-edge');

            return Editor.generateHtml(element.node());
        },
        libs: ['d3'],
    })
};
```

Доступные библиотеки:

```
'date-utils@2.3.0'
'date-utils@2.5.3' (alias: 'date-utils')
'd3@7.9.0' (alias: 'd3')
'd3-chord@3.0.1' (alis: 'd3-chord')
'd3-sankey@0.12.3' (alias: 'd3-sankey')
```

## Доступные методы {#methods}

Весь код для Advanced-чарта исполняется в песочнице на основе QuickJs, что ограничивает доступ к методам браузерного API и DOM. Для работы с деревом элементов добавлены синтетические элементы `document`, которые не связаны с «внешним миром».

Для упрощения работы с данными внутри поддержаны дополнительные методы:

```js
// аналог браузерного console.log для отладки кода
console.log(..args: unknown[])

// аналог браузерного setTimeout и clearTimeout
setTimeout: (handler: TimerHandler, timeout: number)
clearTimeout(timeoutId)

// для работы с HTML
// при возврате из функции строки без обертки в generateHtml, данные будут экранированы
Editor.generateHtml(value: string | object)

// В чарте можно объявить дополнительные параметры, которые будут влиять на отображение при работе с событиями, например. 
// Методы работы со стейтом:
// получения состояния чарта
Chart.getState()
// обновление состояния чарта
// При вызове метода будет выполнен метод render. Если нужно обновить состояние без перерисовки, нужно добавить вторым аргументом {silent: true}
Chart.setState(state: object, options?: {silent: boolean})

// Простановка параметров кросс-фильтрации. Подробнее в разделе чарт-чарт фильтрация
Editor.updateActionParams(params)
```

## События {#actions}

Доступные события:

```js
events: {
    click: Editor.wrapFn({
        fn: function(event) {
            ...
        },
    }),
    keydown: Editor.wrapFn({
        fn: function(event) {
            ...
        },
    }),
},
```

## Тултип {#tooltip}

Пример:

```js
module.exports = {
    render: Editor.wrapFn({
        fn: function() {
            ...
        },
    }),
    tooltip: {
        renderer: Editor.wrapFn({
            fn: function(event, config) {
                const name = event.target?.getAttribute('data-id');

                if (!name) {
                    return null;
                }

                const item = config.chartData.data.find((d) => d.name === name);
                return Editor.generateHtml(`<div style="padding: 20px;">${item.name}</div>`);
            },
            args: [chartConfig],
        }),
    }
};
```

## Чарт-чарт фильтрация {#chart-chart-filtration}

Пример:

```js
const chartData = [{id: '1', OrderYear: '2024'}];
```

```js
render: Editor.wrapFn({
    fn: function(dimensions, data) {
        ...
            svg.append("g")
                .selectAll()
                .data(data)
                .enter().append('rect')
                .attr('data-id', (d) => d.id)
        ...
    },
    args: [chartData],
    libs: ['d3'],
}),
events: {
        click: Editor.wrapFn({
            fn: function(event, data) {
                const dataId = event.target.getAttribute('data-id');
                const selectedItem = data.find(d => d.id === dataId);

                if (selectedItem) {
                    Chart.updateActionParams({OrderYear: selectedItem.OrderYear});
                }
            },
            args: [chartData],
        }),
    },
...
```

## Примеры {#examples}

Примеры на [демонстрационном дашборде](https://datalens.yandex/2aztx9jtm06ko?tab=Az) на вкладке Advanced.
