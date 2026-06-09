# Отзыв роли на ресурс

{% note info %}

Даже если [операция](../../../api-design-guide/concepts/about-async.md) с ресурсами [сервисов](../../../overview/concepts/services.md) {{ yandex-cloud }} разрешена [ролью](../../concepts/access-control/roles.md), ее выполнение может быть заблокировано, если на [организацию](../../../organization/concepts/organization.md), [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) назначена [политика авторизации](../../concepts/access-control/access-policies.md), запрещающая эту операцию.

{% endnote %}

Если вы хотите запретить [субъекту](../../concepts/access-control/index.md#subject) доступ к ресурсу, отзовите у него соответствующие роли на этот ресурс и на ресурсы, от которых наследуются права доступа. Подробнее читайте в разделе [{#T}](../../concepts/access-control/index.md).


## Отозвать роль {#revoke-one-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * Чтобы отозвать роль в каталоге и его дочерних ресурсах:

        1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
        1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
        1. Выберите пользователя в списке и нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив имени пользователя.
        1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.edit-roles }}**.
        1. Нажмите значок ![image](../../../_assets/console-icons/xmark.svg) напротив роли, которую хотите отозвать.
        1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

    * Чтобы отозвать роль в облаке:

        1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужное облако.
        1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
        1. Выберите пользователя в списке и нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив имени пользователя.
        1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.edit-roles }}**.
        1. Нажмите значок ![image](../../../_assets/console-icons/xmark.svg) напротив роли, которую хотите отозвать.
        1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

    * Чтобы отозвать сразу все роли в каталоге или облаке:

        1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог или облако.
        1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
        1. Выберите пользователя в списке и нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив имени пользователя.
        1. Если вы хотите отозвать все роли пользователя в облаке — нажмите кнопку **{{ ui-key.yacloud_components.acl.action.revoke-access }}** и подтвердите отзыв.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    Чтобы отозвать роль у субъекта, удалите права доступа для соответствующего ресурса:

    1. Посмотрите, какие роли назначены на ресурс:
       
       ```bash
       yc <имя_сервиса> <категория_ресурса> list-access-bindings <имя_или_идентификатор_ресурса>
       ```
       
       Где:
       
       * `<имя_сервиса>` — имя сервиса, которому принадлежит ресурс, например `resource-manager`.
       * `<категория_ресурса>` — категория ресурса, например `folder`.
       * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса. Вы можете указать ресурс по имени или идентификатору.
       
       Например, посмотрите кому и какие роли назначены на каталог `default`:
       
       ```bash
       yc resource-manager folder list-access-bindings default
       ```
       
       Результат:
       
       ```text
       +---------------------+----------------+----------------------+
       |       ROLE ID       |  SUBJECT TYPE  |      SUBJECT ID      |
       +---------------------+----------------+----------------------+
       | editor              | serviceAccount | ajepg0mjas06******** |
       | viewer              | userAccount    | aje6o61dvog2******** |
       +---------------------+----------------+----------------------+
       ```
    1. Чтобы удалить права доступа, выполните команду:

        ```bash
        yc <имя_сервиса> <категория_ресурса> remove-access-binding <имя_или_идентификатор_ресурса> \
            --role <идентификатор_роли> \
            --subject <тип_субъекта>:<идентификатор_субъекта>
        ```

        Где:
        * `--role` — идентификатор роли, которую надо отозвать, например `{{ roles-cloud-owner }}`.
        * `<тип_субъекта>` — тип [субъекта](../../concepts/access-control/index.md#subject), у которого отзывается роль.
        * `<идентификатор_субъекта>` — идентификатор субъекта.

- {{ TF }} {#tf}

    Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

    1. Чтобы отозвать роль у субъекта на ресурс, найдите в конфигурационном файле описание ресурса:

        ```
        resource "yandex_resourcemanager_cloud_iam_binding" "admin" {
            cloud_id    = "<идентификатор_облака>"
            role        = "<роль>"
            members     = [
            "serviceAccount:<идентификатор_сервисного_аккаунта>",
            "userAccount:<идентификатор_пользователя>",
            ]
        }
        ```

    1. Удалите запись с информацией о субъекте, у которого нужно отозвать права, из перечня пользователей `members`.

       Более подробную информацию о параметрах ресурса `yandex_resourcemanager_cloud_iam_binding`, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

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
        yc resource-manager cloud list-access-bindings <имя_или_идентификатор_облака>
        ```

- API {#api}

    Чтобы отозвать роль у субъекта на ресурс, удалите соответствующие права доступа:

    1. Посмотрите, кому и какие роли назначены на ресурс с помощью метода REST API `listAccessBindings`. Например, чтобы посмотреть роли на каталог `b1gvmob95yys********`:
       
       ```bash
       export FOLDER_ID=b1gvmob95yys********
       export IAM_TOKEN=CggaATEVAgA...
       curl \
         --header "Authorization: Bearer ${IAM_TOKEN}" \
         "https://resource-manager.{{ api-host }}/resource-manager/v1/folders/${FOLDER_ID}:listAccessBindings"
       ```
       
       Результат:
       
       ```json
       {
         "accessBindings": [
         {
           "subject": {
             "id": "ajei8n54hmfh********",
             "type": "userAccount"
           },
           "roleId": "editor"
         }
         ]
       }
       ```
    1. Сформируйте тело запроса, например в файле `body.json`. В теле запроса укажите, какие назначенные права доступа необходимо удалить. Например, отзовите у пользователя `ajei8n54hmfh********` роль `editor`:

        **body.json:**
        ```json
        {
            "accessBindingDeltas": [{
                "action": "REMOVE",
                "accessBinding": {
                    "roleId": "editor",
                    "subject": {
                        "id": "ajei8n54hmfh********",
                        "type": "userAccount"
                        }
                    }
                }
            ]
        }
        ```

    1. Отзовите роль, удалив назначенные права доступа:

        ```bash
        export FOLDER_ID=b1gvmob95yys********
        export IAM_TOKEN=CggaAT********
        curl \
          --request POST \
          --header "Content-Type: application/json" \
          --header "Authorization: Bearer ${IAM_TOKEN}" \
          --data '@body.json' \
          "https://resource-manager.{{ api-host }}/resource-manager/v1/folders/${FOLDER_ID}:updateAccessBindings"
        ```

{% endlist %}