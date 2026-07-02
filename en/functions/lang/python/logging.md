# Python function execution logging

{{ sf-name }} automatically captures the Python application's standard output streams and sends them to the centralized [logging system](../../operations/function/function-logs.md) in {{ yandex-cloud }}. In addition to the application execution logs, the system also logs request execution events.

Additional messages are logged using standard language constructs:
1. `print`: Outputs a message to the standard output stream, `stdout`.
1. `logging`: Outputs a message in the specified format to the selected output stream.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

{% include [router-logging](../../../_includes/functions/router-logging.md) %}

## User messages {#user-logging}

Before running a function, {{ sf-name }} configures the following for the [root logger](https://docs.python.org/3/howto/logging.html#advanced-logging-tutorial):
* Handler for writing logs to `stdout`.
* Formatter that adds the creation timestamp, request ID, and logging level to each message.

{% note warning %}

You cannot change the root logger settings using the `logging.basicConfig()` function.

{% endnote %}

By default, the root logger level is `Warning`, and all logs below this level are ignored. You can change the logging level using the `setLevel` method for:

* The entire app.
  ```python
  logging.getLogger().setLevel(logging.DEBUG)
  ```
* Any logger except the root one.
  ```python
  logging.getLogger('requests.packages.urllib3').setLevel(logging.DEBUG)
  logging.getLogger('myapp').setLevel(logging.DEBUG)
  ```

You can change the log format as follows:

```python
root_handler = logging.getLogger().handlers[0]
root_handler.setFormatter(logging.Formatter(
	'[%(levelname)s]\t%(name)s\t%(request_id)s\t%(message)s\n'
))
```

This example outputs the logger name instead of the message creation timestamp.

Learn more about how to configure logging in [this Python guide](https://docs.python.org/3/howto/logging.html#configuring-logging).
