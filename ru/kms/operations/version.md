# Управление версиями ключа

Версии ключей можно делать основными (основная версия ключа по умолчанию используется для шифрования и расшифрования) и удалять. Чтобы создать новую версию ключа, [ротируйте](key.md#rotate) его.

## Сделать версию основной {#make-primary}

Чтобы сделать версию основной:

{% list tabs %}

- Консоль управления

  1. Войдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ kms-name }}**.
  1. На панели слева выберите **Симметричные ключи**.
  1. Нажмите на нужный ключ в списке, чтобы открыть страницу с его атрибутами.
  1. Нажмите значок ![menu](../../_assets/horizontal-ellipsis.svg) в строке нужной версии и выберите пункт меню **Сделать основной**.

- CLI

  1. Получите список версий нужного ключа:

     ```
     yc kms symmetric-key list-versions example-key
     ```
	 
	 Результат:
	 
	 ```
     +----------------------+---------+--------+-----------+
     |          ID          | PRIMARY | STATUS | ALGORITHM |
     +----------------------+---------+--------+-----------+
     | abjhduu82ao0r0tkjlp2 | true    | ACTIVE | AES_128   |
     | abj8cvn99nam26f0f4a3 | false   | ACTIVE | AES_128   |
     | abjed9ciau8eatb0pg93 | false   | ACTIVE | AES_256   |
     | abjvejjvfktqc4hsqpss | false   | ACTIVE | AES_128   |
     +----------------------+---------+--------+-----------+
     ```

  1. Смените версию ключа, указав идентификатор нужной версии:

     ```
     yc kms symmetric-key set-primary-version example-key-1 \
       --version-id abj8cvn99nam26f0f4a3
     ```

- API

  Воспользуйтесь методом REST API [setPrimaryVersion](../../kms/api-ref/SymmetricKey/setPrimaryVersion.md) для ресурса [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/SetPrimaryVersion](../../kms/api-ref/grpc/symmetric_key_service.md#SetPrimaryVersion).

{% endlist %}

При следующем запросе на шифрование или расшифрование, в котором не указана конкретная версия ключа, будет использована новая основная версия.

## Удалить версию ключа {#delete}

Удалить версию сразу невозможно: вы можете только запланировать удаление, как минимум на следующий день.

{% note alert %}

Когда наступает срок удаления, версия ключа удаляется безвозвратно: если у вас остались зашифрованные с помощью этой версии данные, расшифровать их будет невозможно.

{% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы удалить версию:

  1. Войдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ kms-name }}**.
  1. На панели слева выберите **Симметричные ключи**.
  1. Нажмите на нужный ключ в списке, чтобы открыть страницу с его атрибутами.
  1. Нажмите значок ![menu](../../_assets/horizontal-ellipsis.svg) в строке нужной версии и выберите пункт меню **Запланировать удаление**.

  Версия перейдет в статус `Scheduled for destruction`, а в столбце **Дата удаления** будет указан срок, на который запланировано удаление.

- CLI

  Чтобы удалить версию:

  1. Получите список версий нужного ключа:

     ```
     yc kms symmetric-key list-versions example-key
	 ```
	 
	 Результат:
	 
	 ```
     +----------------------+---------+--------+-----------+
     |          ID          | PRIMARY | STATUS | ALGORITHM |
     +----------------------+---------+--------+-----------+
     | abj8cvn99nam26f0f4a3 | true    | ACTIVE | AES_128   |
     | abjed9ciau8eatb0pg93 | false   | ACTIVE | AES_256   |
     | abjhduu82ao0r0tkjlp2 | false   | ACTIVE | AES_128   |
     | abjvejjvfktqc4hsqpss | false   | ACTIVE | AES_128   |
     +----------------------+---------+--------+-----------+
     ```

  1. Запланируйте удаление нужной версии:

     ```
     yc kms symmetric-key schedule-version-destruction example-key \
       --version-id abjed9ciau8eatb0pg93
     ```

     Версия перейдет в статус `SCHEDULED_FOR_DESTRUCTION`, а в поле `destroy_at` будет указано время, на которое запланировано удаление.

- API

  Воспользуйтесь методом REST API [scheduleVersionDestruction](../../kms/api-ref/SymmetricKey/scheduleVersionDestruction.md) для ресурса [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/ScheduleVersionDestruction](../../kms/api-ref/grpc/symmetric_key_service.md#ScheduleVersionDestruction).

{% endlist %}

## Отменить удаление версии {#cancel-delete}

Если вы запланировали удаление версии ключа, то до запланированной даты вы можете отменить удаление:

{% list tabs %}

- Консоль управления

  1. Войдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ kms-name }}**.
  1. На панели слева выберите **Симметричные ключи**.
  1. Нажмите на нужный ключ в списке, чтобы открыть страницу с его атрибутами.
  1. Нажмите значок ![menu](../../_assets/horizontal-ellipsis.svg) в строке нужной версии и выберите пункт меню **Отменить удаление**.
  
  Версия вернется в статус `Active`.

- CLI

  1. Получите список версий нужного ключа:

     ```
     yc kms symmetric-key list-versions example-key
	 ```
	 
	 Результат:
	 
	 ```
     +----------------------+---------+---------------------------+-----------+
     |          ID          | PRIMARY |          STATUS           | ALGORITHM |
     +----------------------+---------+---------------------------+-----------+
     | abj8cvn99nam26f0f4a3 | true    | ACTIVE                    | AES_128   |
     | abjed9ciau8eatb0pg93 | false   | SCHEDULED_FOR_DESTRUCTION | AES_256   |
     | abjhduu82ao0r0tkjlp2 | false   | ACTIVE                    | AES_128   |
     | abjvejjvfktqc4hsqpss | false   | ACTIVE                    | AES_128   |
     +----------------------+---------+---------------------------+-----------+
     ```

  1. Отмените удаление нужной версии:

     ```
     yc kms symmetric-key cancel-version-destruction example-key \
       --version-id abjed9ciau8eatb0pg93
     ```

     Версия вернется в статус `ACTIVE`.

- API

  Воспользуйтесь методом REST API [cancelVersionDestruction](../../kms/api-ref/SymmetricKey/cancelVersionDestruction.md) для ресурса [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/CancelVersionDestruction](../../kms/api-ref/grpc/symmetric_key_service.md#CancelVersionDestruction).

{% endlist %}




