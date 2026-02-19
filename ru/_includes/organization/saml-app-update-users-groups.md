{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
  1. Чтобы добавить в SAML-приложение пользователя или группу пользователей:

      1. Нажмите кнопку ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
      1. В открывшемся окне выберите нужного пользователя или группу пользователей.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Чтобы удалить пользователя или группу пользователей из SAML-приложения:

      1. В списке пользователей и групп в строке с нужным пользователем или группой нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
      1. Подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Получите [идентификатор пользователя](../../organization/operations/users-get.md) или [группы пользователей](../../organization/operations/group-get-id.md).

  1. Чтобы добавить в приложение пользователя или группу пользователей:
   
     1. Посмотрите описание команды CLI для добавления пользователей в приложение:
   
        ```bash
        yc organization-manager idp application saml application add-assignments --help
        ```
   
     1. Выполните команду:
   
        ```bash
        yc organization-manager idp application saml application add-assignments \
          --id <идентификатор_приложения> \
          --subject-id <идентификатор_пользователя_или_группы>
        ```
   
        Где:
   
        * `--id` — идентификатор приложения.
        * `--subject-id` — идентификатор нужного пользователя или группы пользователей.
   
        Результат:
   
        ```text
        assignment_deltas:
          - action: ADD
            assignment:
              subject_id: ajetvnq2mil8********
        ```

  1. Чтобы удалить пользователя или группу пользователей из приложения:

     1. Посмотрите описание команды CLI для удаления пользователей из приложения:
   
        ```bash
        yc organization-manager idp application saml application remove-assignments --help
        ```
   
     1. Выполните команду:
   
        ```bash
        yc organization-manager idp application saml application remove-assignments \
          --id <идентификатор_приложения> \
          --subject-id <идентификатор_пользователя_или_группы>
        ```
   
        Где:
   
        * `--id` — идентификатор SAML-приложения.
        * `--subject-id` — идентификатор нужного пользователя или группы пользователей.
   
        Результат:
   
        ```text
        assignment_deltas:
          - action: REMOVE
            assignment:
              subject_id: ajetvnq2mil8********
        ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры SAML-приложения с пользователями и группами:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application_assignment" "example_assignment" {
       application_id = "<идентификатор_SAML-приложения>"
       subject_id     = "<идентификатор_пользователя_или_группы>"
     }
     ```

     Где:

     * `application_id` — идентификатор SAML-приложения.
     * `subject_id` — идентификатор пользователя или группы пользователей, которые будут иметь доступ к SAML-приложению. Чтобы получить идентификатор пользователя, воспользуйтесь [инструкцией](../../organization/operations/users-get.md). Чтобы получить идентификатор группы пользователей, воспользуйтесь [инструкцией](../../organization/operations/group-get-id.md).

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_saml_application_assignment` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application_assignment).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Воспользуйтесь методом REST API [Application.UpdateAssignments](../../organization/idp/application/saml/api-ref/Application/updateAssignments.md) для ресурса [Application](../../organization/idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/UpdateAssignments](../../organization/idp/application/saml/api-ref/grpc/Application/updateAssignments.md).

{% endlist %}