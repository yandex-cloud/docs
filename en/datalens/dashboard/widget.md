---
title: Widgets in {{ datalens-full-name }}
description: In {{ datalens-full-name }}, widgets are dashboard elements. You can create links between Selector and Chart widgets.
---

# Widgets in {{ datalens-full-name }}

_Widgets_ are dashboard elements. You can create links between **Selector** and **Chart** widgets.

{{ datalens-short-name }} supports the following widget types:

* [Chart](#chart)
* [Selector](#selector)
* [Selector (JS)](#js-selector)
* [Text](#text)
* [Title](#title)
* [Insight](#ai)

## Chart {#chart}

Visualization as a table or chart.
You can place charts anywhere on the dashboard and resize the dashboard.
Charts can be linked to selectors.

For more information about charts, see [{#T}](../concepts/chart/index.md).

## Selector {#selector}

A filter that affects query results on its linked widgets. To add a selector to a dashboard, go to [{#T}](../operations/dashboard/add-selector.md).
A selector can be linked to a chart or another selector. For more information, see [{#T}](./link.md).

For more information about selectors, see [{#T}](./selector.md).


## Selector (JS) {#js-selector}

Flexible filter created with [Editor](../charts/editor/index.md) which controls the results of queries in the linked widgets through the dashboard parameters. To add a JS selector to a dashboard, go to [{#T}](../charts/editor/add-js-selector.md).

For more information about JS selectors, see [{#T}](../charts/editor/widgets/controls.md).


## Text {#text}

Text widget. A text-only dashboard element for links, captions, and other similar content. Supports [Markdown](https://ru.wikipedia.org/wiki/Markdown).
For more information about Markdown markup, see [{#T}](./markdown.md).

## Title {#title}

Heading widget. You can use it to separate similarly themed charts, group them within a single dashboard page, and create a [table of contents](./settings.md#contents) for the dashboard. Only for text data.


## Insight {#ai}

Widget that displays an insight by Neuroanalyst. You can specify up to five charts from the current dashboard tab in one insight. With Neuroanalyst, you can discover data relationships not visible in individual charts.

When [adding](../operations/dashboard/add-ai.md) a widget, you can set a custom prompt asking about the data. When you save a dashboard, Neuroanalyst will analyze the specified charts and generate its findings based on chart data and the custom prompt. The result will be updated each time you open the dashboard.

There is an action bar at the bottom of the widget:

* ![image](../../_assets/console-icons/copy.svg) **Copy**. Copies the contents of the insight to the clipboard.
* ![image](../../_assets/console-icons/arrow-rotate-left.svg) **Once more**. Updates the insight response.
* ![image](../../_assets/console-icons/thumbs-up.svg) **This answer is good**. Evaluates the insight response positively.
* ![image](../../_assets/console-icons/thumbs-down.svg) **This answer is bad**. Evaluates the insight response negatively.

When you hover over the widget, a menu ![image](../../_assets/console-icons/ellipsis.svg) appears in the top-right corner with a choice of actions:

* ![image](../../_assets/console-icons/copy.svg) **Copy insight**. Copies the contents of the insight to the clipboard.
* ![image](../../_assets/console-icons/arrow-rotate-left.svg) **Regenerate**. Updates the insight response.

If Neuroanalyst is [disabled](../concepts/neuroanalyst.md#prohibit), the widget will not work.

