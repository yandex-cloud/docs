---
title: "Deleting a backup policy"
description: "In this tutorial, you will learn how to delete a backup policy in **{{ backup-name }}**."
---

# Deleting a backup policy

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to delete the policy from.
   1. In the list of services, select **{{ backup-name }}**.
   1. Go to the ![policies](../../../_assets/backup/policies.svg) **Backup policies** tab.
   1. Click ![image](../../../_assets/options.svg) next to the appropriate policy, and select **Delete**.
   1. Confirm the deletion.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to delete a backup policy:

      ```bash
      yc backup policy delete --help
      ```

   1. Get the ID of the backup policy to delete:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

   1. Delete the policy by specifying its ID:

      ```bash
      yc backup policy delete <policy_ID>
      ```

      For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/policy/delete.md).

- API

   To delete a [backup policy](../../concepts/policy.md), use the [delete](../../backup/api-ref/Policy/delete.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Delete](../../backup/api-ref/grpc/policy_service.md#Delete) gRPC API call.

{% endlist %}
