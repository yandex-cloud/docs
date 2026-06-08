---
title: '{{ datalens-full-name }} release notes: April 2026'
description: Check out {{ datalens-full-name }} release notes for April 2026.
---

# {{ datalens-full-name }} release notes: April 2026

* [Changes in basic features](#base)
* [Fixes and improvements](#fixes)

## Changes in basic features {#base}


* In Editor, added the [Activities](../charts/editor/tabs.md#activities) tab where you can set up interactive actions for dashboard elements, such as:

  * Send an HTTP request by clicking a button, chart, or table row.
  * Process a response and show the result in a pop-up window or toast, or update your dashboard parameters.

  Available for the following visualization types: [selector](../charts/editor/widgets/controls.md), [table](../charts/editor/widgets/table.md), and [chart (Gravity UI Charts)](../charts/editor/widgets/chart.md).

* Added a dashboard setting to adjust the spacing between charts.


* Moved dashboard settings to a right-side panel. To open settings, click ![image](../../_assets/console-icons/gear.svg) at the top while in edit mode. Visual changes apply immediately after saving new settings.
* Added the ability to set up the dashboard to display all tabs or selected tabs. By default, you do not see the hidden tabs when you open the dashboard: you see them if you access the dashboard via a link to a hidden tab.

  * To hide all tabs, click ![image](../../_assets/console-icons/eye.svg) to the right of the **Tabs** field in the [dashboard settings](../operations/dashboard/dash-settings.md). To show all tabs, click ![image](../../_assets/console-icons/eye-slash.svg).
  * To hide a selected tab, click ![image](../../_assets/console-icons/sliders-vertical.svg) to the right of the **Tabs** field in the dashboard settings and then click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/eye-slash.svg) **Hide** to the right of the tab name in the window that opens. To show a selected tab, click ![image](../../_assets/console-icons/eye-slash.svg) → ![image](../../_assets/console-icons/eye.svg) **Show**.
  
* Updated UI colors for consistent styling: removed purple tones in dark mode and deepened black shades.

## Fixes and improvements {#fixes}


* Removed the legacy [Google Sheets](../operations/connection/create-google-sheets.md) connection.
* Now you can select {{ datalens-short-name }} On-premises when creating a {{ datalens-short-name }} [support](../qa/index.md#how-to-resolve-problem) ticket.
* Fixed an error that occurred when [switching color palettes](../settings/appearance.md#default-palette).


* Fixed an issue where version history timestamps for [connections](../concepts/chart/versioning.md), [datasets](../dataset/versioning.md), [charts](../concepts/chart/versioning.md), [dashboards](../dashboard/versioning.md), and [reports](../reports/versioning.md) did not reflect the user's time zone.
* Implemented handling for browser pop-up blocking errors with error code and description.
* Fixed an issue in [report exports](../reports/report-operations.md#report-export) where line breaks immediately following emojis in tables were lost.


### Dashboard fixes {#dashboard-fixes}


* Fixed inconsistent behavior of global selectors on dashboards with [public access](../concepts/datalens-public.md).


* Fixed an issue where clicking a link in the dashboard or chart table of contents while holding **Ctrl** (**Cmd**) would take you from the current tab to the one that opened.
* Fixed a preview rendering issue for [Mermaid](../dashboard/markdown.md#mermaid) diagrams.


### Fixes in charts {#chart-fixes}


* In [tables](../visualization-ref/table-chart.md#additional-settings), added support for right-aligning linear indicators when manually setting a value range consisting entirely of positive or negative values.


* In [tables](../visualization-ref/table-chart.md), fixed an issue where a selected cell fill color palette reset to the default one after selecting a different cell.

