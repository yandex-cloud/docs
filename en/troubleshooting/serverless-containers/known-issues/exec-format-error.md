# Fixing the `user container exec format error` error


## Issue description {#issue-description}

When attempting to start a container in {{ serverless-containers-name }}, you see the following error in its logs:

```
"errorMessage":"user container finished with error: fork/exec /usr/local/bin/python3: exec format error","errorType":"UserCodeError"}
```

## Solution {#issue-resolution}

We recommend building a container with the architecture explicitly set to `--platform=linux/amd64`.

For more information about the {{ serverless-containers-name }} runtime, see [this article](../../../serverless-containers/concepts/runtime.md).

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of your container in {{ serverless-containers-name }}.
1. Full error message from the container execution log.