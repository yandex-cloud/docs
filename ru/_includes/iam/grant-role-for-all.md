{% include [set-access-to-all](set-access-to-all.md) %}

Например, разрешите любому прошедшему аутентификацию пользователю просматривать информацию о каталоге:

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
    1. В окне **{{ ui-key.yacloud_components.acl.label.title }}** нажмите кнопку ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud_org.form.acl.edit.action.subject.select }}**.
    1. Выберите раздел **{{ ui-key.yacloud_org.common.resource-acl.label_groups }}**.
    1. Выберите группу `All authenticated users`.
    1. Нажмите кнопку ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}**.
    1. Выберите роль `resource-manager.viewer`.
    1. Нажмите **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI

  {% include [cli-install](../cli-install.md) %}

  Назначьте роль `viewer` на каталог `my-folder`. В качестве субъекта укажите тип `system` и идентификатор `allAuthenticatedUsers`:

  ```bash
  yc resource-manager folder add-access-binding my-folder \
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

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% note alert %}

  Не создавайте ресурс совместно с ресурсом `yandex_resourcemanager_folder_iam_policy`. Они будут конфликтовать.

  {% endnote %}

  Чтобы назначить роль на каталог, созданный с помощью {{ TF }}:

  1. Опишите в конфигурационном файле параметры роли каталога:

     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который назначаются права. Обязательный параметр.
     * `role` — назначаемая роль. Обязательный параметр.

       {% note info %}

       Для каждой роли можно использовать только один ресурс `yandex_resourcemanager_folder_iam_member`.

       {% endnote %}

     * `member` — пользователь, которому будет присвоена роль. Чтобы добавить всех пользователей, создайте запись в формате `system:<allUsers|allAuthenticatedUsers>`, где `<allUsers|allAuthenticatedUsers>` — одна из [системных групп](../../iam/concepts/access-control/system-group.md). Обязательный параметр.

     Пример структуры конфигурационного файла:

     ```hcl
     ...
     data "yandex_resourcemanager_folder" "project1" {
       folder_id = "<идентификатор каталога>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "viewer" {
       folder_id = "${data.yandex_resourcemanager_folder_iam_member.project1.id}"
       role      = "viewer"
       member    = "system:allUsers"
     }
     ...
     ```

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder_iam_member` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
  
  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение каталога можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc resource-manager folder list-access-bindings <имя каталога>|<ID каталога>
     ```

{% endlist %}
