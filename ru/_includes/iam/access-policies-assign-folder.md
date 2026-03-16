Чтобы создать для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) политику авторизации на основе [шаблона без дополнительных параметров](../../iam/concepts/access-control/access-policies.md#fixed):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите](../../iam/operations/access-policies/list.md) список поддерживаемых шаблонов политик авторизации с идентификаторами.
  1. Выполните команду:

      ```bash
      yc resource-manager folder bind-access-policy \
        --name <имя_каталога> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя каталога, для которого вы хотите создать политику. Вместо имени каталога вы можете указать его [идентификатор](../../resource-manager/operations/folder/get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона, на основе которого вы хотите создать политику авторизации для указанного каталога.
  1. [Убедитесь](../../resource-manager/operations/folder/manage-access-policies.md#view-assigned), что политика была создана.

- API {#api}

  Воспользуйтесь методом REST API [bindAccessPolicy](../../resource-manager/api-ref/Folder/bindAccessPolicy.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/BindAccessPolicy](../../resource-manager/api-ref/grpc/Folder/bindAccessPolicy.md).

{% endlist %}

Созданная политика авторизации будет применяться ко всем ресурсам в заданном каталоге.