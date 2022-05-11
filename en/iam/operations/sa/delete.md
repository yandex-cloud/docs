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

      ```
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

   To delete a service account, use the [delete](../../api-ref/ServiceAccount/delete.md) method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource.

{% endlist %}
