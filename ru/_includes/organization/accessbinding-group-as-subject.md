{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

   1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.

   1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).

   1. На панели слева выберите раздел ![persons-lock](../../_assets/console-icons/persons-lock.svg) [{{ ui-key.yacloud_org.pages.acl }}]({{ link-org-acl }}).

   1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

   1. Перейдите на вкладку **{{ ui-key.yacloud_org.pages.groups }}** и выберите группу, или воспользуйтесь поиском по названию группы.

   1. Нажмите **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** и выберите роль в облаке или каталоге. Вы можете назначить больше одной роли. 

   1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  1. Выберите роль из [справочника ролей {{ yandex-cloud }}](../../iam/roles-reference.md).

  1. Назначьте роль с помощью команды:

      ```bash
      yc <имя_сервиса> <ресурс> add-access-binding <имя_или_идентификатор_ресурса> \
        --role <идентификатор_роли> \
        --subject group:<идентификатор_группы>
      ```

      Где:

      * `<имя_сервиса>` — имя сервиса, для доступа к ресурсу которого назначается роль, например, `resource-manager`.
      * `<ресурс>` — категория ресурса, например, `cloud`.
      * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса. Вы можете указать имя или идентификатор ресурса.
      * `--role` — идентификатор роли, например, `{{ roles-cloud-owner }}`.
      * `--subject group` — идентификатор группы, которой назначается роль.

      Например, назначьте роль `resource-manager.viewer` на [облако](../../resource-manager/concepts/resources-hierarchy.md#folder) `mycloud`:

      ```bash
      yc resource-manager cloud add-access-binding mycloud \
        --role resource-manager.viewer \
        --subject group:aje6o61dvog2********
      ```

- {{ TF }} {#tf}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Добавьте в конфигурационный файл параметры ресурса, укажите нужную роль и группу:

       ```
       resource "yandex_resourcemanager_cloud_iam_member" "admin" {
         cloud_id    = "<идентификатор_облака>"
         role        = "<идентификатор_роли>"
         member      = "group:<идентификатор_группы>"
       }
       ```

       Где:

       * `cloud_id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md). Вы также можете назначить роль внутри отдельного каталога. Для этого вместо `cloud_id` укажите `folder_id` и нужный идентификатор каталога в параметрах ресурса.
       * `role` — назначаемая [роль](../../iam/concepts/access-control/roles.md). Обязательный параметр.
       * `member` — группа, которой назначается роль. Указывается в виде `group:<идентификатор_группы>`. Обязательный параметр.

       Более подробную информацию о параметрах ресурса `yandex_resourcemanager_cloud_iam_member` см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_iam_member).

    1. Создайте ресурсы:

        {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}
  
    После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

          ```
          terraform plan
          ```

       Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

    1. Разверните облачные ресурсы.

       1. Если в конфигурации нет ошибок, выполните команду:

          ```
          terraform apply
          ```

       1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

       После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

       ```bash
       yc resource-manager folder list-access-bindings <имя_или_идентификатор_папки>
       ```

- API {#api}

  Воспользуйтесь методом REST API `updateAccessBindings` для соответствующего ресурса.

  1. Выберите роль из [справочника ролей {{ yandex-cloud }}](../../iam/roles-reference.md).

  1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип `group` и идентификатор группы:

      **body.json:**
      ```json
      {
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "<идентификатор_группы>",
                      "type": "group"
                      }
                  }
              }
          ]
      }
      ```

  1. {% include [grant-role-folder-via-curl-step](../iam/grant-role-folder-via-curl-step.md) %}

  Вы можете ознакомиться с подробной инструкцией назначения роли для соответствующего ресурса:
  * [{#T}](../../iam/operations/sa/set-access-bindings.md)
  * [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
  * [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)

{% endlist %}
