# Отзыв роли на ресурс

Если вы хотите запретить [субъекту](../../concepts/access-control/index.md#subject) доступ к ресурсу, отзовите у него соответствующие роли на этот ресурс и на ресурсы, от которых наследуются права доступа. Подробнее читайте в разделе [{#T}](../../concepts/access-control/index.md).


## Отозвать роль {#revoke-one-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * Чтобы отозвать роль в каталоге и его дочерних ресурсах:

        {% include [update-access-binding-user-console-folder](../../../_includes/resource-manager/update-access-binding-user-console-folder.md) %}

    * Чтобы отозвать роль в облаке:

        {% include [update-access-binding-user-console-cloud](../../../_includes/resource-manager/update-access-binding-user-console-cloud.md) %}

    * Чтобы отозвать сразу все роли в каталоге или облаке:

        1. На [стартовой странице]({{ link-console-main }}) консоли управления выберите каталог или облако.
        1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
        1. Выберите пользователя в списке и нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив имени пользователя.
        1. Если вы хотите отозвать все роли пользователя в облаке — нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_remove-bindings }}** и подтвердите отзыв.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Чтобы отозвать роль у субъекта, удалите права доступа для соответствующего ресурса:

    1. {% include [list-access-bindings-via-cli](../../../_includes/iam/list-access-bindings-via-cli.md) %}
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

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

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

    1. {% include [include](../../../_includes/iam/list-access-bindings-via-api.md) %}
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

        {% include [grant-role-folder-via-curl](../../../_includes/iam/grant-role-folder-via-curl.md) %}

{% endlist %}
