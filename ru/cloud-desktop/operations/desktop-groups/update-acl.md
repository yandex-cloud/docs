---
title: Инструкция по изменению прав доступа к группе рабочих столов в {{ cloud-desktop-full-name }}
description: Из статьи вы узнаете, как изменить права доступа к группе рабочих столов в {{ cloud-desktop-full-name }}.
---

# Изменить права доступа к группе рабочих столов

{% include [access-options](../../../_includes/cloud-desktop/access-options.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположена группа рабочих столов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Справа от группы рабочих столов, к которой вы хотите изменить права доступа, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Настроить ACL**.
  1. В появившемся окне **{{ ui-key.yacloud.component.acl-dialog.label_title }}** выдайте или отзовите необходимые разрешения.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% note alert %}

  Команда `set-access-bindings` полностью перезаписывает права доступа к группе рабочих столов. Все текущие роли на группу будут удалены.

  {% endnote %}

  1. Убедитесь, что на группу рабочих столов не назначены роли, которые вы не хотите потерять:

     ```bash
     yc desktops group list-access-bindings <имя_или_идентификатор_группы_рабочих_столов>
     ```

  1. Посмотрите описание команды CLI для назначения ролей на группу рабочих столов:

     ```bash
     yc desktops group set-access-bindings --help
     ```

  1. Назначьте роли:

      ```bash
      yc desktops group set-access-bindings <имя_или_идентификатор_группы_рабочих_столов> \
        --access-binding role=<роль>,<тип_субъекта>=<идентификатор_субъекта> \
        --access-binding role=<роль>,<тип_субъекта>=<идентификатор_субъекта>
      ```

      Где `--access-binding` — параметры для установки прав доступа:

      * `role` — назначаемая [роль](../../security/index.md#roles-list).
      * `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

      Например, назначьте роли нескольким пользователям и сервисному аккаунту:

      ```bash
      yc desktops group set-access-bindings my-desktop-group \
        --access-binding role=editor,userAccount=gfei8n54hmfh******** \
        --access-binding role=viewer,userAccount=helj89sfj80a******** \
        --access-binding role=editor,serviceAccount=ajel6l0jcb9s********
      ```

      Чтобы назначить роль субъекту без перезаписи остальных ролей, используйте [команду](../../../cli/cli-ref/desktops/cli-ref/group/add-access-bindings.md) `yc desktops group add-access-bindings`. Например, чтобы назначить роль сервисному аккаунту:

      ```bash
      yc desktops group add-access-bindings \
        --name <имя_группы_рабочих_столов> \
        --role <роль> \
        --service-account-name <имя_сервисного_аккаунта>
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/DesktopGroup/updateAccessBindings.md) для ресурса [DesktopGroup](../../api-ref/DesktopGroup/index.md) или вызовом gRPC API [DesktopGroupService/UpdateAccessBindings](../../api-ref/grpc/DesktopGroup/updateAccessBindings.md).

{% endlist %}
