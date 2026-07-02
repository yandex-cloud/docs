# Go function execution logging

{{ sf-name }} automatically captures the Go application's standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}. In addition to the application execution logs, the system also logs request execution events.

Additional messages are logged using standard language constructs:
1. `fmt.Print` / `Println`: Outputs a message to the standard output stream, `stdout`.
1. `print` / `println`: Outputs a message to the standard error stream, `stderr`.
1. `time.Now` + `time.Since`: Returns the action duration.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

For more information about string formatting, see [this guide](https://pkg.go.dev/fmt). Learn about the `print` and `println` built-in functions [here](https://pkg.go.dev/builtin/) and about the `time` package and its features [here](https://pkg.go.dev/time).

{% include [router-logging](../../../_includes/functions/router-logging.md) %}
