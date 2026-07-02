---
title: Kotlin function execution logging
description: '{{ sf-name }} automatically captures the Kotlin application''s standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}.'
---

# Kotlin function execution logging

{{ sf-name }} automatically captures the application's standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}. In addition to the application execution logs, the system also logs request execution events.

Additional messages are logged using standard language constructs:

1. `println`: Outputs a message to the standard output stream, `stdout`.
1. `System.err.println`: Outputs a message to the standard error stream, `stderr`.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

## See also {#see-also}

* [String formatting in the Kotlin docs](https://kotlinlang.org/docs/strings.html#string-formatting)
* [Viewing function logs](../../operations/function/function-logs.md)
