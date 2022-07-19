# Adding a user to a cloud


To add users to the cloud, first invite them to the [organization](../../../organization/enable-org.md) assigned for the cloud.

You can add [users with a Yandex account](#passport-user) and [federated users](#federated-user).

## Add a user with a Yandex account {#passport-user}

1. [Log in to the account]({{ link-passport-login }}) your organization's administrator.
1. Go to [{{ org-full-name }}]({{ link-org-main }}).
1. In the left panel, select [Users]({{ link-org-main }}/users) ![icon-users](../../../_assets/organization/icon-users.png).
1. In the upper-right corner, click **Add user**.
1. Enter the Yandex user's email address.
1. Click **Add**. The user will be added to the organization and get access to its services.

{% note info %}

{% include [yandex-account-2fa-warning.md](../../../_includes/iam/yandex-account-2fa-warning.md) %}

{% endnote %}


## Add federated users {#federated-user}

To add federated users, you need to know the Name IDs of the users that the Identity Provider Server (IdP) returns in the authentication successful response. This is usually the user's primary email address. If you don't know what the server returns as the Name ID, contact the administrator who configured authentication for your federation.

To add federation users to an organization:

{% list tabs %}

- Management console

  1. [Log in to the account]({{ link-passport-login }}) your organization's administrator.
  1. Go to [{{ org-full-name }}]({{ link-org-main }}).
  1. In the left panel, select [Users]({{ link-org-main }}/users) ![icon-users](../../../_assets/organization/icon-users.png).
  1. In the upper-right corner, click on the arrow next to the **Add user** button. Select **Add federated users**.
  1. Select the identity federation to add users from.
  1. List the Name IDs of users, separating them with line breaks.
  1. Click **Add**. This will give the users access to the organization.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <IAM token>" \
        -d '@body.json' \
        https://iam.{{ api-host }}/iam/v1/saml/federations/<federation ID>:addUserAccounts
      ```

{% endlist %}

#### What's next {#what-is-next}

* [Assign roles to the added users](../roles/grant.md).

