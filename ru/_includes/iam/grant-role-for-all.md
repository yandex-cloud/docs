{% include [set-access-to-all](set-access-to-all.md) %}

Например, разрешите любому прошедшему аутентификацию пользователю просматривать информацию о каталоге и ресурсах в нем:

{% list tabs %}

- CLI

  Назначьте роль `viewer` на каталог `my-folder`. В качестве субъекта укажите тип `system` и идентификатор `allAuthenticatedUsers`:

  ```
  $ yc resource-manager folder add-access-binding my-folder \
      --role viewer \
      --subject system:allAuthenticatedUsers
  ```

- API

  1. Сформируйте тело запроса, например в файле `body.json`. В `roleId` назначьте роль `viewer`. В свойстве `subject` укажите тип `system` и идентификатор `allAuthenticatedUsers`:

      **body.json:**
      ```json
      {
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "allAuthenticatedUsers",
                  "type": "system"
                  }
              }
          }]
      }
      ```
  1. {% include [grant-role-folder-via-curl-step](grant-role-folder-via-curl-step.md) %}

{% endlist %}
