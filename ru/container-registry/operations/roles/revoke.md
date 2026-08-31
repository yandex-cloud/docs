# Отозвать роль на ресурс

Вы можете запретить [субъекту](../../../iam/concepts/access-control/index.md#subject) доступ к ресурсу, для этого необходимо отозвать у него соответствующие [роли](../../../iam/concepts/access-control/roles.md) на этот ресурс и на ресурсы, от которых наследуются права доступа. Подробнее читайте в разделе [{#T}](../../../iam/concepts/access-control/index.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно отозвать роль на ресурс.
  1. [Перейдите]({{ link-console-main }}/link/container-registry) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите [реестр](../../concepts/registry.md) или [репозиторий](../../concepts/repository.md) в нем.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Выберите пользователя в списке и нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив имени пользователя.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.edit-roles }}**.
  1. Нажмите значок ![image](../../../_assets/console-icons/xmark.svg) напротив роли, которую хотите отозвать.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Просмотрите назначенные роли:

     ```bash
     yc container <ресурс> list-access-bindings <имя_или_идентификатор_ресурса>
     ```

     Где:
     * `<ресурс>` — тип ресурса `registry` (реестр) или `repository` (репозиторий);
     * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, на который назначена роль.

  1. Отзовите роль:

     ```bash
     yc container <ресурс> remove-access-binding <имя_или_идентификатор_ресурса> \
       --role <роль> \
       --subject <тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `<ресурс>` — тип ресурса `registry` (реестр) или `repository` (репозиторий);
     * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, на который отзывается роль;
     * `<идентификатор_роли>` — [роль](../../security/index.md#service-roles), которую необходимо отозвать;
     * `--subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

         {% cut "Обозначения субъектов" %}

         {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

         {% endcut %}
     
     **Пример**

     В примере ниже у пользователя отзывается роль `container-registry.admin` на реестр `my-first-registry`.
     
     ```bash
     yc container registry remove-access-binding my-first-registry \
       --role container-registry.admin \
       --subject userAccount:ajeugsk5ubk6********
     ```

     Результат:

     ```text
     done (9s)
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием назначения ролей.

     Пример описания назначения роли в конфигурации {{ TF }}:

       ```
       resource "yandex_container_registry_iam_binding" "имя_реестра" {
         registry_id = "<идентификатор_реестра>"
         role        = "<роль>"
       
         members = [
           "<тип_субъекта>:<идентификатор_субъекта>",
         ]
       }
       ```

       Где:

       * `registry_id` — идентификатор реестра, на который назначена роль.
       * `role` — [роль](../../security/index.md#service-roles), которую необходимо отозвать.
       * `members` — список обозначений [субъектов](../../../iam/concepts/access-control/index.md#subject), у которых отзывается роль.

           {% cut "Обозначения субъектов" %}

           {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

           {% endcut %}

       Подробнее о параметрах ресурса `yandex_container_registry_iam_binding` в [документации провайдера]({{ tf-provider-resources-link }}/container_registry_iam_binding).
  
  1. {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить отзыв роли можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     * Для реестра:

       ```bash
       yc container registry list-access-bindings <имя_или_идентификатор_реестра>
       ```

     * Для репозитория:

       ```bash
       yc container repository list-access-bindings <имя_или_идентификатор_репозитория>
       ```

- API {#api}

  [Просмотрите](get-assigned-roles.md#cli) роли, назначенные на ресурсы.
  
  Чтобы отозвать роли, назначенные на реестр, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md).

  Чтобы отозвать роли, назначенные на репозиторий, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Repository/updateAccessBindings.md) для ресурса [Repository](../../api-ref/Repository/index.md) или вызовом gRPC API [RepositoryService/UpdateAccessBindings](../../api-ref/grpc/Repository/updateAccessBindings.md).

  В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

  {% cut "Обозначения субъектов" %}

  {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}

Подробнее об управлении ролями читайте в [документации](../../../iam/concepts/index.md) {{ iam-full-name }}.
