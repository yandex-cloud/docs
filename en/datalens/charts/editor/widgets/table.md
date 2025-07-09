---
title: How to work with tables in Editor
description: In this tutorial, you will learn how to work with tables in Editor.
---

# Table


{% include [business-note](../../../../_includes/datalens/datalens-functionality-available-business-note.md) %}


This type of chart supports the same functionality as the [table](../../../visualization-ref/table-chart.md) in the wizard: you can customize styles, set up cross-filtering, pagination, etc.

## Structure on the Prepare tab {#prepare}

On the **Prepare** tab, in `module.exports`, you need to create a structure:

```js
module.exports = {
    head: ...,
    rows: ...,
    footer: ...,
};
```

The required `head` field configures the table header cells.

The field value is an array of JSON objects in the following format:

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

Where:

* `id`: Contains a unique ID of the table column. Required field; string value type.
* `name`: Outputs the value to the table header cell unless `formattedName` is explicitly specified. Optional field; string value type.
* `formattedName`: Outputs the value to the table header cell, overriding the `name` field value. Optional field; value type: string or a markup result set through the [Editor.generateHtml(args)](../methods.md#gen-html) function.
* `type`: Sets the column data type. Optional field; string value type. Possible values:
  
  * `text`: String.
  * `number`: Number.
  * `date`: Date (in milliseconds) with time displayed in the browser time zone.
  * `bar`: Indicator.
  
  The default value is `text`.

* `hint`: Tooltip in the table header cell. When hovering over the question mark, the tooltip displays the field value. Optional field; string value type (with Markdown support).
* `format`: Sets the column data formatting. Optional field; string value type, available for a `date` type field. Example of a `format` value:

  ```
  format: "DD/MM/YY HH:mm:ss"
  ```

* `formatter`: Sets the column data formatting. Optional field; value type is object in this format:

  ```
  {
      precision: <number>,
      multiplier: <number>,
      suffix: "<string>",
      prefix: "<string>",
  }
  ```

  Where:

  * `precision`: Rounding precision (number of decimal places) for all values in the column. Available for `number` type fields.
  * `multiplier`: Multiplier for all values in the column. Available for `number` type fields.
  * `suffix`: Text to output after a cell value in the entire column.
  * `prefix`: Text to output before a cell value in the entire column.

* `align`: Indicator alignment within a cell. Optional field; available for `bar` type fields. String value type, possible values are `right` and `left`. The default value is `right`.

  {% note info %}

  If you only specify the `max` value, Editor will render a bar from left to right. You can change this with `align: 'right'`.

  If you only specify the `min` value, Editor will render a bar from right to left. You can change this with `align: 'left'`.

  If you specify both `max` and `min`, a floating zero appears, from which the bar is rendered to the right for positive values and to the left for negative ones. In this case, Editor ignores the `align` value.

  {% endnote %}

* `min`: Minimum threshold for an indicator. Optional field; number value type. Available for `bar` type fields.
* `max`: Maximum threshold for an indicator. Optional field; number value type. Available for `bar` type fields.
* `showLabel`: Displaying the indicator label. Optional field; number value type. Available for `bar` type fields. The default value is `true`.
* `barHeight`: CSS style for the indicator height. Optional field; available for `bar` type fields. Number or string value type from the available height CSS style values. The default value is `100%`.
* `width`: Column cell width. Optional field. Number or string value type from the available width CSS style values. The default value is `auto`.
* `group`: Whether to group values into a single cell. Applies to consecutive identical cell values in the column. Optional field; `boolean` value type. The default value is `false`.
* `pinned`: Whether the column is pinned when scrolling horizontally. Optional field; `boolean` value type. The default value is `false`.
* `css`: Description of CSS styles for the table header cell. Optional field; value type: object from CSS properties.
* `sub`: Array of table header cells for setting a two-tier head. The array elements must be objects with fields identical to the `head` field ones.
* `custom`: Cell parameter configuration for cross-filtering. For more information, see [{#T}](../cross-filtration.md).

The `rows` field is a required one; it contains the configuration for table cell contents.

The field value is a JSON object in the following format:

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

Where:

* `value`: Table cell content value unless `formattedValue` is set. Required field; string, number or date value type. For `bar` type cells, this is the indicator value.
* `formattedValue`: Table cell content value which overrides `value`. Optional field; value type: string, number, date, or a markup result set through the [Editor.generateHtml(args)](../methods.md#gen-html) function. In `bar` cells, it is used for the indicator label.
* `type`: Overrides the `head` value for a specific cell. For more information about the field, see above.
* `align`: Sets the indicator alignment value, if not specified in `head`. For more information about the field, see above.
* `min`: Sets the minimum threshold value for an indicator, if not specified in `head`. For more information about the field, see above.
* `max`: Sets the maximum threshold value for an indicator, if not specified in `head`. For more information about the field, see above.
* `showLabel`: Sets how to display the indicator label, if not specified in `head`. For more information about the field, see above.
* `barHeight`: Sets how to style the indicator height in CSS, if not specified in `head`. For more information about the field, see above.
* `css`: Description of CSS styles for a table cell. Optional field; value type: object from CSS properties.
* `link`: Sets the display of the entire cell content as a link for `text` type columns. Optional field; value type is object in this format:

  ```json
  {
      href: "<string>",
      newWindow: <boolean>,
  }
  ```

  Where:

  * `href`: URL to go to.
  * `newWindow`: Indicates whether to open the link in a new window.

* `onClick`: Action on cell click. Optional field; value type is object in this format:

  ```json
  {
      action: "<string>",
      args: <object>,
  }
  ```

  Where:

  * `action`: Action type. Possible values: `setParams` (sets new parameter values on click).
  * `args`: Static arguments for the action, e.g., for `setParams`, the arguments are an object with a key and a new parameter value.

  The `footer` field is an optional one; it contains the configuration for table footer cells. Its format is identical to the `rows` field.

### Available methods {#methods}

Supports the same functionality as the [table](../../../visualization-ref/table-chart.md) in a wizard.

## Structure on the Config tab {#config}

This tab describes visualization settings. Use `module.exports` on the **Config** tab to create a structure:


```js
module.exports = {
    title: <object>,
    sort: "<string>",
    order: "<string>",
    paginator: <object>,
    size: "<string>",
    events: {
        click: [{
        // You can also define it as an array of objects.
            handler: {type: 'setActionParams'},
        // Currently, only one scope, 'row', is supported.
            scope: 'row',
      }
    ]},
};
```

Where all fields are optional:

* `title`: Object in the following format:

  ```json
  {
      text: "<string>",
      style: <object>,
          // header CSS styles
          style: {
              'text-align': 'center',
              'font-size': '20px'
          }
  ```
  
  Where:

  * `text`: Table header.
  * `style`: Description of CSS styles for the table header. Value type: object from CSS properties.

* `order`: Sorting order. String value type from these possible values: `acs` (ascending) or `desc` (descending).
* `paginator`: Table pagination configuration. Value type: object in the following format:

  ```json
  {
      enabled: <boolean>,
      limit: <number>,
  }
  ```
  
  Where:

  * `enabled`: Indicates that pagination is enabled. Boolean value type.
  * `limit`: Number of rows per page for pagination. Number value type.

    {% note info %}
    
    If specified, the `limit` field value affects only the number of rows displayed in the pagination component and not the number of rows displayed in the table body. Implement this in code on the **Prepare** tab using the [Editor.getCurrentPage()](../methods.md#get-current-page) helper method.

    {% endnote %}

* `size`: Table size, including font size, line spacing, and indentation within cells. String value type from these possible values: `l`, `m`, or `s`.
* `events`: Specifies a configuration for cross-filtering in the table. To override this configuration for a specific cell, use the `custom` field for the cell. For more information, see [{#T}](../cross-filtration.md).

## Examples {#examples}

* [Table with additional formatting and special elements inserted in chart cells](https://datalens.yandex/nvkfwnekf9xy9?tab=OXk#Пример%20Таблицы%20с%20дополнительными%20форматированием%20и%20вставкой%20спец%20элементов%20в%20ячейках%20чарта)
* [Table with a dynamic set of columns](https://datalens.yandex/nvkfwnekf9xy9?tab=OXk#Пример%20Таблицы%20с%20динамическим%20набором%20столбцов)
* [Table with indicators in cells](https://datalens.yandex/nvkfwnekf9xy9?tab=OXk#Пример%20Таблицы%20с%20индикаторами%20в%20ячейках)