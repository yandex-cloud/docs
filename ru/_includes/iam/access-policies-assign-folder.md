Чтобы назначить политику авторизации на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите](../../iam/operations/access-policies/list.md) список поддерживаемых политик авторизации с идентификаторами.
  1. Выполните команду:

      ```bash
      yc resource-manager folder bind-access-policy \
        --name <имя_каталога> \
        --access-policy-template-id=<идентификатор_политики_авторизации>
      ```

      Где:

      * `--name` — имя каталога, на который вы хотите назначить политику. Вместо имени каталога вы можете указать его [идентификатор](../../resource-manager/operations/folder/get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор политики авторизации, которую вы хотите назначить на указанный каталог.
  1. [Убедитесь](../../resource-manager/operations/folder/manage-access-policies.md#view-assigned), что политика была назначена.

- API {#api}

  Воспользуйтесь методом REST API [bindAccessPolicy](../../resource-manager/api-ref/Folder/bindAccessPolicy.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/BindAccessPolicy](../../resource-manager/api-ref/grpc/Folder/bindAccessPolicy.md).

{% endlist %}

Назначенная политика авторизации будет применяться ко всем ресурсам в заданном каталоге.