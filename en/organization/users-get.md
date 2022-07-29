# Get the user's ID or email

You can get the following information about an organization's registered users:
- ID
- Login
- Email
- Federation ID

{% list tabs %}

- {{ org-name }} interface

   1. [Log in]({{link-passport}}) to the organization's administrator account.

   1. Go to [{{org-full-name}}]({{link-org-main}}).

   1. In the left panel, select [Users]({{link-org-users}}) ![icon-users](../_assets/organization/icon-users.svg). The page will display a list:

      - The **User** column contains the user's username and email.

      - The **ID** column contains the user ID.

      - The **Federation** column contains the federation ID.

- CLI

   1. See the description of the command to get information about an organization's users:

      ```
      $ yc organization-manager user list --help
      ```

   1. Get user information by specifying the organization ID:

      ```
      $ yc organization-manager user list --organization-id bof33mc4bik7bg
      +----------------------+----------+------------------+-----------------------+
      |          ID          | USERNAME |      EMAIL       |     FEDERATION ID     |
      +----------------------+----------+------------------+-----------------------+
      | ajeebjmlsdk9guz4kejh | hatter   | hatter@{{yandex-domain}} | gyuiawudhiksd21hsdjh  |
      | bsdeoujmzsdks1guzker | alice    | alice@{{yandex-domain}}  |                       |
      +----------------------+----------+------------------+-----------------------+
      ```

- API

   Get user parameters with an [API call](../organization/api-ref/User/listMembers.md).

{% endlist %}
