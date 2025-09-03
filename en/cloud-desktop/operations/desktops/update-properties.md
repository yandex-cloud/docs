---
title: Updating a {{ cloud-desktop-full-name }} desktop
description: In this tutorial, you will learn how to update the {{ cloud-desktop-name }} desktop parameters.
---

# Updating a desktop

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../../cli/index.yaml) command for updating a [desktop](../../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops desktop update-properties --help
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
  1. Update desktop parameters, e.g., name:

      ```bash
      yc desktops desktop update-properties \
        --name <desktop_name> \
        --new-name <new_desktop_name>
      ```

      Result:

      ```text
      id: e3vmvhgbgac4********
      folder_id: b1g681qpemb4********
      desktop_group_id: e3v1rbln45tl********
      created_at: "2024-10-09T22:42:28.020Z"
      status: ACTIVE
      name: renamed-cloud-desktop
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