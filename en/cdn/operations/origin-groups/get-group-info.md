---
title: How to get information about an origin in {{ cdn-full-name }}
---

# Getting information about origins

You can get information about an individual [origin](#get-origin) or an [origin group](#get-origin-group).

## Getting information about an origin {#get-origin}

To get the URL and other details of an origin:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your origin.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}**.
  1. Select the origin group containing your origin.
  1. The **{{ ui-key.yacloud.common.overview }}** page will show the origin details.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to get information about an origin:

      ```bash
      yc cdn origin get --help
      ```

  1. Get information about the origin by specifying its ID or name:

      ```bash
      yc cdn origin get <origin_ID>
      ```

      Result:

      ```text
      id: "152152********"
      origin_group_id: "2128********"
      source: test-cdn-1.{{ s3-storage-host }}
      enabled: true
      meta:
        bucket:
          name: test-cdn-1
      ```

- API {#api}

  To get detailed information about an origin, use the [get](../../api-ref/Origin/get.md) REST API method for the [Origin](../../api-ref/Origin/index.md) resource or the [OriginService/Get](../../api-ref/grpc/origin_service.md#Get) gRPC API call.

{% endlist %}

## Getting information about an origin group {#get-origin-group}

To get the name, set of origins, and other details of an origin group:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your origin group.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}**.
  1. Select an origin group.
  1. The **{{ ui-key.yacloud.common.overview }}** page will show the origin group details.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to get information about an origin group:

      ```bash
      yc cdn origin-group get --help
      ```

  1. Get information about the origin group by specifying its ID or name:

      ```bash
      yc cdn origin-group get <origin_group_ID>
      ```

      Result:

      ```text
      id: "2149********"
      folder_id: b1ggmp8es27t********
      name: test-cdn-group
      use_next: true
      origins:
      - id: "2741********"
        origin_group_id: "2149********"
        source: test-cdn-1-2.{{ s3-storage-host }}
        enabled: true
        backup: true
        meta:
          bucket:
            name: test-cdn-1-2
      - id: "2742********"
        origin_group_id: "2149********"
        source: test-cdn-1-1.{{ s3-storage-host }}
        enabled: true
        meta:
          bucket:
            name: test-cdn-1-1
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_cdn_origin_group" "my_group" {
        origin_group_id = "<group_ID>"
      }

      output "my_group_origin" {
        value = "${data.yandex_cdn_origin_group.my_group.origin}"
      }
      ```

      Where:

      * `data "yandex_cdn_origin_group"`: Description of the origin group as a data source:
        * `origin_group_id`: Origin group ID.
      * `output "my_group_origin"`: Output variable that contains information about the origin group:
        * `value`: Returned value.

      You can replace `origin` with any other parameter to get the information you need. For more information about the `yandex_cdn_origin_group` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/datasource_cdn_origin_group).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      my_group_origin = toset([
        {
          "backup" = false
          "enabled" = true
          "origin_group_id" = 2149********
          "source" = "test-cdn-1-2"
        },
        {
          "backup" = true
          "enabled" = true
          "origin_group_id" = 2149********
          "source" = "test-cdn-1-1"
        },
      ])
      ```

- API {#api}

  To get detailed information about an origin group, use the [get](../../api-ref/OriginGroup/get.md) REST API method for the [OriginGroup](../../api-ref/OriginGroup/index.md) resource or the [OriginGroupService/Get](../../api-ref/grpc/origin_group_service.md#Get) gRPC API call.

{% endlist %}
