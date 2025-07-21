---
title: '{{ datalens-full-name }} release notes: May 2025'
description: Check out {{ datalens-full-name }} release notes for May 2025.
---

# {{ datalens-full-name }} release notes: May 2025


* [Changes in basic features](#base)
* [Changes available with the _Business_ service plan](#business)

## Changes in basic features {#base}

### Exporting and importing workbooks {#workbooks-export-import}

Added [exporting and importing workbooks](../workbooks-collections/export-and-import.md) in {{ datalens-short-name }}. Now you can transfer [workbooks](../workbooks-collections/index.md) between installations using export and import tools. For example, you can export a ready-made workbook with its settings and connections from cloud {{ datalens-full-name }} to an [open source](https://datalens.tech) installation.

### {{ datalens-short-name }} Gallery {#gallery}

We added a [section]({{ link-datalens-main }}/gallery) with ready-made dashboards for your inspiration and business needs. You are free to deploy the ones you like for yourselves – not only in cloud but in any other environment, even within your corporate perimeter.




### Changes in charts {#charts-changes}

In [wizard](../concepts/chart/dataset-based-charts.md) and [QL charts](../concepts/chart/ql-charts.md), we added a [setting](../concepts/chart/settings.md#common-settings) to preserve [spaces and line breaks](../visualization-ref/table-chart.md#spaces-and-line-breaks) in tables.

### Changes in the interface {#interface-changes}

Updated the appearance of the [service plan selection](../settings/service-plan.md#change-service-plan) page with feature description.

### Starting out with {{ datalens-short-name }} {#start-video}

Fixed the issue with viewing the introductory video available when clicking ![image](../../_assets/console-icons/circle-question.svg) → **Starting out with {{ datalens-short-name }}** in the left-hand panel.


### Fixes in charts {#charts-fixes}



Fixed line breaks for headers and values in [table](../visualization-ref/table-chart.md) columns for some browsers.


### Changes in widgets {#widget-changes}

* Added autofocus to the text input field for [Header](../dashboard/widget.md#title) and [Text](../dashboard/widget.md#text) widgets when adding or editing widgets on a [dashboard](../concepts/dashboard.md).
* In the visual editor, added a _copy to clipboard_ button for [code block](../dashboard/markdown.md#code) content to dashboard text widgets and [Markdown](../charts/editor/widgets/markdown.md) charts in Editor.

### Undoing and redoing changes to dashboards {#undo-redo}

When editing a [dashboard](../concepts/dashboard.md), you can now undo/redo any change introduced within the current version:

* To undo changes, click ![image](../../_assets/console-icons/arrow-uturn-ccw-left.svg) in the top-right corner of the screen or press **Ctrl** (**Cmd**) + **Z**.
* To redo changes, click ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) or press **Ctrl** (**Cmd**) + **Shift** + **Z**.


## Changes available with the _Business_ service plan {#business}

### Changes in Editor {#editor-changes}

* Added the [Editor.updateParams](../charts/editor/widgets/advanced.md) method to [advanced chart](../charts/editor/methods.md#update-params).
* Added additional attributes and tags for the [Editor.generateHtml](../charts/editor/methods.md#gen-html) method.
* Controls are now available in [Markdown](../charts/editor/widgets/markdown.md) charts in Editor.
* Fixed the revision comparison dialogue for charts in Editor.

