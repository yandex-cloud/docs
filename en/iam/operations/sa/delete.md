---
title: How to delete a service account
description: Follow this guide to delete a service account.
---

# Deleting a service account

{% note warning %}

Deleting a [service account](../../concepts/users/service-accounts.md) is permanent. You cannot restore a deleted service account; you can only [re-create it](create.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [delete-sa-via-console](../../../_includes/iam/delete-sa-via-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the delete service account command:

      ```bash
      yc iam service-account delete --help
      ```

  1. Select a service account, e.g., `my-robot`:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```

  1. Delete the service account:

      ```bash
      yc iam service-account delete my-robot
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

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
  
     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:
     ```bash
     terraform apply
     ```
     
  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the deletion of the service account using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     ```bash
     yc iam service-account list
     ```

- API {#api}

  To delete a service account, use the [delete](../../api-ref/ServiceAccount/delete.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Delete](../../api-ref/grpc/ServiceAccount/delete.md) gRPC API call.

{% endlist %}

You cannot delete a service account while it is linked to some cloud [resources](../../../overview/roles-and-resources.md#resources). First, update the service account in the resource's settings or delete the resource and then delete the service account. For example, if your service account is linked to a VM, first [delete](../../../compute/operations/vm-control/vm-delete.md) the VM and then delete the service account.
