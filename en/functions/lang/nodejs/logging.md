# Node.js function execution logging

{{ sf-name }} automatically captures the Node.js application's standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}. In addition to the application execution logs, the system also logs request execution events.

Additional messages are logged using standard language constructs:
1. `console.log`: Outputs a message to the standard output stream, `stdout`.
1. `console.error`: Outputs a message to the standard error stream, `stderr`.
1. `console.time` / `console.timeLog`: Outputs the action duration.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

For more information about the Console API specifications, see [this WHATWG Console standard](https://console.spec.whatwg.org/).

{% include [router-logging](../../../_includes/functions/router-logging.md) %}
