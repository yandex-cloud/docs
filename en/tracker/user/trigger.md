# Triggers

{% note warning %}

Only [queue owners](../manager/queue-access.md) can create, edit, and delete triggers by default.

{% endnote %}

A trigger is a set of [actions](set-action.md) that are executed automatically once certain [conditions](set-action.md) are met. For example, a trigger can modify issue parameters, leave an automatic comment, or send an HTTP request if a status changes or a specific user subscribes to an issue.

You can use triggers to automatically [name assignees to issues](../manager/trigger-examples.md#assign_ticket) , or [send notifications from {{ tracker-name }} to messengers](../messenger.md).

Each queue has its own set of triggers. Triggers are executed in the same order they were listed in queue settings. However, you can manually [change the trigger order](manage-trigger.md) if necessary.

[Creating triggers](create-trigger.md)

[Editing and deleting triggers](manage-trigger.md)

