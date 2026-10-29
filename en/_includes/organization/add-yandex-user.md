1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).

1. In the left-hand panel, select ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.

1. In the top-right corner of the screen, click ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.page.users.dropdown.button-text }}** and select ![person-planet-earth](../../_assets/console-icons/person-planet-earth.svg) **{{ ui-key.yacloud_org.page.users.action.invite-users }}** from the drop-down list.

1. Enter the email addresses of the users you want to invite to the organization (e.g., `{{ login-example }}`).

    {% include [send-invitation](./send-invitation.md) %}

1. To send invitations, click **{{ ui-key.yacloud_components.organization.action_next }}**. This will open the window for assigning roles and adding users to the group.

1. {% include [assign-roles-on-invite](../organization/assign-roles-on-invite.md) %}

    You can assign roles for an [organization](../../organization/concepts/organization.md), [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). The roles assigned for organizations, clouds, and folders also apply to their nested resources.

1. {% include [add-to-group-on-invite](../organization/add-to-group-on-invite.md) %}
