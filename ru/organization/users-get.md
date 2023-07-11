# Получить идентификатор или почту пользователя

Вы можете получить следующую информацию о пользователях, которые зарегистрированы в организации:
* идентификатор;
* логин;
* почта;
* идентификатор федерации.

{% note info %}

Получить идентификатор или почту может пользователь с ролью `organization-manager.admin` или `organization-manager.organizations.owner`. Как назначить роль пользователю, читайте в разделе [Роли](roles.md#admin).

{% endnote %}

{% list tabs %}

- {{ org-name }}

  {% include [users-info](../_includes/users-info.md) %}

- CLI

  1. Посмотрите описание команды получения информации о пользователях организации:

      ```
      yc organization-manager user list --help
      ```

  1. Получите информацию о пользователях, указав идентификатор организации:

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

  Получите параметры пользователя с помощью [запроса к API](../organization/api-ref/User/listMembers.md).

{% endlist %}