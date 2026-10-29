# Getting started with {{ iam-short-name }}

To get started with {{ iam-short-name }}, add a user to your organization and grant them access to a resource in one of your clouds. [Learn more about organizations, resources, and users](../overview/roles-and-resources.md).

## Getting started {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}). If you have not signed up yet, navigate to the management console and follow the on-screen instructions.
1. Make sure that you have the required [roles](./concepts/access-control/roles.md):

    1. In the management console, click ![image](../_assets/console-icons/layout-side-content-left.svg) or ![image](../_assets/console-icons/chevron-down.svg) in the top panel and select the cloud.
    1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
    1. Specify your account in the search bar.
    1. Check that your account has the following roles:

        * Organization owner (`organization-manager.organizations.owner`) or administrator (`organization-manager.admin`)
        * Cloud owner (`resource-manager.clouds.owner`) or administrator (`admin`)

1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have an `ACTIVE` or `TRIAL_ACTIVE` [billing account](../billing/concepts/billing-account.md). If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have any users to add to the cloud, you can [create a new Yandex account](https://passport.yandex.ru/registration) and grant this account access to the cloud.

## Add users with a Yandex account to your organization and assign them roles {#add-organization-member-and-assign-roles}

{% list tabs group=instructions %}

- Management console {#console}
  
    1. [Log in]({{ link-passport-login }}) to the cloud administrator account.
    1. In the [management console]({{ link-console-main }}), click ![image](../_assets/console-icons/layout-side-content-left.svg) or ![image](../_assets/console-icons/chevron-down.svg) in the top panel and select the cloud.
    1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
    1. In the top-right corner, click ![icon-users](../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.resource-acl.button_invite-users }}**.
    1. Enter the email addresses of the users you want to invite to the organization (e.g., `{{ login-example }}`).

        {% include [send-invitation](../_includes/organization/send-invitation.md) %}

    1. To send an invitation, click **{{ ui-key.yacloud_components.organization.action_next }}**. This will open the window for assigning roles and adding users to the group.

    1. {% include [assign-roles-on-invite](../_includes/organization/assign-roles-on-invite.md) %}

        For example, to grant users access to viewing cloud resources in the management console, select the relevant cloud in the **{{ ui-key.yacloud_components.organization.access_label_scope }}** field and specify the `resource-manager.viewer` role when assigning roles.

        To manage a folder, select the relevant folder in the **{{ ui-key.yacloud_components.organization.access_label_scope }}** field and specify the `resource-manager.editor` role when assigning roles.

    1. {% include [add-to-group-on-invite](../_includes/organization/add-to-group-on-invite.md) %}

    1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

The user will be able to log in to the organization upon accepting the invitation via the emailed link and selecting an account for log-in. To access the services enabled for the organization, the users you invited simply need to log in to their Yandex account.


## Revoke assigned roles {#revoke-roles}

If the assigned roles are no longer needed, revoke them:

{% list tabs group=instructions %}

- Management console {#console}

    * To revoke a role only in the folder:

        {% include [update-access-binding-user-console-folder](../_includes/resource-manager/update-access-binding-user-console-folder.md) %}

    * To revoke a role in the cloud:

        {% include [update-access-binding-user-console-cloud](../_includes/resource-manager/update-access-binding-user-console-cloud.md) %}

{% endlist %}

## What's next {#what-is-next}

* The [step-by-step guides](operations/index.md) will help you perform specific tasks in {{ iam-name }}.
* Learn about [access management in {{ yandex-cloud }}](concepts/access-control/index.md).
* See the [best practices for using {{ yandex-cloud }} securely](best-practices/using-iam-securely.md).
* Learn [how to get started with {{ org-full-name }}](../organization/quickstart.md).
* Learn about [authentication in {{ yandex-cloud }}](concepts/authorization/index.md#authentication).
* [Learn how to work with service accounts](quickstart-sa.md).
* Use [authentication and authorization security checklist](../security/domains/iam-checklist.md).
* See [answers to frequently asked questions](qa/index.md).
