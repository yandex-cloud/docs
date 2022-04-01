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

- Terraform

  Если у вас еще нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% note alert %}

  Не создавайте ресурс совместно с ресурсом `yandex_resourcemanager_folder_iam_policy`. Они будут конфликтовать.

  {% endnote %}

  Чтобы назначить роль на каталог, созданный с помощью Terraform:

  1. Опишите в конфигурационном файле параметры роли каталога:

     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который назначаются права. Обязательный параметр.
     * `role` — назначаемая роль. Обязательный параметр.

       {% note info %}

       Для каждой роли можно использовать только один ресурс `yandex_resourcemanager_folder_iam_binding`.

       {% endnote %}

     * `members` — список пользователей, которым будет присвоена роль. Чтобы добавить всех пользователей, создайте запись в формате `system:<allUsers|allAuthenticatedUsers>`, где `<allUsers|allAuthenticatedUsers>` — одна из [системных групп](../../iam/concepts/access-control/system-group.md). Обязательный параметр.

     {% cut "Пример назначения роли на каталог с помощью Terraform" %}

     ```hcl
     ...
     data "yandex_resourcemanager_folder" "project1" {
       folder_id = "<идентификатор каталога>"
     }

     resource "yandex_resourcemanager_folder_iam_binding" "viewer" {
       folder_id = "${data.yandex_resourcemanager_folder_iam_member.project1.id}"

       role = "viewer"

     members = [
       "system:allUsers",
     ]
     }
     ...
     ```
    
     {% endcut %}

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder_iam_binding` в Terraform, см. в [документации провайдера](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder_iam_binding).
  
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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

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
