---
title: Java function runtime logging
description: '{{ sf-name }} automatically captures a Java application''s standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}.'
---

# Java function runtime logging

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}. Along with application runtime logging, the system logs request execution events.

Additional messages are logged using standard language constructs:
1. `System.out.println`: Outputs a message to the standard output stream, `stdout`.
1. `System.err.println`: Outputs a message to the standard error stream, `stderr`.
1. `Instant.now` + `Duration.between` (and other methods): Returns the action duration.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

For more information about string formatting, see the [Java documentation](https://docs.oracle.com/javase/tutorial/essential/io/formatting.html).

{% include [router-logging](../../../_includes/functions/router-logging.md) %}
