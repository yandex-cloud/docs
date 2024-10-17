### Добавьте федеративных пользователей {#add-user-sso}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    {% include [add-users-to-fed](./add-users-to-fed.md) %}

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    1. Посмотрите описание команды добавления пользователей:

        ```bash
        yc organization-manager federation saml add-user-accounts --help
        ```

    1. Добавьте пользователей, перечислив их Name ID через запятую:

        ```bash
        yc organization-manager federation saml add-user-accounts \
           --name <имя_федерации> \
           --name-ids <список_Name_ID_пользователей>
        ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_organizationmanager_saml_federation_user_account" "some_account" {
        federation_id = "<идентификатор_федерации>"
        name_id       = "<Name_ID_пользователя>"
      }
      ```

      Где:
      * `federation_id` — идентификатор федерации для добавления пользователя.
      * `name_id` — Name ID пользователя.

      Более подробную информацию о параметрах ресурса `yandex_organizationmanager_saml_federation_user_account` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc organization-manager federations saml \
        --organization-id <идентификатор_организации> list-user-accounts \
        --id <идентификатор_федерации>
      ```

- API {#api}

  Воспользуйтесь методом REST API [addUserAccounts](../../iam/saml/api-ref/Federation/addUserAccounts.md) для ресурса [Federation](../../iam/saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/AddUserAccounts](../../iam/saml/api-ref/grpc/Federation/addUserAccounts.md) и передайте в запросе:

  * Идентификатор федерации в параметре `federationId`.
  * Список Name ID пользователей в параметре `nameIds`.

{% endlist %}
