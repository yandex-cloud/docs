Чтобы удалить политику авторизации, созданную для [организации](../../organization/concepts/organization.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите](../../organization/operations/manage-access-policies.md#view-assigned) список идентификаторов шаблонов политик авторизации, назначенных на организацию.
  1. Выполните команду:

      ```bash
      yc organization-manager organization unbind-access-policy \
        --name <имя_организации> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя организации, для которой вы хотите удалить политику. Вместо имени организации вы можете указать ее [идентификатор](../../organization/operations/organization-get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона политики авторизации, которую вы хотите удалить у указанной организации.
  1. [Убедитесь](../../organization/operations/manage-access-policies.md#view-assigned), что политика была удалена.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../terraform-install.md) %}

  1. В конфигурации найдите ресурс `yandex_organization_manager_organization_iam_policy_binding` с идентификаторами нужного шаблона политики в `access_policy_template_id` и организации в `organization_id`.
  1. Удалите блок этого ресурса. Сам ресурс организации удалять не нужно.
  1. Примените конфигурацию:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Убедитесь, что план удаляет только нужную привязку политики. Эти инструкции применимы к привязке, которой управляет текущая конфигурация { TF }.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../../organization/api-ref/Organization/unbindAccessPolicy.md) для ресурса [Organization](../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UnbindAccessPolicy](../../organization/api-ref/grpc/Organization/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам внутри всех облаков в пределах заданной организации.