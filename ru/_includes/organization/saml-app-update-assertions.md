{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
  1. Чтобы добавить атрибут групп пользователей, в правом верхнем углу страницы нажмите кнопку ![circles-3-plus](../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** задайте имя атрибута групп пользователей. Имя атрибута должно быть уникальным для вашего приложения.
      1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_group_attribute_value }}** выберите одно из значений:

          {% include [saml-app-group-assertion](./saml-app-group-assertion.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Чтобы добавить дополнительные атрибуты пользователей, в правом верхнем углу страницы нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** задайте имя атрибута, уникальное для вашего приложения.
      1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_value }}** выберите одно из значений:

          {% include [saml-app-assertion-list](./saml-app-assertion-list.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Чтобы изменить имеющийся атрибут, нажмите на строку с нужным атрибутом и в открывшемся окне:
  
      1. Измените имя и/или значение атрибута.

          {% include [saml-app-nameid-assertion](./saml-app-nameid-assertion.md) %}
      
      1. Нажмите кнопку **{{ ui-key.yacloud.common.update }}**.
  1. Чтобы удалить имеющийся атрибут пользователя или группы, в строке с этим атрибутом нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**, после чего подтвердите удаление.

      {% note info %}

      Удалять можно любые атрибуты, кроме обязательного атрибута `NameID`.

      {% endnote %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для добавления атрибута:

     ```bash
     yc organization-manager idp application saml attribute create --help
     ```

  1. Чтобы добавить атрибут пользователя, выполните команду:

     ```bash
     yc organization-manager idp application saml attribute create \
       --application-id <идентификатор_приложения> \
       --name <имя_атрибута> \
       --value <значение_атрибута>
     ```

     Где:

     * `--application-id` — идентификатор SAML-приложения.
     * `--name` — имя атрибута, уникальное для вашего приложения.
     * `--value` — значение атрибута. Возможные значения:

       {% include [saml-app-assertion-list](./saml-app-assertion-list.md) %}

  1. Чтобы добавить атрибут групп пользователей, выполните команду:

     ```bash
     yc organization-manager idp application saml attribute create \
       --application-id <идентификатор_приложения> \
       --name <имя_атрибута_групп> \
       --value <значение_атрибута_групп>
     ```

     Где:

     * `--name` — имя атрибута групп пользователей. Имя атрибута должно быть уникальным для вашего приложения.
     * `--value` — значение атрибута групп. Возможные значения:

       {% include [saml-app-group-assertion](./saml-app-group-assertion.md) %}

  1. Чтобы изменить атрибут, выполните команду:

     ```bash
     yc organization-manager idp application saml attribute update \
       --id <идентификатор_атрибута> \
       --name <новое_имя_атрибута> \
       --value <новое_значение_атрибута>
     ```

  1. Чтобы удалить атрибут, выполните команду:

     ```bash
     yc organization-manager idp application saml attribute delete <идентификатор_атрибута>
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле атрибуты SAML-приложения:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
       organization_id = "<идентификатор_организации>"
       name            = "<имя_приложения>"

       attribute_mapping = {
         name_id  = {
           format = "EMAIL"
         }

         attributes = [{
           name  = "email"
           value = "SubjectClaims.email"
         }, {
           name  = "firstName"
           value = "SubjectClaims.given_name"
         }, {
           name  = "lastName"
           value = "SubjectClaims.family_name"
         }]
       }

       group_claims_settings = {
         group_attribute_name    = "<имя_атрибута_групп>"
         group_distribution_type = "ALL_GROUPS"
       }
     }
     ```

     Где:

     * `organization_id` — [идентификатор организации](../../organization/operations/organization-get-id.md), в которой нужно создать SAML-приложение. Обязательный параметр.
     * `name` — имя SAML-приложения. Обязательный параметр.
     * `attributes` — список атрибутов, которые будут передаваться из {{ org-name }} поставщику услуг. Каждый атрибут содержит:
       * `name` — имя атрибута, уникальное для вашего приложения.
       * `value` — значение атрибута. Возможные значения:

         {% include [saml-app-assertion-list](./saml-app-assertion-list.md) %}

     * `group_claims_settings` — параметры атрибутов групп пользователей:
       * `group_attribute_name` — имя атрибута групп пользователей. Имя атрибута должно быть уникальным для вашего приложения.
       * `group_distribution_type` — значение атрибута групп. Возможные значения: 
         * `ASSIGNED_GROUPS` — в SAML-ответе в значение данного поля из всех групп, в которые входит пользователь, будут включены только те группы, которые явно заданы на вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** SAML-приложения.
         * `ALL_GROUPS` — в SAML-ответе в значение данного поля будут включены все [группы](../../organization/concepts/groups.md), в которые входит пользователь.

             Максимальное количество передаваемых в этом поле групп — 1&nbsp;000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп. 

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_saml_application` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Воспользуйтесь методом REST API [Application.Update](../../organization/idp/application/saml/api-ref/Application/update.md) для ресурса [Application](../../organization/idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Update](../../organization/idp/application/saml/api-ref/grpc/Application/update.md).

{% endlist %}

Убедитесь, что добавленные атрибуты также добавлены в настройки интеграции SAML-приложения на стороне поставщика услуг и корректно обрабатываются им.