---
title: Dashboards in Yandex DataLens
description: 'Dashboard in Yandex DataLens — a page or a set of pages on which widgets are located. Allows you to collect charts in one place, add explanatory captions and titles to them. New dashboard pages can be created using the tab element. DataLens allows you to display your dashboard in full screen mode.'
---

# Yandex DataLens dashboard

_Dashboards_ are pages or sets of pages that contain widgets. They let you group charts in one place and add explanatory text and titles.
You can create new dashboard pages using the **tab** element.

## Display modes {#display-modes}

{{ datalens-short-name }} lets you display the dashboard in full-screen mode. This mode hides part of the interface elements and expands the widget area on the screen.

On the mobile version of the dashboard, {{ datalens-short-name }} displays the charts one after another using the following sorting rule: left-to-right, top-to-bottom.

## Widgets {#widget}

_Widgets_ are dashboard elements. You can create links between selector and chart widgets.

{{ datalens-full-name }} offers the following types of widgets:

- [Chart](#chart)
- [Selector](#selector)
- [Text](#text)
- [Title](#title)

### Chart {#chart}

Visualization as a table or chart.
You can place charts anywhere on a dashboard and change their size.
Charts can be linked to selectors.

For more information about charts, see [{#T}](chart/index.md).

### Selector {#selector}

A filter that affects query results on its linked widgets. To add a selector to a dashboard, go to [{#T}](../operations/dashboard/add-selector.md).
The selector can be linked to a chart or another selector.
 For more information, see [Link](#link).
A selector works within a single dashboard tab.

### Text {#text}

A widget represented as text. It lets you place things like a set of links or explanatory captions on a dashboard. The [Markdown markup language](https://en.wikipedia.org/wiki/Markdown) is supported.
For more information about Markdown markup, see [{#T}](markdown.md).

### Title {#title}

A widget represented as a heading. It lets you differentiate charts by meaning and divide them into groups within a single dashboard page.

## Link {#link}

Links determine how a selector affects one or more charts or other selectors. By default, selectors are linked with charts created within a single dataset. Selectors and charts based on different datasets can also be linked manually using [aliases](#alias).

You can choose an existing dataset field as the link or create your own field where you manually set the selector values. You can specify the fields to be associated through a link in the [alias](#alias) configuration window.

You can use links to filter the values of selectors and charts. For example, if you select a country in the first selector on the dashboard, the second selector limits the list of cities (and vice versa).

The field used by the selector to filter on must be included in the dataset used to construct a chart. Otherwise, the link will not work. For more information, see the section [{#T}](data-join.md).

The link type determines how values in selectors and charts are filtered. The type is set in the links window in dashboard edit mode.
You can use the following types of links for a pair of widgets:

* **Link**, for widgets that mutually affect each other.
* **Incoming link**, when a widget is affected by a widget.
* **Outgoing link**, when a widget affects another widget.
* **Ignore**, for widgets that mutually ignore each other.
* **No link**, for widgets from different datasets or widgets that can't be linked.

{% note warning %}

You can't create a link with [{#T}](#text) and [{#T}](#title) widgets.

{% endnote %}

Some widgets can't affect other widgets. Possible types of links between widgets are shown in the table:

| Affects/Affected | Selector | Charts |
| ----- | ----- | ----- |
| **Selector** | Link<br/>Incoming link<br/>Outgoing link<br/>Ignore | Outgoing link<br/>Ignore |
| **Chart** | Incoming link<br/>Ignore | — |

## An alias {#alias}

An alias is a link between fields of different datasets, which determines how widgets impact each other when you link them.

Aliases let you link widgets that are based on different datasets. For example, if you create an alias using the `[Region]` and `[Country]` fields from different datasets, a selector by the `[Region]` field from one dataset will filter data in a chart with the `[Country]` field of another dataset. For widgets based on the same dataset, aliases are created automatically. Creating aliases is required when you need to:

* Establish links between selectors that are based on different datasets, so that the values of one selector filter the list of available values of another selector.

* Establish links between a selector of the **Based on datasets** type from one dataset and charts from another dataset, so that the selector values filter the values in the charts.

* Establish links between a selector of the **Manual input** type and other selectors, so that the values of one selector filter the list of available values of another selector.

You can specify an alias for a pair of linked widgets. In this case:

* Multiple aliases can be set for a single pair of widgets.
* An alias set for one pair of widgets is applied to all linked widgets that are based on the same datasets (which use the fields specified in the alias).
* An alias works within a single dashboard tab.
* To limit the use of aliases, set **Ignore** as your link type for the link between your widgets on the selected field. In this case, the widgets for the selected field will have no effect on the dashboard tab.

For more information about how to create aliases, see [{#T}](../operations/dashboard/create-alias.md).

You can delete links from an alias where more than two fields are linked. Delete a field from the alias if its associated link between datasets or widgets is not required on a dashboard tab. For more information, see [{#T}](../operations/dashboard/edit-alias.md).

## Publishing dashboards {#public-access}

You can grant any internet user access to a dashboard using [{{ datalens-public }}](datalens-public.md). This dashboard becomes public and any user can view it without authorization.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

## Access management {#access-management}

You can configure dashboard permissions. For more information, see [{#T}](../security/index.md).

## Auto-update {#auto-update}

You can set up [automatic updates](../operations/dashboard/auto-update.md) of data in the dashboard. The update interval is specified in seconds and the minimum value is 30 seconds. The setting is global: after saving the dashboard, auto-update will work for all users that open it. Auto-update also works in the mobile version.

The following limitations apply to auto-update:

* Data is updated only for the tab opened in the browser.

* The data is updated only for the current active tab, however:
  * If the tab isn't selected as the current tab, it's not considered active and the data is not updated.
  * If the tab is selected as the current tab, but the browser is running in the background, the tab is considered active and the data is updated.

## Troubleshooting {#diagnostics}

If a dashboard includes many charts that take a long time to load and process data, this can degrade the speed of the entire dashboard. You can analyze chart performance with an inspector.

A chart Inspector is a {{ datalens-short-name }} tool that helps you troubleshoot data loading and browser rendering issues. You can use it to determine why a chart is slow or optimize data acquisition and chart rendering.

​To open the chart Inspector, click ![image](../../_assets/datalens/horizontal-ellipsis.svg) in the upper right-hand corner of the chart and select **Inspector**.

{% cut "Example of a chart inspector" %}

![image](../../_assets/datalens/concepts/inspector-message.png)

{% endcut %}

At the top of the inspector window, there is information on the speed of the base operations:

* **Config resolving**: Chart configuration load time.
* **Data fetching**: Time data takes to load from the source.
* **Execution**: Time to process data received from the source.
* **Rendering**: Time to render data on a chart.

Values above the optimal level are highlighted (orange or red). To get recommendations for optimizing a metric, hove the mouse over the question mark next to its name.

For some chart types, additional metrics are displayed:

* **Columns / Rows**: Number of table columns and rows (for **Table** and **Pivot table** charts).
* **Yandex Maps API**: Time to load modules required by Yandex Maps (for **Map** charts).

The inspector also displays source request IDs (Request ID) and request traces (Trace IDs).

The **Data sources** section displays information on the sources used in a chart:

* Source name.
* Link to source.
* Request body in JSON format.
* SQL query text sent to source (if information supplied by source).

