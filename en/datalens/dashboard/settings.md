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

* Displayed when [contacting support](../operations/dashboard/add-support-message.md). In this case, if the user clicks ![image](../../_assets/console-icons/circle-question.svg) in the bottom-left corner and selects **Create request**, they will see an additional message in the **Information** window.
* Displayed if a [dashboard access error](../operations/dashboard/add-access-message.md) occurs. In this case, if the user has no dashboard view permission, they will see the saved message.

## Widget loading settings {#load-settings}

You can customize the loading speed of widgets on the dashboard. To do this, [configure](../operations/dashboard/dash-settings.md) the dashboard settings under **Other settings**:

* **Load only visible charts**. If the option is enabled, only charts that are visible on the screen are loaded. Loading takes place as the user scrolls through the dashboard page. If the option is disabled, all charts of the active dashboard tab are loaded when the dashboard opens.
* **Number of concurrently loaded widgets**. The option limits the maximum number of concurrently loaded widgets on the dashboard. This can be of use if the dashboard data sources are not adapted to a large concurrent workload. If you set it to `Unlimited`, as many widgets will be loaded as there are simultaneous connections supported by your browser.
* **Loading priority**. Determines the order in which widgets are loaded on the dashboard. For example, if you prioritize charts, all the charts on the screen will be loaded first, followed by selectors.

## Display modes {#display-modes}

{{ datalens-short-name }} allows you to display the dashboard in full-screen mode. This mode hides part of the interface elements and expands the widget area on the screen.

By default, on the mobile version of the dashboard, {{ datalens-short-name }} displays the charts one after another using the following sorting rule: left-to-right, top-to-bottom. In the tab settings, you can change the order of displaying charts and selectors in the mobile version or mailing lists. For more information, see [{#T}](../operations/dashboard/display-modes.md).


