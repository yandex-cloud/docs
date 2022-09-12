## Config {#config}

### Общая информация {#common-config}

В результате выполнения вкладки Config должны быть экспортированы данные, отвечающие за дополнительную конфигурацию
отображения.

### Пример {#example-config}

```js
module.exports = {
    // Higcharts-тип графика или один из кастомных типов
    // 'stack' - слоёные области
    // 'stacked_column' - слоёные колонки
    // 'stacked_100p' - слоёные облати с масштабом в 100%
    // 'stacked_column_100p' - слоёные колонки с масштабом в 100%
    type: 'line',
    // показывать ли проценты в тултипе (актуально для типов чарта: 'pie', 'funnel' и 'solidgauge' и графиков со stack: 'normal')
    showPercentInTooltip: true,
    // количество знаков после запятой у процентых значений в тултипе (актуально при showPercentInTooltip: true)
    tooltipPercentPrecision: 2, // по умолчанию - 1
    // сортировка рядов: 'byLastValue' - по последнему значению, 'alphabet' - по алфавиту
    // по умолчанию отображаются в том порядке, в котором заданы
    orderType: 'byLastValue',
    // направление сортировки рядов: 'fromTop - прямой, 'fromBottom' - обратный.
    orderSort: 'fromBottom',
    // скрытие комментариев при загрузке
    hideComments: true,
    // включить сумму в тултипе
    // по умолчанию включено для типов 'stack', 'stacked_100p', 'stacked_column', 'stacked_column_100p'
    // какие конкретно ряды должны попасть в сумму регулируется свойством ряда 'useInSum: true'
    enableSum: true,
    // округление значений
    precision: 2,
    // убрать эту кнопку "Скрыть все ряды"
    removeShowHideAll: true,
    // убрать вертикальные серые линии выходных и праздников
    hideHolidaysBands: true,
    // не перекрывать график контролами
    notOverlayControls: true,
    // настройки полосы навигатора
    highstock: {
        // минимальное начальное положение навигатора в миллисекундах
        range_min : 1510458756080,
        // максимальное начальное положение навигатора в миллисекундах
        range_max : 1518458756080,
        // name ряда, который будет отображаться в навигаторе
        base_series_name: 'hits'
    },
    // настройки комментариев
    comments: {
        // значимые параметры - имя параметров графика, чьи значения будут учитываться при создании комментария
        // (значимые параметры формируют срез для комментариев)
        matchedParams: ['service'],
        // способ совпадения параметров комментария и значимых параметров:
        // 'full' - полное совпадение параметров комментария и значимых параметров,
        // 'contains' - параметры комментария являются подмножеством значимых параметров
        // (по умолчанию: 'full')
        // пример:
        //     - параметры графика: {region: 'RU', scale: 'd', service: 'charts'}
        //     - значимые параметры: ['region', 'scale']
        //     - способ совпадения 'full':
        //         - комментарий с параметрами {region: 'RU', scale: 'd'} попадет в список
        //         - комментарий с параметрами {region: 'RU'} не попадет в список
        //     - способ совпадения 'contains':
        //         - комментарий с параметрами {region: 'RU', scale: 'd'} попадет в список
        //         - комментарий с параметрами {region: 'RU'} попадет в список
        matchType: 'contains',
        // массив каналов
        // всегда содержит {feed: <имя текущего графика>, matchedParams: <описанные выше>}
        feeds: [
            {
                // название канала
                // (стоит использовать максимально уникальное, чтобы избежать коллизий)
                feed: 'service/login/regions',
                matchedParams: ['region']
            },
            {
                feed: 'service/login/versions'
            }
        ],
        // отображать комментарии, которые не попадают в текущую сетку (скейл) графика
        // (по умолчанию: false)
        ignoreScale: false
    },
    // переопределение информации, выводимой в тултипе (по умолчанию: null)
    manageTooltipConfig: function (config, chart) {
        // массив с рядом
        config.lines.forEach(function (line) {
            // префикс
            line.valuePrefix = '-';
            // суффикс
            line.valueSuffix = 'kg';

            line.commentText = 'Комментарий к точке';

            // меняем значение (в этом примере с помощью деления)
            line.value = Highcharts.numberFormat(line.originalValue / 100, 1);
        });

        // выставляем сумму рядов
        config.sum = 100;

        config.commentDateText = 'Комментарий к дате';

        // возвращаем переопределенную информацию
        return config;
    }
};
```

#### Дополнительные возможности переопределения тултипа {#additional-options-tooltip-config}
Помимо стандартных для Highcharts методов переопределения строк тултипа [pointFormat](https://api.highcharts.com/highcharts/tooltip.pointFormat) 
и [pointFormatter](https://api.highcharts.com/highcharts/tooltip.pointFormat) (смотри [пример](https://datalens-staging.yandex-team.ru/editor/5xzcv2k7ler61-tooltip-pointformat-example)), на уровне библиотеки [ChartKit](https://github.yandex-team.ru/data-ui/chartkit) 
поддержаны два дополнительных метода, которые могут быть определены на вкладке Config: ```replaceCellAt``` - с помощью которого можно переопределить не всю строку, а лишь отдельную ячейку и ```insertCellAt``` - позволяющий добавить
дополнительную ячейку:
* ```replaceCellAt``` - принимает объект, где ключ - индекс ячейки которая должна быть переопределена, значение - строка либо функция возвращающая строку, которая будет отрендерена на месте 
переопределённой ячейки.
* ```insertCellAt``` - принимает объект, где ключ - индекс на место которого будет вставлена новая ячейка, сдвинув, при этом, существующие, а значение - строка либо функция возвращающая строку,  
которая будет отрендерена в добавившейся ячейке.

**Пример:**
Для подавляющего большинства типов визуализаций строка данных в тултипе состоит из трёх ячеек: цвет, название и значение. Например, мы собираемся переопределить ячейку цвета, сделав 
её больше и добавляя поверх текст `new` в некоторых случаях, а также хотим добавить новую ячейку между названием и значением, где будем выводить дополнительную информацию. Ниже - код, 
который потребуется для реализации описанного, [по ссылке пример в Chart Editor](https://datalens.yandex-team.ru/editor/kbyezcqk81xgg-tooltip-customization-example?_t=graph).
```js
module.exports = {
    // переопределяем первую ячейку в которой отображается цвет линии
    replaceCellAt: {
        "0": function(data) {
            return (
                `<td>
                    <div style="background-color: ${data.seriesColor}; width: 32px; height: 16px; text-align: center; color: white; line-height: 16px">
                        ${data.isNew > 0.5 ? 'new' : ''}
                    </div>
                </td>`
            );
        },
    },
    // вставляем новую ячейку между названием и значением
    insertCellAt: {
        "2": function(data) {
            return (
                `<td>
                    ${data.note}
                </td>`
            );
        },
    },
};
```