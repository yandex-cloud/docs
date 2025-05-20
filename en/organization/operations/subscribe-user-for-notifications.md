# Subscribing a user to notifications

By default, technical notifications for an organization are sent to users with the `organization-manager.organizations.owner` role.

You can also subscribe other users in your organization to receive technical notifications. To do this:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ cloud-center }}]({{ cloud-center-link }}).
  
      To subscribe a user to receive technical notifications, you need the `editor` [role](../../iam/roles-reference.md#editor) or higher for the organization.

      {% include [switch-org-note](../../_includes/organization/switch-org-note.md) %}

      On the {{ cloud-center }} home page that opens, you can view general info about your organization.

  1. Scroll the page down to **{{ ui-key.yacloud_org.dashboard.notify.title.notify }}** and click ![PersonPlus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.dashboard.notify.placeholder_add-user-action }}**. In the window that opens:

      1. Select the user you want to subscribe to notifications or use the search bar to locate one.

          You can subscribe multiple users to notifications at the same time.
      1. Click **{{ ui-key.yacloud.common.add }}**.

  The users you add will appear in **{{ ui-key.yacloud_org.dashboard.notify.title.notify }}**.

{% endlist %}

Users you have subscribed to notifications will receive technical notifications from the organization. Each subscribed user can configure the types and channels for receiving their notifications. To learn more, see [{#T}](../../resource-manager/concepts/notify.md#notification-settings).