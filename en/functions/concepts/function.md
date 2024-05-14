# Function

A _function_ allows you to put your code in {{ yandex-cloud }} and run it on request or trigger.

Once created, a function only contains its own metadata, including its name, description, and unique ID. To start using the function, you need to [create a function version](../operations/function/version-manage.md). You can execute functions using the HTTPS API or CLI.

Before writing your functions, review the [programming model](#programming-model).

## Function versions {#version}

_Versions_ contain the function code, run parameters, and all required dependencies. You can work with different versions of the same function during different development stages, e.g., under development, alpha version, beta version, etc. When making changes, new versions are always created with the default `$latest` [tag](#tag). It does not matter whether you uploaded a completely new code or only made some minor changes.

### Code upload format {#upload}

To [create a version](../operations/function/version-manage.md), you can use the code editor or upload your code and its dependencies in one of the formats described in the table below. After you create a function, you no longer need the object with the code. You can delete it from storage.

| Format | Management console | {{ yandex-cloud }} CLI |
|----|----|----|
| ZIP archive from your PC | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| ZIP archive from S3, specifying the bucket and object | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Directory | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| File | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |

{% include [upload-limits](../../_includes/functions/upload-limits.md) %}

For more information about how to create versions, see [{#T}](../operations/function/version-manage.md).

### Version tag {#tag}

Tags are used for calling a particular version of a function. Each tag must be unique within the function. One version may have multiple tags.

{% note info %}

When creating a new version, it's assigned the `$latest` tag by default.

{% endnote %}

## Programming model {#programming-model}

{{ sf-name }} supports different programming languages. Regardless of the language you choose, you should write your code based on the programming model accepted in the service. It contains elements that the user needs to implement as well as mechanisms that are already implemented on the service side and can be used when necessary.

### Model description {#model-desc}

To enable a function call, describe a _handler_ in it. It is defined when writing code. The handler handles the data received by invoking respective functions and methods in the code. The handler should accept the data that comes with function requests and the context provided by {{ sf-name }}. Some [runtime environments](runtime/index.md) have requirements for an absolute path to the handler file:

* Python, Go, Java: No `.` in the file name before the extension, e.g., `.handler.py`.
* .NET Core: No `.` in the file name before the extension and at the beginning of the name of the directory containing the handler file, e.g., `.handler.cs` or `.test/handler.cs`.

_Context_ allows your function code to interact with {{ sf-name }}. For example, the function can use it to find how much time is left before {{ sf-name }} completes its execution.

Incoming requests are processed by the function one at a time. For your function to process multiple requests simultaneously, use _asynchronous code execution_ provided by the [runtime environment](runtime/index.md).

To report a function execution error to the service, handle errors using _exceptions_.

The service _logs_ the execution of functions. However, if necessary, you can implement additional logging in your function code.

### Scaling a function {#scaling}

A function instance processes one function call at a single point in time. If the function is called faster than one instance can process the request, the service scales the function by running additional function instances. This ensures _concurrent request processing_. In {{ sf-name }}, you can specify:

{% include [scaling](../../_includes/functions/scaling.md) %}

{% note info %}

Function calls are distributed across availability zones randomly. {{ sf-name }} does not guarantee their even distribution across zones. For example, all calls, no matter how many, might end up in the same zone.

{% endnote %}

{% include [provisioned-instances-time](../../_includes/functions/provisioned-instances-time.md) %}

#### Limits {#limits}

When the number of function instances reaches the `zone_instances_limit`, {{ sf-name }} stops scaling it. If there are more function calls than instances available, the call is queued and treated as a call-in-progress. When the number of calls-in-progress reaches the `zone_requests_limit`, the service stops queuing calls and returns the `429 TooManyRequests` error.



#### Provisioned instances {#provisioned-instances}

A _provisioned instance_ is a function instance that, when started, is guaranteed not to have a cold start. In the provisioned instance before the function is called:
* The interpreter is started.
* {{ sf-name }} runtime environment components are initialized.
* The user code is loaded and initialized.

{% include [provisioned-instances-price](../../_includes/functions/provisioned-instances-price.md) %}

If the number of function calls exceeds the number of provisioned instances, {{ sf-name }} scales the function within the [quotas](limits.md#functions-quotas), but unprovisioned instances have a cold start when they are first started.

Provisioned instances count towards the following [quotas](limits.md) even when they are not running:
* Number of function instances per availability zone.
* Total RAM for all running functions per availability zone.
* Number of provisioned function instances per cloud.



#### See also

* [Creating a function version](../operations/function/version-manage.md).
* [Adding scaling settings](../operations/function/scaling-settings-add.md).
