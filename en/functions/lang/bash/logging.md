# Bash function runtime logging

{{ sf-name }} automatically captures the `stderr` standard error output stream of a Bash application and logs errors to the centralized logging system available in {{ yandex-cloud }}. In addition to the application run history, system messages with request execution event details are generated.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

{% include [router-logging](../../../_includes/functions/router-logging.md) %}
