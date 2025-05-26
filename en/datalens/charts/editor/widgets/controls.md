---
title: How to work with a dashboard selector in {{ datalens-full-name }}
description: In this tutorial, you will learn how to work with a dashboard selector in {{ datalens-full-name }}.
---

# Selector

{% include [business-note](../../../../_includes/datalens/datalens-functionality-available-business-note.md) %}

Selector describes a set of [controls](#controls) to specify dashboard chart parameters.

The chart parses the parameter and applies a filter based on the field the parameter is linked with (see example). When supplying numeric parameter values to the selector, convert them to a string or an array of strings. This will prevent data presentation inconsistencies in different widget states, e.g., when it is simply displayed on the dashboard or opened for editing.

{% note info %}

During the initial rendering of a dashboard, parameters of all charts remain static. Dynamic changes to the parameters are only possible at subsequent selector updates.

{% endnote %}

As a result of executing the [Controls](../tabs.md#controls) tab, the chart controls rendering data should be exported. This tab is available only for the following visualizations: [Chart](./chart.md), [Advanced chart](advanced.md), [Table](./table.md), Selector.

The controls are mainly designed for updating the parameters and re-rendering the chart. See the [Params](../tabs.md#params) tab description for details on the chart parameters.

## Structure on the Controls tab {#controls}

You need to create a structure on the **Controls** tab in module.exports:

```js
module.exports = {
    controls: [
        {
            // single control structure
        },
        ...
    ],
};
```

The structure depends on control type.

## Fields common to all controls {#common-fields}

There are fields common to all control types:

* `type`: Control type. Required field; string value type from these available values: `input`, `textarea`, `datepicker`, `range-datepicker`, `select`, `checkbox`, `line-break`, `button`.
* `param`: Name of the linked parameter. Required field; string value type. This option is available for all control types except `line-break`. If you change the value of such a control, the same value will be assigned to the linked parameter the next time the chart is re-rendered.
* `updateOnChange`: Property to initiate an update and re-rendering of the chart. You can set a value for each control to re-render it on change or only for a button, in which case all the changes made to the controls will be applied in one go once the button is clicked. Optional field; boolean value type. This option is available for all control types except `line-break`.
* `updateControlsOnChange`: Property to initiate re-rendering and updating the whole section of controls without re-rendering the whole chart. Optional field; boolean value type. This option is available for all control types except `line-break`.

  {% note info %}

  On the [Sources](../tabs.md#sources) tab, only sources with the `ui: true` property set will be requested. Invoking the [Editor.getLoadedData()](../methods.md#get-loaded-data) method after such a re-render will return data only for the re-requested sources.

  {% endnote %}

* `width`: Control width. Optional field; string or number value type from the possible CSS property values. This option is available for all control types except `button` and `line-break`.
* `hidden`: To hide or not to hide the control from the page. Optional field; boolean value type.
* `label`: External selector header. Optional field; string value type. This option is available for all control types except `line-break`.
* `labelPlacement`: Location of external selector header. Optional field; string value type from these possible values: `top` or `left`. This option is available for all control types except `checkbox`, `button`, and `line-break`.
* `innerLabel`: Internal header. Optional field; string value type. This option is available for all control types except `checkbox`, `button`, and `line-break`.
* `required`: Indicates a required control. In which case set the default value for the parameter linked to the control, otherwise the control will be highlighted in red, and the chart selection will use an empty value for the parameter. This option is available for all control types except `line-break`.
* `accentType`: Accentuates the control in color. Optional field; the possible value is info string. This option is available for all control types except _button_ and `line-break`.
* `operation`: You can specify an operator for the control via the `OPERATIONS` dictionary. If you do that, a string defining the operator type will be added to the parameter, e.g., the `__gt_42` parameter will represent a selector with `GT` for operator and `42` for value. This option is available for all control types except _button_ and `line-break`.

## Input field {#input}

Control with `type: "input"` (single line) or `type: "textarea"` (multi-line).

In addition to the common control fields, the following is available:

`placeholder`: Placeholder text displayed when the field has no content. Optional field; string value type.


## Calendar (single date) {#calendar}

Control with `type: "datepicker"`. The value of the linked parameter must be a string with an ISO date or [relative date](../tabs.md#relative-date).

In addition to the common control fields, the following is available:

* `minDate`: Minimum possible value in ISO. Optional field; string or `null` value type, e.g., `'2024-09-30'`.
* `maxDate`: Maximum possible value in ISO. Optional field; string or `null` value type, e.g., `'2025-09-30'`.


## Calendar (date interval) {#calendar-interval}

Control with `type: "range-datepicker"`. If the `param` field is used instead of `paramFrom` and `paramTo`, its value must be an [interval](../tabs.md#interval). The value of the linked parameter must be a string with an ISO date or relative date.

In addition to the common control fields, the following is available:

* `paramFrom`: Name of the linked interval start parameter (instead of the `param` field). Required field; string value type in ISO format or [relative date](../tabs.md#relativedate).
* `aramTo`: Name of the linked interval end parameter (instead of the `param` field). Required field; string value type in ISO format or [relative date](../tabs.md#relativedate).
* `minDate`: Minimum possible value in ISO format. Optional field; string or `null` value type, e.g., `'2024-09-30'`.
* `maxDate`: Maximum possible value in ISO format. Optional field; string or `null` value type, e.g., `'2025-09-30'`.


## List

Control with `type: "select"`.

In addition to the common control fields, the following is available:

* `multiselect`: Property indicating whether multiple choice is enabled. Optional field; boolean value type.
* `searchable`: Property indicating whether the search bar is enabled. Optional field; boolean value type.
* `content`: Drop-down list content. Required field; object array type:

  ```json
  [
      {
          title: "<string>",
          value: "<string>",
      },
      ...
  ],
  ```

  Where:

  * `title`: Displayed option name. Required field; string value type.
  * `value`: Option value; when selected, it is set as the linked parameter value. Required field; string value type. `value` must be a string because all parameters are converted to a string (`true` -> `'true'`, `42` -> `'42'`). Otherwise, the parameter value will not match any of the listed ones, and it will look as if the value is not selected.


## Checkbox {#checkbox}

Control with `type: "checkbox"`.


## Line break {#switch-line}

Control with `type: "line-break"`.


## Button {#button}

Control with `type: "button"`.

In addition to the common control fields, the following is available:

* `theme`: Button theme. Optional field. String value type from the [possible values](https://preview.gravity-ui.com/uikit/?path=/story/components-inputs-button--view) of the `view` field of the Gravity UI design system `Button` component. The default value is `action`. [Example of how it may look like](https://datalens.yandex/nvkfwnekf9xy9?tab=jEx#Селектор%20с%20кнопкой%2C%20выбор%20внешнего%20вида).
* `onClick`: Action on click. Required field; object type:

  ```json
  {
      action: "<string>",
      args: <object>,
  },
  ```

  Where:

  * `action`: Action type. This is a required field, its possible values are:
  
    * `setParams`: Sets new static parameters provided to `args` on click, example of action description:

      ```json
      onClick: {
          action: "setParams",
          args: {
              month: "May",
              region: "RU",
          }
      }
      ```

    * `setInitialParams`: Sets parameters to defaults:

      * In preview, when editing chart/selector: in the **Params** tab.
      * On dashboard: in the chart/selector settings.
      * Fallback: in the **Params** tab.

      Example of action description:

      ```json
      onClick: {
         action: "setInitialParams"
      }
      ```

  * `args`: Static arguments. Required field, its format depends on action type.


## Available methods {#methods}

This type of chart supports the same functionality as [table](../../../visualization-ref/table-chart.md) in the wizard: you can customize styles, cross-filtering, pagination, etc.

## Adding a selector to a dashboard and report {#add-to-dash-report}

[Adding a JS Selector](../add-js-selector.md) to a report is similar to adding a regular selector to a separate section with all selectors.

If required, create aliases to link your selector to other widgets on the dashboard.

## Special parameters {#spec-params}

To specify a [relative date](../tabs.md#relativedate) in the external selector parameters settings, use the following format: `__relative_<symbol><quantity><unit>`.

## Examples {#examples}

* [Selector with possible controls](https://datalens.yandex/nvkfwnekf9xy9?tab=jEx#Селектор%20с%20возможными%20контролами)
* [Selector that modifies a second selector depending on the first selector value](https://datalens.yandex/nvkfwnekf9xy9?tab=jEx#Селектор%20с%20отображением%20второго%20селектора%20в%20зависимости%20от%20выбора%20значения%20первого)
* [Example of how the button may look like (selected in the selector)](https://datalens.yandex/nvkfwnekf9xy9?tab=jEx#Селектор%20с%20кнопкой%2C%20выбор%20внешнего%20вида)
* [Example with controls in chart](https://datalens.yandex/nvkfwnekf9xy9?tab=jEx#Селекторы%20(контролы)%20в%20чарте)