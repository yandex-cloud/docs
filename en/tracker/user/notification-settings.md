# Configuring notification contents

By default, {{ tracker-name }} sends you notifications about changes to issues if you have one of the following roles:

- **Reporter**: You created this issue.
- **Assignee**: You are assigned to this issue.
- **Follower**: You are subscribed to notifications for this issue.
- **Queue/version/component/goal subscriber**: You are subscribed to notifications for the queue, version, component, or goal that the issue belongs to.

You can configure notifications so that you only receive updates about events you're interested in:

- Each role can have [its own set of notifications about particular events](notification-settings.md#section_iqn_y55_xgb).
- [Add additional roles for receiving notifications](notification-settings.md#sec_add_role).
- [Configure the list of roles and events for subscriptions to queues, components, and versions](notification-settings.md#sec_subscription_roles).

## Configure event lists {#section_iqn_y55_xgb}

You can configure the list of events that you want to get notifications for. To do this:

{% if audience == "external" %}

1. On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Notification settings**.

    {% note info %}

    You can also follow this link: [https://tracker.yandex.ru/subscriptions/roles]({{ link-sub-roles }}).

    {% endnote %}

{% else %}

1. On the top panel in {{ tracker-name }}, click on your profile picture, select **Personal settings**, and click **Notification settings**.

    {% note info %}

    You can also follow this link: [https://st.yandex-team.ru/subscriptions/roles]({{ link-sub-roles-ya }}).

    {% endnote %}

{% endif %}

1. Select a role and configure the list of events you want to be notified about via email or in [update reports](notification-digest.md):
    - To add an event, click ![](../../_assets/tracker/button-plus.png).
    - To delete an event, click ![](../../_assets/tracker/small-x.png).
    - To restore the default values, click **Reset**.

## Add notification roles {#sec_add_role}

You can also configure notifications about updates for additional roles:

- **Modifier**: You made changes to the issue.
- **Access**: You are listed in the **Access** field for the issue.
- **Queue owner**: You are the owner of the queue the issue is in.
- **Team member**: You are on the team for the queue that the issue is in.
- **Component owner**: You are responsible for the component that the issue is related to.
- **Favorites**: You added the issue to your favorites.

To add roles and set their notifications:

{% if audience == "external" %}

1. On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Notification settings**.

    {% note info %}

    You can also follow this link: [https://tracker.yandex.ru/subscriptions/roles]({{ link-sub-roles }}).

    {% endnote %}

{% else %}

1. On the top panel in {{ tracker-name }}, click on your profile picture, select **Personal settings**, and click **Notification settings**.

    {% note info %}

    You can also follow this link: [https://st.yandex-team.ru/subscriptions/roles]({{ link-sub-roles-ya }}).

    {% endnote %}

{% endif %}

1. Click **Add role** at the bottom of the page and select a role. To delete a role, click ![](../../_assets/tracker/remove-task-type.png) next to the role name.

1. [Configure the list of events](notification-settings.md#section_iqn_y55_xgb) you want to be notified about for that role.

## Configure the list of roles and events for subscriptions {#sec_subscription_roles}

If you are subscribed to queue, component, or version updates, you can configure the role list for the following subscription notifications:

{% if audience == "external" %}

1. On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Notification settings** and go to the **Subscriptions** tab.

    {% note info %}

    You can also follow this link: [https://tracker.yandex.ru/subscriptions/manage]({{ link-sub-manage }}).

    {% endnote %}

{% else %}

1. On the top panel in {{ tracker-name }}, click on your profile picture, select **Personal settings**, and click **Notification settings**.

1. Go to the **Subscriptions** tab.

    {% note info %}

    You can also follow this link: [https://st.yandex-team.ru/subscriptions/manage]({{ link-sub-manage-ya }}).

    {% endnote %}

{% endif %}

1. Choose the role you want to set up an event list for, which can be found next to the name of the queue, component, or version.

    {% note tip %}

    If there are no queues, components, or versions displayed on the **Subscriptions** tab, [subscribe to notifications](subscribe.md#section_xt5_xrv_jz).

    {% endnote %}

1. To add a role, click ![](../../_assets/tracker/button-plus.png).

1. [Configure the list of events](notification-settings.md#section_iqn_y55_xgb) you want to be notified about for the selected role.

1. To unsubscribe from a queue, component, or version, click ![](../../_assets/tracker/small-x.png) before the list of roles.

## Configure how usernames and event types are displayed {#section_u1f_3w5_xgb}

You can choose the display type for usernames and event types in notification messages. To do this:

1. {% if audience == "external" %}On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Personal settings**.{% else %}On the {{ tracker-name }} top panel, click on your profile picture and select **Personal settings** or follow the link: [https://st.yandex-team.ru/settings]({{ link-settings-ya }}){% endif %}

    {% if audience == "external" %}

    {% note info %}

    You can also follow this link: [https://tracker.yandex.ru/settings]({{ link-settings }}).

    {% endnote %}

    {% endif %}

1. Choose the option you need in the **Sender's name in emails** section.

1. Enable or disable **Show event type in notifications**.

1. Click **Save**.



