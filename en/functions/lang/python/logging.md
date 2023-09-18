# Python function runtime logging

{{ sf-name }} automatically captures a Python application's standard output streams and sends them to the centralized [logging system](../../operations/function/function-logs.md) available in {{ yandex-cloud }}. In addition to the application run history, the system logs request execution events.

Additional messages are logged using standard language constructs:
1. `print`: Outputs a message to the standard output stream, `stdout`.
1. `logging`: Outputs a message in the set format to the selected output stream.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

{% include [router-logging](../../../_includes/functions/router-logging.md) %}

## Custom messages {#user-logging}

Before running a {{ sf-name }} function, configures the following for the [root logger](https://docs.python.org/3/howto/logging.html#advanced-logging-tutorial):
* A handler for logging data to the `stdout` output stream.
* A formatter that adds to the message its creation timestamp, the request ID, and the logging level.

{% note warning %}

You can't change the root logger settings using the `logging.basicConfig()` function.

{% endnote %}

By default, the root logger level is `Warning`, all logs with a lower level are ignored. You can change the logging level using the `setLevel` method for:

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

The example shows the logger name output instead of the message creation timestamp.

Learn more about how to configure logging in the [Python documentation](https://docs.python.org/3/howto/logging.html#configuring-logging).
