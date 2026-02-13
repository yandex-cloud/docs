Чтобы назначить политику авторизации на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите](../../iam/operations/access-policies/list.md) список поддерживаемых политик авторизации с идентификаторами.
  1. Выполните команду:

      ```bash
      yc resource-manager cloud bind-access-policy \
        --name <имя_облака> \
        --access-policy-template-id=<идентификатор_политики_авторизации>
      ```

      Где:

      * `--name` — имя облака, на которое вы хотите назначить политику. Вместо имени облака вы можете указать его [идентификатор](../../resource-manager/operations/cloud/get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор политики авторизации, которую вы хотите назначить на указанное облако.
  1. [Убедитесь](../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned), что политика была назначена.

- API {#api}

  Воспользуйтесь методом REST API [bindAccessPolicy](../../resource-manager/api-ref/Cloud/bindAccessPolicy.md) для ресурса [Cloud](../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/BindAccessPolicy](../../resource-manager/api-ref/grpc/Cloud/bindAccessPolicy.md).

{% endlist %}

Назначенная политика авторизации будет применяться к ресурсам внутри всех каталогов в пределах заданного облака.