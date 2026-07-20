* Задайте значения для переменных, обязательных для подключения к {{ traces-name }}:

    ```bash
    export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Api-Key <ваш_API-ключ>,x-monium-project=<имя_проекта>,x-monium-service=my-ai-agent"
    ```
    ```bash
    export OTEL_SERVICE_NAME="my-ai-agent"
    ```
    ```bash
    export OTEL_EXPORTER_OTLP_ENDPOINT="{{ api-host-monium }}:443"
    ```

    Где:
    - `<ваш_API-ключ>` — API-ключ сервисного аккаунта, созданный ранее.
    - `<имя_проекта>` — имя проекта в формате `folder__<идентификатор_каталога>`, например `folder__b1g2e3abc4def5ghij6k`.

    Подробнее о специальных заголовках {{ monium-name }} читайте в разделе [{#T}](../../monium/collector/otlp-protocol.md#headers).

* Создайте дополнительную переменную, позволяющую захватывать содержимое промптов и ответов модели:

    ```bash
    export OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT=true
    ```

    Без этой переменной в трейсах будут записаны модель, количество токенов и время вызова, но не тексты промптов и ответов.