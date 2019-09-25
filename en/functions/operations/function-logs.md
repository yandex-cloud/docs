# Viewing the execution log

The execution log uses Coordinated Universal Time, [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).

When viewing the log, you can set a specific interval using the `--since` and `--until` flags. If no interval is specified when invoking a function, information for the last hour is displayed.

The following flags are used:

* `--since`: Time N and later.
* `--until`: Time N and earlier.

If you only specify one flag, information is displayed for the hour before or after N depending on the flag.

Allowed time formats:

- `HH:MM:SS`. Example: `15:04:05`.
- [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt). Example: `2006-01-02T15:04:05Z`, `2h`, `3h30m ago`.

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    1. {% include [yc-function-list](../../_includes/functions/function-list.md) %}

    1. View the function execution log:

        ```
        $ yc serverless function logs my-python-function
        2019-07-04 09:27:43     START RequestID: 34dc9533-ed6e-4468-b9f2-2aa082266fad Version: b09i2s85a0c1fisjboft
        2019-07-04 09:27:43     END RequestID: 34dc9533-ed6e-4468-b9f2-2aa082266fad
        2019-07-04 09:27:43     REPORT RequestID: 34dc9533-ed6e-4468-b9f2-2aa082266fad Duration: 538.610 ms Billed Duration: 538.700 ms Memory Size: 128 MB Max Memory Used: 13 MB
        2019-07-04 09:29:25     START RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f279394ef Version: b09i2s85a0c1fisjboft
        2019-07-04 09:29:26     END RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f279394ef
        2019-07-04 09:29:26     REPORT RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f279394ef Duration: 554.904 ms Billed Duration: 555.000 ms Memory Size: 128 MB Max Memory Used: 13 MB
        ...
        ```

{% endlist %}

