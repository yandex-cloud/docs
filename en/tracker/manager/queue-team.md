# Adding a queue team

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

The queue team includes the employees who create and execute issues in the given queue. The queue owner is an employee who has full access to editing the queue settings. You can set the team and queue owner on the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--team }}** tab.

## Changing the queue owner {#change-owner}

The owner manages the queue:

* Edits the [main settings](edit-queue-general.md).
* Adds users to the [queue team](queue-team.md).
* Configures [notifications](subscriptions.md).
* Changes [access rights to the queue](queue-access.md).

Changing the queue owner:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Click the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--team }}** tab.

1. Click image ![](../../_assets/tracker/icon-edit.png) next to the owner name.

1. Enter the name or username of the new owner.

1. If you want all new issues to be automatically assigned to the owner, select **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_team.field--bind-to-lead }}**.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_types.save }}**.

## Changing the queue team {#edit-team}

The teams usually includes users who work on issues in the queue. You can assign privileged access rights for issues in the queue to the team members.

To change the list of team members:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Click the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--team }}** tab.

1. To add a new member, enter their username or name in the **{{ ui-key.startrek.blocks-desktop_b-queue-form.queue-team }}** field.

1. To remove a member, click ![](../../_assets/tracker/remove-task-type.png) next to the user's name.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_types.save }}**.
