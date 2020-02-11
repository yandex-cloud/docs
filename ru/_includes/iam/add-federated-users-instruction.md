
{% list tabs %}

- Консоль управления

  Чтобы добавить пользователей федерации в облако:

  1. {% include [grant-role-console-first-steps](grant-role-console-first-steps.md) %}
  1. Нажмите на стрелку возле кнопки **Добавить пользователя**.
  1. Выберите **Добавить федеративных пользователей**.
  1. Выберите федерацию, из которой необходимо добавить пользователей.
  1. Перечислите Name ID пользователей, разделяя их переносами строк.

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
        https://iam.api.cloud.yandex.net/iam/v1/saml/federations/<ID федерации>:addUserAccounts
      ```


{% endlist %}