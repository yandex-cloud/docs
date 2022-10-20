#### Quotas {#functions-quotas}

| Type of limit | Value |
--- | ---
| Number of functions per cloud | 10 |
| Number of function instances per availability zone | 10 |
| Number of concurrent function calls (for all functions in each availability zone) | 10 |
| Total RAM for all running functions per availability zone | 20 GB |
| Number of tags per function | 10 |
| Number of concurrent operations on a single function and its versions | 10 |
| Number of concurrent operations on all functions and their versions per folder | 15 |
| Number of concurrent operations on all functions and their versions per cloud | 20 |
| Number of provisioned function instances per cloud | 2 |

A function instance processes one function call at a time. If there are more function calls than instances available, the call is queued. A queued call is treated as call-in-progress and consumes your [quota]({{ link-console-quotas }}).

Function calls are distributed across [availability zones](../overview/concepts/geo-scope.md) randomly. {{ sf-name }} does not guarantee their even distribution across zones. For example, all calls, regardless of their number, might end up in the same zone.

#### Limits {#functions-limits}

| Type of limit | Value |
--- | ---
| **Maximum uploaded file size** |
| ZIP archive from the management console | 3.5 MB |
| ZIP archive from S3 bucket | 128 MB |
| Unzipped ZIP archive from S3 bucket | 680 MB |
| **Other restrictions** |
| Maximum size of the JSON structure of a [request](../functions/concepts/function-invoke.md#request) and [response](../functions/concepts/function-invoke.md#response) | 3.5 MB |
| Maximum [temporary file](../functions/concepts/runtime/environment-variables.md#files) size | 512 MB |
| Maximum function execution time before [timeout](../functions/operations/function/version-manage.md#version-create), including original initialization at first call | 10 minutes |
| Maximum total environment variable storage, including variable names | 4 KB |
| Maximum number of [triggers](../functions/concepts/trigger/index.md) per [message queue](../message-queue/concepts/queue.md) | 1 |

#### Other restrictions {#functions-other-restrictions}

* The trigger must be in the same cloud as the queue that messages are read from.
* When installing dependencies:
   * The total time for installing dependencies is limited to **5 minutes**. After it expires, the build fails with an error.
   * **1 GB** of RAM is allocated to install dependencies, of which **700 MB** is allocated for temporary file storage (tmpfs). Memory is consumed by active processes and files created and downloaded during the build.
   * **50%** of the CPU is available.

   If the build takes longer than 5 minutes or requires more resources, gather the dependencies yourself and [download the function as a ZIP archive](../functions/operations/function/version-manage.md#func-version-create).