# Настройка выгрузки логов

[Выгрузка логов](../../concepts/logs.md) — платная функция, о ее тарификации в разделе [Правила тарификации для Yandex Cloud CDN](../../pricing.md).

Описание полей в выгружаемых логах в разделе [Справочник логов запросов](../../logs-ref.md).

{% note warning %}

Возможна задержка при выгрузке логов.

{% endnote %}

## Включение выгрузки {#enabling}

Чтобы включить выгрузку для [ресурса](../../concepts/resource.md):

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором расположен ресурс.

  1. Перейдите в сервис **Cloud CDN**.

  1. Нажмите на имя необходимого ресурса.

  1. Перейдите на вкладку **Выгрузка логов**.

  1. В правом верхнем углу нажмите **Включить**.

  1. Выберите **Бакет**.

  1. (Опционально) Укажите **Префикс** для имен файлов с логами.

  1. Нажмите кнопку **Включить**.

- API {#api}

  Воспользуйтесь методом REST API [activate](../../api-ref/RawLogs/activate.md) для ресурса [RawLogs](../../api-ref/RawLogs/index.md) или вызовом gRPC API [RawLogsService/Activate](../../api-ref/grpc/RawLogs/activate.md).

{% endlist %}

После включения статус выгрузки изменится с `NOT_ACTIVATED`  на `OK`.

При статусе `FAIL` сервис не выгружает логи, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

## Редактирование выгрузки {#editing}

Чтобы изменить параметры выгрузки:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором расположен ресурс.

  1. Перейдите в сервис **Cloud CDN**.

  1. Нажмите на имя необходимого ресурса.

  1. Перейдите на вкладку **Выгрузка логов**.

  1. В правом верхнем углу нажмите значок ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.

  1. Укажите нужные параметры и нажмите **Сохранить**.

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/RawLogs/update.md) для ресурса [RawLogs](../../api-ref/RawLogs/index.md) или вызовом gRPC API [RawLogsService/Update](../../api-ref/grpc/RawLogs/update.md).

{% endlist %}

## Отключение выгрузки {#disabling}

Чтобы отключить выгрузку:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором расположен ресурс.

  1. Перейдите в сервис **Cloud CDN**.

  1. Нажмите на имя необходимого ресурса.

  1. Перейдите на вкладку **Выгрузка логов**.

  1. В правом верхнем углу нажмите **Выключить**.

- API {#api}

  Воспользуйтесь методом REST API [deactivate](../../api-ref/RawLogs/deactivate.md) для ресурса [RawLogs](../../api-ref/RawLogs/index.md) или вызовом gRPC API [RawLogsService/Deactivate](../../api-ref/grpc/RawLogs/deactivate.md).

{% endlist %}