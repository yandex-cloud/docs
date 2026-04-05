---
title: '{{ datalens-full-name }} release notes: January 2026'
description: Check out {{ datalens-full-name }} release notes for January 2026.
---

# {{ datalens-full-name }} release notes: January 2026

* [Changes in basic features](#base)
* [Fixes and improvements](#fixes)

## Changes in basic features {#base}


* [Billing account](../settings/service-plan.md#billing-account) lists now include billing accounts associated with other [organizations](../concepts/organizations.md) if the user has been granted permissions for those organizations.


* Released the first version of the [public API](../operations/api-start.md).

  
  {{ datalens-name }} provides a public API ([https://api.datalens.tech](https://api.datalens.tech)) to automate operations with dashboards, charts, datasets, and connections.

  [{{ datalens-name }} Public API](../operations/api-start.md) is a collection of methods similar to that used in the {{ datalens-name }} web interface. This API is described by the OpenAPI specification and authenticated via the Yandex Cloud IAM tokens.

  To use the API, you need an [IAM token](../../iam/operations/iam-token/create.md) and an [organization ID](../settings/index.md#service-settings).




## Fixes and improvements {#fixes}


* In [Gallery]({{ link-datalens-main }}/gallery), the **Contact the author** form now opens in a dialog instead of a new tab.
* Added support for [reassigning](../settings/seats.md#reassign) a seat about to expire.
* Fixed errors with redefining the menu item background color when [customizing the UI](../settings/appearance.md#ui-customization) in some themes.


* In the [link settings](../dataset/create-dataset.md#links) window for datasets, added a tooltip and field name search. Previously, with many long and similar field names, finding and selecting the one you need was inconvenient.
* In the formula editor for [creating calculated fields](../concepts/calculations/index.md#how-to-create-calculated-field) in datasets and charts, the description window now displays a helpful tip, links to user guides, and dashboard with examples when no function is selected in the list on the left.
* Fixed an issue where text from the UI was unintentionally copied to the clipboard on certain pages.

### Dashboard fixes {#dashboard-fixes}


* Now you can control which dashboard tabs display a [selector](../dashboard/selector.md). When switching between these tabs, the selector's value is preserved.

  Use the **Show in tabs** setting to configure the selector display on the dashboard:

  * `Current tab <tab_name>`: Display the selector on the specified tab. This is the default option for a single selector.
  * `Selected tabs`: Select one or multiple tabs where you need to display the selector. By default, the current tab is selected.
  * `All tabs`: The selector will be displayed on all tabs. This option is available for a single selector.
  * `From group settings <group_value>`: Selector display will be based on the advanced settings of the selector group widget. This option is available only for a selector within a group.

  For widgets with multiple selectors, you can configure visibility in the **Group settings** tab.

  For more information, see [{#T}](../operations/dashboard/add-selector.md).

* Implemented selector value persistence when switching tabs. Now, if you set a selector value, switch to another tab, and return, the selector retains the value.


* Dashboards now support [configuring links](../operations/dashboard/dashboard-links.md) for charts from unopened widget tabs:

  * Select the chart at the top of the link settings window: the chart's data will load, allowing you to configure the link.
  * In the link settings window, choose a selector, then, in the **Link type** column, click the relevant chart row in the widget list: the chart's data will load, allowing you to configure the link.

* Fixed stable table rendering on initial dashboard loading.
* Fixed an issue where the color of [Mermaid](../dashboard/markdown.md#mermaid) diagrams in dashboard text widgets in the visual editor was different from their actual color on the dashboard.
* Fixed an error where, when setting up [aliases](../dashboard/link.md#alias) with certain QL charts, parameters configured in the QL chart UI did not appear in the parameter selection list.
* In dashboard edit mode, added highlighting to the ![image](../../_assets/console-icons/gear.svg) button for selectors with group visibility set to `All tabs` or `Selected tabs`. 


### Fixes in charts {#chart-fixes}

* In [line charts](../visualization-ref/line-chart.md), fixed an issue with line style configuration for multiple measures; previously, the line style was rendered correctly only for one measure.
* In [maps](../visualization-ref/map-chart.md), fixed drag-and-drop functionality for adding fields to `Layer filters`.
* Fixed auto-application of metric settings in [QL charts](../concepts/chart/ql-charts.md).
