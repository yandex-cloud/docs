# Настройка выгрузки логов

[Выгрузка логов](../../concepts/logs.md) — платная функция, о ее тарификации см. раздел [{#T}](../../pricing.md).

## Включение выгрузки {#enabling}

Чтобы включить выгрузку для [ресурса](../../concepts/resource.md):

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Нажмите на имя необходимого ресурса.

  1. Перейдите на вкладку **{{ ui-key.yacloud.cdn.label_resource-raw-logs }}**.

  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.cdn.button_resource-activate-raw-logs }}**.

  1. Выберите **{{ ui-key.yacloud.cdn.label_bucket }}**.

  1. (Опционально) Укажите **{{ ui-key.yacloud.cdn.label_bucket-key-prefix }}** для имен файлов с логами.

  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-activate-raw-logs }}**.

- API {#api}

  Воспользуйтесь методом REST API [activate](../../api-ref/RawLogs/activate.md) для ресурса [RawLogs](../../api-ref/RawLogs/index.md) или вызовом gRPC API [RawLogsService/Activate](../../api-ref/grpc/raw_logs_service.md#Activate).

{% endlist %}

После включения статус выгрузки изменится с `NOT_ACTIVATED`  на `OK`.

При статусе `FAIL` сервис не выгружает логи, обратитесь в [техническую поддержку]({{ link-console-support }}).

## Редактирование выгрузки {#editing}

Чтобы изменить параметры выгрузки:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Нажмите на имя необходимого ресурса.

  1. Перейдите на вкладку **{{ ui-key.yacloud.cdn.label_resource-raw-logs }}**.

  1. В правом верхнем углу нажмите значок ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

  1. Укажите нужные параметры и нажмите **{{ ui-key.yacloud.common.save }}**.

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/RawLogs/update.md) для ресурса [RawLogs](../../api-ref/RawLogs/index.md) или вызовом gRPC API [RawLogsService/Update](../../api-ref/grpc/raw_logs_service.md#Update).

{% endlist %}

## Отключение выгрузки {#disabling}

Чтобы отключить выгрузку:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Нажмите на имя необходимого ресурса.

  1. Перейдите на вкладку **{{ ui-key.yacloud.cdn.label_resource-raw-logs }}**.

  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.cdn.button_resource-deactivate-raw-logs }}**.

- API {#api}

  Воспользуйтесь методом REST API [deactivate](../../api-ref/RawLogs/deactivate.md) для ресурса [RawLogs](../../api-ref/RawLogs/index.md) или вызовом gRPC API [RawLogsService/Deactivate](../../api-ref/grpc/raw_logs_service.md#Deactivate).

{% endlist %}
