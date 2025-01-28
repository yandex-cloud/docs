---
title: Managing CDN resource labels in {{ cdn-full-name }}
description: Follow this guide to manage CDN resource labels in {{ cdn-name }}.
---

# Managing resource labels

[CDN resource labels](../../concepts/labels.md) are key-value pairs used for logical CDN resource labeling.

## Adding or updating labels {#add-edit-label}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}** from the list of services.
  1. In the line with the CDN resource, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.cdn.label_section-content }}**, find the **{{ ui-key.yacloud_billing.component.label-set.label_labels }}** field.
  1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Enter a label in `key: value` format. To edit an existing label, enter its key and a new value.
  1. Click **Enter**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to update the CDN resource settings:

      ```bash
      yc cdn resource update --help
      ```

  1. Get a list of CDN resources in the default folder:

      ```bash
      yc cdn resource list
      ```

      Result:

      ```text
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      |          ID          |  CNAME  |           CREATED AT           |           UPDATED AT           | ACTIVE |                         OPTIONS                         |
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      | bc8jhcx5o47p******** | ****.ru | seconds:1734615244             | seconds:1734615244             | false  | edge_cache_settings:{enabled:true                       |
      |                      |         | nanos:439618000                | nanos:439638000                |        |  default_value:345600}                                  |
      |                      |         |                                |                                |        | query_params_options:{ignore_query_string:{enabled:true |
      |                      |         |                                |                                |        |  value:true}}  stale:{enabled:true  value:"error"       |
      |                      |         |                                |                                |        | value:"updating"}                                       |
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      ```

  1. Add labels by specifying the name of the CDN resource:

      ```bash
      yc cdn resource update <CDN_resource_ID> \
        --add-labels <label_1_key>=<label_1_value>,<label_2_key>=<label_2_value>,...,<label_n_key>=<label_n_value>
      ```

      Where `--add-labels` is a flag to list the CDN resource labels in `key=value` format.

      Result:

      ```text
      id: bc8jhcx5o47p********
      folder_id: b1g681qpemb4********
      cname: ****.ru
      ...
      labels:
        key2: value2
        key3: value3
        key4: value4
      ```

{% endlist %}

## Viewing labels {#get-label}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}** from the list of services.
  1. Navigate to the CDN resource.
  1. Under **{{ ui-key.yacloud.cdn.label_section-content }}**, find the **{{ ui-key.yacloud_billing.component.label-set.label_labels }}** field.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to update the CDN resource settings:

      ```bash
      yc cdn resource update --help
      ```

  1. Get a list of CDN resources in the default folder:

      ```bash
      yc cdn resource list
      ```

      Result:

      ```text
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      |          ID          |  CNAME  |           CREATED AT           |           UPDATED AT           | ACTIVE |                         OPTIONS                         |
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      | bc8jhcx5o47p******** | ****.ru | seconds:1734615244             | seconds:1734615244             | false  | edge_cache_settings:{enabled:true                       |
      |                      |         | nanos:439618000                | nanos:439638000                |        |  default_value:345600}                                  |
      |                      |         |                                |                                |        | query_params_options:{ignore_query_string:{enabled:true |
      |                      |         |                                |                                |        |  value:true}}  stale:{enabled:true  value:"error"       |
      |                      |         |                                |                                |        | value:"updating"}                                       |
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      ```

  1. Get information about the labels by specifying the name of the CDN resource:

      ```bash
      yc cdn resource get <CDN_resource_ID>
      ```

      Result:

      ```text
      id: bc8jhcx5o47p********
      folder_id: b1g681qpemb4********
      cname: ****.ru
      ...
      labels:
        key2: value2
        key3: value3
        key4: value4
      ```

{% endlist %}

## Deleting labels {#delete-label}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}** from the list of services.
  1. In the line with the CDN resource, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.cdn.label_section-content }}**, find the **{{ ui-key.yacloud_billing.component.label-set.label_labels }}** field.
  1. Click ![image](../../../_assets/console-icons/xmark.svg) next to the label.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to update the CDN resource settings:

      ```bash
      yc cdn resource update --help
      ```

  1. Get a list of CDN resources in the default folder:

      ```bash
      yc cdn resource list
      ```

      Result:

      ```text
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      |          ID          |  CNAME  |           CREATED AT           |           UPDATED AT           | ACTIVE |                         OPTIONS                         |
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      | bc8jhcx5o47p******** | ****.ru | seconds:1734615244             | seconds:1734615244             | false  | edge_cache_settings:{enabled:true                       |
      |                      |         | nanos:439618000                | nanos:439638000                |        |  default_value:345600}                                  |
      |                      |         |                                |                                |        | query_params_options:{ignore_query_string:{enabled:true |
      |                      |         |                                |                                |        |  value:true}}  stale:{enabled:true  value:"error"       |
      |                      |         |                                |                                |        | value:"updating"}                                       |
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      ```

  1. Delete labels by specifying the name of the CDN resource:

      ```bash
      yc cdn resource update <CDN_resource_ID> \
        --remove-labels <label_1_key>,<label_2_key>,...,<label_n_key>
      ```

      Where `--remove-labels` is a flag to list the CDN resource label keys.

      Result:

      ```text
      id: bc8jhcx5o47p********
      folder_id: b1g681qpemb4********
      cname: ****.ru
      ...
      labels:
        key2: value2
        key3: value3
        key4: value4
      ```

      To delete all labels, use the `--remove-all-labels` flag:

      ```bash
      yc cdn resource update <CDN_resource_ID> \
        --remove-all-labels
      ```

{% endlist %}
