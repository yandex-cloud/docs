#### Quotas {#quotas}

| Type of limit | Value |
| ----- | ----- |
| Number of functions per cloud | 10 |
| Number of instances of a single function in each availability area | 10 |
| Number of concurrent function calls (for all functions in each availability zone) | 10 |
| Total RAM for all running functions in each availability zone | 20 GB |

#### Limits {#limits}

| Type of limit | Value |
| ----- | ----- |
| **Maximum uploaded file size** |
| ZIP archive from the management console | 3.5 MB |
| ZIP archive from S3 bucket | 128 MB |
| Unzipped ZIP archive from S3 bucket | 680 MB |
| **Other restriction** |
| Maximum size of the [request JSON structure](../functions/concepts/function-invoke.md#request) | 3.5 MB |
| Maximum [temporary file size](../functions/concepts/runtime/environment-variables.md#files) | 512 MB |
| Maximum function execution time before [timeout](../functions/operations/function/version-manage.md#version-create) (including original initialization at first call) | 5 minutes |
| Maximum number of [triggers](../functions/concepts/trigger/index.md) per [message queue](../message-queue/concepts/queue.md) | 1 |

#### Other restrictions {#other-restrictions}

* The trigger must be in the same cloud as the queue that messages are read from.
* When installing dependencies:
    * The total runtime of the `npm ci` command is limited to **5 minutes**. After it expires, the build fails with an error.
    * The command is allocated no more than **1 GB** of RAM.

