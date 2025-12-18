# Fixing the `Device or resource busy` error


## Issue description {#issue-description}

When trying to install a library, you get this error:

```
ERROR: Could not install packages due to an OSError: [Errno 16] Device or resource busy: '.nfs0000000000009d3a00000018'
```

## Solution {#issue-resolution}

This is a system message related to resources. 

Try running these commands:

* `Kernel` ⟶ `Restart Kernel`
* `File` ⟶ `Stop IDE executions` in {{ jlab }}Lab or click **Stop IDE executions** in the **Running operations** widget on the project page.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Project URL.
1. Exact time when the issue occurred.