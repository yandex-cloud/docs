{% list tabs %}

- Cloud Organization

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.
    1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
    1. На левой панели выберите раздел [Пользователи]({{ link-org-users }}) ![icon-users](../../_assets/organization/icon-users.svg).
    1. В правом верхнем углу нажмите ![icon-users](../../_assets/datalens/arrow-down.svg) → **Добавить федеративных пользователей**.
    1. Выберите федерацию, из которой необходимо добавить пользователей.
    1. Перечислите Name ID пользователей, разделяя их переносами строк.
    1. Нажмите **Добавить**. Пользователи будут подключены к организации.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды добавления пользователей:

      ```bash
      yc organization-manager federation saml add-user-accounts --help
      ```

  1. Добавьте пользователей, перечислив их Name ID через запятую:

      ```bash
      yc organization-manager federation saml add-user-accounts \
        --name my-federation \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

- API

  Чтобы добавить пользователей федерации в облако:

  1.  Сформируйте файл с телом запроса, например `body.json`. В теле запроса укажите массив Name ID пользователей, которых необходимо добавить:

      ```json
      {
        "nameIds": [
          "alice@example.com",
          "bob@example.com",
          "charlie@example.com"
        ]
      }
      ```
  1.  Отправьте запрос, указав в параметрах идентификатор федерации:

      ```bash
      $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <IAM-токен>" \
        -d '@body.json' \
        https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/<ID_федерации>:addUserAccounts
      ```

{% endlist %}