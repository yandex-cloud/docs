# Logging

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized [logging system](../../operations/function/function-logs.md) available in {{ yandex-cloud }}. In addition to the application run history, the system logs request execution events.

Additional messages are logged using standard language constructs:

1. `print`: Outputs a message to the standard output stream, `stdout`.
1. `logging`: Outputs a message in the set format to the selected output stream.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

{% include [router-logging](../../../_includes/functions/router-logging.md) %}

