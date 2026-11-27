---
title: Managing deliveries in {{ datalens-platform-full-name }}
description: Follow this guide to view the list of data deliveries or statistics for a specific delivery, pause or delete a delivery, or change delivery settings in {{ datalens-platform-full-name }}.
alternate:
  - href: en/datalens/datalens-platform/operations/data-transfer/manage-transfer.md
    type: text/markdown
    title: Markdown version
---

# Managing deliveries

Once you create a delivery, you can view the list of data deliveries or statistics for a specific delivery, pause or delete a delivery, or change delivery settings.

## Viewing and filtering the list of deliveries {#view-transfer-list}

All configured data deliveries are collected on the **Data delivery** page. On this page, you can find the delivery you need, evaluate its current status, view details, change settings, pause or delete a delivery.

The list of deliveries is displayed as a table. To go to a specific delivery, click its name on the list.

To quickly find a delivery by name, enter a part of the name in the **Search by name** field above the table. The list is being filtered as you enter new characters. It will show only those deliveries whose name contain the text you entered. You can also use filtering by status, author, or delivery source. To reset a filter, reopen it and unselect the selected value.

## Viewing and managing delivery {#manage-transfer}

To open a delivery, select it from the list on the **Data deliveries** page. On the **Overview tab**, you can view the chart of successful and failed deliveries over a period and delivery settings. You can also pause, edit, or delete a delivery.

### Updating delivery settings {#update-transfer}

To update delivery settings:

1. Go to the ![image](../../../../_assets/console-icons/database-arrow-right.svg) **Data deliveries** section.
1. Select a delivery from the list of deliveries.
1. In the top-right corner, click ![image](../../../../_assets/console-icons/pencil.svg) **Edit**.
1. Update the required settings, e.g., schedule, composition of transferred tables, or target writing mode.
1. Save your changes.

### Pausing a delivery {#pause-transfer}

Pausing temporarily stops a scheduled delivery. At the same time, the delivery settings are preserved and you can resume it later.

To pause a delivery:

1. Go to the ![image](../../../../_assets/console-icons/database-arrow-right.svg) **Data deliveries** section and select a delivery from the list of deliveries.
1. In the top-right corner, click ![image](../../../../_assets/console-icons/pause.svg) **Pause**.

The delivery status will change to **Stopped**. To resume the delivery, click the start button in the same place: it appears instead of **Pause** once the delivery is stopped.

### Deleting a delivery {#delete-transfer}

{% note warning "Warning" %}

Deleting a delivery is irreversible: the delivery and its settings are deleted completely. The data previously delivered to the target are not deleted.

{% endnote %}

To delete a delivery:

1. Go to the ![image](../../../../_assets/console-icons/database-arrow-right.svg) **Data deliveries** section and select a delivery from the list of deliveries.
1. In the top-right corner, click ![image](../../../../_assets/console-icons/trash-bin.svg) **Delete**.
1. Confirm the deletion.
