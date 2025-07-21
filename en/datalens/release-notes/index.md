---
title: '{{ datalens-full-name }} release notes: June 2025'
description: Check out {{ datalens-full-name }} release notes for June 2025.
---

# {{ datalens-full-name }} release notes: June 2025


* [Changes in basic features](#base)
* [Changes available with the _Business_ service plan](#business)

## Changes in basic features {#base}

### {{ datalens-gallery }} {#gallery-changes}

Updated the [{{ datalens-gallery }}]({{ link-datalens-main }}/gallery) section:

* Corrected the layout.
* Made cards look better on narrow screens.
* Improved public dashboard preview from the gallery card for non-logged in users.

### Exporting and importing workbooks {#workbooks-export-import}

Added a **Retry** button to [workbook export and import](../workbooks-collections/export-and-import.md) error window.

### Linking a card to a billing account {#ba-card-link}

You can now optionally link a card when [creating a billing account](../../billing/operations/create-new-account.md).

### Update in notifications {#notifications-changes}

Updated the notification component that opens when you click ![image](../../_assets/console-icons/bell.svg) **Notifications**. Now it displays [{{ cloud-center }}]({{ cloud-center-link }}) updates as well.



### Fixes in connections {#connections-fixes}

Fixed the problem of replacing tables in a connection to [Yandex Documents](../operations/connection/create-yadocs.md), where only the last element could be replaced correctly.


### Fixes in dashboards {#dashboard-fixes}

* Fixed the problem of copying links when pasting a selector into another widget using the **Paste** button. Now selectors are copied together with their links, same as when added to the dashboard via the **Insert** button on the bottom panel of the dashboard page.
* Fixed copying in the dashboard access link settings window: now it is enough to click ![icon](../../_assets/console-icons/copy.svg) in the **Link** field. We also added the **Open current tab by default** option.
* Fixed issues:
  
  * [Header](../dashboard/widget.md#title) background used to mismatch the [widget pinning](../dashboard/settings.md#widget-fixation) area background.
  * Switching to edit mode was changing the indent between the widget pinning area and the dashboard's main content.
  * On dashboards without tabs or widget pinning areas, the main content area was pinning itself to the dashboard title.

### Fixes in charts {#chart-fixes}

Fixed a bug when opening chart preview via the **Open in new tab** menu item. Previously, the preview page would be loading indefinitely unless you had relevant data viewing permissions. Now you get an access restriction message instead.

Also fixed a bug causing the address bar parameters to disappear when redirected to a new address.


## Changes available with the _Business_ service plan {#business}

### Token update for non-public embeddings {#private-embedded-token-update}

For non-public embeddings you can now use the [postMessage](https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage) method to [update the JWT link](../security/private-embedded-objects.md#token-update) without losing the filter states.

Thanks to the token update, embedded dashboards can now operate in the background long-term without losing their previously selected tab states and selector values.

