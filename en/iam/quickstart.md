# Getting started with {{ iam-short-name }}

To get started with {{ iam-short-name }}, add a user to your organization and grant them access to a resource in one of your clouds. [Learn more about organizations, resources, and users](../overview/roles-and-resources.md).

## Getting started {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. Make sure that you have the required [roles](./concepts/access-control/roles.md):

    1. In the management console, select the appropriate cloud from the list on the left. For example:

        ![image](../_assets/resource-manager/switch-cloud-n-n.png)

    1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
    1. Specify your account in the search bar.
    1. Check that your account has the following roles:

        * Organization owner (`organization-manager.organizations.owner`) or administrator (`organization-manager.admin`)
        * Cloud owner (`resource-manager.clouds.owner`) or administrator (`admin`)

1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have any users to add to the cloud, you can [create a new Yandex account](https://passport.yandex.ru/registration) and grant this account access to the cloud.

## Add a user with a Yandex account to your organization {#add-organization-member}

{% list tabs group=instructions %}

- Management console {#console}
  
    1. [Log in]({{ link-passport-login }}) to the cloud administrator account.
    1. Log in to the [management console]({{ link-console-main }}).
    1. Select the appropriate cloud from the list on the left.
    1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
    1. In the top-right corner, click ![icon-users](../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.resource-acl.button_invite-users }}**.
    1. Enter the email addresses of the users you want to invite to the organization (e.g., `{{login-example}}`).

        {% include [send-invitation](../_includes/organization/send-invitation.md) %}

    1. Click **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**.

{% endlist %}

The user will be able to log in to the organization upon accepting the invitation via the emailed link and selecting an account for log-in. To access the [services](../organization/concepts/manage-services.md#collaboration) enabled for the organization, the users you invited simply need to log in to their Yandex account.

## Assign roles to the user {#assign-role}

To specify which operations the user can perform, assign relevant roles to the user. For example, allow the user to view cloud resources and manage a folder:

{% list tabs group=instructions %}

- Management console {#console}

    1. Assign the user a role in the cloud:
        
        {% include [set-accessbinding-user-editor-folder-console](../_includes/resource-manager/set-accessbinding-user-viewer-cloud-console.md) %}

    1. Assign the user a role in the folder:

        {% include [set-accessbinding-user-editor-folder-console](../_includes/resource-manager/set-accessbinding-user-editor-folder-console.md) %}

{% endlist %}

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
* Learn [how to get started with {{ org-name }}](../organization/quickstart.md).
* Learn about [authentication in {{ yandex-cloud }}](concepts/authorization/index.md#authentication).
* [Learn how to work with service accounts](quickstart-sa.md).
* See [answers to frequently asked questions](qa/index.md).
