# Functions

_A function_ is a set of [versions](#version).

Once created, a function only contains metadata about itself, including name, description, and unique ID. To start using the function, you need to [create a version](../operations/version-manage.md#version-create). You can execute functions using the HTTP API or CLI.

Before writing your functions, review the [programming model](#programming-model).

## Function versions {#version}

_Versions_ contain the function code, run parameters, and all necessary dependencies. You can work with different versions of the same function during different stages of development (for example, a version under development or alpha and beta versions). When making changes, new versions are always created with a [tag](#tag) (by default, `$latest`). It doesn't matter if you uploaded a completely new code or made only minor changes.

To create a version, you need a ZIP archive of the distribution package with the code and all necessary dependencies. You can:

- Upload the ZIP archive from your PC.

- Upload the ZIP archive by specifying the bucket and object in S3 storage.

    {% note info %}

    After you create a function, you no longer need the object with the code. You can delete it from storage.

    {% endnote %}

For more information about how to create versions, see [{#T}](../operations/version-manage.md#version-create).

### Version tag {#tag}

Tags are used for calling a particular version of a function. Each tag must be unique within the function. One version may have multiple tags.

{% note info %}

When creating a new version, it's assigned the `$latest` tag by default.

{% endnote %}

## Programming model {#programming-model}

{{ sf-name }} supports different programming languages. Regardless of the language you choose, you should write your code based on the programming model accepted in the service. It contains elements that the user needs to implement as well as mechanisms that are already implemented on the service side and can be used when necessary.

### Model description {#model-desc}

To enable a function call, describe a _handler_ in it. It's defined when writing code and handles the data received by calling the necessary functions and methods in the code. The handler should accept the data that comes with function requests and the context passed by {{ sf-name }}.

_Context_ lets your function code interact with {{ sf-name }}. For example, the function can use it to find out how much time is left until {{ sf-name }} completes its execution.

Incoming requests are processed by the function one at a time. If the function is called faster than one instance can process the request, the service scales the function by running additional function instances. This ensures _concurrent  request processing_.

To let your function process multiple requests simultaneously, use _asynchronous code execution_, as provided by the [runtime environment](runtime/index.md).

To report a function execution error to the service, handle errors using _exceptions_.

The service _logs_ the execution of functions. However, if necessary, you can implement additional logging in your function code.

