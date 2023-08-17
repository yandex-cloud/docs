# Adding a user to the cloud

Add a user to your [organization](../../../organization/) to [grant](../../../iam/operations/roles/grant.md) him or her access to {{ yandex-cloud }} resources.

You can add [users with a Yandexaccount](#passport-user) as well as [federated users](#federated-user). To do this, you need to be the organization administrator (the `organization-manager.admin` role) or owner (the `organization-manager.organizations.owner` role).

The user will become an organization member, and you will be able to grant them access to your cloud resources by [assigning](../roles/grant.md) them a [role](../../concepts/access-control/roles.md). A new organization member will not have access to cloud resources until you assign them a role.

## Add a user with a Yandex account {#add-useraccount}

You can add a user to an organization via the management console or {{ org-full-name }}. If you add a user via {{ org-full-name }}, an invitation to join the organization will be sent to the user's email address. If you use the management console, users are added immediately.

### Add a user via the {{ org-full-name }} interface {#organization-user}

{% include [invite-user](../../../_includes/organization/invite-user.md) %}

{% note info %}

{% include [yandex-account-2fa-warning.md](../../../_includes/iam/yandex-account-2fa-warning.md) %}

{% endnote %}

### Add a user via the management console {#console-user}

1. [Log in]({{ link-passport-login }}) to the cloud administrator account.
1. Log in to the [management console]({{ link-console-main }}).
1. [Select](../../../resource-manager/operations/cloud/switch-cloud.md) a cloud.
1. Go to **Access rights**.
1. In the top-right corner, click ![icon-users](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.
1. Enter the user's Yandex email address.
1. Click **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**.

After receiving the invitation, the user should:

1. Click the link and accept the invitation.
1. Log in to the organization.

## Add federated users {#federated-user}

To add federated users, you need to know the Name IDs of the users that the Identity Provider Server (IdP) returns in the authentication successful response. This is usually the user's main email address. If you do not know what the server returns as the Name ID, contact the administrator who configured authentication for your federation.

To add federation users to an organization:

{% include [add-federateduser](../../../_includes/organization/add-federateduser.md) %}

#### What's next {#what-is-next}

* [Assign roles to the new users](../roles/grant.md).
