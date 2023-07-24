# Deleting a service account

{% note warning %}

Deleting a [service account](../../concepts/users/service-accounts.md) is permanent. You can't restore a deleted service account; you can only [re-create it](create.md).

{% endnote %}

{% list tabs %}

- Management console

   {% include [delete-sa-via-console](../../../_includes/iam/delete-sa-via-console.md) %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the delete service account command:

      ```bash
      yc iam service-account delete --help
      ```

   1. Select a service account (for example, `my-robot`):

      ```bash
      yc iam service-account list
      ```

      Result:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2h6g9a33s | my-robot         |                               |
      | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
      +----------------------+------------------+-------------------------------+
      ```
   1. Delete the service account:

      ```bash
      yc iam service-account delete my-robot
      ```

- API

   To delete a service account, use the [delete](../../api-ref/ServiceAccount/delete.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Delete](../../api-ref/grpc/service_account_service.md#Delete) gRPC API call.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a service account:

   1. Open the {{ TF }} configuration file and delete the fragment with the service account description.
      Example of the service account description in the {{ TF }} configuration:

      ```hcl
      ...
      resource "yandex_iam_service_account" "sa" {
        name        = "my-robot"
        description = "this is my favorite service account"
       }
      ...
      ```

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Check the configuration using this command:
      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```text
      Success! The configuration is valid.
      ```

   1. Run this command:
      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify that the service account was deleted in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iam service-account list
      ```

{% endlist %}

{% note info %}

You cannot delete a service account while it is linked to some cloud resources, such as instance groups. First, update the service account in the resource settings or delete the resource and then delete the service account.

{% endnote %}
