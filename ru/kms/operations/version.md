# Управление версиями ключа

Версии ключей можно делать основными (основная версия ключа по умолчанию используется для шифрования и расшифрования) и удалять. Чтобы создать новую версию ключа, [ротируйте](key.md#rotate) его.

## Сделать версию основной {#make-primary}

Чтобы сделать версию основной:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Нажмите на нужный ключ в списке, чтобы открыть страницу с его атрибутами.
  1. В строке нужной версии нажмите значок ![menu](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.kms.symmetric-key.overview.button_action-set-primary }}**.

- CLI {#cli}

  1. Получите список версий нужного ключа:

     ```bash
     yc kms symmetric-key list-versions example-key
     ```

     Результат:

     ```text
     +----------------------+---------+--------+-----------+
     |          ID          | PRIMARY | STATUS | ALGORITHM |
     +----------------------+---------+--------+-----------+
     | abjhduu82ao0******** | true    | ACTIVE | AES_128   |
     | abj8cvn99nam******** | false   | ACTIVE | AES_128   |
     | abjed9ciau8e******** | false   | ACTIVE | AES_256   |
     | abjvejjvfktq******** | false   | ACTIVE | AES_128   |
     +----------------------+---------+--------+-----------+
     ```

  1. Смените версию ключа, указав идентификатор нужной версии:

     ```bash
     yc kms symmetric-key set-primary-version example-key-1 \
       --version-id abj8cvn99nam********
     ```

- API {#api}

  Воспользуйтесь методом REST API [setPrimaryVersion](../../kms/api-ref/SymmetricKey/setPrimaryVersion.md) для ресурса [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/SetPrimaryVersion](../../kms/api-ref/grpc/SymmetricKey/setPrimaryVersion.md).

{% endlist %}

При следующем запросе на шифрование или расшифрование, в котором не указана конкретная версия ключа, будет использована новая основная версия.

## Удалить версию ключа {#delete}

Удалить версию сразу невозможно: вы можете только запланировать удаление, как минимум на следующий день.

{% note alert %}

Когда наступает срок удаления, версия ключа удаляется безвозвратно: если у вас остались зашифрованные с помощью этой версии данные, расшифровать их будет невозможно.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить версию:

  1. Войдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Нажмите на нужный ключ в списке, чтобы открыть страницу с его атрибутами.
  1. В строке нужной версии нажмите значок ![menu](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.kms.symmetric-key.overview.button_action-schedule-destruction }}**.

  Версия перейдет в статус `Scheduled for destruction`, а в столбце **{{ ui-key.yacloud.kms.symmetric-key.overview.column_version-destroy }}** будет указан срок, на который запланировано удаление.

- CLI {#cli}

  Чтобы удалить версию:

  1. Получите список версий нужного ключа:

     ```bash
     yc kms symmetric-key list-versions example-key
     ```

     Результат:

     ```text
     +----------------------+---------+--------+-----------+
     |          ID          | PRIMARY | STATUS | ALGORITHM |
     +----------------------+---------+--------+-----------+
     | abj8cvn99nam******** | true    | ACTIVE | AES_128   |
     | abjed9ciau8e******** | false   | ACTIVE | AES_256   |
     | abjhduu82ao0******** | false   | ACTIVE | AES_128   |
     | abjvejjvfktq******** | false   | ACTIVE | AES_128   |
     +----------------------+---------+--------+-----------+
     ```

  1. Запланируйте удаление нужной версии:

     ```bash
     yc kms symmetric-key schedule-version-destruction example-key \
       --version-id abjed9ciau8e********
     ```

     Версия перейдет в статус `SCHEDULED_FOR_DESTRUCTION`, а в поле `destroy_at` будет указано время, на которое запланировано удаление.

- API {#api}

  Воспользуйтесь методом REST API [scheduleVersionDestruction](../../kms/api-ref/SymmetricKey/scheduleVersionDestruction.md) для ресурса [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/ScheduleVersionDestruction](../../kms/api-ref/grpc/SymmetricKey/scheduleVersionDestruction.md).

{% endlist %}

## Отменить удаление версии {#cancel-delete}

Если вы запланировали удаление версии ключа, то до запланированной даты вы можете отменить удаление:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Нажмите на нужный ключ в списке, чтобы открыть страницу с его атрибутами.
  1. В строке нужной версии нажмите значок ![menu](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.kms.symmetric-key.overview.button_action-cancel-destruction }}**.
  
  Версия вернется в статус `Active`.

- CLI {#cli}

  1. Получите список версий нужного ключа:

     ```bash
     yc kms symmetric-key list-versions example-key
     ```

     Результат:

     ```text
     +----------------------+---------+---------------------------+-----------+
     |          ID          | PRIMARY |          STATUS           | ALGORITHM |
     +----------------------+---------+---------------------------+-----------+
     | abj8cvn99nam******** | true    | ACTIVE                    | AES_128   |
     | abjed9ciau8e******** | false   | SCHEDULED_FOR_DESTRUCTION | AES_256   |
     | abjhduu82ao0******** | false   | ACTIVE                    | AES_128   |
     | abjvejjvfktq******** | false   | ACTIVE                    | AES_128   |
     +----------------------+---------+---------------------------+-----------+
     ```

  1. Отмените удаление нужной версии:

     ```bash
     yc kms symmetric-key cancel-version-destruction example-key \
       --version-id abjed9ciau8e********
     ```

     Версия вернется в статус `ACTIVE`.

- API {#api}

  Воспользуйтесь методом REST API [cancelVersionDestruction](../../kms/api-ref/SymmetricKey/cancelVersionDestruction.md) для ресурса [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/CancelVersionDestruction](../../kms/api-ref/grpc/SymmetricKey/cancelVersionDestruction.md).

{% endlist %}




