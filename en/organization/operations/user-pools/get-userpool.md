---
title: How to get information about a user pool in {{ org-full-name }}
description: Follow this guide to get information about a user pool in {{ org-name }}.
---

# Getting information about a user pool


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. Select the required pool from the [user pool](../../concepts/user-pools.md) list.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting information about a [user pool](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool get --help
     ```

  1. Run this command:

     ```bash
     yc organization-manager idp userpool get <pool_ID>
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get a list of [domains](../../concepts/domains.md) in a [user pool](../../concepts/user-pools.md):

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

     ```hcl
     data "yandex_organizationmanager_idp_userpool" "userpool" {
       userpool_id = "<pool_ID>"
     }
     
     output "my_userpool-domains" {
       value = data.yandex_organizationmanager_idp_userpool.userpool.domains
     }
     ```

     Where:

     * `data "yandex_organizationmanager_idp_userpool"`: Description of the user pool as a data source:
       * `userpool_id`: Pool ID.
     * `output "instance_domain"`: Output variable that contains information about the pool domains:
       * `value`: Return value.

     You can replace `domains` with any other parameter to get the information you need. For more information about the `yandex_organizationmanager_idp_userpool` data source properties, see [this {{ TF }} provider article]({{ tf-provider-datasources-link }}/organizationmanager_idp_userpool).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      my_userpool-domains = tolist([
        "domain.example1.net",
        "domain-example2.ru"
      ])
      ```

- API {#api}

  Use the [Userpool.Get](../../idp/api-ref/Userpool/get.md) REST API method for the [Userpool](../../idp/api-ref/Userpool/index.md) resource or the [UserpoolService/Get](../../idp/api-ref/grpc/Userpool/get.md) gRPC API call.

{% endlist %}