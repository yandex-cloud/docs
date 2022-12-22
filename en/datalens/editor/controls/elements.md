
# Elements available in selectors

* [Input field](#input)
* [Textarea](#textarea)
* [Calendar](#calendar)
* [Calendar for interval](#calendar-interval)
* [Select](#select)
* [Checkbox](#checkbox)
* [Button](#button)
* [Line break](#switch-line)

### Input field {#input}

```javascript
{
    // Control type
    type: 'input',

    // Linked parameter
    param: 'input',

    // Width
    width: '200px',

    // Hide control
    hidden: false,

    // Label
    label: 'Text field',

    // Text placeholder shown when no text is entered
    placeholder: 'Enter text',
},
```

### Textarea {#textarea}

A button that, when clicked, opens a dialog with `textarea`.

```js
{
    // Control type
    type: 'textarea',

    // Linked parameter
    param: 'textarea',

    // Button width
    width: '200px',

    // Hide control
    hidden: false,

    // Label for the button and dialog
    label: 'Text area',

    // Placeholder text
    placeholder: 'Type text',

    // Button theme
    theme: 'normal',
},
```

### Calendar {#calendar}

```javascript
{
    // Control type
    type: 'datepicker',

    // Linked parameter
    param: 'datepicker',

    // Width
    width: 170,

    // Hide control
    hidden: false,

    // Label
    label: 'Date',

    // Minimum possible value in ISO
    minDate: null,

    // Maximum possible value in ISO
    maxDate: '2019-09-30',
},
```

The value of the linked parameter must be a string with ISO date or a [relative date](../params.md#relativedate).

### Calendar for interval {#calendar-interval}

```javascript
{
    // Control type
    type: 'range-datepicker',

    // Linked parameter at the end of interval
    paramFrom: 'rangeDatepickerFrom',

    // Linked parameter at the beginning of interval
    paramTo: 'rangeDatepickerTo',

    // Linked parameter of the interval
    // param: 'rangeDatepicker',

    // Width
    width: 250,

    // Hide control
    hidden: false,

    // Label
    label: 'Calendar',

    // Minimum possible value
    minDate: '2019-09-01',

    // Maximum possible value 
    maxDate: null,
},
```

The value of the linked parameters `paramFrom` and `paramTo` must be a string with an ISO date or a [relative date](../params.md#relativedate).

The value of the linked `param` parameter must be an [interval](../params.md#interval).

### Select {#select}

```javascript
{
    // Control type
    type: 'select' ,

    // Linked parameter
    param: 'select',

    // Width
    width: '140px',

    // Hide control
    hidden: false,

    // Label
    label: 'Select',

    // Show title inside
    labelInside: true,

    // Multiple choice
    multiselect: false,

    // Add search string
    searchable: false,

    // Content
    content: [
        // The value must be a string because all parameters are cast as strings
        // true -> 'true', 42 -> '42'
        // Otherwise, the parameter value won't match any of the listed ones
        // and it will look as if no value has been selected
        {title: 'Daily', value: 'd'},
        {title: 'Weekly', value: 'w'},
        {title: 'Monthly', value: 'm'},
    ],
},
```

### Checkbox {#checkbox}

A selected checkbox means that the linked parameter is set to `"true"` (a string), and a cleared checkbox means `"false"`.

```javascript
{
    // Control type
    type: 'checkbox',

    // Linked parameter
    param: 'checkbox',

    // Width
    width: null,

    // Hide control
    hidden: false,

    // Label
    label: 'Checkbox',
},
```

### Button {#button}

```javascript
{
    // Control type
    type: 'button',

    // Width
    width: null,

    // Hide control
    hidden: false,

    // Text
    label: 'Go',

    // Button theme
    theme: 'action',

    // Action on click
    onClick: {
        // Action type
        // Possible values: setParams
        action: 'setParams',
        // Static arguments
        args: {
            scale: 'd',
            region: 'RU'
        }
    }
}
```

### Line break {#switch-line}

```js
{
    // Control type
    type: 'line-break'
}
```
