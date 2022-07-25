# Назначение роли

Чтобы предоставить доступ к ресурсу, назначьте субъекту [роль](../../concepts/access-control/roles.md) на сам ресурс или ресурс, от которого наследуются права доступа, например на каталог или облако. Подробнее читайте в разделе [{#T}](../../concepts/access-control/index.md).


## Назначить роль пользователю с аккаунтом на Яндексе {#access-to-user}

В этом разделе описывается, как назначить роль пользователю с аккаунтом на Яндексе. В примерах ниже описано, как назначить роль [сервисному аккаунту](#access-to-sa), [пользователю федерации](#access-to-federated-user) или [всем пользователям сразу](#access-to-all).



{% list tabs %}

- Консоль управления

    В консоли управления можно назначить роль только на облако или каталог:


    1. Добавьте пользователя в облако через [консоль управления](../users/create.md#console-user) или [{{ org-full-name }}](../users/create.md#organization-user).

    1. Назначьте пользователю роль в облаке:

        {% include [set-access-binding-user-cloud-console](../../../_includes/resource-manager/set-access-binding-user-cloud-console.md) %}

    1. Назначьте пользователю роль в каталоге:
 
        {% include [set-access-binding-user-acc-abstract-console](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    1. Выберите роль из списка в разделе [Роли](../../concepts/access-control/roles.md).
    1. [Получите идентификатор пользователя](../users/get.md).
    1. Назначьте роль с помощью команды:

        ```bash
        yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
            --role <role-id> \
            --subject userAccount:<user-account-id>
        ```

        Где:

        * `<service-name>` — имя сервиса, на чей ресурс назначается роль, например `resource-manager`.
        * `<resource>` — категория ресурса, например `cloud`.
        * `<resource-name>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору.
        * `<resource-id>` — идентификатор ресурса.
        * `<role-id>` — идентификатор роли, например `{{ roles-cloud-owner }}`.
        * `<user-account-id>` — идентификатор аккаунта пользователя, которому назначается роль.

        Например, назначьте роль `viewer` на [облако](../../../resource-manager/concepts/resources-hierarchy.md#folder) `mycloud`:

        ```bash
        yc resource-manager cloud add-access-binding mycloud \
            --role viewer \
            --subject userAccount:aje6o61dvog2h6g9a33s
        ```

- API

    Воспользуйтесь методом `updateAccessBindings` для соответствующего ресурса.

    1. Выберите роль из списка в разделе [Роли](../../concepts/access-control/roles.md).
    1. [Получите идентификатор пользователя](../users/get.md).
    1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип `userAccount` и идентификатор пользователя:

        **body.json:**
        ```json
        {
            "accessBindingDeltas": [{
                "action": "ADD",
                "accessBinding": {
                    "roleId": "editor",
                    "subject": {
                        "id": "gfei8n54hmfhuk5nogse",
                        "type": "userAccount"
                        }
                    }
                }
            ]
        }
        ```

    1. {% include [grant-role-folder-via-curl-step](../../../_includes/iam/grant-role-folder-via-curl-step.md) %}

    Вы можете ознакомиться с подробной инструкцией назначения роли для соответствующего ресурса:
    * [{#T}](../sa/set-access-bindings.md).
    * [{#T}](../../../resource-manager/operations/cloud/set-access-bindings.md).
    * [{#T}](../../../resource-manager/operations/folder/set-access-bindings.md).

- {{ TF }}

    Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    1. Добавьте в конфигурационный файл параметры ресурса, укажите нужную роль и перечень пользователей облака:

       * `cloud_id` — идентификатор облака. Вы также можете назначить роль внутри отдельного каталога. Для этого вместо `cloud_id` укажите `folder_id` и нужный идентификатор каталога в параметрах ресурса.
       * `role` — назначаемая роль. Обязательный параметр.
       * `members` — список пользователей и сервисных аккаунтов, которым назначается роль. Указывается в виде `userAccount:<идентификатор пользователя>` или `serviceAccount:<идентификатор сервисного аккаунта>`. Обязательный параметр.

       Пример структуры конфигурационного файла:

        ```
        resource "yandex_resourcemanager_cloud_iam_binding" "admin" {
            cloud_id    = "<идентификатор облака>"
            role        = "<роль>"
            members     = [
            "serviceAccount:<идентификатор сервисного аккаунта>",
            "userAccount:<идентификатор пользователя>",
            ]
        }
        ```


        Более подробную информацию о параметрах ресурса `yandex_resourcemanager_cloud_iam_binding` см. в [документации провайдера]({{ tf-provider-link }}/iam_service_account_iam_binding).

    1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:

            ```
            terraform plan
            ```

       Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:

            ```
            terraform apply
            ```

        1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

            ```
            yc resource-manager folder list-access-bindings <имя каталога>|<идентификатор каталога>
            ```

{% endlist %}


## Назначить несколько ролей {#multiple-roles}

{% list tabs %}

- Консоль управления

    {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-multiple-users-console.md) %}

- CLI

    Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-binding`.

    {% note alert %}

    Команда `set-access-binding` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

    {% endnote %}

    Например, чтобы назначить несколько ролей на каталог:

    1. Убедитесь, что на ресурс не назначено ролей, которые вы не хотите потерять:

        ```bash
        yc resource-manager folder list-access-binding my-folder
        ```

    1. Назначьте роли. Например, назначьте одному пользователю роль `editor`, а другому `viewer`:


        ```bash
        yc resource-manager folder set-access-bindings my-folder \
            --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse
            --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
        ```

- API

    1. Чтобы назначить одному пользователю роль `editor`, а другому `viewer`, в файл с телом запроса добавьте несколько привязок прав доступа в `accessBindingDeltas`.

        **body.json:**
        ```json
        {
            "accessBindingDeltas": [{
                "action": "ADD",
                "accessBinding": {
                    "roleId": "editor",
                    "subject": {
                        "id": "gfei8n54hmfhuk5nogse",
                        "type": "userAccount"
                    }
                }
            },{
                "action": "ADD",
                "accessBinding": {
                    "roleId": "viewer",
                    "subject": {
                        "id": "helj89sfj80aj24nugsz",
                        "type": "userAccount"
                    }
                }
            }]
        }
        ```

    1. Назначьте указанные роли, например на каталог с идентификатором `b1gvmob95yysaplct532`:

        {% include [grant-role-folder-via-curl](../../../_includes/iam/grant-role-folder-via-curl.md) %}

    Вы также можете назначать роли с помощью метода `setAccessBindings`.

    {% note alert %}

    Метод `setAccessBindings` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

    {% endnote %}

    1. В теле запроса укажите список новых привязок прав доступа.

        **body.json:**
        ```json
        {
            "accessBindings": [{
                "roleId": "editor",
                "subject": { "id": "ajei8n54hmfhuk5nog0g", "type": "userAccount" }
            },{
                "roleId": "viewer",
                "subject": { "id": "helj89sfj80aj24nugsz", "type": "userAccount" }
            }]
        }
        ```

    2. Назначьте роли:

        ```bash
        export FOLDER_ID=b1gvmob95yysaplct532
        export IAM_TOKEN=CggaATEVAgA...
        curl -X POST \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer ${IAM_TOKEN}" \
            -d '@body.json' \
            "https://resource-manager.{{ api-host }}/resource-manager/v1/folders/${FOLDER_ID}:setAccessBindings"
        ```

{% endlist %}


## Доступ к ресурсу для сервисного аккаунта {#access-to-sa}

{% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-sa.md) %}


## Доступ к ресурсу для федеративного пользователя {#access-to-federated-user}

В консоли управления [федеративному пользователю](../../../organization/add-federation.md) можно назначить роль на отдельное облако или каталог.

{% list tabs %}

- Консоль управления

    Назначение роли происходит так же, как назначение роли пользователю с аккаунтом на Яндексе. Рядом с именем пользователя будет указано имя федерации, к которой он относится.

    В консоли управления можно назначить роль только на облако или каталог:

    1. Назначьте пользователю роль в облаке:

        {% include [set-access-binding-user-cloud-console](../../../_includes/resource-manager/set-access-binding-user-cloud-console.md) %}

    1. Назначьте пользователю роль в каталоге:

        {% include [set-access-binding-user-acc-abstract-console](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI

    1. Выберите роль из списка в разделе [Роли](../../concepts/access-control/roles.md).
    1. [Получите идентификатор пользователя](../users/get.md).
    1. Назначьте роль с помощью команды:

        ```bash
        yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
            --role <role-id> \
            --subject federatedUser:<federated-user-id>
        ```

        Где:

        * `<service-name>` — имя сервиса, на чей ресурс назначается роль, например `resource-manager`.
        * `<resource>` — категория ресурса, например `cloud`.
        * `<resource-name>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору.
        * `<resource-id>` — идентификатор ресурса.
        * `<role-id>` — идентификатор роли, например `{{ roles-cloud-owner }}`.
        * `<federated-user-id>` — идентификатор аккаунта пользователя, которому назначается роль.

        Например, назначьте роль `viewer` на [облако](../../../resource-manager/concepts/resources-hierarchy.md#folder) `mycloud`:

        ```bash
        yc resource-manager cloud add-access-binding mycloud \
            --role viewer \
            --subject federatedUser:aje6o61dvog2h6g9a33s
        ```

- API

    Воспользуйтесь методом `updateAccessBindings` для соответствующего ресурса.

    1. Выберите роль из списка в разделе [Роли](../../concepts/access-control/roles.md).
    1. [Получите идентификатор пользователя](../users/get.md).
    1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип `federatedUser` и идентификатор пользователя:

        **body.json:**

        ```json
        {
            "accessBindingDeltas": [{
                "action": "ADD",
                "accessBinding": {
                    "roleId": "editor",
                    "subject": {
                        "id": "gfei8n54hmfhuk5nogse",
                        "type": "federatedUser"
                        }
                    }
                }
            ]
        }
        ```

    1. {% include [grant-role-folder-via-curl-step](../../../_includes/iam/grant-role-folder-via-curl-step.md) %}

{% endlist %}



## Доступ к ресурсу для группы пользователей {##access-group}

{% list tabs %}

- Консоль управления

    Назначьте роль в облаке для группы пользователей:

    1. В [консоли управления]({{ link-console-main }}) [выберите](../../../resource-manager/operations/cloud/switch-cloud.md) облако.
    1. Перейдите на вкладку **Права доступа**.
    1. Нажмите кнопку **Назначить роли**.
    1. В окне **Настройка прав доступа** нажмите кнопку **Выбрать пользователя**:
        1. Перейдите на вкладку **Группы** или воспользуйтесь поиском, чтобы найти группу по названию.
        1. Нажмите кнопку **Добавить роль**.
        1. Выберите роль в облаке.
        1. Нажмите кнопку **Сохранить**.
  
    Название группы отобразится в разделе **Права доступа** облака вместе с остальными пользователями, у которых есть роли в этом облаке.

- CLI

    1. Выберите роль из списка в разделе [Роли](../../concepts/access-control/roles.md).
    1. [Получите идентификатор пользователя](../users/get.md).
    1. Назначьте роль с помощью команды:

        ```bash
        yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
            --role <role-id> \
            --subject group:<group-id>
        ```

        Где:

        * `<service-name>` — имя сервиса, на чей ресурс назначается роль, например `resource-manager`.
        * `<resource>` — категория ресурса, например `cloud`.
        * `<resource-name>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору.
        * `<resource-id>` — идентификатор ресурса.
        * `<role-id>` — идентификатор роли, например `{{ roles-cloud-owner }}`.
        * `<group-id>` — идентификатор группы, которой назначается роль.

        Например, назначьте роль `viewer` на [облако](../../../resource-manager/concepts/resources-hierarchy.md#folder) `mycloud`:

        ```bash
        yc resource-manager cloud add-access-binding mycloud \
            --role viewer \
            --subject group:aje6o61dvog2h6g9a33s
        ```

{% endlist %}

## Доступ к ресурсу всем пользователям {#access-to-all}

{% include [grant-role-for-all](../../../_includes/iam/grant-role-for-all.md) %}
