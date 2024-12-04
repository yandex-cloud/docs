---
title: Dashboard settings
description: In this tutorial, you will learn about dashboard settings.
---

# Dashboard settings


Dashboard settings allow you to optimize it for a specific task or work with a specific data source. For example, you can set the dashboard update time, add informational messages, or customize widget loading priority.

## Auto-update {#auto-update}

You can set up [automatic updates](../operations/dashboard/auto-update.md) for dashboard data. The update interval is specified in seconds and the minimum value is 30 seconds. The setting is global: after saving the dashboard, auto-update will work for all users that open it. Auto-update also works in the mobile version.

The following limitations apply to auto update:

* Data is updated only for the tab opened in the browser.
* Data is updated only for the current active tab, however:

  * If the tab is not selected as the current tab, it is not considered active and the data is not updated.
  * If the tab is selected as the current tab, but the browser is running in the background, the tab is considered active and the data is updated.

## Description and message settings {#message-settings}

You can [add a description](../operations/dashboard/add-description.md) to a dashboard. To view the description, click ![image](../../_assets/console-icons/circle-info.svg) in the top-right corner of the screen.

You can also set up additional information messages:

* Displayed when [contacting support](../operations/dashboard/add-support-message.md). In this case, if the user clicks ![image](../../_assets/console-icons/circle-question.svg) in the bottom-left corner of the screen and selects **Create request**, they will see an additional message in the **Information** window.
* Displayed if a [dashboard access error](../operations/dashboard/add-access-message.md) occurs. In this case, if the user has no dashboard view permission, they will see the saved message.

  {% include [datalens-access-message-note](../../_includes/datalens/datalens-access-message-note.md) %}

## Widget loading settings {#load-settings}

You can customize the loading speed of widgets on the dashboard. To do this, [configure](../operations/dashboard/dash-settings.md) the dashboard settings under **Other settings**:

* **Load only visible charts**. If the option is enabled, only charts that are visible on the screen are loaded. Loading takes place as the user scrolls through the dashboard page. If the option is disabled, all charts of the active dashboard tab are loaded when the dashboard opens.
* **Number of concurrently loaded widgets**. The option limits the maximum number of concurrently loaded widgets on the dashboard. This can be of use if the dashboard data sources are not adapted to a large concurrent workload. If you set it to `Unlimited`, as many widgets will be loaded as there are simultaneous connections supported by your browser.
* **Loading priority**. Determines the order in which widgets are loaded on the dashboard. For example, if you prioritize charts, all the charts on the screen will be loaded first, followed by selectors.

## Display modes {#display-modes}


By default, on the mobile version of the dashboard, {{ datalens-short-name }} displays the charts one after another using the following sorting rule: left-to-right, top-to-bottom. In the tab settings, you can change the order of displaying charts and selectors in the mobile version or mailing lists. For more information, see [{#T}](../operations/dashboard/display-modes.md).

## Pinning widgets {#widget-fixation}

You can pin (i.e. lock the position of) a widget in dedicated lock areas at the top of the dashboard. These areas stay locked as you scroll the page, and the widgets pinned on them keep their position.

There are two lock areas available, one below the other. Their purposes are different:

* Widgets pinned to the top area are always visible. This area has a fixed height. We recommend using it for your selectors.
* The bottom area, with widgets pinned on it, can be collapsed and expanded as needed. If it contains widgets, you will see the ![image](../../_assets/console-icons/chevrons-up.svg) (hide) or ![image](../../_assets/console-icons/chevrons-down.svg) (show) icon to the right of this area. This area changes its height depending on the height of the widgets pinned on it.

You can manage pinned widgets in dashboard edit mode as follows:

* To pin a widget, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/pin.svg) **Pin** or drag it to a lock area. By default, widgets are pinned to the top area. If a widget does not fit into the top area width and height wise, it gets pinned to the bottom area. Widgets are drag-and-droppable from one lock area to another.
* To unpin a widget, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/pin-slash.svg) **Unpin** or drag it out of the lock area.
* To unpin all widgets, click ![image](../../_assets/console-icons/gear.svg) → ![image](../../_assets/console-icons/pin-slash.svg) **Unpin all** to the right of the lock area.
* To customize the bottom lock area behavior as you open the dashboard, click ![image](../../_assets/console-icons/gear.svg) → ![image](../../_assets/console-icons/square.svg) **Hide by default** or ![image](../../_assets/console-icons/square-check.svg) **Hide by default** to the right of the lock area.


