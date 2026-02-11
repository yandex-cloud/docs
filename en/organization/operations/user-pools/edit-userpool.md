---
title: How to edit a user pool in {{ org-full-name }}
description: Follow this guide to edit a user pool in {{ org-name }}.
---

# Editing a user pool


{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.  
  1. In the line with the [user pool](../../../organization/concepts/user-pools.md), click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../../_assets/console-icons/pencil.svg) **Edit**.
  1. Enter a new name or description for the user pool.

      The name must be unique within the organization and satisfy the relevant requirements:

      {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

  1. Specify a new [domain](../../concepts/domains.md) to use if there are no other domains associated with the pool.
  1. Add or delete labels.
  1. Click **{{ ui-key.yacloud_org.actions.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to update a [user pool](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool update --help
     ```

  1. Run this command:

     ```bash
     yc organization-manager idp userpool update <pool_ID> \
       --userpool-name <pool_name> \
       --description <pool_description> \
       --default-subdomain <default_domain> \
       --labels <key>=<value>[,<key>=<value>]
     ```

     Where:
     
     * `--userpool-name`: New user pool name. The name must be unique within the organization and aligned with the naming requirements:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `--description`: New user pool description.
     * `--labels`: New list of [labels](../../../resource-manager/concepts/labels.md). You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and update the [user pool](../../concepts/user-pools.md) parameters:

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

     Where:

     * `name`: New user pool name. The name must be unique within the organization and aligned with the naming requirements:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `description`: New user pool description.
     * `default_subdomain`: New default [domain](../../concepts/domains.md). It will be used if no other domains are associated with the pool.
     * `labels`: New list of [labels](../../../resource-manager/concepts/labels.md).

     For more information about `yandex_organizationmanager_idp_userpool` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/organizationmanager_idp_userpool).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will update all the required resources. You can check the update in [{{ org-full-name }}]({{ link-org-cloud-center }}) or using the [CLI](../../../cli/):

     ```bash
     yc organization-manager idp userpool get <pool_ID>
     ```

- API {#api}

  Use the [Userpool.Update](../../idp/api-ref/Userpool/update.md) REST API method for the [Userpool](../../idp/api-ref/Userpool/index.md) resource or the [UserpoolService/Update](../../idp/api-ref/grpc/Userpool/update.md) gRPC API call.

{% endlist %}