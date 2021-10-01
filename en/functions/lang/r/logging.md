# R function runtime logging

{{ sf-name }} automatically captures an R application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. In addition to the application run history, the system logs request execution events.

Standard solutions, such as the logging package, are used to log additional messages.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

{% include [router-logging](../../../_includes/functions/router-logging.md) %}

