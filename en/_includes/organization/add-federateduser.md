{% list tabs %}

- Cloud Organization

   1. [Log in]({{ link-passport-login }}) to the organization's administrator account.
   1. Go to [{{ org-full-name }}]({{ link-org-main }}).
   1. In the left-hand panel, select [Users]({{ link-org-users }}) ![icon-users](../../_assets/organization/icon-users.svg).
   1. In the upper-right corner, click on the arrow next to the **Add user** button. Select **Add federated users**.
   1. Select the identity federation to add users from.
   1. List the Name IDs of users, separating them with line breaks.
   1. Click **Add**. This will give the users access to the organization.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the add user command:

      ```bash
      yc organization-manager federation saml add-user-accounts --help
      ```

   1. Add users by listing their Name IDs separated by a comma:

      ```bash
      yc organization-manager federation saml add-user-accounts \
        --name my-federation \
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