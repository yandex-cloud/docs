[Документация Yandex Cloud](../../../../index.md) > [Yandex Serverless Integrations](../../../index.md) > [Пошаговые инструкции](../../index.md) > EventRouter > Управление правами доступа к ресурсам > Посмотреть роли, назначенные на ресурс

# Посмотреть роли, назначенные на ресурс EventRouter

{% note info %}

Роли, назначенные на каталог, облако или организацию, автоматически [наследуются](../../../../iam/concepts/access-control/index.md#inheritance) ресурсами EventRouter. При этом они не отображаются в списке ролей, назначенных на них. Подробнее о [просмотре ролей](../../../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы посмотреть роли, назначенные на ресурс EventRouter, выполните команду:

  ```bash
  yc serverless <тип_ресурса> list-access-bindings <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Посмотреть роли, назначенные на [шину](../../../concepts/eventrouter/bus.md):

  ```bash
  yc serverless eventrouter bus list-access-bindings epdplu8jn7sr********
  ```

  Результат:

  ```text
  +---------------------------------+----------------+----------------------+
  |             ROLE ID             |  SUBJECT TYPE  |      SUBJECT ID      |
  +---------------------------------+----------------+----------------------+
  | serverless.eventrouter.admin    | serviceAccount | ajef2lm8ahpc******** |
  | serverless.eventrouter.auditor  | serviceAccount | rrbilgiqaptv******** |
  +---------------------------------+----------------+----------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API `listAccessBindings` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListAccessBindings`.

  Например, для [шины](../../../concepts/eventrouter/bus.md) воспользуйтесь методом REST API [listAccessBindings](../../../eventrouter/api-ref/Bus/listAccessBindings.md) для ресурса [Bus](../../../eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [BusService/ListAccessBindings](../../../eventrouter/api-ref/grpc/Bus/listAccessBindings.md).

{% endlist %}