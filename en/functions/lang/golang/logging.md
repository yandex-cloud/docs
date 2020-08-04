# Logging

{{ sf-name }} automatically captures standard application output streams and sends them to the centralized logging system available in Yandex.Cloud. In addition to the application run history, the system logs request execution events.

Additional messages are logged using standard language constructs:

1. `fmt.Print` / `Println`: Outputs a message to the standard output stream, `stdout`.
1. `print` / `println`: Outputs a message to the standard error stream, `stderr`.
1. `time.Now` + `time.Since`: Returns the action duration.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

For more information about string formatting, see the [relevant section of the documentation](https://golang.org/pkg/fmt/). Learn about the `print` and `println` built-in functions [here](https://golang.org/pkg/builtin/) and about the `time` package and its functionality [here](https://golang.org/pkg/time/).

{% include [router-logging](../../../_includes/functions/router-logging.md) %}

