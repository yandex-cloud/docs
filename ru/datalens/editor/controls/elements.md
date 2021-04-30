
# Доступные в селекторах элементы

* [Поле ввода](#input)
* [Textarea](#textarea)
* [Календарь](#calendar)
* [Календарь на интервал](#calendar-interval)
* [Селект](#select)
* [Чекбокс](#checkbox)
* [Кнопка](#button)
* [Переход на новую строку](#switch-line)

### Поле ввода {#input}

```javascript
{
    // тип контрола
    type: 'input',

    // связанный параметр
    param: 'input',

    // ширина
    width: '200px',

    // скрыть контрол
    hidden: false,

    // заголовок
    label: 'Поле ввода',

    // текст-заглушка, когда у поля нет содержимого
    placeholder: 'Введите текст',
},
```

### Textarea {#textarea}

Кнопка, по клику на которую будет открыт дилог с `textarea`.

```js
{
    // тип контрола
    type: 'textarea',

    // связанный параметр
    param: 'textarea',

    // ширина кнопки
    width: '200px',

    // скрыть контрол
    hidden: false,

    // заголовок кнопки и диалога
    label: 'Область текста',

    // текст-заглушка
    placeholder: 'Введите текст',

    // тема кнопки
    theme: 'normal',
},
```

### Календарь {#calendar}

```javascript
{
    // тип контрола
    type: 'datepicker',

    // связанный параметр
    param: 'datepicker',

    // ширина
    width: 170,

    // скрыть контрол
    hidden: false,

    // заголовок
    label: 'Дата',

    // минимальное возможное значение в ISO
    minDate: null,

    // максимальное возможное значение в ISO
    maxDate: '2019-09-30',
},
```

Значением связанного параметра должна быть строка с ISO датой или [относительная дата](../params.md#relativedate).

### Календарь на интервал {#calendar-interval}

```javascript
{
    // тип контрола
    type: 'range-datepicker',

    // связанный параметр конца интервала
    paramFrom: 'rangeDatepickerFrom',

    // связанный параметр начала интервала
    paramTo: 'rangeDatepickerTo',

    // связанный параметр интервала
    // param: 'rangeDatepicker',

    // ширина
    width: 250,

    // скрыть контрол
    hidden: false,

    // заголовок
    label: 'Календарь',

    // минимальное возможное значение
    minDate: '2019-09-01',

    // максимальное возможное значение
    maxDate: null,
},
```

Значением связанных параметров `paramFrom` и `paramTo` должна быть строка с ISO датой или [относительная дата](../params.md#relativedate).

Значением связанного параметра `param` должен быть [интервал](../params.md#interval).

### Селект {#select}

```javascript
{
    // тип контрола
    type: 'select' ,

    // связанный параметр
    param: 'select',

    // ширина
    width: '140px',

    // скрыть контрол
    hidden: false,

    // заголовок
    label: 'Селект',

    // отображать заголовок внутри
    labelInside: true,

    // множественный выбор
    multiselect: false,

    // добавить поисковую строку
    searchable: false,

    // содержимое
    content: [
        // value обязательно должно быть строкой, т.к. все параметры приводятся к строке
        // true -> 'true', 42 -> '42'
        // в противном случае значение параметра не совпадет ни с одним из перечисленных,
        // а выглядеть будет как будто значение не выбрано
        {title: 'Daily', value: 'd'},
        {title: 'Weekly', value: 'w'},
        {title: 'Monthly', value: 'm'},
    ],
},
```

### Чекбокс {#checkbox}

Отмеченный чекбокс устанавливает значение связанного параметра равное `"true"` (именно строкой), снятый — в `"false"`.

```javascript
{
    // тип контрола
    type: 'checkbox',

    // связанный параметр
    param: 'checkbox',

    // ширина
    width: null,

    // скрыть контрол
    hidden: false,

    // заголовок
    label: 'Чекбокс',
},
```

### Кнопка {#button}

```javascript
{
    // тип контрола
    type: 'button',

    // ширина
    width: null,

    // скрыть контрол
    hidden: false,

    // текст
    label: 'Go',

    // тема кнопки
    theme: 'action',

    // действие по клику
    onClick: {
        // тип действия
        // возможные значения: setParams
        action: 'setParams',
        // статические аргументы
        args: {
            scale: 'd',
            region: 'RU'
        }
    }
}
```

### Переход на новую строку {#switch-line}

```js
{
    // тип контрола
    type: 'line-break'
}
```
