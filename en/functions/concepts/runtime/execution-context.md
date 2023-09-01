# Execution context

The _execution context_ is a temporary runtime environment that initializes the external dependencies of your function code, such as database connections and HTTP endpoints.

When calling each function, {{ sf-name }} starts the execution context based on the configuration parameters that the user defined when creating this function. The service provides and manages the resources required for function calls.

A function may be delayed when called for the first time or after an update, because the service sets up the execution context and initializes the function. For subsequent function calls, the service tries to reuse the execution context. This ensures better performance for subsequent calls, as there is no need to perform the entire startup process again or reinstall the dependencies.

Initialization only takes place when a new function instance is created. {{ sf-name }} creates a new function instance at function call if there are no function instances or not enough of them to process calls. If several function calls are processed by the same instance, initialization only takes place at the first call.

## Reusing the execution context {#reuse-context}

Once a function is executed, the context is kept pending for the function to be called again. This means that:

* Any declarations in the function code (outside the [handler](../function.md#model-desc) code) remain initialized, providing additional optimization when the function is called again.

    For example, if the function establishes a database connection, the original connection is used in subsequent calls instead of reconnecting. You can add logic to your code that will check whether a connection exists before creating a new one.

* Each execution context provides 512 MB of additional disk space in the `/tmp` folder. The directory contents remain in the execution context providing a temporary cache that can be used for multiple calls. You can add extra code to check if the cache contains any data that you saved.

    {% note info %}

    The `NOEXEC` flag is set for the file system mounted in the `/tmp` folder. This disables the execution of binary files saved in this folder.

    {% endnote %}

* Background processes or callbacks initiated by your function, which were not completed before the function execution is complete, are resumed if the execution context is reused.

   There may be situations when the service needs to create a new execution context. This may lead to unexpected results, such as database connectivity failures. Make sure that any background processes or callbacks in your code have completed before the function execution is complete.
