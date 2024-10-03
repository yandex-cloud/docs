---
title: How to delete a queue in {{ tracker-name }}
description: Follow this guide to delete a queue in {{ tracker-name }}.
---

# Deleting a queue in {{ tracker-name }}

{% note warning %}

Before deleting a queue, make sure you [moved important issues](../user/move-ticket.md) to other queues. You can only restore a deleted queue and its issues with an [API call](../concepts/queues/restore-queue.md).

Once the queue is created, you will not able to create a new queue with the same key.

{% endnote %}

{% note warning %}

By default, a queue can only be deleted by [its owner](queue-access.md).

{% endnote %}

To delete a queue and all the issues in it:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. In the top-right corner of the page, click ![](../../_assets/horizontal-ellipsis.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **{{ ui-key.startrek.ui_components_page-queue-admin_QueueActionsMenu.remove-queue-action }}**.

1. Confirm the deletion.

{% note tip %}

* Instead of deleting the queue, you can [close access to it](queue-access.md#set-access) for everyone except the owner. Issues of such a queue are not visible to other users, but you can easily recover them.

{% endnote %}
