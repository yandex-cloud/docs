# Adding a user to the cloud

{% if product == "yandex-cloud" %}

You can add [users with a {% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %}](#passport-user) account and [federated users](#federated-user).

## Adding a user via {{ org-full-name }} {#organization-user}

Via {{ org-full-name }}, you can only add users with a {% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} account.

1. [Log in]({{ link-passport-login }}) to the organization's administrator account.
1. Go to [{{ org-full-name }}]({{ link-org-main }}).
1. In the left panel, select [Users]({{ link-org-main }}/users) ![icon-users](../../../_assets/organization/icon-users.svg).
1. In the upper-right corner, click **Add user**.
1. Enter the {% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} user's email address.
1. Click **Add**. The user will be added to the organization and get access to its services.

When a new user is added to an organization, they are automatically assigned the [cloud member role](../../concepts/access-control/roles.md#member): `{{ roles-cloud-member }}`. This role is necessary for the user to access resources in the cloud. However, this role doesn't give you the right to perform any operations and is only used in combination with other roles, such as `admin`, `editor`, or `viewer`.

{% note info %}

{% include [yandex-account-2fa-warning.md](../../../_includes/iam/yandex-account-2fa-warning.md) %}

{% endnote %}

## Adding a user via the management console {#console-user}

Via the management console, you can only add users with a {% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} account.

1. [Log in]({{ link-passport-login }}) to the cloud administrator account.
1. Log in to the [management console]({{ link-console-main }}).
1. [Select](../../../resource-manager/operations/cloud/switch-cloud.md) a cloud.
1. Go to **Access rights**.
1. Click ![image](../../../_assets/options.svg) in the upper-right corner of the page.
1. Click **Add user**.
1. Enter the user's {% if product == "yandex-cloud" %}Yandex{% endif %} {% if product == "cloud-il" %}Google{% endif %} email address.
1. Click **Add**.

After that, the user gets the [cloud member role](../../concepts/access-control/roles.md#member): `{{ roles-cloud-member }}`. This role is necessary for the user to access resources in the cloud. However, this role doesn't give you the right to perform any operations and is only used in combination with other roles, such as `admin`, `editor`, or `viewer`.

{% endif %}
{% if product == "cloud-il" %}
{% note info %}

At the [Preview](../../../overview/concepts/launch-stages.md) stage, you can only add [federated users](../../concepts/federations.md) to the cloud.

{% endnote %}

{% endif %}
## Add federated users {#federated-user}

To add federated users, you need to know the Name IDs of the users that the Identity Provider Server (IdP) returns in the authentication successful response. This is usually the user's main email address. If you don't know what the server returns as the Name ID, contact the administrator who configured authentication for your federation.

To add federation users to an organization:

{% list tabs %}

- Management console

  1. [Log in to the account]({{ link-passport-login }}) your organization's administrator.
  1. Go to [{{ org-full-name }}]({{ link-org-main }}).
  1. In the left panel, select [Users]({{ link-org-main }}/users) ![icon-users](../../../_assets/organization/icon-users.svg).
  1. In the upper-right corner, click on the arrow next to the **Add user** button. Select **Add federated users**.
  1. Select the identity federation to add users from.
  1. List the Name IDs of users, separating them with line breaks.
  1. Click **Add**. This will give the users access to the organization.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <IAM token>" \
        -d '@body.json' \
        https://iam.{{ api-host }}/iam/v1/saml/federations/<federation ID>:addUserAccounts
      ```

{% endlist %}

#### What's next {#what-is-next}

* [Assign roles to the new users](../roles/grant.md).