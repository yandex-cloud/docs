# Работа с механизмом логирования действий с бакетом

Чтобы отслеживать работу с [бакетом](../../concepts/bucket.md), включите [механизм логирования](../../concepts/server-logs.md). Подробная информация о запросах к _исходному_ бакету будет сохранена в [объекте](../../concepts/object.md) в _целевом_ бакете. Однако {{ objstorage-name }} [не гарантирует](../../concepts/server-logs.md) полноту и своевременность записи логов.

По умолчанию механизм логирования отключен. После его включения, {{ objstorage-name }} будет записывать информацию о действиях с бакетом раз в час.

## Включите механизм логирования {#enable}

Чтобы логировать обращения к бакету:

1. Используйте существующий или создайте новый целевой бакет с именем, например,`bucket-logs`. В этот бакет будут записываться логи.

   {% cut "Как создать бакет" %}

   {% include [create-bucket](../../../_includes/storage/create-bucket.md) %}

   {% endcut %}

1. Включите механизм логирования в исходном бакете, который вы хотите отслеживать.

   {% list tabs %}

   - API

     Отправьте запрос методом [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md).

     Пример тела HTTP-запроса:

     ```xml
     <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
       <LoggingEnabled>
         <TargetBucket>bucket-logs</TargetBucket>
         <TargetPrefix>logs/</TargetPrefix>
       </LoggingEnabled>
     </BucketLoggingStatus>
     ```

     Где:

     * `<TargetBucket>` – имя целевого бакета;
     * `<TargetPrefix>` – префикс, который будет использоваться со всеми [ключами](../../concepts/object.md#key) объектов с логами. Должен заканчиваться знаком `/`, например, `logs/`. Необязательный параметр.

   {% endlist %}

## Получите настройки логирования {#get-settings}

Чтобы получить имя целевого бакета и префикс ключа объекта с логами, выполните следующее действие:

{% list tabs %}

- API

  Отправьте запрос методом [getBucketLogging](../../s3/api-ref/bucket/getBucketLogging.md).

  Пример тела HTTP-ответа:

  ```xml
  HTTP/1.1 200
  <?xml version="1.0" encoding="UTF-8"?>
  <BucketLoggingStatus>
     <LoggingEnabled>
        <TargetBucket>bucket-logs</TargetBucket>
        <TargetPrefix>logs/</TargetPrefix>
     </LoggingEnabled>
  </BucketLoggingStatus>
  ```

{% endlist %}

## Получите логи {#get-logs}

Чтобы получить логи, скачайте из бакета `bucket-logs` объект с префиксом `logs/`:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где находится бакет `bucket-logs`.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите на имя бакета `bucket-logs`.
  1. Нажмите на имя объекта с префиксом `logs/`.
  1. Нажмите кнопку **Скачать**.

{% endlist %}

## Выключить механизм логирования {#stop-logging}

Чтобы выключить логирование, выполните следующее действие:

{% list tabs %}

- API

  Отправьте запрос методом [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md). В теле запроса передайте параметр `<BucketLoggingStatus>` с пустым значением.

  Пример тела HTTP-запроса:

  ```xml
  <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01" />
  ```

{% endlist %}
