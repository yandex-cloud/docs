# Subscribe to notifications

Subscriptions keep you from missing changes to issues that are important for you. If someone edits an issue that you have subscribed to, you receive an email notification.

You can subscribe to a specific issue, or to all issues related to a particular queue, version, or component.

You can [configure your notifications and subscriptions](notification-settings.md#section_iqn_y55_xgb) so that you only receive updates about events you're interested in.

## How to subscribe to an issue {#section_xt5_xrv_jz}

If you want to be notified of changes to a specific issue, subscribe to it:

1. Open the issue page.

1. On the right-hand panel in the **Followers** field, click **Add me**. If you don't see the **Followers** field, add it using the button ![](../../_assets/tracker/task-params-btn.png).

If you did everything correctly, your name will appear in the followers field. Now you will receive emails with notifications of any changes to this issue.

{% note info %}

You can also add other users to the list of followers. To do this, click on the word **Followers** and enter the login or name of the user.

{% endnote %}

## How to subscribe to a queue {#section_k13_z5v_jz}

Subscribe to changes to a queue to track changes to all of the issues in the queue:

1. Open the [queue page](queue.md).

1. Choose:
    - ![](../../_assets/tracker/icon-settings.png) → **Subscribe to new issues** to only get notifications about new issues created in the queue.
    - ![](../../_assets/tracker/icon-settings.png) → **Subscribe to all notifications** to get notifications of any changes to issues in the queue.

## How to subscribe to a component {#section_km3_jnf_qz}

You can subscribe not only to a queue, but also to its individual components. This way you will only receive notifications about issues that are related to the components you are interested in.

To subscribe to a component:

1. Open the [queue page](queue.md).

1. Go to the **Components** tab.

1. Hold the cursor over the component.

1. Select ![](../../_assets/tracker/icon-settings.png) → **Subscribe**.

If you did everything right, an icon appears next to the component name: ![](../../_assets/tracker/subscribtion.png)

## How to subscribe to a version {#section_n2y_jnf_qz}

To track issues associated with a specific version, subscribe to it:

1. Open the [queue page](queue.md).

1. Go to the **Versions** tab.

1. Hold the cursor over the version.

1. Select ![](../../_assets/tracker/icon-settings.png) → **Subscribe**.

If you did everything right, an icon appears next to the version number: ![](../../_assets/tracker/subscribtion.png)

{% if audience == "internal" %}

## Subscribe to a goal {#section_as4_ny4_xgb}

To track issues associated with a specific goal, subscribe to it:

1. Open the [queue page](queue.md).

1. Go to the **Goals** tab.

1. Click ![](../../_assets/tracker/subscribtion.png) in the goal line.

{% endif %}

## Get notifications about your own actions {#sec_self}

By default you don't get notifications for the actions you've done yourself. To enable notifications about your own actions:

1. {% if audience == "external" %}On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Personal settings**.{% else %}On the {{ tracker-name }} top panel, click on your profile picture and select **Personal settings** or follow the link: [https://st.yandex-team.ru/settings]({{ link-settings-ya }}){% endif %}

    {% if audience == "external" %}

    {% note info %}

    You can also follow this link: [https://tracker.yandex.ru/settings]({{ link-settings }}).

    {% endnote %}

    {% endif %}

1. Enable **Receive updates with my own actions**.

1. Click **Save**.

{% if audience == "external" %}

[Contact support](../troubleshooting.md)

{% endif %}

