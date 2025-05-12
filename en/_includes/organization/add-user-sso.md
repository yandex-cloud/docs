### Add federated users {#add-user-sso}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    {% include [add-users-to-fed](./add-users-to-fed.md) %}

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    1. View the description of the add user command:

        ```bash
        yc organization-manager federation saml add-user-accounts --help
        ```

    1. Add users by listing their name IDs separated by a comma:

        ```bash
        yc organization-manager federation saml add-user-accounts \
           --name <federation_name> \
           --name-ids <list_of_user_name_IDs>
        ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the resources you want to create:

      ```hcl
      resource "yandex_organizationmanager_saml_federation_user_account" "some_account" {
        federation_id = "<federation_ID>"
        name_id       = "<user_name_ID>"
      }
      ```

      Where:
      * `federation_id`: ID of the federation to add the user to.
      * `name_id`: Name ID of the user.

      For more information about `yandex_organizationmanager_saml_federation_user_account` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/) command:

      ```bash
      yc organization-manager federations saml \
        --organization-id <organization_ID> list-user-accounts \
        --id <federation_ID>
      ```

- API {#api}

  Use the [addUserAccounts](../../organization/saml/api-ref/Federation/addUserAccounts.md) REST API method for the [Federation](../../organization/saml/api-ref/Federation/index.md) resource or the [FederationService/AddUserAccounts](../../organization/saml/api-ref/grpc/Federation/addUserAccounts.md) gRPC API call and provide the following in the request:

  * Federation ID in the `federationId` parameter.
  * List of user name IDs in the `nameIds` parameter.

{% endlist %}
