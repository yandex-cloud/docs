Чтобы посмотреть список политик авторизации, созданных для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  Выполните команду, указав имя или [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, для которого вы хотите посмотреть созданные политики:

  ```bash
  yc resource-manager folder list-access-policy-bindings <имя_или_идентификатор_каталога>
  ```

  Результат:

  ```
  +---------------------------------------------+-------------------------------------------------+
  |          ACCESS POLICY TEMPLATE ID          |                   PARAMETERS                    |
  +---------------------------------------------+-------------------------------------------------+
  | backup.denyRemoveProtection                 |                                                 |
  | serverless.containers.restrictNetworkAccess | allowed_vpc_network_ids=[enphfcfseu9i********], |
  |                                             | allowed_src_ips=[192.168.1.12/24]               |
  +---------------------------------------------+-------------------------------------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessPolicyBindings](../../resource-manager/api-ref/Folder/listAccessPolicyBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/ListAccessPolicyBindings](../../resource-manager/api-ref/grpc/Folder/listAccessPolicyBindings.md).

{% endlist %}