---
title: Dashboard settings in {{ datalens-full-name }}
description: In this tutorial, you will learn about dashboard settings in {{ datalens-full-name }}.
---

# Dashboard settings in {{ datalens-full-name }}

Dashboard settings allow you to optimize it for a specific task or work with a specific data source. For example, you can set the dashboard update time, add informational messages, or customize widget loading priority.

## Auto-update {#auto-update}

You can set up [automatic updates](../operations/dashboard/auto-update.md) for dashboard data. The update interval is specified in seconds and the minimum value is 30 seconds. The setting is global: after saving the dashboard, auto-update will work for all users that open it. Auto-update also works in the mobile version.

Auto-update is subject to the following limitations:

* Data is updated only for the tab opened in the browser.
* Data is updated only for the current active tab, however:

  * If the tab is not selected as the current tab, it is not considered active and the data is not updated.
  * If the tab is selected as the current tab, but the browser is running in the background, the tab is considered active and the data is updated.


## Table of contents {#contents}

You can configure the way the [table of contents is displayed](../operations/dashboard/add-contents.md) on the dashboard.

If the **Table of contents** option is on, all [titles](widget.md#title) with **Display in table of contents** ticked and the names of [tabs](#tabs) not hidden in the settings will be displayed in the table of contents on the left. When you click a title in the table of contents, the dashboard page automatically scrolls to the relevant section, and its hash gets added to the address bar. When you click a tab in the table of contents, the dashboard switches to that tab, and its hash gets added to the address bar.

In view mode, you can also show or hide the table of contents via the menu. Do it by clicking ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/list-ul.svg) **Table of contents** at the top of the dashboard. After you refresh the page, the table of contents is one again displayed as per the **Table of contents** option in the settings.


## Margins {#margins}

You can [set offsets](../operations/dashboard/add-margins.md) between widgets. The possible values range from `0` to `22`. The default value is `8`.


## Title {#title-dashboard}

This setting allows you to manage dashboard [title display](../operations/dashboard/add-title-dashboard.md).



## Tabs {#tabs}

