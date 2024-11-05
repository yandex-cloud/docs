---
title: Инструкция по удалению группы рабочих столов в {{ cloud-desktop-full-name }}
description: Из статьи вы узнаете, как удалить группу рабочих столов в {{ cloud-desktop-full-name }}.
---

# Удалить группу рабочих столов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположена группа рабочих столов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Справа от группы рабочих столов, которую вы хотите удалить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  
      {% note tip %}

      Чтобы удалить несколько групп рабочих столов, выделите их в списке и нажмите кнопку **{{ ui-key.yacloud.common.delete }}** в нижней части экрана.

      {% endnote %}

  1. Подтвердите удаление.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/index.yaml) для удаления [группы рабочих столов](../../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops group delete --help
      ```

  1. Получите список групп рабочих столов в каталоге по умолчанию:

      {% include [desktops-group-list](../../../_includes/cloud-desktop/desktops-group-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы рабочих столов, например `my-desktop-group`.
  1. Удалите группу рабочих столов:

     ```bash
     yc desktops group delete <имя_или_идентификатор_группы_рабочих_столов>
     ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/DesktopGroup/delete.md) для ресурса [DesktopGroup](../../api-ref/DesktopGroup/index.md) или вызовом gRPC API [DesktopGroupService/Delete](../../api-ref/grpc/DesktopGroup/delete.md).

{% endlist %}