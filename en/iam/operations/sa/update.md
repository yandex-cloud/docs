---
title: "Updating a service account"
description: "Follow this guide to update a service account."
---

# Updating a service account

You can change a service account's name and description. Using the {{ yandex-cloud }} API you can also [label](../../../resource-manager/concepts/labels.md) a service account.

To change a service account's roles, follow [this guide](assign-role-for-sa.md).

{% list tabs group=instructions %}

- Management console {#console}

   To update a service account:

   1. In the [management console]({{ link-console-main }}), navigate to the folder the service account belongs to.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the service account and select **{{ ui-key.yacloud.iam.folder.service-accounts.button_action-edit }}**.
   1. Change the name of your service account.

      The name format requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

   1. Change the description of your service account.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_save }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   To update a service account:

   1. See the description of the update service account command:

      ```bash
      yc iam service-account update --help
      ```

   1. Select a service account, e.g., `my-robot`:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```bash
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```

   1. Change the service account parameters, such as name and description:

      ```bash
      yc iam service-account update my-robot \
        --new-name my-service-account \
        --description "this is my service account"
      ```

      The name format requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To update a service account:

   1. Open the {{ TF }} configuration file and edit the fragment with the service account description.
      Example of the service account description in the {{ TF }} configuration:

      ```hcl
      ...
      resource "yandex_iam_service_account" "sa" {
        name        = "my-robot"
        description = "this is new description"
       }
      ...
      ```
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

      You can verify that the service account was updated in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iam service-account list
      ```

- API {#api}

   To update a service account, use the [update](../../api-ref/ServiceAccount/update.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Update](../../api-ref/grpc/service_account_service.md#Update) gRPC API call.

{% endlist %}
