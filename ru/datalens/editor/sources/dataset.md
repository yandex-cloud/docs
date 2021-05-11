# Датасет

**Интерфейс**: [`https://datalens.yandex-team.ru/datasets`](https://datalens.yandex-team.ru/datasets)(старая ссылка [`https://stat.yandex-team.ru/datasets`](https://stat.yandex-team.ru/datasets))

**Префикс**: `/_bi` -> `https://back.datalens.yandex-team.ru`

## Формирование источника данных {#forming-data-source}

Для формирования источника данных используется метод `buildSource` модуля `libs/dataset/v1`.
Метод `buildSource` принимает один аргумент типа `object` со следующими свойствами:
|Имя|Тип|Описание|Обязательный / По умолчанию|
|:---|:---|:---|:---|
|id|`string`|Id датасета|Обязательный
|columns|`string[]`|Колонки|Обязательный
|order|`OrderObject[]`|Параметры сортировки по колонкам|-
|where|`FilterObject[]`|Дополнительные условия|-
|limit|`number`|Ограничение выдачи заданным количеством строк|-
|offset|`number`|Смещения выдачи на заданное количество строк|-

`order` – это массив состоящий из `OrderObject`. `OrderObject` выглядит так:
|Имя|Тип|Описание|Обязательный / По умолчанию|
|:---|:---|:---|:---|
|column|`string`|Колонка по которой сортировать|Обязательный
|direction|`OrderEnum`|Порядок сортировки|Обязательный

`OrderEnum` – одно из:
- `ORDERS.DESC` – по убыванию
- `ORDERS.ASC` – по возрастанию

`ORDERS` нужно импортировать из модуля:

`const {ORDERS} = require('libs/dataset/v1');`

`where` – это массив состоящий из `FilterObject`. `FilterObject` выглядит так:

|Имя|Тип|Описание|Обязательный / По умолчанию|
|:---|:---|:---|:---|
|column|`string`|Колонка по которой фильтровать|Обязательный
|operation|`OperationEnum`|Операция сравнения которую применять|Обязательный
|values|`string[]`|Значения с которыми сравнивать|Обязательный

`OperationEnum` – одно из:
- `OPERATIONS.ISNULL` – проверка на NULL
- `OPERATIONS.ISNOTNULL` – проверка на *не* NULL
- `OPERATIONS.GT` – больше
- `OPERATIONS.LT` – меньше
- `OPERATIONS.GTE` – больше или равно
- `OPERATIONS.LTE` – меньше или равно
- `OPERATIONS.EQ` – равно
- `OPERATIONS.NE` – не равно
- `OPERATIONS.STARTSWITH` – начинается на
- `OPERATIONS.ISTARTSWITH` – начинается на (регистронезависимый)
- `OPERATIONS.ENDSWITH` – заканчивается на
- `OPERATIONS.IENDSWITH` – заканчивается на (регистронезависимый)
- `OPERATIONS.CONTAINS` – содержит
- `OPERATIONS.ICONTAINS` – содержит (регистронезависимый)
- `OPERATIONS.NOTCONTAINS` – не содержит
- `OPERATIONS.NOTICONTAINS` – не содержит (регистронезависимый)
- `OPERATIONS.IN` – принадлежит множеству
- `OPERATIONS.NIN` – не принадлежит множеству
- `OPERATIONS.BETWEEN` – между

`OPERATIONS` нужно импортировать из модуля:

`const {OPERATIONS} = require('libs/dataset/v1');`

### Пример {#forming-data-source-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const {buildSource, OPERATIONS, ORDERS} = require('libs/dataset/v1');

// формируем источник данных
module.exports = {
    dataset: buildSource({
        // указываем нужный id датасета
        id: 'y55xt5d3p9csw',

        // запрашиваем две колонки
        columns: ['Category', 'Profit'],

        // формируем where
        where: [{
            // фильтруем по Category
            column: 'Category',

            // чтобы значение принадлежало множеству
            operation: OPERATIONS.IN,

            // множеству из 'Furniture', 'Office Supplies'
            values: ['Furniture', 'Office Supplies'],
        }],

        // настраиваем сортировку
        order_by: [{
            // по убыванию
            direction: ORDERS.DESC,

            // по колонке Profit
            column: 'Profit',
        }],
    }),
};
```

## Примеры {#examples}

[График по данным из Датасета](https://charts.yandex-team.ru/editor/8nhx675cmotg6)
