[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Desktop](../../index.md) > [Пошаговые инструкции](../index.md) > Группы рабочих столов > Изменить права доступа к группе рабочих столов

# Изменить права доступа к группе рабочих столов

В Cloud Desktop управление доступом реализовано с помощью [разграничения ролей Yandex Identity and Access Management](../../security/index.md) и [списков управления доступом (ACL)](../../concepts/acl.md). [Пример использования механизмов доступа](../../concepts/acl.md#example).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором расположена группа рабочих столов.
  1. Перейдите в сервис **Cloud Desktop**.
  1. Выберите группу рабочих столов, к которой хотите изменить права доступа.
  1. На панели слева выберите ![persons](../../../_assets/console-icons/persons.svg) **Права доступа**.
  1. Нажмите **Назначить роли**.
  1. В открывшемся окне **Выдача доступа** выдайте или отзовите необходимые разрешения.
  1. Нажмите кнопку **Сохранить**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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