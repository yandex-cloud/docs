---
title: How to edit the basic settings of a resource in {{ cdn-full-name }}
description: Follow this guide to update the basic resource settings.
---

# Editing the basic settings of a resource

To edit the basic settings of a [resource](../../concepts/resource.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Click the resource name.

  1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

  1. Edit the resource settings.

      {% note warning %}

      You cannot change the primary [domain name used for content distribution](../../concepts/resource.md#hostnames).

      {% endnote %}

      * To add [labels](../../concepts/labels.md):

          * Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          * Enter a label in `key: value` format.
          * Press **Enter**.

      * To configure a [TLS certificate](../../concepts/clients-to-servers-tls.md) for a CDN resource, in the **{{ ui-key.yacloud.cdn.label_certificate-type }}** field, select one of the options:

          * `{{ ui-key.yacloud.cdn.value_certificate-no }}`: Resource will only be available over HTTP.


          * `{{ ui-key.yacloud.cdn.value_certificate-custom }}`: Select a certificate. The resource will be available over HTTP and HTTPS.

              {% include [lets-encrypt-over](../../../_includes/cdn/lets-encrypt-over.md) %}

              {% include [certificate-usage](../../../_includes/cdn/certificate-usage.md) %}

          To learn more, see [{#T}](../../concepts/clients-to-servers-tls.md).

      * To enable [request redirection](../../concepts/http-rewrite.md) on a CDN resource:

          1. Enable **{{ ui-key.yacloud.cdn.field_rewrite-rule-redirect }}**.
          1. In the **{{ ui-key.yacloud.cdn.field_rewrite-rule-body }}** field, set a rule, e.g., `/(.*) /new-folder/$1`.

              {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}

          1. In the **{{ ui-key.yacloud.cdn.field_rewrite-rule-flag }}** field, specify the required [flag](../../concepts/http-rewrite.md#flag):

              {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

      * To restrict access to resource content with [secure tokens](../../concepts/secure-tokens.md), enable **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**:

          {% include [enable-secure-token](../../../_includes/cdn/enable-secure-token.md) %}

          {% include [enable-ip-policy](../../../_includes/cdn/enable-ip-policy.md) %}

          For more information, see [{#T}](enable-secure-token.md).

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
      id: s0me1dkfjq********
      folder_id: s0mef01der7p********
      cname: testexample.com
      created_at: "2022-01-19T09:23:57.921365Z"
      updated_at: "2022-01-19T10:55:30.305141Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default value: "345600"
        cache_http_headers:
          enabled: true
          value:
          - content-type
          - content-length
          - connection
          - server
          - date
          - test
        stale:
          enabled: true
          value:
          - error
          - updating
        allowed_http_methods:
          value:
          - GET
          - POST
          - HEAD
          - OPTIONS
      origin_group_id: "89783"
      origin_group_name: My origins group
      origin_protocol: HTTP
      ssl_certificate:
        type: DONT_USE
        status: READY
      ```

  1. Edit the resource settings:

      ```bash
      yc cdn resource update <resource_ID> \
        <flag> <new_value>
      ```

      {% include [certificate-settings-cli](../../../_includes/cdn/certificate-settings-cli.md) %}

      To enable [request redirection](../../concepts/http-rewrite.md) on a CDN resource, use these parameters:

      * `--rewrite-body`: Rewrite rule, e.g., `--rewrite-body '/(.*) /new-folder/$1'`.

          {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}
      * `--rewrite-flag`: [Flag](../../concepts/http-rewrite.md#flag). The possible values are:

          {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

      To disable [request redirection](../../concepts/http-rewrite.md) on a CDN resource, use the `--clear-rewrite` parameter.

      {% include [access-restrictions-cli](../../../_includes/cdn/access-restrictions-cli.md) %}

      To disable the IP-based access policy, use the `--clear-ip-address-acl` parameter.

      To add or remove [labels](../../concepts/labels.md), use the `--add-labels`, `--remove-labels`, and `--remove-all-labels` parameters.

      For more information about the `yc cdn resource update` command, see the [CLI reference](../../../cli/cli-ref/cdn/cli-ref/resource/update.md).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To update the parameters of a CDN resource created using {{ TF }}:

  1. Open the {{ TF }} configuration file and edit the fragment with the resource description:

      {% include [create-resource-tf](../../../_includes/cdn/create-resource-tf.md) %}

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

     The terminal will display a list of resources with their parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:
     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the changes to the CDN resource in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

     ```bash
     yc cdn resource list
     ```

- API {#api}

  Use the [update](../../api-ref/Resource/update.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Update](../../api-ref/grpc/Resource/update.md) gRPC API call.

  You can restrict access to the resource with [secure tokens](../../concepts/secure-tokens.md) and an [IP-based access policy](../../concepts/ip-address-acl.md).

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

## Examples {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

  Change the protocol for origins from HTTP to HTTPS and select a Let's Encrypt® certificate [added](../../../certificate-manager/operations/managed/cert-create.md) to {{ certificate-manager-name }} or an [uploaded](../../../certificate-manager/operations/import/cert-create.md) certificate of your own:

    ```bash
    yc cdn resource update s0me1dkfjq******** \
      --origin-protocol HTTPS \
      --cert-manager-ssl-cert-id <certificate_ID>
    ```

  Result:

    ```text
    id: s0me1dkfjq********

    ...

    cname: testexample.com
    active: true

    ...

    origin_group_id: "89783"
    origin_group_name: My origins group
    origin_protocol: HTTPS
    ssl_certificate:
    type: CM
    status: CREATING
    ```

{% endlist %}