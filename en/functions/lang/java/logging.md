# Java function runtime logging

{{ sf-name }} automatically captures a Java application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. In addition to the application run history, the system logs request execution events.

Additional messages are logged using standard language constructs:
1. `System.out.println`: Outputs a message to the standard output stream, `stdout`.
1. `System.err.println`: Outputs a message to the standard error stream, `stderr`.
1. `Instant.now` + `Duration.between` (and other methods): Returns the action duration.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

For more information about string formatting, see the [relevant section of the documentation](https://docs.oracle.com/javase/tutorial/essential/io/formatting.html).

{% include [router-logging](../../../_includes/functions/router-logging.md) %}
