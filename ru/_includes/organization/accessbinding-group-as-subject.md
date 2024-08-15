{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

  1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.
  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  1. На панели слева выберите раздел ![persons-lock](../../_assets/console-icons/persons-lock.svg) [{{ ui-key.yacloud_org.pages.acl }}]({{ link-org-acl }}).
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_org.entity.user.action.acl }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.pages.groups }}** и выберите [группу](../../organization/concepts/groups.md) или воспользуйтесь поиском по названию группы.

     Вы также можете назначить роль одной из [системных](../../iam/concepts/access-control/system-group.md) групп:

     * `All users in organization X` — в группу входят все пользователи организации `X`.
     * `All users in federation N` — в группу входят все пользователи федерации `N`.

  1. Нажмите **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** и выберите [роль](../../iam/concepts/access-control/roles.md) в [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder). Вы можете назначить больше одной роли.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  1. Выберите [роль](../../iam/concepts/access-control/roles.md) из [справочника ролей {{ yandex-cloud }}](../../iam/roles-reference.md).
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
     * `--subject group` — идентификатор [группы](../../organization/concepts/groups.md), которой назначается роль.

         Для того чтобы назначить роль одной из [системных групп](../../iam/concepts/access-control/system-group.md), вместо параметра `--subject` используйте параметр `--organization-users <идентификатор_организации>` или `--federation-users <идентификатор_федерации>`, передав в нем соответственно идентификатор [организации](../../organization/quickstart.md) или [федерации удостоверений](../../organization/concepts/add-federation.md), всем пользователям которых вы хотите назначить роль.
         
         Вы также можете назначить роль системной группе с помощью параметра `--subject`. Для этого передайте в нем идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), соответствующий выбранной системной группе.

     Например, назначьте роль `resource-manager.viewer` на [облако](../../resource-manager/concepts/resources-hierarchy.md#folder) `mycloud`:

     ```bash
     yc resource-manager cloud add-access-binding mycloud \
       --role resource-manager.viewer \
       --subject group:aje6o61dvog2********
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Добавьте в конфигурационный файл параметры ресурса, укажите нужную [роль](../../iam/concepts/access-control/roles.md) и [группу](../../organization/concepts/groups.md):

     ```hcl
     resource "yandex_resourcemanager_cloud_iam_member" "admin" {
       cloud_id    = "<идентификатор_облака>"
       role        = "<идентификатор_роли>"
       member      = "group:<идентификатор_группы>"
     }
     ```

     Где:
     * `cloud_id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md). Вы также можете назначить роль внутри отдельного [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder). Для этого вместо `cloud_id` укажите `folder_id` и нужный идентификатор каталога в параметрах ресурса.
     * `role` — назначаемая роль. Обязательный параметр.
     * `member` — группа, которой назначается роль. Указывается в виде `group:<идентификатор_группы>`. Обязательный параметр.

         Для того чтобы назначить роль одной из [системных групп](../../iam/concepts/access-control/system-group.md), в параметре `member` укажите:

         * `system:group:organization:<идентификатор_организации>:users` — чтобы назначить роль системной группе `All users in organization X`;
         * `system:group:federation:<идентификатор_федерации>:users` — чтобы назначить роль системной группе `All users in federation N`.

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_cloud_iam_member` см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_iam_member).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     terraform plan
     ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc resource-manager folder list-access-bindings <имя_или_идентификатор_папки>
     ```

- API {#api}

  Воспользуйтесь методом REST API `updateAccessBindings` для соответствующего ресурса.
  1. Выберите [роль](../../iam/concepts/access-control/roles.md) из [справочника ролей {{ yandex-cloud }}](../../iam/roles-reference.md).
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
       }]
     }
     ```

  1. {% include [grant-role-folder-via-curl-step](../iam/grant-role-folder-via-curl-step.md) %}

  Вы можете ознакомиться с подробной инструкцией назначения роли для соответствующего ресурса:
  * [{#T}](../../iam/operations/sa/set-access-bindings.md).
  * [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md).
  * [{#T}](../../resource-manager/operations/folder/set-access-bindings.md).

{% endlist %}