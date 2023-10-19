---
title: "How to delete a queue in {{ tracker-name }}"
description: "Use this guide to delete a queue in {{ tracker-name }}."
---

# Deleting a queue in {{ tracker-name }}

{% note warning %}

Before deleting a queue, make sure you [moved important issues](../user/move-ticket.md) to other queues. You can only restore a deleted queue and its issues with an [API call](../concepts/queues/restore-queue.md).

Once the queue is created, you won't be able to create a new queue with the same key.

{% endnote %}

To delete a queue and all the issues in it:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--main }}** tab.

1. Click **{{ ui-key.startrek.ui_components_page-queue-admin_QueueActionsMenu.remove-queue-action }}**.

1. Confirm the deletion.

{% note tip %}

* To remove a queue only from the **{{ ui-key.startrek.blocks-desktop_b-head.queues }}** menu in the {{ tracker-name }} top panel, open the menu and click ![](../../_assets/tracker/remove-task-type.png).
* Instead of deleting the queue, you can [close access to it](queue-access.md#set-access) for everyone except the owner. Issues of such a queue aren't visible to other users, but you can easily recover them.

{% endnote %}
