---
title: How to change desktop group access permissions in {{ cloud-desktop-full-name }}
description: In this tutorial, you will learn how to change access permissions for a desktop group in {{ cloud-desktop-full-name }}.
---

# Changing desktop group access permissions

{% include [access-options](../../../_includes/cloud-desktop/access-options.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the desktop group.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Select the desktop group to update access permissions for.
  1. In the left-hand panel, select ![persons](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.label_access-rights }}**.
  1. Click **{{ ui-key.yacloud_org.common.resource-acl.button_new-bindings }}**.
  1. In the **{{ ui-key.yacloud_components.acl.label.title }}** window that opens, grant or revoke permissions as needed.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  You can assign multiple roles using the `set-access-bindings` command.

  {% note alert %}

  The `set-access-bindings` command completely overwrites access permissions for the desktop group. All current group roles will be deleted.

  {% endnote %}

  1. Make sure the desktop group has no roles you want to keep:

     ```bash
     yc desktops group list-access-bindings <desktop_group_name_or_ID>
     ```

  1. See the description of the CLI command for assigning roles to a desktop group:

     ```bash
     yc desktops group set-access-bindings --help
     ```

  1. Assign roles:

      ```bash
      yc desktops group set-access-bindings <desktop_group_name_or_ID> \
        --access-binding role=<role>,<subject_type>=<subject_ID> \
        --access-binding role=<role>,<subject_type>=<subject_ID>
      ```

      Where `--access-binding` contains access permission settings:

      * `role`: [Role](../../security/index.md#roles-list).
      * `subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) the role is assigned to.

      For example, the following command will assign roles to multiple users and a single service account:

      ```bash
      yc desktops group set-access-bindings my-desktop-group \
        --access-binding role=editor,userAccount=gfei8n54hmfh******** \
        --access-binding role=viewer,userAccount=helj89sfj80a******** \
        --access-binding role=editor,serviceAccount=ajel6l0jcb9s********
      ```

      To assign a role to a subject without rewriting its other roles, use the `yc desktops group add-access-bindings` [command](../../../cli/cli-ref/desktops/cli-ref/group/add-access-bindings.md). For example, the following command will assign a role to a service account:

      ```bash
      yc desktops group add-access-bindings \
        --name <desktop_group_name> \
        --role <role> \
        --service-account-name <service_account_name>
      ```

- API {#api}

  Use the [updateAccessBindings](../../api-ref/DesktopGroup/updateAccessBindings.md) REST API method for the [DesktopGroup](../../api-ref/DesktopGroup/index.md) resource or the [DesktopGroupService/UpdateAccessBindings](../../api-ref/grpc/DesktopGroup/updateAccessBindings.md) gRPC API call.

{% endlist %}
