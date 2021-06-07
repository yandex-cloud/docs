# Overview

By default, {{ tracker-name }} sends you notifications about changes to issues if you have one of the following roles:

- **Reporter**: You created this issue.
- **Assignee**: You are assigned to this issue.
- **Follower**: You are subscribed to notifications for this issue.
- **Queue/version/component/goal subscriber**: You are subscribed to notifications for the queue, version, component, or goal that the issue belongs to.

You can configure notifications so that you only receive updates about events you're interested in:

- Each role can have [its own set of notifications about particular events](user-notifications.md#section_iqn_y55_xgb).

- [Add additional roles for receiving notifications](user-notifications.md#sec_add_role).

- [Configure the list of roles and events for subscriptions to queues, components, and versions](user-subscriptions.md).


## Configure how usernames and event types are displayed {#section_u1f_3w5_xgb}

You can choose the display type for usernames and event types in notification messages. To do this:

1. {% if audience == "external" %}On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Personal settings** or follow this link: [https://tracker.yandex.com/settings]({{ link-settings }}){% else %}On the {{ tracker-name }} top panel, click on your profile picture and select **Personal settings** or follow this link: [https://st.yandex-team.ru/settings]({{ link-settings-ya }}){% endif %}.

1. Choose the option you need in the **Sender's name in emails** section.

1. Enable or disable **Show event type in notifications**.

1. Click **Save**.

