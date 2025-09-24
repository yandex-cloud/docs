`transformer`: Transformation rules:

* `cloudFunction`: ID of the function created in {{ sf-name }}.


* `serviceAccountId`: ID of the service account you want to use to invoke the processing function.


* `numberOfRetries`: Number of attempts to invoke the processing function.
* `bufferSize`: Buffer size (in bytes) at which data will be transferred to the processing function.

    The maximum buffer size is 3.5 MB. For more information about restrictions that apply to functions in {{ sf-name }}, see the [relevant section](../../../../../functions/concepts/limits.md).

* `bufferFlushInterval`: Interval (in seconds) to wait before transferring stream data to the processing function.

    {% note info %}

    If the buffer is full or the sending interval expires, data will be transferred to the processing function.

    {% endnote %}

* `invocationTimeout`: Allowed timeout of a processing function response, in seconds.

{% note warning %}

Specify values ​​for `bufferFlushInterval` and `invocationTimeout` with the `s` postfix, e.g., `10s`.

{% endnote %}
