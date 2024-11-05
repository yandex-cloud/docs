---
title: Инструкция по удалению рабочего стола в {{ cloud-desktop-full-name }}
description: Из статьи вы узнаете, как удалить рабочий стол в {{ cloud-desktop-full-name }}.
---

# Удалить рабочий стол

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен рабочий стол.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Справа от рабочего стола, который вы хотите удалить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.

      {% note tip %}

      Чтобы удалить несколько рабочих столов, выделите их в списке и нажмите кнопку **{{ ui-key.yacloud.common.delete }}** в нижней части экрана.

      {% endnote %}

  1. Подтвердите удаление.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/index.yaml) для удаления [рабочего стола](../../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops desktop delete --help
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
      | e3vio1bc5ppz******** | reserved-desktop | ACTIVE | e3v1rbln45tl******** | 2024-10-09 21:35:17 |
      +----------------------+------------------+--------+----------------------+---------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного рабочего стола, например `my-cloud-desktop`.
  1. Удалите рабочий стол:

      ```bash
      yc desktops desktop delete <имя_или_идентификатор_рабочего_стола>
      ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/Desktop/delete.md) для ресурса [Desktop](../../api-ref/Desktop/index.md) или вызовом gRPC API [DesktopService/Delete](../../api-ref/grpc/Desktop/delete.md).

{% endlist %}
