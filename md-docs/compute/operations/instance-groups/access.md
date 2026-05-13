# Настроить права доступа к группе виртуальных машин

Чтобы предоставить пользователю, группе или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) доступ к [группе виртуальных машин](../../concepts/instance-groups/index.md), назначьте [роль](../../../iam/concepts/access-control/roles.md) на нее.

## Назначить роль {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится группа ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Выберите нужную группу.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к группе ВМ.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для назначения роли на группу ВМ:

     ```bash
     yc compute instance-group add-access-binding --help
     ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

     ```bash
     yc compute instance-group list
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+--------+------+
     |          ID          |          NAME        | STATUS | SIZE |
     +----------------------+----------------------+--------+------+
     | cl15b3mrkk88******** | first-instance-group | ACTIVE |    3 |
     +----------------------+----------------------+--------+------+
     ```

  1. Посмотрите список ролей, которые уже назначены на ресурс:

     ```bash
     yc compute instance-group list-access-bindings <имя_или_идентификатор_группы_ВМ>
     ```

  1. Назначьте роль с помощью команды:

     * Пользователю:

       ```bash
       yc compute instance-group add-access-binding <имя_или_идентификатор_группы_ВМ> \
         --user-account-id <идентификатор_пользователя> \
         --role <роль>
       ```

       Где:

       * `--user-account-id` — [идентификатор пользователя](../../../organization/operations/users-get.md).
       * `--role` — назначаемая [роль](../../security/index.md#roles-list).

     * Сервисному аккаунту:

       ```bash
       yc compute instance-group add-access-binding <имя_или_идентификатор_группы_ВМ> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --role <роль>
       ```

       Где:

       * `--service-account-id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md).
       * `--role` — назначаемая роль.

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../instancegroup/api-ref/InstanceGroup/updateAccessBindings.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/UpdateAccessBindings](../../instancegroup/api-ref/grpc/InstanceGroup/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}

## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится группа ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Выберите нужную группу.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к группе ВМ.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Добавьте еще роль через кнопку **Добавить роль**.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% note alert %}
  
  Команда `set-access-bindings` полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

     ```bash
     yc compute instance-group list-access-bindings <имя_или_идентификатор_группы_ВМ>
     ```

  1. Посмотрите описание команды CLI для назначения ролей на группу ВМ:

     ```bash
     yc compute instance-group set-access-bindings --help
     ```

  1. Назначьте роли:

     ```bash
     yc compute instance-group set-access-bindings <имя_или_идентификатор_группы_ВМ> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--access-binding` — назначаемая роль:

       * `role` — идентификатор назначаемой роли.
       * `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

     Например, назначьте роли нескольким пользователям и сервисному аккаунту:

     ```bash
     yc compute instance-group set-access-bindings test-group \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
       --access-binding role=viewer,subject=userAccount:helj89sfj80a******** \
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- API {#api}

  Воспользуйтесь методом REST API [setAccessBindings](../../instancegroup/api-ref/InstanceGroup/setAccessBindings.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/SetAccessBindings](../../instancegroup/api-ref/grpc/InstanceGroup/setAccessBindings.md).

{% endlist %}

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится группа ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Выберите нужную группу.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **Права доступа**.
  1. В строке нужного пользователя нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите **Изменить роли**.
  1. Нажмите значок ![cross](../../../_assets/console-icons/xmark.svg) рядом с ролью, чтобы удалить ее.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для отзыва роли на группу ВМ:

     ```bash
     yc compute instance-group remove-access-binding --help
     ```

  1. Посмотрите, кому и какие роли назначены на ресурс:

     ```bash
     yc compute instance-group list-access-bindings <имя_или_идентификатор_группы_ВМ>
     ```

  1. Чтобы отозвать права доступа, выполните команду:

     ```bash
     yc compute instance-group remove-access-binding <имя_или_идентификатор_группы_ВМ> \
       --role <идентификатор_роли> \
       --subject <тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--role` — идентификатор роли, которую надо отозвать.
     * `--subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

     Например, чтобы отозвать роль `viewer` у пользователя с идентификатором `ajel6l0jcb9s********` на группу ВМ:

     ```bash
     yc compute instance-group remove-access-binding test-group \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../instancegroup/api-ref/InstanceGroup/updateAccessBindings.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/UpdateAccessBindings](../../instancegroup/api-ref/grpc/InstanceGroup/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}