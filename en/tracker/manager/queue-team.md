---
title: How to add a queue team
description: Follow this guide to add a queue team.
---

# Adding a queue team

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

The queue team is represented by employees who create and execute issues in a given queue. The queue team members get notified by email on any issue-related changes.

The queue owner is an employee who has full access to editing the queue settings.

You can set the queue team on the **Queue team** tab.

## Changing the queue owner {#change-owner}

The owner manages the queue:

* Edits the [main settings](edit-queue-general.md).
* Adds users to the [queue team](../glossary.md#queue-team).
* Configures [notifications](subscriptions.md).
* Changes [access rights to the queue](queue-access.md).

Changing the queue owner:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_Queues_pages_PageQueue_header.settings }}**.

1. Go to the **Access rights** tab.

1. Click the user picture next to the owner name. The window to change the queue owner will open.

1. Click **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminTabPermissions_ChangeOwnerForm.change-owner }}**.

1. Enter the name or username of the new owner.

1. Click **Save**.

1. If you want all new issues to be automatically assigned to the owner, enable the **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminTabPermissions_ChangeOwnerForm.set-as-default }}** option.

1. Click **Save**.

## Changing the queue team {#edit-team}

The teams usually includes users who work on issues in the queue. You can assign privileged access rights for issues in the queue to the team members.

To change the list of team members:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_Queues_pages_PageQueue_header.settings }}**.

1. Go to the **Queue team** tab.

1. To add a new member, enter the username or name of the user in the **Queue team** field.

1. To remove a member, click ![](../../_assets/tracker/remove-task-type.png) next to the user's name.

1. Click **Save**.
