---
title: How to configure content request redirection
description: Follow this guide to configure redirection of requests from a CDN resource to an origin using a _rewrite_ rule.
---

# Configuring request redirection

With [request redirection](../../concepts/http-rewrite.md), you can reconfigure paths of requests to your content. This can be useful when restructuring files and folders on an [origin](../../concepts/origins.md). You can also use redirection if you want to keep search engine rankings of your content when moving your resource to a new address.

To enable request redirection on a CDN resource:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Click the CDN resource name.

  1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

  1. Enable **{{ ui-key.yacloud.cdn.field_rewrite-rule-redirect }}**.

  1. In the **{{ ui-key.yacloud.cdn.field_rewrite-rule-body }}** field, set a rule, e.g., `/(.*) /new-folder/$1`.

      {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}

  1. In the **{{ ui-key.yacloud.cdn.field_rewrite-rule-flag }}** field, specify the required [flag](../../concepts/http-rewrite.md#flag):

      {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI update resource command:

      ```bash
      yc cdn resource update --help
      ```

  1. Get a list of all resources in the default folder:

      ```bash
      yc cdn resource list --format yaml
      ```

      Result:

      ```text
      - id: bc8ceo77zu7h********
        folder_id: b1gt6g8ht345********
        cname: cdn.example.com
        created_at: "2024-09-10T19:15:16.305043Z"
        updated_at: "2024-09-11T17:19:50.622628Z"
        active: true
        options:
          edge_cache_settings:
            enabled: true
            default_value: "345600"
          query_params_options:
            ignore_query_string:
              enabled: true
              value: true
          slice:
            enabled: true
            value: true
          host_options:
            host:
              enabled: true
              value: cdn-source-sample-bucket.{{ s3-storage-host }}
          stale:
            enabled: true
            value:
              - error
              - updating
          ignore_cookie:
            enabled: true
            value: true
        origin_group_id: "328146"
        origin_group_name: Origins for cdn.example.com (225300)
        origin_protocol: HTTPS
        ssl_certificate:
          type: CM
          status: READY
          data:
            cm:
              id: fpquvh0em4no********
      ```

      Save the CDN resource ID (the `id` field at the beginning of the output) as you will need it at the next step.

  1. Enable request redirection by specifying the CDN resource ID you saved in the previous step:

      ```bash
      yc cdn resource update <resource_ID> \
        --rewrite-body '<rewrite_rule>' \
        --rewrite-flag <flag>
      ```

      Where:
      * `--rewrite-body`: Rewrite rule, e.g., `--rewrite-body '/(.*) /new-folder/$1'`.

          {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}
      * `--rewrite-flag`: [Flag](../../concepts/http-rewrite.md#flag). The possible values are:

          {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

      {% cut "Result" %}

      ```text
      id: bc8ceo77zu7h********
      folder_id: b1gt6g8ht345********
      cname: cdn.example.com
      created_at: "2024-09-10T19:15:16.305043Z"
      updated_at: "2024-09-11T17:55:21.100567Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default_value: "345600"
        query_params_options:
          ignore_query_string:
            enabled: true
            value: true
        slice:
          enabled: true
          value: true
        host_options:
          host:
            enabled: true
            value: cdn-source-sample-bucket.{{ s3-storage-host }}
        stale:
          enabled: true
          value:
            - error
            - updating
        ignore_cookie:
          enabled: true
          value: true
        rewrite:
          enabled: true
          body: /(.*) /new-folder/$1
          flag: BREAK
      origin_group_id: "328146"
      origin_group_name: Origins for cdn.example.com (225300)
      origin_protocol: HTTPS
      ssl_certificate:
        type: CM
        status: READY
        data:
          cm:
            id: fpquvh0em4no********
      ```

      {% endcut %}

     To disable request redirection for a CDN resource, run this command, specifying the appropriate CDN resource ID:

      ```bash
      yc cdn resource update <resource_ID> --clear-rewrite
      ```

      For more information about the `yc cdn resource update` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

- API {#api}

  Use the [update](../../api-ref/Resource/update.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Update](../../api-ref/grpc/Resource/update.md) gRPC API call.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

#### See also {#see-also}

* [{#T}](../../concepts/http-rewrite.md)