---
title: Configuring Yandex Tracker notifications. Overview
description: 'By default, Tracker will notify you of task changes if you have one of the roles. You can customize the content of notifications so that you only receive emails about events that interest you. You can choose how usernames and event types are displayed in notification emails.'
---
# Configure notifications in {{ tracker-name }}

By default, {{ tracker-name }} sends you notifications about changes to issues if you have one of these roles:

- **Reporter**: You created this issue.
- **Assignee**: You are assigned to this issue.
- **Follower**: You are subscribed to notifications for this issue.
- **Queue/version/component/goal subscriber**: You are subscribed to notifications for the queue, version, component, or goal that the issue belongs to.

You can configure notifications so that you only receive updates about events you're interested in (such as issue status updates or being assigned as the issue follower):

- Each role can have [its own set of notifications about particular events](user-notifications.md#section_iqn_y55_xgb).
- [Add additional roles for receiving notifications](user-notifications.md#sec_add_role).
- [Configuring the list of roles and events for subscriptions to queues, components, and versions](user-subscriptions.md).

## Configuring how usernames and event types are displayed {#section_u1f_3w5_xgb}

You can choose the display type for usernames and event types in notification messages. To do this:

1. {% include [open-personal-settings](../../_includes/tracker/open-personal-settings.md) %}

2. Choose the option you need in the **Email sender name** section.

3. Enable or disable **Show event type in notifications**.

4. Click **Save**.

