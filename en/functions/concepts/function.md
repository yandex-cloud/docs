# Function

_The function_ lets you put your code in {{ yandex-cloud }} and run it on request or trigger.

Once created, a function only contains its own metadata, including its name, description, and unique ID. To start using the function, you need to [create a function version](../operations/function/version-manage.md#version-create). You can execute functions using the HTTP API or CLI.

Before writing your functions, review the [programming model](#programming-model).

## Function versions {#version}

_Versions_ contain the function code, run parameters, and all necessary dependencies. You can work with different versions of the same function during different stages of development (for example, a version under development or alpha and beta versions). When making changes, new versions are always created with a [tag](#tag) (by default, `$latest`). It doesn't matter if you uploaded a completely new code or made only minor changes.

### Code upload format {#upload}

To create a version, you can use the [code editor](../operations/function/function-editor.md) or upload your code and its dependencies in one of the formats described in the table below. After you create a function, you no longer need the object with the code. You can delete it from storage.

| Format | Management console | YC CLI |
| ---- | ---- | ---- |
| ZIP archive from your PC | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| ZIP archive from S3, specifying the bucket and object | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Directory | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| File | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |

{% include [upload-limits](../../_includes/functions/upload-limits.md) %}

For more information about how to create versions, see [{#T}](../operations/function/version-manage.md#version-create).

### Version tag {#tag}

Tags are used for calling a particular version of a function. Each tag must be unique within the function. One version may have multiple tags.

{% note info %}

When creating a new version, it's assigned the `$latest` tag by default.

{% endnote %}

## Programming model {#programming-model}

{{ sf-name }} supports different programming languages. Regardless of the language you choose, you should write your code based on the programming model accepted in the service. It contains elements that the user needs to implement as well as mechanisms that are already implemented on the service side and can be used when necessary.

### Model description {#model-desc}

To enable a function call, describe a _handler_ in it. It's defined when writing code and handles the data received by calling the necessary functions and methods in the code. The handler should accept the data that comes with function requests and the context passed by {{ sf-name }}.

_Context_ lets your function code interact with {{ sf-name }}. For example, the function can use it to find how much time is left before {{ sf-name }} completes its execution.

Incoming requests are processed by the function one at a time. If the function is called faster than one instance can process the request, the service scales the function by running additional function instances. This ensures _concurrent  request processing_.

To let your function process multiple requests simultaneously, use _asynchronous code execution_ provided by the [runtime environment](runtime/index.md).

To report a function execution error to the service, handle errors using _exceptions_.

The service _logs_ the execution of functions. However, if necessary, you can implement additional logging in your function code.

