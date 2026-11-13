{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
  1. Чтобы добавить атрибут групп пользователей, в правом верхнем углу страницы нажмите кнопку ![circles-3-plus](../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** задайте имя атрибута групп пользователей. Имя атрибута должно быть уникальным для вашего приложения.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_group_attribute_value_oxrpu }}** выберите одно из значений:

          {% include [saml-app-group-assertion](./saml-app-group-assertion.md) %}

      1. В поле **Значение для групп** выберите, какое значение группы будет передаваться поставщику услуг:

          {% include [app-group-attribute-values](./app-group-attribute-values.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Чтобы добавить дополнительные атрибуты пользователей, в правом верхнем углу страницы нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** задайте имя атрибута, уникальное для вашего приложения.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}** выберите одно из значений:

          {% include [saml-app-assertion-list](./saml-app-assertion-list.md) %}

      1. (Опционально) Нажмите **{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.action_add_transformation_bc8Cd }}**, чтобы добавить [трансформацию атрибута](*transform). Выберите один из типов трансформации:

         * `{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.type_extract_after_q4x8n }}` — возвращает часть значения, которая находится после указанной подстроки. Подстрока указывается в поле **{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.field_substring_siBpY }}**. Например, `user@site.com` + `@` → `site.com`.
         * `{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.type_extract_before_ju2PE }}` — возвращает часть значения, которая находится до указанной подстроки. Подстрока указывается в поле **{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.field_substring_siBpY }}**. Например, `user@example.com` + `@` → `user`.
         * `{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.type_to_lowercase_vRG6c }}` — приводит все символы в значении атрибута к нижнему регистру.
         * `{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.type_to_uppercase_uF6Br }}` — приводит все символы в значении атрибута к верхнему регистру.
         * `{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.type_trim_3SF6q }}` — удаляет пробелы в начале и в конце значения атрибута.
         * `{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.type_if_empty_e5unh }}` — заменяет текущее значение атрибута, если оно пустое. Можно выбрать значение для замены из списка значений атрибутов или указать свое. Например, если значение `username` пустое, использовать `email`.
         * `{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.type_constant_tvJWi }}` — заменяет текущее значение на указанную константу. Константа указывается в поле **{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.field_if_empty_value_1K7py }}**. Например, `<значение_атрибута>` → `User`.
         * `{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.type_replace_kQ2vN }}` — заменяет указанную подстроку в значении атрибута на другую строку. Подстрока указывается в поле **{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.field_replace_pattern_hM0Yc }}**, строка замены — в поле **{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.field_replace_replacement_pFtQ8 }}**. Например, `user@example.com` + `example.com` + `company.com` → `user@company.com`.

      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Чтобы изменить имеющийся атрибут, нажмите на строку с нужным атрибутом и в открывшемся окне:
  
      1. Измените имя и/или значение атрибута. Для атрибута групп в поле **Значение для групп** выберите имя, идентификатор или внешний идентификатор группы.

          {% include [saml-app-nameid-assertion](./saml-app-nameid-assertion.md) %}
      
      1. Нажмите кнопку **{{ ui-key.yacloud.common.update }}**.
  1. Чтобы удалить имеющийся атрибут пользователя или группы, в строке с этим атрибутом нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**, после чего подтвердите удаление.

      {% note info %}

      Удалять можно любые атрибуты, кроме обязательного атрибута `NameID`.

      {% endnote %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения SAML-приложения:

     ```bash
     yc organization-manager idp application saml application update --help
     ```

  1. Получите текущую конфигурацию приложения:

     ```bash
     yc organization-manager idp application saml application get \
       --id <идентификатор_приложения> \
       --format yaml
     ```

     Сохраните настройки из поля `attribute_mapping`: формат и значение обязательного атрибута `NameID`, а также имена и значения остальных атрибутов.

     {% note warning %}

     При изменении атрибутов CLI передает всю конфигурацию `attribute_mapping`, а не изменение одного атрибута. Передайте полный итоговый список атрибутов, включая те, которые нужно сохранить, и текущий формат `NameID`. Не рассчитывайте на автоматическое сохранение пропущенных настроек.



     {% endnote %}

  1. Чтобы добавить или изменить атрибуты пользователей, передайте итоговый набор атрибутов. Например, для набора `email`, `firstName` и `lastName`:

     ```bash
     yc organization-manager idp application saml application update \
       --id <идентификатор_приложения> \
       --name-id-format <текущий_формат_nameid> \
       --attribute "email=SubjectClaims.email" \
       --attribute "firstName=SubjectClaims.given_name" \
       --attribute "lastName=SubjectClaims.family_name"
     ```

     Где:

     * `--id` — идентификатор SAML-приложения. Обязательный параметр.
     * `--name-id-format` — текущий формат `NameID`: `persistent` для значения `PERSISTENT` или `email` для значения `EMAIL` в полученной конфигурации.
     * `--attribute` — имя и значение атрибута в формате `имя=значение`. Для каждого атрибута передайте отдельный параметр. Чтобы удалить отдельный атрибут и сохранить остальные, передайте остальные атрибуты, не включая удаляемый. Пример предполагает, что в итоговом списке остается хотя бы один пользовательский атрибут.

       Возможные значения атрибутов:

       {% include [saml-app-assertion-list](./saml-app-assertion-list.md) %}

  1. Чтобы указать, какие группы и какое значение группы будут передаваться поставщику услуг, выполните команду. При изменении существующих настроек укажите все три параметра групп с нужными итоговыми значениями:

     ```bash
     yc organization-manager idp application saml application update \
       --id <идентификатор_приложения> \
       --group-distribution-type <тип_распределения_групп> \
       --group-attribute-name <имя_атрибута_групп> \
       --group-attribute-value <тип_значения_группы>
     ```

     Где:

     * `--id` — идентификатор SAML-приложения. Обязательный параметр.
     * `--group-distribution-type` — передаваемые группы. Возможные значения:
       * `all-groups` — поставщику услуг будут переданы все группы, в которые входит пользователь.

           Максимальное количество передаваемых групп — 1&nbsp;000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп.

       * `assigned-groups` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые явно заданы на вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** SAML-приложения.
       * `none` — поставщику услуг не будут переданы группы, в которые входит пользователь.
     * `--group-attribute-name` — имя атрибута групп пользователей. Имя атрибута должно быть уникальным для вашего приложения.
     * `--group-attribute-value` — тип значения группы. Возможные значения:
       * `name` — имя группы. Используется по умолчанию.
       * `id` — идентификатор группы.
       * `external-id` — внешний идентификатор группы.

     Эта команда изменяет настройки передачи групп, а не список атрибутов пользователей. Чтобы отключить передачу групп, укажите `none` в параметре `--group-distribution-type`.

  1. Проверьте итоговую конфигурацию приложения:

     ```bash
     yc organization-manager idp application saml application get \
       --id <идентификатор_приложения> \
       --format yaml
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
         group_attribute_value   = "NAME"
         group_distribution_type = "ALL_GROUPS"
       }
     }
     ```

     Где:

     * `organization_id` — [идентификатор организации](../../organization/operations/organization-get-id.md), в которой нужно создать SAML-приложение. Обязательный параметр.
     * `name` — имя SAML-приложения. Обязательный параметр.
     * `attributes` — список атрибутов, которые будут передаваться из {{ org-full-name }} поставщику услуг. Каждый атрибут содержит:
       * `name` — имя атрибута, уникальное для вашего приложения.
       * `value` — значение атрибута. Возможные значения:

         {% include [saml-app-assertion-list](./saml-app-assertion-list.md) %}

     * `group_claims_settings` — параметры атрибутов групп пользователей:
       * `group_attribute_name` — имя атрибута групп пользователей. Имя атрибута должно быть уникальным для вашего приложения.
       * `group_attribute_value` — тип значения группы, которое будет передано поставщику услуг. Возможные значения:
         * `NAME` — имя группы. Используется по умолчанию.
         * `ID` — идентификатор группы.
         * `EXTERNAL_ID` — внешний идентификатор группы.
       * `group_distribution_type` — передаваемые группы. Возможные значения:
         * `ALL_GROUPS` — поставщику услуг будут переданы все [группы](../../organization/concepts/groups.md), в которые входит пользователь.

             Максимальное количество передаваемых в этом поле групп — 1&nbsp;000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп.

         * `ASSIGNED_GROUPS` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые явно заданы на вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** SAML-приложения.
         * `NONE` — поставщику услуг не будут переданы группы, в которые входит пользователь.

     Подробнее о параметрах ресурса `yandex_organizationmanager_idp_application_saml_application` читайте в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Воспользуйтесь методом REST API [Application.Update](../../organization/idp/application/saml/api-ref/Application/update.md) для ресурса [Application](../../organization/idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Update](../../organization/idp/application/saml/api-ref/grpc/Application/update.md).

{% endlist %}

Убедитесь, что добавленные атрибуты также добавлены в настройки интеграции SAML-приложения на стороне поставщика услуг и корректно обрабатываются им.

[*transform]: Трансформации изменяют значение атрибута перед отправкой в SAML-ответе. Например, приводят текст к нижнему регистру, удаляют пробелы или извлекают часть строки. Трансформации применяются последовательно, сверху вниз.
