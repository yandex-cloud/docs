# Subscribing to notifications

By using subscriptions, you will never miss changes in the issues that are important to you. If someone edits an issue you are subscribed to, you will get notified by email.

You can subscribe both to a specific issue and to all the issues related to a specific queue, version, or component.

You can [set up the content](notification-settings.md) of your notifications and subscriptions to get emails only on the events that are relevant for you.

{% note info %}

Notifications about invitations to comments are also displayed in the {{ tracker-name }} [notification center](#notif_call_comments).

{% endnote %}

## Subscribing to an issue {#section_xt5_xrv_jz}

If you want to get notified about changes in a specific issue, subscribe to it.

1. Open the issue page.

1. In the **{{ ui-key.startrek-backend.fields.issue.followers }}** field on the right-hand panel, click **Add me**. If you do not see the **{{ ui-key.startrek-backend.fields.issue.followers }}** field, add it by clicking ![](../../_assets/tracker/svg/add-task.svg)&nbsp;**{{ ui-key.startrek.ui_components_IssueSidebar.add-sidebar-field }}**.


If you followed the steps correctly, your name will be added to the Followers field. Now you will get emails with notifications about any changes in this issue.

{% note info %}

You can also add other users to the followers list. To do this, click **{{ ui-key.startrek-backend.fields.issue.followers }}** and enter the username or name of the person you want to add.

{% endnote %}

## Subscribing to a queue {#section_k13_z5v_jz}

Subscribe to changes in the queue to track changes to all its issues.

1. Open the [queue page](queue.md).

1. In the upper-right corner, click ![](../../_assets/tracker/svg/actions.svg). Then click ![](../../_assets/tracker/svg/subscribe.svg)&nbsp;**{{ ui-key.startrek.ui_components_PageQueue_header.subscribe }}** and select a value:
   - Select **{{ ui-key.startrek.ui_components_PageQueue_header.subscribe-new-tickets }}** to get notifications on new issues created in the queue. You will also subscribe to notifications on all events specified in the [notification settings](user-notifications.md#sec_add_role) for the **{{ ui-key.startrek-backend.roles.role.name.queue-follower-key-value }}** role.
   - Select **{{ ui-key.startrek.ui_components_PageQueue_header.subscribe-all }}** to get notifications on all changes to issues in the queue.

You can also [select events](user-subscriptions.md) you want to get notified about.


## Subscribing to a component {#section_km3_jnf_qz}

You can subscribe both to a queue and its specific components. This allows you to get notified only about the issues related to the components that interest you.

To subscribe to a component:

1. Open the [queue page](queue.md).

1. In the top-right corner, click ![](../../_assets/tracker/svg/actions.svg), then click ![](../../_assets/tracker/svg/components.svg)&nbsp;**Components**.

1. Hover the cursor over the component.

1. Select ![](../../_assets/tracker/icon-settings.png) → **Subscribe to issues with this component**.

If you did everything right, you'll see the following icon next to the component name: ![](../../_assets/tracker/subscribtion.png)

By default, all notifications will arrive to your mailbox. You can [select events](user-subscriptions.md) you want to get notified about.

## Subscribing to a version {#section_n2y_jnf_qz}

To track issues related to a specific version, subscribe to it:

1. Open the [queue page](queue.md).

1. In the top-right corner, click ![](../../_assets/tracker/svg/actions.svg), then click ![](../../_assets/tracker/svg/versions.svg)&nbsp;**Versions**.

1. Hover the cursor over the version.

1. Select ![](../../_assets/tracker/icon-settings.png) → **Subscribe**.

If you did everything right, you'll see the following icon next to the version number: ![](../../_assets/tracker/subscribtion.png)

By default, all notifications will arrive to your mailbox. You can [select events](user-subscriptions.md) you want to get notified about.


## Getting notifications about your own actions {#sec_self}

By default, you won't get notified about your own actions on issues. To get notifications about your own actions:

1. Click the link [{{link-tracker}}settings]({{ link-settings }}).

1. Enable **Receive updates with my own actions**.

1. Click **Save**.

## Notifications about invitations to comment {#notif_call_comments}

When you are invited to comment on an issue, you'll get notified about this both in your mailbox and via the {{ tracker-name }} [notification center](notifications.md#notif_center).

To disable sending notifications:
1. In the left-hand panel, click ![](../../_assets/tracker/svg/bell_2.svg)&nbsp;**Notifications** to open the notification center.
1. In the top-right corner of the notification center, click ![](../../_assets/vertical-ellipsis.svg) → **Settings**.
1. Clear the checkbox next to **Invitation to comments**.

