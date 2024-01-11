---
title: "How to edit an origin group in {{ cdn-full-name }}"
description: "In this tutorial, you will learn how to edit a {{ cdn-name }} origin group."
---

# Editing an origin group

## Editing a group {#editing-groups}

To edit an [origin group](../../concepts/origins.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a resource group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}**.
   1. Select the group to edit.
   1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
   1. Edit as appropriate.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI origin group edit command below:

      ```bash
      yc cdn origin-group update --help
      ```

   1. Get a list of all origin groups in the default folder:

      ```bash
      yc cdn origin-group list --format yaml
      ```

      Result:

      ```bash
      - id: "90209"
        folder_id: b1g86q4m5vej********
        name: test-group-1
      ...
          origin_group_id: "90208"
          source: www.a1.com
          enabled: true
      ```

   1. Edit the settings of the origin group by specifying the group ID:

      ```bash
      yc cdn origin-group update --id <origin_group_ID> \
        --name <new_group_name> \
        --origin source=<new_origin_IP_address_or_domain_name>,enabled=true \
        --origin source=<new_origin_IP_address_or_domain_name>,enabled=true,backup=true
      ```

      Where `--origin` is the origin specification:
      * `source`: New origin's IP address or domain name.
      * `enabled`: Origin enabled flag.
      * `backup`: Flag marking the origin as a backup.

      Result:

      ```bash
      id: "90209"
      folder_id: b1g86q4m5vej********
      name: test-group-22
      ...
        origin_group_id: "90209"
        source: www.site1.com
        enabled: true
      ```

      For more information about the `yc cdn origin-group update` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/origin-group/update.md).

- API

   To update an origin group, use the [update](../../api-ref/OriginGroup/update.md) REST API method for the [OriginGroup](../../api-ref/OriginGroup/index.md) resource or the [OriginGroupService/Update](../../api-ref/grpc/origin_group_service.md#Update) gRPC API call.

{% endlist %}

## Removing one origin from a group {#group-source-deletion}

{% note info %}

You can only delete backup origins.

{% endnote %}

To remove an origin from an origin group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a resource group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}** and click the name of the group to delete an origin from.
   1. Select the appropriate origin and click **{{ ui-key.yacloud.common.delete }}** in the bottom panel.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- API

   Use the [delete](../../api-ref/Origin/delete.md) REST API method for the [Origin](../../api-ref/Origin/index.md) resource or the [OriginService/Delete](../../api-ref/grpc/origin_service.md#Delete) gRPC API call.

{% endlist %}

## Removing multiple origins from a group {#summ-group-source-deletion}

{% note info %}

You can only delete backup origins.

{% endnote %}

To remove multiple origins from a group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a resource group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}** and click the name of the group to delete origins from.
   1. Select the appropriate origins and click **{{ ui-key.yacloud.common.delete }}** in the bottom panel.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}