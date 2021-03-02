# Triggers

{% note warning %}

By default, only a [queue owner](../manager/queue-access.md) can create, edit, and delete triggers.

{% endnote %}

A trigger is a set of [actions](create-trigger.md) that are executed automatically once certain [conditions](create-trigger.md) are met. For example, a trigger can modify issue parameters, leave an automatic comment, or send an HTTP request if a status changes or a specific user subscribes to an issue.

You can use triggers to automatically [name assignees to issues](../manager/trigger-examples.md#assign_ticket), [send email notifications when issues are created from user requests](../manager/trigger-examples.md#notify_mail), or [send notifications from {{ tracker-name }} to messengers](../messenger.md).

Each queue has its own set of triggers. Triggers are executed in the same order they were listed in queue settings. However, you can manually [change the trigger order](manage-trigger.md) if necessary.

[Creating triggers](create-trigger.md)

[Editing and deleting triggers](manage-trigger.md)


[Contact support](../troubleshooting.md)

