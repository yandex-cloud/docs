---
title: Adding a selector to a dashboard in {{ datalens-full-name }}
description: Follow this guide to add a selector to a dashboard in {{ datalens-full-name }}.
---

# Adding a selector to a dashboard in {{ datalens-full-name }}


Before adding a selector, make sure you have the `{{ permission-write }}` or `{{ permission-admin }}` permission for the dashboard. For more information, see [{#T}](../../security/manage-access.md).


To add a [selector](../../dashboard/selector.md) to a dashboard:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need.
1. At the top of the page, click **Edit**.
1. In the panel at the bottom of the page, hold down ![image](../../../_assets/console-icons/sliders.svg) **Selector** and drag it to the required area.

   
   ![image](../../../_assets/datalens/operations/widget-select-js.png =650x95)


1. Under **Selector settings**, set the source and specify the selector parameters:

   {% list tabs %}

   - Based on dataset

     * **Dataset**: Dataset with data for the selector. You can choose a dataset from the list of objects or provide a link. This is a required field.
     * **Field**: Dataset field with selector values. It can be either a dimension or a measure (for more information, see [{#T}](../../dataset/data-model.md#field)). This is a required field.

     
     * **Show in tabs**: Select how the selector will be displayed on the dashboards:

       * `Current tab <tab_name>`: Display the selector on the specified tab. This is the default option for a single selector.
       * `Selected tabs`: Select one or multiple tabs where you need to display the selector. By default, the current tab is selected.
       * `All tabs`: The selector will be displayed on all tabs. This option is available for a single selector.
       * `From group settings <group_value>`: Selector display will be based on the advanced settings of the selector group widget. This option is available only for a selector within a group.

     * ![image](../../../_assets/console-icons/magnifier.svg) button: Displayed to the right of the **Show in tabs** setting if the **Field** is specified. It allows you to find and group selectors with the same field or parameter in other tabs. To group the current selector with the one you find, click **Group** next to the relevant selector in the list. After grouping, the current selector’s **Show in tabs** setting may get updated automatically, for example:

       * `Current tab`: Switches to `Selected tabs`, i.e., the tabs containing the grouped selectors.
       * `Selected tabs`: No changes, but the list of tabs will include the tab with the new selector, if not specified previously.
       * `All tabs`: No changes.
     
       The links from the new selector’s tab will apply to the current selector within the relevant tab.

     
     * **Selector type**: Drop-down list, input field, calendar, or checkbox.

       {% note info %}

       * **Calendar** is only available for fields of the `Date` or `Date and time` type.
       * **Checkbox** is only available for fields of the `Boolean` type.
       * Measure selectors can only have the **Input field** type.

       {% endnote %}

     * **Operation**: Comparison operation by which the selector filters the chart values (e.g., **Equal to**, **Greater than**, or **Less than**). If the field is left blank, the selector will filter by the **Equal to** operation by default. The list of available operations depends on the field type.
       
       {% note info %}
       
       Do not specify an operation in the following cases:

       * Selector will filter a QL chart.
       * Selector is linked to parameters of a chart or dataset.

       {% endnote %}

     * **Multiple choice**: Allows choosing several values in the selector. Only available for the **List** selector type.
     * **Range**: Allows setting a time interval in the selector. Only available for the **Calendar** selector type.
     * **Required field**: Sets the selector value as a required parameter. When enabled, `*` is added to the end of the selector name. Not available for the **Checkbox** selector type.
     * **Default value**: Displayed when you first open the dashboard. This is a required field if the **Required field** option is enabled.

     * **Header**: Used to pick a selector when establishing a link with other widgets. By default, when you add a selector, the header text is substituted from the field title in the [dataset](../../dataset/index.md). This is a required field.
       
       Select the header location below: `Left` (default), `Top`, or `Hidden` to hide it from the dashboard. It is not available for the **Checkbox** selector type.

     * **Inner title**: Allows specifying text inside a selector. For example, you can use it to display an operation inside a selector. Not available for the **Checkbox** selector type.
     * **Coloring**: Allows you to highlight important selectors. It is not available for the **Checkbox** selector type.
     * **Tooltip**: This option allows adding a text comment to the selector. By default, with this option enabled, the tooltip text is taken from the field description in the dataset. You can edit the tooltip text using the visual editor or [Markdown](../../dashboard/markdown.md). When you change the dataset field description, the text is not automatically updated.

       When the option is enabled, the ![image](../../../_assets/console-icons/circle-question.svg) icon appears on the dashboard next to the selector. Hover over the icon to bring up the tooltip.

   - Manual input

     * **Field or parameter**: Field name you can use to link the selector with other widgets in the [alias](../../dashboard/link.md#alias) configuration window. This is a required field.

       ![image](../../../_assets/datalens/selector-settings/field-name.png)


     
     * **Show in tabs**: Select how to display the selector on the dashboard:

       * `Current tab <tab_name>`: Display the selector on the specified tab. This is the default option for a single selector.
       * `Selected tabs`: Select one or multiple tabs where you need to display the selector. By default, the current tab is selected.
       * `All tabs`: The selector will be displayed on all tabs. This option is available for a single selector.
       * `From group settings <group_value>`: Selector display will be based on the advanced settings of the selector group widget. This option is available only for a selector within a group.

     * ![image](../../../_assets/console-icons/magnifier.svg) button: Displayed to the right of the **Show in tabs** setting if the **Field or parameter** is speficied. It allows you to find and group selectors with the same field or parameter in other tabs. To group the current selector with the one you find, click **Group** next to the relevant selector in the list. After grouping, the current selector’s **Show in tabs** setting may get updated automatically, for example:

       * `Current tab`: Switches to `Selected tabs`, i.e., the tabs containing the grouped selectors.
       * `Selected tabs`: No changes, but the list of tabs will include the tab with the new selector, if not specified previously.
       * `All tabs`: No changes.
     
       The links from the new selector’s tab will apply to the current selector within the relevant tab.

     
     * **Selector type**: Drop-down list, input field, calendar, or checkbox.

       {% note info %}

       * **Calendar** is only available for fields of the `Date` or `Date and time` type.
       * **Checkbox** is only available for fields of the `Boolean` type.
       * Measure selectors can only have the **Input field** type.

       {% endnote %}

     * **Operation**: Comparison operation by which the selector filters the chart values (e.g., **Equal to**, **Greater than**, or **Less than**). If the field is left blank, the selector will filter by the **Equal to** operation by default. The list of available operations depends on the field type.
       
       {% note info %}
       
       Do not specify an operation in the following cases:

       * Selector will filter a QL chart.
       * Selector is linked to parameters of a chart or dataset.

       {% endnote %}

     * **Required field**: Sets the selector value as a required parameter. When enabled, `*` is added to the end of the selector name. Not available for the **Checkbox** selector type.
     * **Multiple choice**: Allows choosing several values in the selector. Only available for the **List** selector type.
     * **Possible values**: List of values to select. Only available for the **List** selector type. To add multiple values at once, copy the list of values to the clipboard, paste it into the input field, and click **Add**. You can also remove a value by clicking ![image](../../../_assets/console-icons/xmark.svg), or swap the values around by dragging them.
     * **Range**: Allows setting a time interval in the selector. Only available for the **Calendar** selector type.
     * **Time**: Allows specifying time. Only available for the **Calendar** selector type.
     * **Default value**: Displayed when you first open the dashboard. This field must be set for the **List** type; otherwise, no value will be available in the selector. This is a required field if the **Required field** option is enabled.

     * **Header**: Used to pick a selector when establishing a link with other widgets. This is a required field.
       
       Select the header location below: `Left` (default), `Top`, or `Hidden` to hide it from the dashboard. It is not available for the **Checkbox** selector type.

     * **Inner title**: Allows specifying text inside a selector. For example, you can use it to display an operation inside a selector. Not available for the **Checkbox** selector type.
     * **Coloring**: Allows you to highlight important selectors. It is not available for the **Checkbox** selector type.
     * **Tooltip**: This option allows adding a text comment to the selector. By default, with this option enabled, the tooltip text is taken from the field description in the [dataset](../../dataset/index.md). You can change the tooltip text. When you change the dataset field description, the text is not automatically updated.

       When the option is enabled, the ![image](../../../_assets/console-icons/circle-question.svg) icon appears on the dashboard next to the selector. Hover over the icon to bring up the tooltip.

   {% endlist %}

   In [QL charts](../../concepts/chart/ql-charts.md), you can control [selector parameters](../chart/create-sql-chart.md#selector-parameters) from the **Parameters** tab in the chart editing area and use the **Query** tab to specify a variable in the query itself in `not_var{{variable}}` format.

1. Optionally, add another selector to the widget. To to this, on the left side of the **Selectors** tab, click ![image](../../../_assets/console-icons/plus.svg) **Add selector** and repeat the actions from the previous step. You can also duplicate the new selector or copy it to the clipboard. To do this, on the **Selectors** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the selector and select:

   * **Duplicate**: This will add a new selector with the same parameters to the widget.
   * **Copy to clipboard**: You can paste the selector you copied into a different widget using the **Paste** button on the **Selectors** tab or to a dashboard using the **Insert** button on the bottom panel of the dashboard page.

1. Optionally, go to the **Group settings** tab and specify the widget settings:

   * **Apply button**: Adds a widget button which applies the values of all selectors in the widget. The selector values are not applied until you click the button.
   * **Reset button**: Adds a widget button which resets the values of all the widget selectors to their defaults.
   * **Auto height**: Sets the automatic height for a widget on the dashboard. Available for widgets with multiple selectors.

   
   * Optionally, for a widget with multiple selectors, use the **Show in tabs** field to configure how to display the selector on the dashboard:

     * `Current tab <tab_name>` is default. The selector will be displayed on the specified tab.
     * `Selected tabs`: Select one or multiple tabs where you need to display the selector. By default, the current tab is selected.
     * `All tabs`: Display the selector on all tabs.
     
     This setting becomes available when you add a second selector to a widget:
     
     * Setting value used in the first selector automatically applies to the entire group. You can change it at any time.
     * For each new selector in the group, the default value is `From group settings <group_value>`.

     When using this setting, consider the following:

     * You cannot save a selector if it has the setting value where the current tab displays no selectors. For example, if you specify `Selected tabs` for a single selector, you can deselect the current tab, but you cannot save the selector.
     * You cannot save a selector with the `Selected tabs` value if no tabs are selected.
     * Group settings restrict how you set up each selector within a group. For example, if you select `Current tab` for a group, you must also specify `Current tab` for each selector in this group.

       | **Configuring a group** | **Configuring a selector** |
       |----------------------|---------------------|
       | `All tabs` | `Current tab`, `Selected tabs`, `All tabs` |
       | `Selected tabs` | `Current tab`, `Selected tabs` |
       | `Current tab`    | `Current tab` |

     * When you delete a selector on the current tab, it is automatically deleted from all tabs.
     * When you copy and paste a selector, its settings are preserved.
     * You cannot paste a copied selector if its settings prevent it from being displayed on the current tab.


     
   * Optionally, for a widget with multiple selectors, customize the selector arrangement. To do this, arrange the selectors as needed by dragging them and adjust the width of each one:

      * `Auto`: Automatic selector width.
      * `%`: Selector width as a percentage of the widget's total width.
      * `px`: Selector width in pixels.

   Click **Save**.

   ![image](../../../_assets/datalens/selector-settings/selector-extending-settings.png =581x419)

1. Click **Save**. The widget will be displayed on the dashboard.

{% note warning %}

When adding a selector by a certain field to your dashboard, filters added at the chart level are no longer applied to the dashboard's chart.

{% endnote %}

## Limitations {#restrictions}

* For measure selectors, only one type is available: **Input field**.
* We recommend that you always make your measure selectors independent from other selectors. To do this, set your dashboard's [link](../../dashboard/link.md) type to **Not linked** with other selectors in the **Links** section when editing.
