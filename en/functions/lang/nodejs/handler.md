# Node.js function call handler

A _call handler_ is a method used to handle each Node.js function call. When creating a function version, you should specify the entry point that consists of the file name and request handler name (for example, `index.myFunction`). To make the handler available outside the module (file), export it by adding a key to the `module.exports` object.

{% note info %}

At any given time, a single function instance processes only one request. This lets you use global variables without having to provide data integrity control.

{% endnote %}

When invoking the handler, the runtime passes the following arguments:
1. The request body (the `body` parameter).

   If the request body is a JSON document, it's converted to an `Object` using the `JSON.parse` method.
1. The invocation context (the `context` parameter).

   The context contains the necessary information about the function version. The structure of this object is described in [{#T}](context.md).

## Handler types {#type}

A function can simultaneously handle one or more requests using synchronous and asynchronous request handlers, respectively.

## Asynchronous handler {#async}

A handler can be an asynchronous function `async function()`. In this case you can use the following statements:
* `return`: Returns the function response.
* `throw`: Reports an error to the runtime environment.
* `await`: Tracks the execution of asynchronous function invocations.

{% note info %}

An asynchronous function must return a direct result. You don't need to additionally use the `Promise` object to track the invocation results, since the function is initially asynchronous.

{% endnote %}

To learn more about programming with `async/await`, see the [Modern JavaScript tutorial](https://learn.javascript.en/async-await).

## Synchronous handler {#sync}

If you don't need to invoke asynchronous functions or you need to use a traditional callback model, use a synchronous handler.

To have the execution result returned, use the `return` statement or throw an exception using the `throw` statement. A synchronous function must return a result different from `undefined`, otherwise the code will be executed with an error saying `Non-async entry point should provide a result. Return a value or use async function instead`.

However, if the handler returns an instance of the `Promise` object, the runtime automatically waits until its handling result is returned. When using `Promises`, correct handling of errors and exceptions depends on your function code. Make sure that:
* One of the function callbacks (`resolve` or `reject`), which is run inside the `Promise` object, is executed without fail.
* All exceptions in the function body are handled correctly.
Otherwise, code execution will be disrupted (the function will stop responding to invocations or the entire process will fail).

To learn more about programming with `Promises`, see the [Modern JavaScript tutorial](https://learn.javascript.en/promise-basics).

## Examples {#examples}

### HTTP request structure output {#http-req}

The following function outputs the request structure and invocation context to both the execution log and function response:

```js
module.exports.handler = function (event, context) {
    console.log("event", event);
    console.log("context", context);

    return {
        statusCode: 200,
        body: JSON.stringify({
            event: event,
            context: context
        })
    };
};
```

### Asynchronous handler {#async-example}

The function makes a request to `https://example.com/` and returns the HTTP response code and the contents of a JSON document:

```js
const fetch = require("node-fetch");

module.exports.handler = async function (event) {

    const response = await fetch('https://example.com/');
    const body     = await response.text();

    return {
        code: response.status,
        body: body
    };

};
```

### Synchronous handler {#sync-example}

The function returns the available response or an error:

```js
module.exports.handler = function () {
    if (Math.random() >= 0.5) {
        throw new Error("not so lucky");
    }

    return {
        "message": "Lucky one!"
    };
};
```
