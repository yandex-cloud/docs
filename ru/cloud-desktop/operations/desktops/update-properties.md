---
title: Изменить рабочий стол {{ cloud-desktop-full-name }}
description: Следуя данной инструкции, вы сможете изменить параметры рабочего стола {{ cloud-desktop-name }}.
---

# Изменить рабочий стол

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/index.yaml) для изменения [рабочего стола](../../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops desktop update-properties --help
      ```

  1. Получите список рабочих столов в каталоге по умолчанию:

      ```bash
      yc desktops desktop list
      ```

      Результат:

      ```bash
      +----------------------+------------------+--------+----------------------+---------------------+
      |          ID          |       NAME       | STATUS |   DESKTOP GROUP ID   |   CREATED (UTC-0)   |
      +----------------------+------------------+--------+----------------------+---------------------+
      | e3vmvhgbgac4******** | my-cloud-desktop | ACTIVE | e3v1rbln45tl******** | 2024-10-09 22:42:28 |
      | e3vio1bc5ppz******** | reserved-desktop | ACTIVE | e3v9om0ur4rl******** | 2024-10-09 21:35:17 |
      +----------------------+------------------+--------+----------------------+---------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного рабочего стола, например `my-cloud-desktop`.
  1. Измените параметры рабочего стола, например, имя:

      ```bash
      yc desktops desktop update-properties \
        --name <имя_рабочего_стола> \
        --new-name <новое_имя_рабочего_стола>
      ```

      Результат:

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