# Request handler for a function in Node.js

A _request handler_ is a method used to process each Node.js function call. When creating a function version, you should must the entry point that consists of the file name and the request handler name, e.g., `index.myFunction`. To enable external access to the handler (file), export it by adding a key to the `module.exports` object.

{% note info %}

At any given time, one function instance cannot handle more calls than set in the [concurrency](../../concepts/function.md#concurrency) parameter. This allows you to use global variables without the need to ensure data integrity control.

{% endnote %}

When calling the handler, the runtime provides the following arguments:
1. Request body (the `body` parameter). 

    If the request body is a JSON document, it will be converted into `Object` using the `JSON.parse` method.
1. Invocation context (the `context` parameter). 

    The context provides all required information about the function version. The structure of this object is described in [{#T}](context.md).
    
## Handler types {#type}

A function can handle one or multiple requests at the same time, with synchronous and asynchronous handlers used respectively.

## Asynchronous handler {#async}

A handler can be an `async function()` asynchronous function. In this case, you can use the following statements: 
* `return`: Returns the function response.
* `throw`: Reports an error to the runtime.
* `await`: Tracks the execution of asynchronous function invocations.

{% note info %}

An asynchronous function must return a direct result. You do not need to additionally use the `Promise` object to track the call results because the function is already asynchronous.

{% endnote %}

For more information about the development process using `async/await`, see [this JavaScript tutorial](https://learn.javascript.en/async-await).

## Synchronous handler {#sync}

If you do not need to invoke asynchronous functions or you need to use a traditional callback model, use a synchronous handler.

To return the execution result, use the `return` statement or throw an exception using the `throw` statement. A synchronous function must return a result different from `undefined`; otherwise, the code will fail with this error: `Non-async entry point should provide a result. Return a value or use async function instead`.

However, if the handler returns a `Promise`, the runtime will automatically wait for it to resolve. When using a `Promise` object, correct error and exception handling depends on your function code. Make sure that: 
* One of the function callbacks (`resolve` or `reject`) within the `Promise` object will always be executed. 
* All exceptions in the function body are handled correctly. 
Otherwise, code execution will be disrupted: the function will stop responding to invocations or the entire process will fail.

For more information about the development process using `Promise`, see [this JavaScript tutorial](https://learn.javascript.en/promise-basics).

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

The function sends a request to `https://example.com/` and returns the HTTP status code and the contents of the JSON document:

```js
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

The function returns either a prepared response or an error:

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
