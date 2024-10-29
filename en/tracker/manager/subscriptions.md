# Subscribing other users to queue updates

You can subscribe {{ tracker-name }} users to notifications about changes to all issues within a certain queue or changes related to specific versions or components.

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

To set up sending of notification about issue status changes in the queue:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg)&nbsp;**{{ ui-key.startrek.ui_Queues_pages_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.yacloud.component.navigation-menu.label_notifications }}** tab.

1. Set up sending of notifications:

   **About all issues in the queue**

   1. Go to the **All issues** tab and click **Add**.

   1. In the window that opens, list logins or names of users to notify. Click **Apply**.

   1. You will see these users listed on the **All issues** tab. Select in which cases the users will be notified:

      - **Creating issues**: Users only get notifications when new issues are created.

      - **All notifications**: Users get notifications of any changes to issues.

   **About issues related to a specific component**

   You can set up sending of notifications about the issues whose properties include a certain component:

   1. Go to the **Components** tab. The **All** section lists all the components in the queue and the **Components with notifications** section, the components with configured notifications.

   1. Select the component you want to subscribe users to and click **Add**.

   1. List the names or logins of users to notify. Click **Apply**.

   1. You will see these users added to the component list on the **Components** tab. Select in which cases the users will be notified:

      - **Creating issues**: Users only get notifications when new issues are created.

      - **All notifications**: Users get notifications of any changes to issues.

   **About issues related to a specific version**

   You can set up sending of notifications about the issues whose properties include a certain version.

   1. Go to the **Versions** tab. The **All** section lists all the versions in the queue and the **Versions with notifications** section, the versions with configured notifications.

   1. Select the version you want to subscribe users to and click **Add**.

   1. List the names or logins of users to notify. Click **Apply**.

   1. You will see these users added to the version list on the **Versions** tab. Select in which cases the users will be notified:

      - **Creating issues**: Users only get notifications when new issues are created.

      - **All notifications**: Users get notifications of any changes to issues.

1. Click **Save**.
