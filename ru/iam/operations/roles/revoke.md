# Отзыв роли на ресурс

Если вы хотите запретить [субъекту](../../concepts/access-control/index.md#subject) доступ к ресурсу, отзовите у него соответствующие роли на этот ресурс и на ресурсы, от которых наследуются права доступа. Подробнее читайте в разделе [[!TITLE]](../../concepts/access-control/index.md).

>[!NOTE]
>
>Если вам надо временно отнять все права доступа у пользователя с аккаунтом на Яндексе, вы можете отозвать только роль `[!KEYREF roles-cloud-member]`. У пользователя останутся все остальные роли, но он не сможет выполнять никаких операций с ресурсами в облаке. Когда вы снова добавите пользователя в облако, права доступа для него уже будут настроены.

## Как отозвать роль {#revoke-one-role}

---

**[!TAB Консоль управления]**

В консоли управления можно отозвать роль только на облако или каталог:

1. [!INCLUDE [grant-role-console-first-steps](../../../_includes/iam/grant-role-console-first-steps.md)]
1. [!INCLUDE [configure-roles-console](../../../_includes/iam/configure-roles-console.md)]
1. Нажмите на крестик рядом с ролью, чтобы удалить ее. В блоке **Роли на облако <имя облака>** вы можете удалять роли, назначенные пользователю на это облако. В блоке **Роли в каталогах** вы можете удалять роли, назначенные пользователю на каталоги.

**[!TAB CLI]**

Чтобы отозвать роль у субъекта, удалите соответствующую привязку прав доступа для соответствующего ресурса:

1. Посмотрите, кому и какие роли назначены на ресурс:
    `yc <SERVICE-NAME> <RESOURCE> list-access-bindings <RESOURCE-NAME>|<RESOURCE-ID>`

    Например, посмотрите привязки прав доступа на каталог `default`:
    ```
    $  yc resource-manager folder list-access-bindings default
    +---------------------+----------------+----------------------+
    |       ROLE ID       |  SUBJECT TYPE  |      SUBJECT ID      |
    +---------------------+----------------+----------------------+
    | editor              | serviceAccount | ajepg0mjas06siuj5usm |
    | viewer              | userAccount    | aje6o61dvog2h6g9a33s |
    +---------------------+----------------+----------------------+
    ```
1. Чтобы удалить привязку прав доступа, выполните команду:

    ```
    yc <SERVICE-NAME> <RESOURCE> remove-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
        --role <ROLE-ID> \
        --subject <SUBJECT-TYPE>:<SUBJECT-ID>
    ```

    где:

    * `<SERVICE-NAME>` — имя сервиса, которому принадлежит ресурс, например `resource-manager`.
    * `<RESOURCE>` — категория ресурса, например `folder`.
    * `<RESOURCE-NAME>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору.
    * `<RESOURCE-ID>` — идентификатор ресурса.
    * `<ROLE-ID>` — идентификатор роли, которую надо отозвать, например `[!KEYREF roles-cloud-owner]`.
    * `<SUBJECT-TYPE>` — тип [субъекта](../../concepts/access-control/index.md#subject), у которого отзывается роль.
    * `<SUBJECT-ID>` — идентификатор субъекта.

    Например, чтобы отозвать роль у пользователя с идентификатором `aje6o61dvog2h6g9a33s`:

    ```
    $ yc resource-manager folder remove-access-binding default \
        --role viewer \
        --subject userAccount:aje6o61dvog2h6g9a33s
    ```

**[!TAB API]**

Чтобы отозвать роль у субъекта на ресурс, удалите соответствующую привязку прав доступа. Например, отзовите у пользователя роль на каталог `b1gvmob95yysaplct532`:

1. Посмотрите, кому и какие роли назначены на ресурс с помощью метода `listAccessBindings`:

    ```
    $ export FOLDER_ID=b1gvmob95yysaplct532
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/${FOLDER_ID}:listAccessBindings"

    {
     "accessBindings": [
      {
       "subject": {
        "id": "ajei8n54hmfhuk5nog0g",
        "type": "userAccount"
       },
       "roleId": "editor"
      }
     ]
    }
    ```

1. Сформируйте тело запроса, например в файле `body.json`. В теле запроса укажите, какую привязку прав доступа необходимо удалить.

    **body.json:**
    ```json
    {
        "accessBindingDeltas": [{
            "action": "REMOVE",
            "accessBinding": {
                "roleId": "editor",
                "subject": {
                    "id": "ajei8n54hmfhuk5nog0g",
                    "type": "userAccount"
                    }
                }
            }
        ]
    }
    ```
1. Отзовите роль, удалив указанную привязку прав доступа:

    [!INCLUDE [grant-role-folder-via-curl](../../../_includes/iam/grant-role-folder-via-curl.md)]

---