---
title: '{{ tracker-full-name }} notification settings. Overview'
description: By default, {{ tracker-name }} sends you notifications about changes to issues if you have one of the required roles. You can configure the contents of notifications to only receive messages about the events you're interested in. You can choose how to display usernames and event types in notification messages.
---

# Setting up notifications in {{ tracker-name }}

By default, {{ tracker-name }} sends notifications about changes to issues to your email address if you have one of these roles:

- **{{ ui-key.startrek-backend.roles.role.name.author }}**: You created this issue.
- **{{ ui-key.startrek-backend.roles.role.name.assignee }}**: You are assigned to this issue.
- **{{ ui-key.startrek-backend.roles.role.name.follower-key-value }}**: You are subscribed to notifications about this issue.
- **Queue/version/component/goal subscriber**: You are subscribed to notifications for the queue, version, component, or goal that the issue belongs to.

You can configure the contents of notifications to only receive messages about the events you're interested in (for example, only when an issue's status changes or when you're added to issue followers):

- [Setting up a list of events that you'll be notified of](user-notifications.md#section_iqn_y55_xgb) for each role.
- [Adding additional roles to receive notifications for](user-notifications.md#sec_add_role).
- [Configuring the list of roles and events for subscriptions to queues, components, and versions](user-subscriptions.md).

{% note info %}

Notifications about invitations to comments are also displayed in the {{ tracker-name }} [notification center](notifications.md#notif_center).

{% endnote %}

## Configuring how usernames and event types are displayed {#section_u1f_3w5_xgb}

You can choose how to display usernames and event types in notification messages. To do this:

<!---1. {% include [open-personal-settings](../../_includes/tracker/open-personal-settings.md) %}-->

1. Click the link [{{ link-tracker }} settings]({{ link-settings }}).

1. Choose the option you need in the **Email sender name** section.

1. Enable or disable **Show event type in notifications**.

1. Click **Save**.