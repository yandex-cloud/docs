{% list tabs %}

- Management console

  To add identity federation users to the cloud:
  1. {% include [grant-role-console-first-steps](grant-role-console-first-steps.md) %}
  1. Click the arrow next to the **Add user** button.
  1. Select **Add federated users**.
  1. Select the identity federation to add users from.
  1. List the Name IDs of users, separating them with line breaks.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. View a description of the add user command:

      ```
      yc iam federation add-user-accounts --help
      ```

  1. Add users by listing their Name IDs separated by a comma:

      ```
      yc iam federation add-user-accounts --name my-federation \
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
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <IAM token>" \
        -d '@body.json' \
        https://iam.{{ api-host }}/iam/v1/saml/federations/<federation ID>:addUserAccounts
      ```

{% endlist %}

