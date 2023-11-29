# Managing users

The guide in this checklist item will help you add users to your created organization, appoint an administrator, and set user roles.

## Add a Yandex user {#add-user-yandex}

If your employees have Yandex accounts, e.g., `login@yandex.ru`, they can use them to access {{ yandex-cloud }} services enabled in your organization.

To add employee accounts to the organization, follow these steps:

1. [Log in]({{ link-passport-login }}) to the organization administrator account.
1. Go to [{{ org-full-name }}]({{ link-org-main }}).
1. In the left-hand panel, select [Users](https://org.cloud.yandex.ru/users) ![icon-users](../../_assets/organization/icon-users.svg).
1. In the top-right corner, click **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.
1. Enter the email addresses of the users you want to invite to the organization (e.g., `{{login-example}}`).

    You can send invitations to any email address. Invited users will be able to select the appropriate Yandex account once they accept the invitation.

1. Click **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**. The users will be added to the organization as soon as they accept the invitation and select a log-in account for the organization.

To access the organization's enabled services, invited users simply need to log in to their Yandex account.

## Add federated users {#add-user-sso}

To add federated users, you need to know the user Name IDs returned by the Identity Provider (IdP) server together with the authentication successful response. This is usually the user's primary email address. If you do not know what the server returns as the Name ID, contact the administrator who configured authentication for your federation.

To add federation users to an organization:

{% include notitle [add-user-sso](../../_includes/organization/add-user-sso.md) %}

## Assign roles to the users {#add-role}

{% list tabs %}

- Management console

   In the management console, you can only assign a role for a cloud or folder:

   {% include [grant-role-console](../../_includes/grant-role-console.md) %}


- CLI

   1. Select a role from the list in [Roles](../../iam/concepts/access-control/roles.md).
   1. [Get the user ID](../../organization/operations/users-get.md).
   1. Assign the role using the command:

   ```
   yc <SERVICE-NAME> <RESOURCE> add-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
     --role <ROLE-ID> \
     --subject userAccount:<USER-ACCOUNT-ID>
   ```

   Where:

   * `<SERVICE-NAME>`: Name of the service to whose resource a role, e.g., `resource-manager`, is assigned.
   * `<RESOURCE>`: Resource category, e.g., `cloud`.
   * `<RESOURCE-NAME>`: Name of the resource. You can specify a resource by its name or ID.
   * `<RESOURCE-ID>`: Resource ID.
   * `<ROLE-ID>`: Role ID, e.g., `{{ roles-cloud-owner }}`.
   * `<USER-ACCOUNT-ID>`: ID of the user account to which the role is assigned.

   For example, assign the `viewer` role for the `mycloud` [cloud](../../resource-manager/concepts/resources-hierarchy.md#folder):

   ```
   $ yc resource-manager cloud add-access-binding mycloud \
     --role viewer \
     --subject userAccount:aje6o61dvog2h6g9a33s
   ```

- API

   Use the `updateAccessBindings` method for the corresponding resource.

   1. Select a role from the list in [Roles](../../iam/concepts/access-control/roles.md).
   1. [Get the user ID](../../organization/operations/users-get.md).
   1. Create a request body, for example, in a `body.json` file. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:

   **body.json:**
   ```json
   {
     "accessBindingDeltas": [{
       "action": "ADD",
       "accessBinding": {
         "roleId": "editor",
         "subject": {
           "id": "gfei8n54hmfhuk5nogse",
           "type": "userAccount"
           }
         }
       }
     ]
   }
   ```

   1. {% include [grant-role-folder-via-curl-step](../../_includes/iam/grant-role-folder-via-curl-step.md) %}

{% endlist %}


## Appoint an administrator {#admin}

To grant a user organization management permissions, assign them one of the following roles:

* `organization-manager.admin`: Organization administrator role.

   The role allows you to edit organization settings, create identity federations, add and remove users, create other administrators, and manage the resources of an organization's clouds.

* `organization-manager.organizations.owner`: The organization owner role.

   The role allows you to appoint organization owners as well as use all the administrator privileges.

   By default, the user who creates an organization is the organization owner.

* `organization-manager.viewer`: This role allows you to view an organization's settings without editing them.
