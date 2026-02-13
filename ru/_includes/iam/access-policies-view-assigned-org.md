Чтобы посмотреть список политик авторизации, назначенных на [организацию](../../organization/concepts/organization.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  Выполните команду, указав имя или [идентификатор](../../organization/operations/organization-get-id.md) организации, для которой вы хотите посмотреть назначенные политики:

  ```bash
  yc organization-manager organization list-access-policy-bindings <имя_или_идентификатор_организации>
  ```

  Результат:

  ```
  +------------------------------+
  |  ACCESS POLICY TEMPLATE ID   |
  +------------------------------+
  | organization.denyUserListing |
  +------------------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessPolicyBindings](../../organization/api-ref/Organization/listAccessPolicyBindings.md) для ресурса [Organization](../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/ListAccessPolicyBindings](../../organization/api-ref/grpc/Organization/listAccessPolicyBindings.md).

{% endlist %}