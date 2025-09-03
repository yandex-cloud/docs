# Updating a desktop

{% include [updating-group-disclaimer](../../../_includes/cloud-desktop/updating-group-disclaimer.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the desktop.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Next to the desktop you want to update, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.button_update }}**.
  1. Confirm the update.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../../cli/index.yaml) command for updating a [desktop](../../concepts/desktops-and-groups.md):

      ```bash
      yc desktops desktop update --help
      ```

  1. Get a list of desktops in the default folder:

      ```bash
      yc desktops desktop list
      ```

      Result:

      ```bash
      +----------------------+------------------+--------+----------------------+---------------------+
      |          ID          |       NAME       | STATUS |   DESKTOP GROUP ID   |   CREATED (UTC-0)   |
      +----------------------+------------------+--------+----------------------+---------------------+
      | e3vmvhgbgac4******** | my-cloud-desktop | ACTIVE | e3v1rbln45tl******** | 2024-10-09 22:42:28 |
      | e3vio1bc5ppz******** | reserved-desktop | ACTIVE | e3v9om0ur4rl******** | 2024-10-09 21:35:17 |
      +----------------------+------------------+--------+----------------------+---------------------+
      ```

  1. Select the `ID` or `NAME` of the desktop you need, e.g., `my-cloud-desktop`.
  1. Update the desktop:

      ```bash
      yc desktops desktop update --name <desktop_name>
      ```

      Result:

      ```text
      id: e3vmvhgbgac4********
      folder_id: b1g681qpemb4********
      desktop_group_id: e3v1rbln45tl********
      created_at: "2024-10-09T22:42:28.020Z"
      status: UPDATING
      name: my-cloud-desktop
      resources:
        memory: "4294967296"
        cores: "2"
        core_fraction: "100"
      network_interfaces:
        - network_id: enp0asmd9pr9********
          subnet_id: e2lb1da2dd9v********
      users:
        - subject_id: ajej2i98kcjd********
      ```

{% endlist %}

Once the desktop is updated, [reset the user password](password-reset.md).