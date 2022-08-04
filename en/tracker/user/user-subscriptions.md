# Notifications about your subscriptions

For subscriptions that inform you about changes to queues, components, or versions, you can select the roles and events you want to be notified about.
To do this:

{% if audience == "external" %}

1. On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Notification settings**, and choose the **Subscriptions** tab. You can also follow this link: [https://tracker.yandex.com/subscriptions/manage]({{ link-sub-manage }}).

{% else %}

1. On the {{ tracker-name }} top panel, click on your profile picture, select **Personal settings**, and then click **Notification settings**.

1. Go to the **Subscriptions** tab. You can also follow this link: [https://st.yandex-team.ru/subscriptions/manage]({{ link-sub-manage }}).

{% endif %}

1. Choose the role you want to set up an event list for, which can be found next to the name of the queue, component, or version.

    {% note tip %}

    If there are no queues, components, or versions displayed on the **Subscriptions** tab, [subscribe to notifications](subscribe.md#section_xt5_xrv_jz).

    {% endnote %}

1. To add a role, click ![](../../_assets/tracker/button-plus.png).

1. [Configure the list of events](user-notifications.md#section_iqn_y55_xgb) you want to be notified about for the selected role. For example, notifications about issue status updates or new comments.

   {% note info %}

   For some roles, events can't be deleted. This means that [notifications are already configured](user-notifications.md) for a similar role. You can edit these events in the relevant section on the **Notifications** tab.

   {% endnote %}

1. To unsubscribe from a queue, component, or version, click ![](../../_assets/tracker/small-x.png) before the list of roles.

