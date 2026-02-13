Чтобы отозвать политику авторизации, назначенную на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите](../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned) список идентификаторов политик авторизации, назначенных на облако.
  1. Выполните команду:

      ```bash
      yc resource-manager cloud unbind-access-policy \
        --name <имя_облака> \
        --access-policy-template-id=<идентификатор_политики_авторизации>
      ```

      Где:

      * `--name` — имя облака, у которого вы хотите отозвать политику. Вместо имени облака вы можете указать его [идентификатор](../../resource-manager/operations/cloud/get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор политики авторизации, которую вы хотите отозвать у указанного облака.
  1. [Убедитесь](../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned), что политика была отозвана.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../../resource-manager/api-ref/Cloud/unbindAccessPolicy.md) для ресурса [Cloud](../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/UnbindAccessPolicy](../../resource-manager/api-ref/grpc/Cloud/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам внутри всех каталогов в пределах заданного облака.