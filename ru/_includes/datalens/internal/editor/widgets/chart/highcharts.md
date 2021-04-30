## Highcharts {#highcharts}

### Общая информация {#common-highcharts}

В результате выполнения вкладки Highcharts должны быть экпортированы данные для настройки графика средствами
[Highcharts](http://api.highcharts.com/highcharts).

### Пример {#example-highcharts}

```js
module.exports = {
    chart: {
        // меняет фон графика
        backgroundColor: '#ffeba0'
    },
    title: {
        text: 'Заголовок'
    },
    subtitle: {
        text: 'Подзаголовок'
    },
    yAxis: {
        title: {
            text: 'Текст для оси Y',
            // выставляет цвет текста красным и жирным
            style: {
                color: '#ff0000',
                fontWeight: 'bold'
            }
        }
    },
    plotOptions: {
        // для всех типов графиков
        series: {
            // соединять пустые точки
            connectNulls: true
        }
    }
};
```
