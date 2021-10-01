# Node.js function runtime logging

{{ sf-name }} automatically captures a Node.js application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. In addition to the application run history, the system logs request execution events.

Additional messages are logged using standard language constructs:

1. `console.log`: Outputs a message to the standard output stream, `stdout`.
1. `console.error`: Outputs a message to the standard error stream, `stderr`.
1. `console.time` / `console.timeLog`: Outputs the action duration.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

For more information about the Console API specifications, see the [WHATWG Console](https://console.spec.whatwg.org/) standard.

{% include [router-logging](../../../_includes/functions/router-logging.md) %}