You can place dashboard contents on different tabs. You can [add](../operations/dashboard/dashboard-tabs.md#tab-add), [rename, duplicate, delete](../operations/dashboard/dashboard-tabs.md#tab-rename-delete), or [reorder](../operations/dashboard/dashboard-tabs.md#tab-move) tabs, and [set up widget display order on a mobile device](../operations/dashboard/display-modes.md).

You can [choose to display](../operations/dashboard/dashboard-hide-tabs.md) all or selected tabs on the dashboard. Hidden tabs are not visible by default when you open the dashboard, but you see them if you use a link to a hidden tab to open the dashboard.

If the **Table of contents** option is enabled in the dashboard settings, the names of tabs are displayed in the [table of contents](#contents). When you click a tab in the table of contents, the dashboard switches to that tab, and its hash gets added to the address bar. Hidden tabs are not displayed in the table of contents.


## Description and message settings {#message-settings}

You can [add a description](../operations/dashboard/add-description.md) to a dashboard. To view the description, click ![image](../../_assets/console-icons/circle-info.svg) in the top-right corner of the screen.

You can also set up additional information messages:

* Displayed when [contacting support](../operations/dashboard/add-support-message.md). Then, if the user clicks the ![image](../../_assets/console-icons/circle-question.svg) icon in the bottom-left corner of the screen and selects **Create request**, an additional message will appear in the **Information** window.
* Displayed if a [dashboard access error](../operations/dashboard/add-access-message.md) occurs. In this case, if the user has no dashboard view permission, they will see the saved message.

  
  {% include [datalens-access-message-note](../../_includes/datalens/datalens-access-message-note.md) %}


## Widget loading settings {#load-settings}

You can customize the loading speed of widgets on the dashboard. To do this, [configure](../operations/dashboard/dash-settings.md) the dashboard settings under **Other settings**:

* **Load only visible charts**. If the option is enabled, only charts that are visible on the screen are loaded. Loading takes place as the user scrolls through the dashboard page. If the option is disabled, all charts of the active dashboard tab are loaded when the dashboard opens.
* **Number of concurrently loaded widgets**. The option limits the maximum number of concurrently loaded widgets on the dashboard. This can be of use if the dashboard data sources are not adapted to a large concurrent workload. If you set it to `Unlimited`, as many widgets will be loaded as there are simultaneous connections supported by your browser.
* **Loading priority**. Determines the order in which widgets are loaded on the dashboard. For example, if you prioritize charts, all the charts on the screen will be loaded first, followed by selectors.


## Display modes {#display-modes}


By default, on the mobile version of the dashboard, {{ datalens-short-name }} displays the charts one after another using the following sorting rule: left-to-right, top-to-bottom. In the tab settings, you can change the order of displaying charts and selectors in the mobile version or mailing lists. For more information, see [{#T}](../operations/dashboard/display-modes.md).


## Neuroanalyst 2.0 {#ai-dashboard}

In the dashboard tab settings, you can select a tab as a reference for Neuroanalyst 2.0. Neuroanalyst uses this reference tab to build charts.

To use a reference tab:

1. Enable **Beta version** in the [dashboard settings](../operations/dashboard/dash-settings.md).
1. [Select a reference tab](../operations/dashboard/dashboard-ai-reference-tab.md) if your dashboard has more than one tab.
1. Optionally, [hide](../operations/dashboard/dashboard-hide-tabs.md) the reference tab in the dashboard settings.

For more on the reference tab, see [{#T}](./insights.md#reference-tab).



## Pinning widgets {#widget-fixation}

You can pin (i.e., lock the position of) a widget in dedicated lock areas at the top of the dashboard. These areas stay locked as you scroll the page, and the widgets pinned on them keep their position.

There are two lock areas available, one below the other. Their purposes are different:

* Widgets pinned to the top area are always visible. We recommend using it for your selectors.
* The bottom area, with widgets pinned on it, can be collapsed and expanded as needed. If it contains widgets, you will see the ![image](../../_assets/console-icons/chevrons-up.svg) (hide) or ![image](../../_assets/console-icons/chevrons-down.svg) (show) icon to the right of this area.

You can manage pinned widgets in dashboard edit mode as follows:

* To pin a widget, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/pin.svg) **Pin** or drag it to a lock area. By default, widgets are pinned to the top area. Widgets are drag-and-droppable from one lock area to another.
* To unpin a widget, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/pin-slash.svg) **Unpin** or drag it out of the lock area.
* To unpin all widgets, click ![image](../../_assets/console-icons/gear.svg) → ![image](../../_assets/console-icons/pin-slash.svg) **Unpin all** to the right of the lock area.
* To customize the bottom lock area behavior as you open the dashboard, click ![image](../../_assets/console-icons/gear.svg) → ![image](../../_assets/console-icons/square.svg) **Hide by default** or ![image](../../_assets/console-icons/square-check.svg) **Hide by default** to the right of the lock area.

When pinning widgets, consider the following:

* The height of the pinned area is determined by the height of widgets you pin in it. If their height exceeds the fixed value, the area will have a scrollbar. Avoid making this area too high.
* You can put widgets in the pinned area one under another, in which case its height will be the combined height of the widgets.
* Widget height can be edited unless **Auto height** is enabled in the settings.


## Mailing lists {#maillists}

You can [set up a mailing list](../operations/dashboard/add-maillists.md) for your dashboard. Recipients will be getting emails with links to the dashboard and chart states specified in the mailing list settings. You can set up the dashboard selector states, schedule, chart sizes, and other parameters. Mailing lists are available for the current dashboard [version](./versioning.md) only.


## Undoing and redoing changes to dashboards {#undo-redo}

When editing a dashboard, you can undo/redo any change introduced within the current version:

* To undo changes, click ![image](../../_assets/console-icons/arrow-uturn-ccw-left.svg) in the top-right corner of the screen or press **Ctrl** (**Cmd**) + **Z**.
* To redo changes, click ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) or press **Ctrl** (**Cmd**) + **Shift** + **Z**.

You undo and redo changes that result in [creating a new version](./versioning.md#version-create).

Unsaved changes in the current version are reset:

* When refreshing the page.
* When saving a dashboard.
