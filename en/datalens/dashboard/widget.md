---
title: Widgets in {{ datalens-name }}
description: Widgets are dashboard elements. You can create links between Selector and Chart widgets.
---

# Widgets

_Widgets_ are dashboard elements. You can create links between **Selector** and **Chart** widgets.

{{ datalens-short-name }} supports the following widget types:

* [Chart](#chart)
* [Selector](#selector)
* [Selector (JS)](#js-selector)
* [Text](#text)
* [Title](#title)

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

{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}

Flexible filter created with [Editor](../charts/editor/index.md) which controls the results of queries in the linked widgets through the dashboard parameters. To add a JS selector to a dashboard, go to [{#T}](../charts/editor/add-js-selector.md).

For more information about JS selectors, see [{#T}](../charts/editor/widgets/controls.md).


## Text {#text}

Text widget. A text-only dashboard element for links, captions, and other similar content. Supports [Markdown](https://ru.wikipedia.org/wiki/Markdown).
For more information about Markdown markup, see [{#T}](./markdown.md).

## Title {#title}

Heading widget. You can use it to separate similarly themed charts, group them within a single dashboard page, and create a table of contents for the dashboard. Only for text data.
