# Function

A _function_ allows you to put your code in {{ yandex-cloud }} and run it on request or trigger.

Possible function statuses include:

* `Creating`: Function was created; background initialization processes are running.
* `Active`: Function was successfully created and is ready for use.
* `Deleting`: Function and all associated resources are being deleted. The function still exists, but you can no longer use it.
* `Error`: Error while creating the function. The function exists, but cannot be used.

Once created, a function only contains its own metadata, including its name, description, and unique ID. To start using the function, you need to [create a function version](../operations/function/version-manage.md). You can execute functions using the HTTPS API or CLI.

Before writing your functions, review the [programming model](#programming-model).

## Function versions {#version}

_Versions_ contain the function code, run parameters, and all required dependencies. You can work with different versions of the same function during different development stages, e.g., under development, alpha version, beta version, etc. Each time a change is made, the system automatically creates a new version and [tags](#tag) it as `$latest` by default. It does not matter whether you uploaded a completely new code or only made some minor changes.

Possible function version statuses include:

* `Creating`: Function version was created; background initialization processes are running.
* `Active`: Function version was successfully created and is ready for use.
* `Obsolete`: Function version is obsolete and about to be deleted as it had no tags for a long time. To make it `Active` again, [add a tag](../operations/function/tag-add.md).
* `Deleting`: Function version is being deleted. It still exists, but you can no longer use it.

### Code upload format {#upload}

To [create a version](../operations/function/version-manage.md), you can use the code editor or upload your code and its dependencies in one of the formats described in the table below. After you create a function, you no longer need the object with the code. You can delete it from storage.

| Format | Management console | {{ yandex-cloud }} CLI |
|----|----|----|
|ZIP archive from your PC| ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
|ZIP archive from S3, specifying the bucket and object| ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
|Directory| ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
|File| ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |

{% include [upload-limits](../../_includes/functions/upload-limits.md) %}

For more information about how to create versions, see [{#T}](../operations/function/version-manage.md).

### Version tag {#tag}

Tags are used for calling a particular version of a function. Each tag must be unique within the function. One version may have multiple tags.

{% note info %}

Once a new version is created, it gets the default tag: `$latest`.

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

Calls are distributed across availability zones randomly. {{ sf-name }} does not guarantee the even distribution of calls across the zones. For example, all calls, no matter how many, might end up in the same zone.

{% endnote %}

{% include [provisioned-instances-time](../../_includes/functions/provisioned-instances-time.md) %}

#### Concurrent function instance calls {#concurrency}

To allow a single function instance to handle multiple function calls concurrently, set the `concurrency` parameter when creating a function version. The IDs of such calls (`RequestID`) must be unique. Otherwise, you will be getting an error when attempting to process a call with a duplicate ID.

If at least one call reaches a timeout, that call and all other calls handled by the same function instance will be aborted. For more information about the timeout, see [{#T}](limits.md#functions-limits).

The `concurrency` parameter is available for functions with the following [runtime environments](runtime/index.md):

* [Node.js](../lang/nodejs/index.md)
* [Go](../lang/golang/index.md)
* [Java](../lang/java/index.md)
* [Bash](../lang/bash/index.md)
* [Kotlin](../lang/kotlin/index.md)

#### Limits {#limits}

When the number of function instances reaches the `zone_instances_limit` value, {{ sf-name }} stops scaling it. If there are more function calls than the instances can handle, the new call is queued and treated as a call in progress. When the number of calls in progress reaches the `zone_requests_limit` value, the service stops queuing calls and returns the `429 TooManyRequests` error.

#### Provisioned instances {#provisioned-instances}

A _provisioned instance_ is a function instance that, when started, is guaranteed not to have a cold start. In the provisioned instance before the function is called:
* The interpreter is started.
* {{ sf-name }} runtime environment components are initialized.
* The user code is loaded and initialized.

{% include [provisioned-instances-price](../../_includes/functions/provisioned-instances-price.md) %}

If there are more function calls than provisioned instances can handle, {{ sf-name }} scales the function within the [quotas](limits.md#functions-quotas). New calls can be handled by either a provisioned instance or a regular one, whichever becomes free or created first.

Provisioned instances count towards the following [quotas](limits.md) even when they are not running:
* Number of function instances per availability zone.
* Total RAM for all running functions per availability zone.
* Number of provisioned function instances per cloud.

#### See also

* [Creating a function version](../operations/function/version-manage.md)
* [Adding scaling settings](../operations/function/scaling-settings-add.md)
