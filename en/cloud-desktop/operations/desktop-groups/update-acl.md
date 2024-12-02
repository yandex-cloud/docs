---
title: How to change access permissions for a desktop group in {{ cloud-desktop-full-name }}
description: In this tutorial, you will learn how to change access permissions for a desktop group in {{ cloud-desktop-full-name }}.
---

# Changing desktop group permissions

{% include [access-options](../../../_includes/cloud-desktop/access-options.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the desktop group is in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of the desktop group you want to change access permissions for and select **{{ ui-key.yacloud.vdi.button_acl }}**.
  1. In the **{{ ui-key.yacloud.component.acl-dialog.label_title }}** window that opens, grant or revoke the appropriate permissions.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  You can assign multiple roles using the `set-access-bindings` command.

  {% note alert %}

  The `set-access-binding` command completely rewrites access permissions for a desktop group. All current group roles will be deleted.

  {% endnote %}

  1. Make sure the desktop group has no roles assigned that you would not want to lose:

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

      Where `--access-binding` is used to provide the parameters for setting access permissions:

      * `role`: [Role](../../security/index.md#roles-list) to assign.
      * `subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

      For example, assign roles to multiple users and a service account:

      ```bash
      yc desktops group set-access-bindings my-desktop-group \
        --access-binding role=editor,userAccount=gfei8n54hmfh******** \
        --access-binding role=viewer,userAccount=helj89sfj80a******** \
        --access-binding role=editor,serviceAccount=ajel6l0jcb9s********
      ```

      To assign a role to a subject without rewriting its other roles, use the `yc desktops group add-access-bindings` [command](../../../cli/cli-ref/desktops/cli-ref/group/add-access-bindings.md). For example, to assign a role to a service account:

      ```bash
      yc desktops group add-access-bindings \
        --name <desktop_group_name> \
        --role <role> \
        --service-account-name <service_account_name>
      ```

- API {#api}

  Use the [updateAccessBindings](../../api-ref/DesktopGroup/updateAccessBindings.md) REST API method for the [DesktopGroup](../../api-ref/DesktopGroup/index.md) resource or the [DesktopGroupService/UpdateAccessBindings](../../api-ref/grpc/DesktopGroup/updateAccessBindings.md) gRPC API call.

{% endlist %}
