# Notifications about your issues

For each role in {{ tracker-name }}, you can configure a list of events you want to be notified about. For example, you can receive notifications about issue status updates or new comments.

## Configuring event lists {#section_iqn_y55_xgb}

{% if audience == "external" %}

1. On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Notification settings** or follow this link: [https://tracker.yandex.com/subscriptions/roles]({{ link-sub-roles }}).

{% else %}

1. On the {{ tracker-name }} top panel, click on your profile picture, select **Personal settings**, and then click **Notification settings**. You can also follow this link: [https://st.yandex-team.ru/subscriptions/roles]({{ link-sub-roles }}).

{% endif %}

1. Select a role and configure the list of events you want to be notified about via email or in [update reports](notification-digest.md):
    - To add an event, click ![](../../_assets/tracker/button-plus.png).
    - To delete an event, click ![](../../_assets/tracker/small-x.png).
    - To delete all notifications for the current role, click **Delete notifications**.

    {% note info %}

    You can't disable notifications for important events, such as changes of assignees or deadlines.

    {% endnote %}

## Adding notification roles {#sec_add_role}

If necessary, you can select additional roles and configure notifications for them:

- **Modifier**: You made changes to the issue.
- **Access**: You are listed in the **Access** field for the issue.
- **Queue Owner**: You are the owner of the queue the issue is in.
- **Team Member**: You are on the team for the queue that the issue is in.
- **Component Owner**: You are responsible for the component that the issue is related to.
- **Favorites**: You added the issue to your favorites.

Other roles that are configured in your organization may also be available in the list.

To add roles and set their notifications:

{% if audience == "external" %}

1. On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Notification settings** or follow this link: [https://tracker.yandex.com/subscriptions/roles]({{ link-sub-roles }}).

{% else %}

1. On the {{ tracker-name }} top panel, click on your profile picture, select **Personal settings**, and then click **Notification settings**. You can also follow this link: [https://st.yandex-team.ru/subscriptions/roles]({{ link-sub-roles }}).

{% endif %}

1. Click **Add role** at the bottom of the page and select a role. To delete a role, click ![](../../_assets/tracker/remove-task-type.png) next to the role name.

1. [Configure the list of events](notification-settings.md#section_iqn_y55_xgb) you want to be notified about for the selected role.

