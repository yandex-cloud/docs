---
title: Изменить группу рабочих столов
description: Следуя данной инструкции, вы сможете изменить группу рабочих столов.
---

# Изменить группу рабочих столов

{% include [updating-group-disclaimer](../../../_includes/cloud-desktop/updating-group-disclaimer.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится группа рабочих столов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Напротив группы, которую нужно изменить, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Выберите **{{ ui-key.yacloud.vdi.section_type }}**: **{{ ui-key.yacloud.vdi.value_type-personal }}** или **{{ ui-key.yacloud.vdi.value_type-session }}**.
  1. В блоке **{{ ui-key.yacloud.vdi.section_desktop }}** измените значения:
     1. **{{ ui-key.yacloud.vdi.field_max-desktops-amount }}** — максимальное количество рабочих столов в группе.
     1. **{{ ui-key.yacloud.vdi.field_min-ready-desktops }}** — количество рабочих столов, которые будут всегда загружены для быстрого подключения пользователей.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** измените конфигурацию рабочих столов.
  1. Выберите [образ](../../concepts/images.md) операционной системы.
  1. В блоке **{{ ui-key.yacloud.vdi.section_disks }}** увеличьте размер рабочего диска.
  1. В блоке **Пользователи рабочих столов** нажмите **Добавить пользователей** и укажите, кому будут доступны рабочие столы:
     * [Группы пользователей](../../../iam/concepts/access-control/public-group.md).
     * [Отдельные пользователи](../../../iam/concepts/users/accounts.md).
     * Почтовый адрес любого пользователя — ему будет отправлено приглашение в вашу организацию и назначена роль для доступа к рабочим столам.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/index.yaml) для изменения [группы рабочих столов](../../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops group update --help
      ```

  1. Получите список рабочих столов в каталоге по умолчанию:

      ```bash
      yc desktops group list
      ```

      Результат:

      ```bash
      +----------------------+-----------------+--------+---------------------+
      |          ID          |      NAME       | STATUS |   CREATED (UTC-0)   |
      +----------------------+-----------------+--------+---------------------+
      | e3v9om0ur4rl******** | desktop-group-1 | ACTIVE | 2025-08-13 13:01:44 |
      | e3vrquks6c8u******** | desktop-group-2 | ACTIVE | 2025-08-14 06:21:16 |
      +----------------------+-----------------+--------+---------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы рабочих столов, например `desktop-group-1`.
  1. Измените параметры группы рабочих столов, например, имя:

      ```bash
      yc desktops group update \
        --name <имя_группы_рабочих_столов> \
        --new-name <новое_имя_группы_рабочих_столов>
      ```

{% endlist %}
