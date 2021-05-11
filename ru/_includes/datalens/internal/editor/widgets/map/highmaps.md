## Highmaps {#highmaps}

### Общая информация {#common}

В результате выполнения вкладки Highmaps должны быть экспортированы данные для настройки карты средствами [Highmaps](http://api.highcharts.com/highmaps).

### Пример {#example}

```js
module.exports = {
    title: {
        text: 'Заголовок'
    },
    subtitle: {
        text: 'Подзаголовок'
    },
    plotOptions: {
        map: {
            dataLabels: {
                // показывать значения на точках
                enabled: true
            }
        }
    }
};
```
