---
title: How to configure a custom server name for SNI in {{ cdn-full-name }}
description: Follow this guide to configure a custom server name for SNI.
---

# Configuring a custom server name for SNI

You can configure a custom server name for [SNI (Server Name Indication)](https://{{ lang }}.wikipedia.org/wiki/Server_Name_Indication) when establishing an HTTPS connection from CDN servers to the origin.

{% note info %}

This setting is only available when using an HTTPS connection between the CDN servers and the origin.

{% endnote %}


## Creating a resource with a custom server name for SNI {#create}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to create a resource:

      ```bash
      yc cdn resource update --help
      ```

  1. Get a list of all [origin groups](../../concepts/origins.md#groups) in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc cdn origin-group list --format yaml
      ```

      Result:

      ```text
      - id: "*****"
        folder_id: b1g86q4m5vej********
        name: test-group-1
      ...
          origin_group_id: "*****"
          source: www.a1.com
          enabled: true
      ```

  1. [Create](create-resource.md) a resource with a custom server name for SNI:

      ```bash
      yc cdn resource create <resource_domain_name> \
        --origin-group-id <origin_group_ID> \
        --origin-protocol HTTPS \
        --custom-server-name <server_name_for_SNI>
      ```

      Result:

      ```text
      id: bc8rpzaciiyp********
      folder_id: b1g681qpemb4********
      cname: example.com
      ...
        custom_server_name:
          enabled: true
          value: custom.example.com
      ...
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the properties of the CDN resource to create:

      ```tf
      resource "yandex_cdn_resource" "my_resource" {
          cname               = "<domain_name>"
          active              = true
          origin_protocol     = "https"
          origin_group_id     = <origin_group_ID>
          options {
            custom_server_name  = <server_name_for_SNI>
          }
      }
      ```

      Where:

      * `cname`: Primary domain name used for content distribution. This is a required setting.
      * `active`: Flag for content availability to end users, where `true` means the CDN content is available to clients, and `false` means the content not available. The default value is `true`. This is an optional setting.
      * `origin_protocol`: Protocol for origins. The default value is `http`. This is an optional setting.
      * `origin_group_id`: [Origin group](../../concepts/origins.md) ID. This is a required parameter. Use the ID from the description of the origin group in the `yandex_cdn_origin_group` resource.
      * `custom_server_name`: Custom server name for SNI.

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new CDN resource using the [management console]({{ link-console-main }}) or this CLI command:

     ```bash
     yc cdn resource list
     ```

- REST API {#rest-api}

  Add the `customServerName` section when using the [create](../../api-ref/Resource/create.md) method for a [Resource](../../api-ref/Resource/index.md):

  ```json
  "originProtocol": "HTTPS",
  "options": {
    "customServerName": {
      "enabled": "<true_or_false>",
      "value": "string"
    }
  }
  ```

  Where:

  * `customServerName.enabled`: Enabling the option:
      * `true` enables the option.
      * `false` disables the option.

  * `customServerName.value`: Custom server name for SNI.
  * `originProtocol`: Connection protocol between CDN servers and the origin.

- gRPC API {#grpc-api}

  Add the `custom_server_name` section when using the [ResourceService/Create](../../api-ref/grpc/Resource/create.md) call:

  ```json
  "origin_protocol": "HTTPS",
  "options": {
    "custom_server_name": {
      "enabled": "<true_or_false>",
      "value": "string"
    }
  }
  ```

  Where:

  * `custom_server_name.enabled`: Enabling the option:
      * `true` enables the option.
      * `false` disables the option.

  * `custom_server_name.value`: New custom server name for SNI.
  * `origin_protocol`: Connection protocol between CDN servers and the origin.

{% endlist %}


## Updating a custom server name for SNI {#update}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to update a resource:

      ```bash
      yc cdn resource update --help
      ```

  1. Get a list of all resources in the folder:

      ```bash
      yc cdn resource list --format yaml
      ```

      Result:

      ```text
      - id: bc8rpzaciiyp********
        folder_id: b1g681qpemb4********
        cname: example.com
        ...
          custom_server_name:
            enabled: true
            value: custom.example.com
        ...
      ```

  1. [Update](configure-basics.md) a custom server name for SNI:

      ```bash
      yc cdn resource update <resource_ID> \
        --origin-protocol HTTPS \
        --custom-server-name <new_server_name_for_SNI>
      ```

      Result:

      ```text
      - id: bc8rpzaciiyp********
        folder_id: b1g681qpemb4********
        cname: example.com
        ...
          custom_server_name:
            enabled: true
            value: new.example.com
        ...
      ```

      To delete a custom server name for SNI, use the `--clear-custom-server-name` flag:

      ```bash
      yc cdn resource update <resource_ID> \
        --clear-custom-server-name
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To update the parameters of a CDN resource created using {{ TF }}:

  1. Open the {{ TF }} configuration file and edit the fragment with the resource description:

      ```tf
      resource "yandex_cdn_resource" "my_resource" {
          cname               = "<domain_name>"
          active              = true
          origin_protocol     = "https"
          origin_group_id     = <origin_group_ID>
          options {
            custom_server_name  = <new_server_name_for_SNI>
          }
      }
      ```

      Where:

      * `cname`: Primary domain name used for content distribution. This is a required setting.
      * `active`: Flag for content availability to end users, where `true` means the CDN content is available to clients, and `false` means the content not available. The default value is `true`. This is an optional setting.
      * `origin_protocol`: Protocol for origins. The default value is `http`. This is an optional setting.
      * `origin_group_id`: [Origin group](../../concepts/origins.md) ID. This is a required parameter. Use the ID from the description of the origin group in the `yandex_cdn_origin_group` resource.
      * `custom_server_name`: New custom server name for SNI.

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will update all the required resources. You can check the CDN resource update in the [management console]({{ link-console-main }}) or using this CLI command:

      ```bash
      yc cdn resource list
      ```

- REST API {#rest-api}

  Add the `customServerName` section when using the [update](../../api-ref/Resource/update.md) method for a [Resource](../../api-ref/Resource/index.md):

  ```json
  "originProtocol": "HTTPS",
  "options": {
    "customServerName": {
      "enabled": "<true_or_false>",
      "value": "string"
    }
  }
  ```

  Where:

  * `customServerName.enabled`: Enabling the option:
      * `true` enables the option.
      * `false` disables the option.

  * `customServerName.value`: Custom server name for SNI.
  * `originProtocol`: Connection protocol between CDN servers and the origin.

- gRPC API {#grpc-api}

  Add the `custom_server_name` section when using the [ResourceService/Update](../../api-ref/grpc/Resource/update.md) call:

  ```json
  "origin_protocol": "HTTPS",
  "options": {
    "custom_server_name": {
      "enabled": "<true_or_false>",
      "value": "string"
    }
  }
  ```

  Where:

  * `custom_server_name.enabled`: Enabling the option:
      * `true` enables the option.
      * `false` disables the option.

  * `custom_server_name.value`: New custom server name for SNI.
  * `origin_protocol`: Connection protocol between CDN servers and the origin.


{% endlist %}