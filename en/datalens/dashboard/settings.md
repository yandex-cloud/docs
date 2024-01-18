# Dashboard settings



## Display modes {#display-modes}

{{ datalens-short-name }} lets you display the dashboard in full-screen mode. This mode hides part of the interface elements and expands the widget area on the screen.

By default, on the mobile version of the dashboard, {{ datalens-short-name }} displays the charts one after another using the following sorting rule: left-to-right, top-to-bottom. In the tab settings, you can change the order of displaying charts and selectors in the mobile version or mailing lists. For more information, see [{#T}](../operations/dashboard/display-modes.md).

## Description and message settings {#message-settings}

You can [add a description](../operations/dashboard/add-description.md) to a dashboard. To view the description, click ![image](../../_assets/console-icons/circle-info.svg) in the upper-right corner of the screen.

You can also set up additional information messages:

* Displayed when [contacting support](../operations/dashboard/add-support-message.md). In this case, if the user clicks ![image](../../_assets/console-icons/circle-question.svg) in the bottom-left corner and selects **Create request**, they will see an additional message in the **Information** window.
* Displayed if a [dashboard access error](../operations/dashboard/add-access-message.md) occurs. In this case, if the user has no dashboard view permission, they will see the saved message.


## Auto-update {#auto-update}

You can set up [automatic updates](../operations/dashboard/auto-update.md) for dashboard data. The update interval is specified in seconds and the minimum value is 30 seconds. The setting is global: after saving the dashboard, auto-update will work for all users that open it. Auto-update also works in the mobile version.

The following limitations apply to auto-update:

* Data is updated only for the tab opened in the browser.
* Data is updated only for the current active tab, however:

   * If the tab is not selected as the current tab, it is not considered active and the data is not updated.
   * If the tab is selected as the current tab, but the browser is running in the background, the tab is considered active and the data is updated.

