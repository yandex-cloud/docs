# Get the user's ID or email

You can get the following information about an organization's registered users:
* ID
* Login
* Email
* Federation ID

{% note info %}

An ID or email can be received by users with the `organization-manager.admin` or `organization-manager.organizations.owner` role. For information on assigning roles to users, see [Roles](../security/index.md#admin).

{% endnote %}

{% list tabs %}

- {{ org-name }}

   {% include [users-info](../../_includes/users-info.md) %}

- CLI

   1. See the description of the command to get information about an organization's users:

      ```
      yc organization-manager user list --help
      ```

   1. Get user information by specifying the organization ID:

      ```
      yc organization-manager user list --organization-id bof33mc4bik7bg
      +----------------------+----------+------------------+-----------------------+
      |          ID          | USERNAME |      EMAIL       |     FEDERATION ID     |
      +----------------------+----------+------------------+-----------------------+
      | ajeebjmlsdk9guz4kejh | hatter   | hatter@{{yandex-domain}} | gyuiawudhiksd21hsdjh  |
      | bsdeoujmzsdks1guzker | alice    | alice@{{yandex-domain}}  |                       |
      +----------------------+----------+------------------+-----------------------+
      ```

- API

   Get user parameters with an [API call](../api-ref/User/listMembers.md).

{% endlist %}