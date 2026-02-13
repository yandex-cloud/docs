Чтобы посмотреть список политик авторизации, назначенных на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  Выполните команду, указав имя или [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, для которого вы хотите посмотреть назначенные политики:

  ```bash
  yc resource-manager folder list-access-policy-bindings <имя_или_идентификатор_каталога>
  ```

  Результат:

  ```
  +---------------------------------------+
  |      ACCESS POLICY TEMPLATE ID        |
  +---------------------------------------+
  | iam.denyServiceAccountApiKeysCreation |
  +---------------------------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessPolicyBindings](../../resource-manager/api-ref/Folder/listAccessPolicyBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/ListAccessPolicyBindings](../../resource-manager/api-ref/grpc/Folder/listAccessPolicyBindings.md).

{% endlist %}