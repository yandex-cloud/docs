## Yandex account users {#useraccount}

If your employees have Yandex accounts, e.g., `{{ login-example }}`, they can use them to access {{ yandex-cloud }} services enabled in your organization.

You can invite a user to an organization via the management console or the {{ cloud-center }} interface. An invitation to join your organization will be sent to the user's email address.

Users with any of the following [roles](../../organization/security/index.md) can invite new users with Yandex accounts to an organization and delete such invitations: `organization-manager.passportUserAdmin`, `organization-manager.admin`, or `organization-manager.organizations.owner`.

### Send an invitation {#send-invitation}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [add-yandex-user](./add-yandex-user.md) %}

- Management console {#console}

    1. Log in to the [management console]({{ link-console-main }}) with the cloud administrator account.

    1. Select the appropriate cloud from the list on the left. Here is an example:

        ![image](../../_assets/resource-manager/switch-cloud-n-n.png)

    1. In the top-right corner, click ![icon-users](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.resource-acl.button_invite-users }}**.

    1. Enter the email addresses of the users you want to invite to the organization (e.g., `{{login-example}}`).

        You can send invitations to any email address. Invited users will be able to select the appropriate Yandex account once they accept the invitation.

    1. Click **{{ ui-key.yacloud_components.organization.action_send-invitation }}**.

{% endlist %}

The user will be able to log in to the organization upon accepting the invitation via the emailed link and selecting an account for log-in. To access the services enabled for the organization, the users you invited simply need to log in to their Yandex account.

You can delete or resend your invitation only via {{ org-name }}.

### Delete the invitation {#delete-invitation}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. In the left-hand panel, select ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.

  1. Select the **{{ ui-key.yacloud_org.users.title_invitations }}** tab in the center of the screen.

  1. In the row with the invitation, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.invitation.label_row-action-delete }}**.

  1. In the window that opens, confirm the deletion.

{% endlist %}

### Resend your invitation {#resend-invitation}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. In the left-hand panel, select ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.

  1. Select the **{{ ui-key.yacloud_org.users.title_invitations }}** tab in the center of the screen.

  1. In the row with the invitation, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.invitation.label_row-action-resend }}**.

  1. In the window that opens, confirm resending the invitation.

{% endlist %}

{% note info %}

{% include [yandex-account-2fa-warning.md](../iam/yandex-account-2fa-warning.md) %}

{% endnote %}
