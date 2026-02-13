Чтобы отозвать политику авторизации, назначенную на [организацию](../../organization/concepts/organization.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите](../../organization/operations/manage-access-policies.md#view-assigned) список идентификаторов политик авторизации, назначенных на организацию.
  1. Выполните команду:

      ```bash
      yc organization-manager organization unbind-access-policy \
        --name <имя_организации> \
        --access-policy-template-id=<идентификатор_политики_авторизации>
      ```

      Где:

      * `--name` — имя организации, у которой вы хотите отозвать политику. Вместо имени организации вы можете указать ее [идентификатор](../../organization/operations/organization-get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор политики авторизации, которую вы хотите отозвать у указанной организации.
  1. [Убедитесь](../../organization/operations/manage-access-policies.md#view-assigned), что политика была отозвана.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../../organization/api-ref/Organization/unbindAccessPolicy.md) для ресурса [Organization](../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UnbindAccessPolicy](../../organization/api-ref/grpc/Organization/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам внутри всех облаков в пределах заданной организации.