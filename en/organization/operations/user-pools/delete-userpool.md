---
title: How to delete a user pool in {{ org-full-name }}
description: Follow this guide to delete a user pool in {{ org-name }}.
---

# Deleting a user pool


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. In the [user pool](../../concepts/user-pools.md) row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm deleting the user pool.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for deleting a [user pool](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool delete --help
     ```

  1. Run this command:

     ```bash
     yc organization-manager idp userpool delete <pool_ID>
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and delete the fragment with the [user pool](../../concepts/user-pools.md) description:

     ```hcl
     resource "yandex_organizationmanager_idp_userpool" "example_userpool" {
       organization_id   = "<organization_ID>"
       name              = "<pool_name>"
       description       = "<pool_description>"
       default_subdomain = "<default_domain>"
       labels            = {
         <key> = "<value>"
       }
     }
     ```

     For more information about `yandex_organizationmanager_idp_userpool` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/organizationmanager_idp_userpool).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will delete all the resources as appropriate. You can check the deletion of the resources in [{{ org-full-name }}]({{ link-org-cloud-center }}) or using this [CLI](../../../cli/) command:

     ```bash
     yc organization-manager idp userpool list --organization-id <organization_ID>
     ```

- API {#api}

  Use the [Userpool.Delete](../../idp/api-ref/Userpool/delete.md) REST API method for the [Userpool](../../idp/api-ref/Userpool/index.md) resource or the [UserpoolService/Delete](../../idp/api-ref/grpc/Userpool/delete.md) gRPC API call.

{% endlist %}