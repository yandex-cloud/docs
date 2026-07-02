# Request handler for a function in PHP

A _request handler_ is a method used to process each PHP function call. When creating a function version, you should must the entry point that consists of the file name and the request handler name, e.g., `index.myFunction`.

{% note info %}

At any given time, a single function instance processes only one request. This allows you to use global variables without the need to ensure data integrity control.

{% endnote %}

When calling the handler, the runtime provides the following arguments:
1. Request body (the `event` parameter).

    If the request body is a JSON document, it will be converted into `Array` using the `json_decode` method.
1. Invocation context (the `context` parameter).

    The context provides all required information about the function version. The structure of this object is described in [{#T}](context.md).

The handler is a function that is declared in the global namespace and takes two arguments.

To return the execution result, use the `return` statement or throw an exception using the `throw` statement.

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

The function returns either a prepared response or an error:

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
