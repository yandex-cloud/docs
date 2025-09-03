---
title: Updating a desktop group
description: In this tutorial, we will update a desktop group.
---

# Updating a desktop group

{% include [updating-group-disclaimer](../../../_includes/cloud-desktop/updating-group-disclaimer.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your desktop group.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Next to the desktop group you want to update, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Select the **{{ ui-key.yacloud.vdi.section_type }}**: **{{ ui-key.yacloud.vdi.value_type-personal }}** or **{{ ui-key.yacloud.vdi.value_type-session }}**.
  1. Under **{{ ui-key.yacloud.vdi.section_desktop }}**, change these values:
     1. **{{ ui-key.yacloud.vdi.field_max-desktops-amount }}**: Maximum number of desktops in the group.
     1. **{{ ui-key.yacloud.vdi.field_min-ready-desktops }}**: Number of desktops kept always loaded for quick user access.
  1. Change the desktop configuration under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**.
  1. Select an OS [image](../../concepts/images.md).
  1. Under **{{ ui-key.yacloud.vdi.section_disks }}**, increase the data disk size.
  1. Under **Desktop users**, click **Add users** and specify those the desktops will be available to:
     * [User groups](../../../iam/concepts/access-control/public-group.md).
     * [Individual users](../../../iam/concepts/users/accounts.md).
     * Any user's mail address. The user will be sent an invitation to your organization and assigned a role for desktop access.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/index.yaml) command for [updating a desktop group](../../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops group update --help
      ```

  1. Get a list of desktops in the default folder:

      ```bash
      yc desktops group list
      ```

      Result:

      ```bash
      +----------------------+-----------------+--------+---------------------+
      |          ID          |      NAME       | STATUS |   CREATED (UTC-0)   |
      +----------------------+-----------------+--------+---------------------+
      | e3v9om0ur4rl******** | desktop-group-1 | ACTIVE | 2025-08-13 13:01:44 |
      | e3vrquks6c8u******** | desktop-group-2 | ACTIVE | 2025-08-14 06:21:16 |
      +----------------------+-----------------+--------+---------------------+
      ```

  1. Select the desktop group `ID` or `NAME`, e.g., `desktop-group-1`.
  1. Update desktop group parameters, e.g., its name:

      ```bash
      yc desktops group update \
        --name <desktop_group_name> \
        --new-name <new_desktop_group_name>
      ```

{% endlist %}
