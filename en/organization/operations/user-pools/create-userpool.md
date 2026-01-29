---
title: How to create a user pool in {{ org-full-name }}
description: Follow this guide to create a user pool in {{ org-name }}.
---

# Creating a user pool


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.  
  1. In the top-right corner of the page, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.userpools.action_create-userpool }}**.
  1. Enter a name and description for the [user pool](../../concepts/user-pools.md).

      The name must be unique within the organization and aligned with the naming requirements:

      {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

  1. In the **{{ ui-key.yacloud_org.form.userpool.caption.domain }}** field, add the [domain](../../concepts/domains.md) that will be used if there are no other domains associated with the pool.
  1. Optionally, add labels:
     1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
     1. Enter a label in `key: value` format.
     1. Press **Enter**.
  1. Click **{{ ui-key.yacloud_org.form.userpool.create.action.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a [user pool](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool create --help
     ```

  1. Run this command:

     ```bash
     yc organization-manager idp userpool create \
       --organization-id <organization_ID> \
       --userpool-name <pool_name> \
       --description <pool_description> \
       --default-subdomain <default_domain> \
       --labels <key>=<value>[,<key>=<value>]
     ```

     Where:
     
     * `--organization-id`: [ID of the organization](../organization-get-id.md) you want to create a user pool in.
     * `--userpool-name`: User pool name. The name must be unique within the organization and aligned with the naming requirements:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `--description`: User pool description. This is an optional parameter.
     * `--default-subdomain`: Default [domain](../../concepts/domains.md). It will be used if no other domains are associated with the pool.
     * `--labels`: List of [labels](../../../resource-manager/concepts/labels.md). This is an optional parameter. You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the [user pool](../../concepts/user-pools.md) parameters in the configuration file:

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

     * `organization_id`: ID of the organization you want to create a user pool in.
     * `name`: User pool name. The name must be unique within the organization and aligned with the naming requirements:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `description`: User pool description. This is an optional parameter.
     * `default_subdomain`: Default [domain](../../concepts/domains.md). It will be used if no other domains are associated with the pool.
     * `labels`: List of [labels](../../../resource-manager/concepts/labels.md). This is an optional parameter.

     For more information about the `yandex_organizationmanager_idp_userpool` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/organizationmanager_idp_userpool).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources and their settings either in [{{ org-full-name }}]({{ link-org-cloud-center }}) or using this [CLI](../../../cli/) command:

     ```bash
     yc organization-manager idp userpool list --organization-id <organization_ID>
     ```

- API {#api}

  Use the [Userpool.Create](../../idp/api-ref/Userpool/create.md) REST API method for the [Userpool](../../idp/api-ref/Userpool/index.md) resource or the [UserpoolService/Create](../../idp/api-ref/grpc/Userpool/create.md) gRPC API call.

{% endlist %}
#### See also {#see-also}

* [{#T}](../add-account.md#add-local-user)
* [{#T}](add-domain.md)