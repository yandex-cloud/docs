# PHP function request handler

A _request handler_ is a method used to handle each PHP function invocation. When creating a function version, you should specify the entry point that consists of the file name and request handler name (for example, `index.myFunction`).

{% note info %}

At any given time, a single function instance processes only one request. This lets you use global variables without having to provide data integrity control.

{% endnote %}

When invoking the handler, the runtime passes the following arguments:

1. The request body (the `event` parameter).

    If the request body is a JSON document, it's converted to an `Array` using the `json_decode` method.

1. The invocation context (the `context` parameter).

    The context contains the necessary information about the function version. The structure of this object is described in [{#T}](context.md).

A handler is a function that is declared in a global namespace and takes two arguments.

To have the execution result returned, use the `return` statement or throw an exception using the `throw` statement.

## Examples {#examples}

### HTTP request structure output {#http-req}

The following function outputs the request structure and invocation context to both the execution log and function response:

```php
<?php

function myHandler ($event, $context) {
    $resp = [
        'event' => $event,
        'context' => $context,
    ];

    return [
        'statusCode' => 200,
        'body' => json_encode($resp),
    ];
}
```

### Synchronous handler {#sync-example}

The function returns the available response or an error:

```php
<?php

function myHandler ($event, $context) {
    $message = "not lucky";
    if (rand() % 2 == 0) {
        $message = "lucky one";
    }

    return [
        'statusCode' => 200,
        'headers' => [
            'Content-Type' => 'text/plain',
        ],
        'body' => $message,
    ];
}
```

