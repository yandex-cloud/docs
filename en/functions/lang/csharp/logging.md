# .NET Core function execution logging

{{ sf-name }} automatically captures the .NET Core application's standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}. In addition to the application execution logs, the system also logs request execution events.

Additional messages are logged using standard language constructs:
1. `Console.Write`: Outputs a message to the standard output stream, `stdout`.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

{% include [router-logging](../../../_includes/functions/router-logging.md) %}
