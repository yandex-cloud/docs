* Set values for the variables required to connect to {{ traces-name }}:

    ```bash
    export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Api-Key <your_API_key>,x-monium-project=<project_name>,x-monium-service=my-ai-agent"
    ```
    ```bash
    export OTEL_SERVICE_NAME="my-ai-agent"
    ```
    ```bash
    export OTEL_EXPORTER_OTLP_ENDPOINT="{{ api-host-monium }}:443"
    ```

    Where:
    - `<your_API_key>`: Service account API key you created earlier.
    - `<project_name>`: Project name in `folder__<folder_ID>` format, e.g., `folder__b1g2e3abc4def5ghij6k`.

    Learn more about special {{ monium-name }} headers [{#T}](../../monium/collector/otlp-protocol.md#headers).

* Create an additional variable to capture the contents of prompts and model responses:

    ```bash
    export OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT=true
    ```

    Without this variable, traces will feature the model, token count, and call duration but not the texts of prompts and responses.