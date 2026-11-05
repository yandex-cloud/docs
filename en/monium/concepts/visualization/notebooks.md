---
title: Notebooks
description: '{{ monium-name }} notebooks help you collect charts, logs, notes, and links for incident analysis.'
---

# Notebooks

A _notebook_ is a telemetry analysis and collaboration tool. You can bring together notes, links, images, interactive charts, and logs in the same document.

Notebooks are useful for incident investigation. They help you gather data from various sources, describe the analysis process, and convey context to your colleagues. Unlike a screenshot, notebook widgets remain interactive: you can view the chart values, change the display, or correlate metrics with logs.

## View and edit modes {#modes}

A notebook opens in one of the following modes:

* **View mode**: Used by default when following a link. The content is read-only, and widget data is updated automatically.
* **Edit mode**: Allows you to edit text, add and configure widgets, and change the document structure.

To edit a notebook, switch to edit mode.

## Global time {#global-time}

_Global time_: Common time interval applied to all the notebook widgets by default. Global time helps you align charts and logs on the same timeline.

You can set a local time interval for an individual widget. Use a local interval to analyze your chart or logs for a period different from the global investigation period.

## Collaboration {#collaboration}

You can share your notebook with your colleagues via a link. Access to notebooks, same as other {{ monium-name }} objects, is controlled by permissions for the project.

Notebooks support:

* Auto-save: Changes are saved automatically.
* Auto-update: In view mode, widget content and data are periodically updated.

Auto-update helps you use the notebook as a shared working document during the incident. Your colleagues see all current charts, logs and comments without manually refreshing the page.

## Working with text {#text}

In a notebook, you can add headers, lists, quotes, links, images, and screenshots. This helps you describe your hypotheses, record findings, and include links to related tickets or dashboards.

You can add a new section in two ways:

* Using the toolbar.
* Using the `/` command in the text.

## Widgets {#widgets}

You can add interactive chart and log widgets to a notebook.

### Chart widget {#chart-widget}

A chart widget displays metric data. You can work with it directly in the notebook: view exact point values, change the visualization type, show or hide the legend.

You can set up the chart in widget edit mode. The settings apply only to the widget you select. Edit the settings to modify the queries, visualization type, or chart display.

With a chart widget, you can:

* Hide controls and leave only the data.
* Set a local time interval.
* Create a snapshot to save the chart data.

### Log widget {#logs-widget}

A log widget displays log entries and helps correlate events with metrics. For example, you can put an error chart and application logs for the same period side by side.

You can set a local time interval for a log widget. This can be of use if you want a shorter period than the rest of the data in the notebook.

## Adding existing charts {#add-to-notebook}

You can add to a notebook an existing chart from a dashboard or [metric explorer](../../metrics/metric-explorer.md). Do it by clicking **Add to notebook** in the chart interface and selecting the notebook.

Use this option if a dashboard with relevant query or visualization already exists at the time of the investigation. This is faster than setting up a widget from scratch.

## Notebook snapshots {#snapshots}

{% note warning %}

In {{ monium-name }}, metrics are stored for a limited time and deleted after the [TTL](../common-ttl.md) expires. To save chart data for an investigation, create a snapshot.

{% endnote %}

A _snapshot_ captures the chart's state: its configuration and metric data. After the snapshot is created, a local time interval containing the saved data is set for the widget. When you open the notebook, the chart loads snapshot data instead of current metrics.

Each chart widget in the notebook can have its own snapshot. You can create and deactivate snapshots independently of one another.
