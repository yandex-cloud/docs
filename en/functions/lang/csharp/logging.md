# .NET Core function runtime logging

{{ sf-name }} automatically captures a .NET Core application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. In addition to the application run history, the system logs request execution events.

Additional messages are logged using standard language constructs:
1. `Console.Write`: Outputs a message to the standard output stream, `stdout`.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

{% include [router-logging](../../../_includes/functions/router-logging.md) %}
