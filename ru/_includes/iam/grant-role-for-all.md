Вы можете предоставить доступ к ресурсу всем пользователям Яндекс.Облака. Для этого назначьте роль [системной группе](../../iam/concepts/access-control/system-group.md) `allAuthenticatedUsers`.

Например, разрешите любому прошедшему аутентификацию пользователю просматривать информацию о каталоге и ресурсах в нем:

---

**[!TAB CLI]**

Назначьте роль `viewer` на каталог `my-folder`. В качестве субъекта укажите тип `system` и идентификатор `allAuthenticatedUsers`:

```
$ yc resource-manager folder add-access-binding my-folder \
    --role viewer \
    --subject system:allAuthenticatedUsers
```

**[!TAB API]**

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
1. [!INCLUDE [grant-role-folder-via-curl-step](grant-role-folder-via-curl-step.md)]

---