---
title: "Triggers"
description: "This article describes how to use triggers."
---

# Triggers

{% note warning %}

Only [queue owners](../manager/queue-access.md) can create, edit, and delete triggers by default.

{% endnote %}

A trigger is a set of [actions](set-action.md) that are executed automatically once certain [conditions](set-condition.md) are met. For example, if the issue status changes or if a certain user subscribes to the issue, the trigger can change the issue's parameters, post a comment, or send an HTTP request.

You can use triggers to [automatically assign issues](../manager/trigger-examples.md#assign_ticket), or [send notifications from {{ tracker-name }} to messengers](../messenger.md).

Each queue has its own set of triggers. Triggers are applied one by one in the sequence listed in the queue settings. However, you can manually [change the trigger order](manage-trigger.md) if necessary.

[How to create a trigger](create-trigger.md)

[Editing and deleting triggers](manage-trigger.md)



