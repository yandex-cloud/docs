Чтобы создать для [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) политику авторизации на основе [шаблона без дополнительных параметров](../../iam/concepts/access-control/access-policies.md#fixed):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите](../../iam/operations/access-policies/list.md) список поддерживаемых шаблонов политик авторизации с идентификаторами.
  1. Выполните команду:

      ```bash
      yc resource-manager cloud bind-access-policy \
        --name <имя_облака> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя облака, для которого вы хотите создать политику. Вместо имени облака вы можете указать его [идентификатор](../../resource-manager/operations/cloud/get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона, на основе которого вы хотите создать политику авторизации для указанного облака.
  1. [Убедитесь](../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned), что политика была создана.

- API {#api}

  Воспользуйтесь методом REST API [bindAccessPolicy](../../resource-manager/api-ref/Cloud/bindAccessPolicy.md) для ресурса [Cloud](../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/BindAccessPolicy](../../resource-manager/api-ref/grpc/Cloud/bindAccessPolicy.md).

{% endlist %}

Созданная политика авторизации будет применяться к ресурсам внутри всех каталогов в пределах заданного облака.