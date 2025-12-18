
# Fixing the `No node can serve the request (Too many reschedules)` error


## Issue description {#issue-description}

When calling a function in {{ sf-name }}, the function code is not run and the function log contains this entry:

```
Code: 429 Message: No node can serve the request: Too many reschedules
```

## Solution {#issue-resolution}

The `Too many reschedules` error may occur if a function or container fails to respond to an HTTP request and terminates. In this case, you can *reschedule* running the request; however, if the request keeps being invalid after repeat function calls, the function call will eventually loop.

The best solution is to rewrite the function code to comply with the requirements for the {{ sf-name }} runtime environment.

You can read more about these requirements in [this guide](../../../functions/concepts/runtime/index.md).

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Cloud function ID.
1. Full text of the error messages from the function log.
