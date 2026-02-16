Чтобы отозвать политику авторизации, назначенную на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите](../../resource-manager/operations/folder/manage-access-policies.md#view-assigned) список идентификаторов политик авторизации, назначенных на каталог.
  1. Выполните команду:

      ```bash
      yc resource-manager folder unbind-access-policy \
        --name <имя_каталога> \
        --access-policy-template-id=<идентификатор_политики_авторизации>
      ```

      Где:

      * `--name` — имя каталога, у которого вы хотите отозвать политику. Вместо имени каталога вы можете указать его [идентификатор](../../resource-manager/operations/folder/get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор политики авторизации, которую вы хотите отозвать у указанного каталога.
  1. [Убедитесь](../../resource-manager/operations/folder/manage-access-policies.md#view-assigned), что политика была отозвана.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../../resource-manager/api-ref/Folder/unbindAccessPolicy.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UnbindAccessPolicy](../../resource-manager/api-ref/grpc/Folder/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам в заданном каталоге.