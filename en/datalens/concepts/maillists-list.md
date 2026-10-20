---
title: List of mailing lists in {{ datalens-full-name }}
description: This article explains how you can view all mailing lists in {{ datalens-name }} and what you can do with them.
---

# List of mailing lists in {{ datalens-full-name }}

To view all mailing lists, click ![image](../../_assets/console-icons/envelope.svg) **Mailing lists** in the left-hand panel. If you do not see ![image](../../_assets/console-icons/envelope.svg) in the panel, first select ![image](../../_assets/console-icons/ellipsis.svg) **More**, then ![image](../../_assets/console-icons/envelope.svg) **Mailing lists**.

![maillist-list](../../_assets/datalens/dashboard/maillists-list.png)

You can also view all mailing lists for the current workbook. To do this, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/envelope.svg) **Mailing lists** at the top of the workbook.

For each item in the list, you can see the following properties:

* Mailing list name.
* Mailing list status: ![image](../../_assets/console-icons/circle-play.svg) **Active** or ![image](../../_assets/console-icons/circle-pause.svg) **Paused**.
* Mailing lists you are subscribed to are labeled with ![image](../../_assets/console-icons/bell.svg) **Subscribed**.
* Name of the dashboard or report for which the mailing list was created.
* Mailing schedule.
* Number of mailing list recipients.
* ![image](../../_assets/console-icons/bell.svg) to subscribe to the mailing list or ![image](../../_assets/console-icons/bell-slash.svg) to unsubscribe from it. The ![image](../../_assets/console-icons/bell.svg) button is only shown to users who can subscribe to the mailing list: the editor and administrator by default, or any user. You can configure this setting on the **Recipient** tab.

You can use the following filters at the top of the list:

* **Object**: In the list, select the object that contains your mailing list: a collection, workbook, dashboard, or report.
* **Status**: Select a mailing list status, `Active`, `Paused`, or `Error`.
* **Recipient**: Select a mailing list recipient.
* **I'm subscribed**: Click to only show the mailing lists you are subscribed to.
* ![image](../../_assets/console-icons/arrow-rotate-left.svg) **Reset**: Click to clear all filters. This option is available when at least one filter is applied.

When you [open the list of mailing lists](../workbooks-collections/workbooks-operations.md#maillist-list) from a workbook, the **Object** filter for this workbook will automatically be applied.

To the right of the filter, you can choose how to sort the list:

* **More recipients**: By the number of recipients.
* **Newest first**: By creation date.

Clicking the mailing list takes you to the page of the object (dashboard or report) it was created for.

You can subscribe to or unsubscribe from a mailing list directly from the list view:
     
* To subscribe to a mailing list, click ![image](../../_assets/console-icons/bell.svg) (**Subscribe**) next to it. The ![image](../../_assets/console-icons/bell.svg) button is only shown to users who can subscribe to the mailing list: the editor and administrator by default, or any user. You can configure this setting on the **Recipients** tab.
* To unsubscribe from a mailing list, click ![image](../../_assets/console-icons/bell-slash.svg) (**Unsubscribe**).

{% note info %}

* The user needs an active seat to receive the mailing list emails.
* You can receive the emails only if you have a role for the mailing list parent workbook.

{% endnote %}
