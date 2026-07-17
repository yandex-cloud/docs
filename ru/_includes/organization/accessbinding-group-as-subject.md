{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления]({{ link-console-main }}) с учетной записью администратора или владельца облака.
  1. В левой части экрана нажмите на строку с именем [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), на который вы хотите назначить роль группе пользователей.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**. В открывшемся окне:

      1. Перейдите на вкладку **{{ ui-key.yacloud_org.pages.groups }}** и выберите [группу](../../organization/concepts/groups.md) или воспользуйтесь поиском по названию группы.

          Вы также можете назначить роль одной из [системных](../../iam/concepts/access-control/system-group.md) групп:

          * `All users in organization X` — в группу входят все пользователи организации `X`.
          * `All users in federation N` — в группу входят все пользователи федерации `N`.

      1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить группе на облако или каталог, который вы выбрали ранее. Вы можете назначить несколько ролей.
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

     * `--role` — идентификатор роли, например, `{{ roles-cloud-owner }}`.
     * `--subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

        {% cut "Обозначения субъектов" %}

        {% include [subjects-designations-cli](../iam/subjects-designations-cli.md) %}

        {% endcut %}

     Например, назначьте роль `resource-manager.viewer` на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) `mycloud`:

     ```bash
     yc resource-manager cloud add-access-binding mycloud \
       --role resource-manager.viewer \
       --subject group:aje6o61dvog2********
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  1. Добавьте в конфигурационный файл параметры ресурса, укажите нужную [роль](../../iam/concepts/access-control/roles.md) и [группу](../../organization/concepts/groups.md):

     ```hcl
     resource "yandex_resourcemanager_cloud_iam_member" "admin" {
       cloud_id = "<идентификатор_облака>"
       role     = "<идентификатор_роли>"
       member   = "group:<идентификатор_группы>"
     }
     ```

     Где:

     * `cloud_id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md). Чтобы назначить роль на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), используйте ресурс `yandex_resourcemanager_folder_iam_member` и укажите идентификатор каталога в параметре `folder_id`.
     * `role` — назначаемая роль. Обязательный параметр.
     * `member` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../iam/subjects-designations-terraform.md) %}

          {% endcut %}

     Подробнее о параметрах ресурсов `yandex_resourcemanager_cloud_iam_member` и `yandex_resourcemanager_folder_iam_member` читайте в документации провайдера для [облака]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_member) и [каталога]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     После этого будут назначены указанные права доступа. Проверить назначение роли можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc resource-manager <cloud_или_folder> list-access-bindings <имя_или_идентификатор_облака_или_каталога>
     ```

- API {#api}

  Чтобы назначить роль группе пользователей на облако, воспользуйтесь методом REST API [updateAccessBindings](../../resource-manager/api-ref/Cloud/updateAccessBindings.md) для ресурса [Cloud](../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Cloud/updateAccessBindings.md).

  Чтобы назначить роль группе пользователей на каталог, воспользуйтесь методом REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

  Передайте в запросе:

  * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
  * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
  * Идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
  * Тип субъекта, которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

      {% cut "Обозначения субъектов" %}

      {% include [subjects-designations-api](../iam/subjects-designations-api.md) %}

      {% endcut %}


  Вы можете ознакомиться с подробной инструкцией назначения роли для соответствующего ресурса:

  * [{#T}](../../iam/operations/sa/set-access-bindings.md).
  * [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md).
  * [{#T}](../../resource-manager/operations/folder/set-access-bindings.md).

{% endlist %}