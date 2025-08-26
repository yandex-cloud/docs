---
title: How to get information about a resource in {{ cdn-full-name }}
---

# Getting information about a resource

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your [resource](../../concepts/resource.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Select a CDN resource.
  1. The **{{ ui-key.yacloud.common.overview }}** page will show the resource details.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to get information about a [resource](../../concepts/resource.md):

      ```bash
      yc cdn resource get --help
      ```

  1. Get information about the resource by specifying its ID or name:
      
      ```bash
      yc cdn resource get <resource_ID>
      ```

      Result:

      ```text
      id: bc8v43fzihmv********
      folder_id: b1ggmp8es27t********
      cname: cdn-res-group.test.com
      created_at: "2023-10-25T11:18:13.630839Z"
      updated_at: "2023-10-25T11:18:13.630858Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default_value: "345600"
        query_params_options:
          ignore_query_string:
            enabled: true
            value: true
        stale:
          enabled: true
          value:
          - error
          - updating
      origin_group_id: "27272********"
      origin_group_name: test-cdn-group
      origin_protocol: HTTP
      ssl_certificate:
        type: DONT_USE
        status: READY
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get information about a [resource](../../concepts/resource.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_cdn_resource" "my_resource" {
        resource_id = "<resource_ID>"
      }

      output "resource_active" {
        value = data.yandex_cdn_resource.my_resource.active
      }
      ```

      Where:

      * `data "yandex_cdn_resource"`: Description of the CDN resource as a data source:
         * `resource_id`: Resource ID.
      * `output "resource_active"`: Output variable that shows whether the CDN resource is active:
         * `value`: Return value.

     You can replace `active` with any other parameter to get the information you need. For more information about the `yandex_cdn_resource` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/cdn_resource).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      resource_active = true
      ```

- API {#api}

  To get detailed information about a [resource](../../concepts/resource.md), use the [get](../../api-ref/Resource/get.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Get](../../api-ref/grpc/Resource/get.md) gRPC API call.

{% endlist %}

## Getting the domain name of a {{ cdn-name }} provider {#get-cname}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your resource.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Select the CDN resource you created.
  1. Under **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** on the **{{ ui-key.yacloud.common.overview }}** page, you will see a domain name in `{{ cname-example-yc }}` or `{{ cname-example-edge }}` format, depending on your [CDN provider](../../concepts/providers.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get information about a resource using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_cdn_resource" "my_resource" {
        resource_id = "<resource_ID>"
      }

      output "provider_cname" {
        value = data.yandex_cdn_resource.my_resource.provider_cname
      }
      ```

      Where:

      * `data "yandex_cdn_resource"`: Description of the CDN resource as a data source:
         * `resource_id`: Resource ID.
      * `output "provider_cname"`: Output variable that contains information about the domain name:
         * `value`: Return value.

     You can replace `provider_cname` with any other parameter to get the information you need. For more information about the `yandex_cdn_resource` data source properties, see [this {{ TF }} provider article]({{ tf-provider-datasources-link }}/cdn_resource).

  1. Get information about resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      provider_cname = "{{ cname-example-yc }}"
      ```

{% endlist %}
