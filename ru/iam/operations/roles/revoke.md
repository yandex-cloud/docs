---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Отзыв роли на ресурс

Если вы хотите запретить [субъекту](../../concepts/access-control/index.md#subject) доступ к ресурсу, отзовите у него соответствующие роли на этот ресурс и на ресурсы, от которых наследуются права доступа. Подробнее читайте в разделе [{#T}](../../concepts/access-control/index.md).

{% note info %}

Если вам надо временно отнять все права доступа у пользователя с аккаунтом на Яндексе, вы можете отозвать только роль `{{ roles-cloud-member }}`. У пользователя останутся все остальные роли, но он не сможет выполнять никаких операций с ресурсами в облаке. Когда вы снова добавите пользователя в облако, права доступа для него уже будут настроены.

{% endnote %}

## Отозвать роль {#revoke-one-role}

{% list tabs %}

- Консоль управления

  В консоли управления можно отозвать роль только на облако или каталог:

  1. {% include [grant-role-console-first-steps](../../../_includes/iam/grant-role-console-first-steps.md) %}
  1. {% include [configure-roles-console](../../../_includes/iam/configure-roles-console.md) %}
  1. Нажмите на крестик рядом с ролью, чтобы удалить ее. В блоке **Роли на облако <имя облака>** вы можете удалять роли, назначенные пользователю на это облако. В блоке **Роли в каталогах** вы можете удалять роли, назначенные пользователю на каталоги.

- CLI

  Чтобы отозвать роль у субъекта, удалите соответствующую привязку прав доступа для соответствующего ресурса:

  1. Посмотрите, кому и какие роли назначены на ресурс:

    {% include [include](../../../_includes/iam/list-access-bindings-via-cli.md) %}
  1. Чтобы удалить привязку прав доступа, выполните команду:

      ```
      yc <SERVICE-NAME> <RESOURCE> remove-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
          --role <ROLE-ID> \
          --subject <SUBJECT-TYPE>:<SUBJECT-ID>
      ```
      где:
      * `<ROLE-ID>` — идентификатор роли, которую надо отозвать, например `{{ roles-cloud-owner }}`.
      * `<SUBJECT-TYPE>` — тип [субъекта](../../concepts/access-control/index.md#subject), у которого отзывается роль.
      * `<SUBJECT-ID>` — идентификатор субъекта.

      Например, чтобы отозвать роль у пользователя с идентификатором `aje6o61dvog2h6g9a33s`:

      ```
      $ yc resource-manager folder remove-access-binding default \
          --role viewer \
          --subject userAccount:aje6o61dvog2h6g9a33s
      ```

- API

  Чтобы отозвать роль у субъекта на ресурс, удалите соответствующую привязку прав доступа:

  1. {% include [include](../../../_includes/iam/list-access-bindings-via-api.md) %}
  1. Сформируйте тело запроса, например в файле `body.json`. В теле запроса укажите, какую привязку прав доступа необходимо удалить. Например, отзовите у пользователя `ajei8n54hmfhuk5nog0g` роль `editor`:

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

      {% include [grant-role-folder-via-curl](../../../_includes/iam/grant-role-folder-via-curl.md) %}

{% endlist %}
