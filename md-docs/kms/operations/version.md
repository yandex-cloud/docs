[Документация Yandex Cloud](../../index.md) > [Yandex Key Management Service](../index.md) > [Пошаговые инструкции](index.md) > Симметричное шифрование > Версия ключа

# Управление версиями ключа

Версии ключей можно делать основными (основная версия ключа по умолчанию используется для шифрования и расшифрования) и удалять. Чтобы создать новую версию ключа, [ротируйте](key.md#rotate) его.

## Сделать версию основной {#make-primary}

{% note info %}

Изменение основной версии ключа относится к [eventually consistent](../concepts/consistency.md) операциям. Изменения, вызванные такими операциями, вступают в силу с задержкой до трех часов.

{% endnote %}

Чтобы сделать версию основной:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Key Management Service**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **Симметричные ключи**.
  1. Нажмите на нужный ключ в списке, чтобы открыть страницу с его атрибутами.
  1. В строке нужной версии нажмите значок ![menu](../../_assets/console-icons/ellipsis.svg) и выберите **Сделать основной**.

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

  Воспользуйтесь методом REST API [setPrimaryVersion](../api-ref/SymmetricKey/setPrimaryVersion.md) для ресурса [SymmetricKey](../api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/SetPrimaryVersion](../api-ref/grpc/SymmetricKey/setPrimaryVersion.md).

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

  1. Войдите в [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Key Management Service**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **Симметричные ключи**.
  1. Нажмите на нужный ключ в списке, чтобы открыть страницу с его атрибутами.
  1. В строке нужной версии нажмите значок ![menu](../../_assets/console-icons/ellipsis.svg) и выберите **Запланировать удаление**.

  Версия перейдет в статус `Scheduled for destruction`, а в столбце **Дата удаления** будет указан срок, на который запланировано удаление.

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

  Воспользуйтесь методом REST API [scheduleVersionDestruction](../api-ref/SymmetricKey/scheduleVersionDestruction.md) для ресурса [SymmetricKey](../api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/ScheduleVersionDestruction](../api-ref/grpc/SymmetricKey/scheduleVersionDestruction.md).

{% endlist %}

{% note info %}

Планирование удаления версии ключа относится к [eventually consistent](../concepts/consistency.md) операциям. Изменения, вызванные такими операциями, вступают в силу с задержкой до трех часов.

{% endnote %}

## Отменить удаление версии {#cancel-delete}

Если вы запланировали удаление версии ключа, то до запланированной даты вы можете отменить удаление:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Key Management Service**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **Симметричные ключи**.
  1. Нажмите на нужный ключ в списке, чтобы открыть страницу с его атрибутами.
  1. В строке нужной версии нажмите значок ![menu](../../_assets/console-icons/ellipsis.svg) и выберите **Отменить удаление**.
  
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

  Воспользуйтесь методом REST API [cancelVersionDestruction](../api-ref/SymmetricKey/cancelVersionDestruction.md) для ресурса [SymmetricKey](../api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/CancelVersionDestruction](../api-ref/grpc/SymmetricKey/cancelVersionDestruction.md).

{% endlist %}