# Add a user

## Adding Yandex{#add-user-account} users

If your employees have Yandex (for example, `{{login-example}}`) accounts, they can use them to access {{yandex-cloud}} services enabled in your organization.

To add employee accounts to the organization, follow these steps:

1. [Log in]({{link-passport}}) to the organization's administrator account.

1. Go to [{{org-full-name}}]({{link-org-main}}).

1. In the left panel, select [Users]({{link-org-users}}) ![icon-users](../_assets/organization/icon-users.png).

1. In the top right-hand corner, click **Add user**.

1. Enter the email addresses of the Yandex users you want to invite to the organization (for example, `{{login-example}}`).


1. Click **Add**.

To access the services enabled for the organization, invited users just need to log in to their Yandex account.

## Add federated users {#add-user-sso}

If, when [setting up a federation](add-federation.md#federation-usage), you didn't enable the option to **Automatically create users**, you need to add your federated users to your organization manually.

To do this, you need to know the Name IDs of the users that the Identity Provider Server (IdP) returns along with the successful authentication confirmation. This is usually the user's primary email address. If you don't know what the server returns as the Name ID, contact the administrator who configured authentication for your federation.

To add federation users to an organization:

{% list tabs %}

- {{ org-name }} interface

   1. [Log in]({{link-passport}}) to the organization's administrator account.

   1. Go to [{{org-full-name}}]({{link-org-main}}).

   1. In the left panel, select [Users]({{link-org-users}}) ![icon-users](../_assets/organization/icon-users.png).

   1. In the upper-right corner, click on the arrow next to the **Add user** button. Select **Add federated users**.

   1. Select the identity federation to add users from.

   1. List the Name IDs of users, separating them with line breaks.

   1. Click **Add**. This will give the users access to the organization.

- CLI

   {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

   1. View a description of the add user command:

      ```
      yc organization-manager federation saml add-user-accounts --help
      ```

   1. Add users by listing their Name IDs separated by a comma:

      ```
      yc organization-manager federation saml add-user-accounts --name my-federation \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

- API

   To add identity federation users to the cloud:

   1. Create a file with the request body (for example, `body.json`). In the request body, specify the array of Name IDs of users you want to add:

      ```json
      {
        "nameIds": [
          "alice@example.com",
          "bob@example.com",
          "charlie@example.com"
        ]
      }
      ```
   1. Send the request by specifying the Federation ID in the parameters:

      ```bash
      $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <IAM token>" \
        -d '@body.json' \
        https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/<federation ID>:addUserAccounts
      ```

{% endlist %}