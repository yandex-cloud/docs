# Deleting a queue

{% note warning %}

Before deleting a queue, make sure you [moved important issues](../user/move-ticket.md) to other queues. You can only restore a deleted queue and its issues with an [API call](../concepts/queues/restore-queue.md).

{% endnote %}

To delete a queue and all the issues in it:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Basic settings** tab.

1. Click **Delete queue**.

1. Confirm the deletion.

{% note tip %}

- To just remove a queue from the **Queues** menu on the {{ tracker-name }} top panel, open the menu and click ![](../../_assets/tracker/remove-task-type.png).
- Instead of deleting the queue, you can [close access to it](queue-access.md#section_bvq_dc3_3z) for everyone except the owner. Issues in the closed queue won&apos;t be visible to other users, but they can be easily restored.

{% endnote %}

