{% include [set-access-to-all](set-access-to-all.md) %}

Например, разрешите любому прошедшему аутентификацию пользователю просматривать информацию о каталоге и ресурсах в нем:

{% list tabs %}

- Консоль управления

    1. Откройте страницу каталога. Вы можете выбрать каталог на [стартовой странице]({{ link-console-main }}) консоли управления. На этой странице отображаются каталоги для выбранного облака.
    1. Перейдите в раздел **Права доступа в каталоге** (кнопка **Права доступа** на панели слева).
    1. Нажмите кнопку **Назначить роли**.
    1. В окне **Настройка прав доступа** каталога нажмите кнопку **Выбрать пользователя**.
    1. Выберите раздел **Группы**.
    1. Выберите группу **All authenticated users**.
    1. Нажмите кнопку **Добавить роль**.
    1. Выберите роль в каталоге.
    1. Нажмите **Сохранить**.

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
