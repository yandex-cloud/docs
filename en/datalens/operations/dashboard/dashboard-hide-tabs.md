---
title: How to customize tab display on a dashboard in {{ datalens-full-name }}
description: Follow this guide to hide or show tabs on a dashboard in {{ datalens-full-name }}.
---

# Customizing tab display on a dashboard in {{ datalens-full-name }}

You can choose to display all or selected tabs on the dashboard:

* [Hide a selected tab](#tab-hide)
* [Show a selected tab](#tab-show)
* [Hide all tabs](#tabs-all-hide)
* [Show all tabs](#tabs-all-show)

Hidden tabs are not visible by default when you open the dashboard, but you see them if you use a [link to a hidden tab](#link-on-hide-tab) to open the dashboard.

## Hiding a selected tab {#tab-hide}

To hide a selected tab:


1. In the top-right corner, click **Edit**.
1. Click ![image](../../../_assets/console-icons/gear.svg) at the top of the screen. The settings window will open on the right.
1. Click the **Tabs** field or the ![image](../../../_assets/console-icons/sliders-vertical.svg) icon next to it.


1. In the window that opens, click ![image](../../../_assets/console-icons/ellipsis.svg) → ![image](../../../_assets/console-icons/eye-slash.svg) **Hide** next to the tab you want to hide. You cannot hide a tab if it is the only visible tab on the dashboard.
1. Click **Save**.
1. In the top-right corner, click **Save**.
   
The tab will no longer be visible by default when you open the dashboard, but you will see it if you use a [link to a hidden tab](#link-on-hide-tab) to open the dashboard.

## Showing a selected tab {#tab-show}

To make the tab visible again:


1. In the top-right corner, click **Edit**.
1. Click ![image](../../../_assets/console-icons/gear.svg) at the top of the screen. The settings window will open on the right.
1. Click the **Tabs** field or the ![image](../../../_assets/console-icons/sliders-vertical.svg) icon next to it.


1. In the window that opens, click ![image](../../../_assets/console-icons/ellipsis.svg) → ![image](../../../_assets/console-icons/eye.svg) **Show** next to the tab you want to be visible.
1. Click **Save**.
1. In the top-right corner, click **Save**.

If [all tabs are hidden](#tabs-all-hide) in the dashboard settings, the tab will not be visible.

## Hiding all tabs {#tabs-all-hide}
 
To hide all tabs:

1. In the top-right corner, click **Edit**.
1. At the top of the screen, click ![image](../../../_assets/console-icons/gear.svg). The settings window will open on the right.


1. Click ![image](../../../_assets/console-icons/eye.svg) to the right of the **Tabs** field.


1. In the top-right corner, click **Save**.

All tabs, except for the first one not hidden [separately](#tab-hide), will no longer be visible by default when you open the dashboard. But you will see them if you use a [link to a particular tab](#link-on-hide-tab) to open the dashboard.

## Showing all tabs {#tabs-all-show}
 
To show all tabs:

1. In the top-right corner, click **Edit**.
1. At the top of the screen, click ![image](../../../_assets/console-icons/gear.svg). The settings window will open on the right.


1. Click ![image](../../../_assets/console-icons/eye-slash.svg) to the right of the **Tabs** field.


1. In the top-right corner, click **Save**.
   
All tabs, except those [hidden separately](#tab-hide), will be visible when you open the dashboard.

## Sharing a link to a hidden tab {#link-on-hide-tab}

To share a link to a hidden tab:

1. In the top-right corner of the dashboard, click **Edit** and navigate to the hidden tab you want to share.


1. At the top of your dashboard, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/arrow-shape-turn-up-right.svg) **Share**.
1. In the window that opens, enable **Open current tab by default**.
1. Optionally, configure other settings:

   * Language, theme, menu display.
   * Save selector values.

   * If you have set up an [identity federation](../../../organization/concepts/add-federation.md), save the federation to share your link with the federation users.

1. Copy the link to the hidden tab with configured appearance settings by clicking ![image](../../../_assets/console-icons/copy.svg) in the **Link** field or click **Copy and close**. You can distribute this link to users with [access](../../security/index.md) to the dashboard. When you follow this link, the dashboard will open on the hidden tab.

