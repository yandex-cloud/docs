Чтобы посмотреть список политик авторизации, назначенных на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  Выполните команду, указав имя или [идентификатор](../../resource-manager/operations/cloud/get-id.md) облака, для которого вы хотите посмотреть назначенные политики:

  ```bash
  yc resource-manager cloud list-access-policy-bindings <имя_или_идентификатор_облака>
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

  Воспользуйтесь методом REST API [listAccessPolicyBindings](../../resource-manager/api-ref/Cloud/listAccessPolicyBindings.md) для ресурса [Cloud](../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/ListAccessPolicyBindings](../../resource-manager/api-ref/grpc/Cloud/listAccessPolicyBindings.md).

{% endlist %}