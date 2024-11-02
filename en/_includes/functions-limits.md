#### Quotas {#functions-quotas}

Type of limit | Value
--- | ---
Number of [triggers](../functions/concepts/trigger/index.md) per cloud | 100
Number of functions per cloud | 10
Number of tags per function | 10
Number of concurrent function calls (for all functions in each availability zone) | 10
Number of function instances per availability zone | 10
Total RAM for all running functions per availability zone | 20 GB
Number of [provisioned function instances](../functions/concepts/function.md#provisioned-instances) per cloud | 2
Number of concurrent operations on a single function and its versions | 10
Number of concurrent operations on all functions and their versions per folder | 15
Number of concurrent operations on all functions and their versions per cloud | 20
Number of [user networks](../functions/concepts/networking.md##user-network) per cloud | 1
Number of network packets per second per function instance | 10,000

For more information about relationships between quotas, see [{#T}](../functions/concepts/limits.md#related-quotas).

#### Limits {#functions-limits}

Type of limit | Value
--- | ---
**Maximum uploaded file size** |
ZIP archive from the management console | 3.5 MB
ZIP archive from S3 bucket | 128 MB
Unzipped ZIP archive from S3 bucket | 680 MB
**Other restrictions** |
Maximum size of the JSON structure of a [request](../functions/concepts/function-invoke.md#request) and [response](../functions/concepts/function-invoke.md#response) | 3.5 MB
Maximum size of [temporary files](../functions/concepts/runtime/environment-variables.md#files) | 512 MB
Maximum function execution time before [timeout](../functions/operations/function/version-manage.md), including original initialization at first call^1^ | 1 hour
Maximum total environment variable storage, including variable names^2^ | 4 KB
Maximum number of triggers per [message queue](../message-queue/concepts/queue.md) | 1
Maximum message size per trigger | 256 KB

^1^ A timeout longer than ten minutes is only available for [long-lived functions](../functions/concepts/long-lived-functions.md).
^2^ {{ lockbox-short-name }} secrets are provided via environment variables and are also counted towards this limit.

#### Other restrictions {#functions-other-restrictions}

When installing dependencies:
  * The total time for installing dependencies is limited to **five minutes**. After it expires, the build will fail with an error.
  * For dependency installation, **1 GB** of RAM is allocated, of which **700 MB** is allocated for temporary file storage (tmpfs). Memory is consumed by active processes and files created and downloaded during the build.
  * **50%** of the CPU is available.

  If the build takes longer than five minutes or requires more resources, build the dependencies yourself and [download the function as a ZIP archive](../functions/operations/function/version-manage.md).