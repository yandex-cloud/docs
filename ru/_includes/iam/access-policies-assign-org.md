Чтобы назначить политику авторизации на [организацию](../../organization/concepts/organization.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите](../../iam/operations/access-policies/list.md) список поддерживаемых политик авторизации с идентификаторами.
  1. Выполните команду:

      ```bash
      yc organization-manager organization bind-access-policy \
        --name <имя_организации> \
        --access-policy-template-id=<идентификатор_политики_авторизации>
      ```

      Где:

      * `--name` — имя организации, на которую вы хотите назначить политику. Вместо имени организации вы можете указать ее [идентификатор](../../organization/operations/organization-get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор политики авторизации, которую вы хотите назначить на указанную организацию.
  1. [Убедитесь](../../organization/operations/manage-access-policies.md#view-assigned), что политика была назначена.

- API {#api}

  Воспользуйтесь методом REST API [bindAccessPolicy](../../organization/api-ref/Organization/bindAccessPolicy.md) для ресурса [Organization](../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/BindAccessPolicy](../../organization/api-ref/grpc/Organization/bindAccessPolicy.md).

{% endlist %}

Назначенная политика авторизации будет применяться к ресурсам внутри всех облаков в пределах заданной организации.