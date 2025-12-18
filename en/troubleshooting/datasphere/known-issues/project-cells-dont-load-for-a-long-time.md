# Troubleshooting long execution times within {{ ml-platform-name }} project cells



## Issue description {#issue-description}

* When you try to run code from {{ jlab }} notebook cells within a {{ ml-platform-name }} project, you get the `Preparing $CONF_NAME instance` message, where `$CONF_NAME` is the name of the [{{ ml-platform-name }} computing resource configuration](../../../datasphere/concepts/configurations.md) you are using.
* Allocating a VM with the computing resource configuration selected in the {{ ml-platform-name }} project properties takes a long time.
* Code execution within {{ ml-platform-name }} project cells takes much longer than expected.

## Solution {#issue-resolution}

Here are possible reasons for long execution times within {{ ml-platform-name }} project cells:

1. Long execution times in cells may may result from both the number of cells and the amount of code. Loading a full project with many cells can take a considerable amount of time. For projects with hundreds of cells, loading may take more than 10 minutes. If feasible, try to reduce the number of cells in your project or opt for a higher-performance computing configuration.

1. When launching code in project cells for the first time, VMs with the relevant resource configuration are allocated and started. This operation also requires some time. You can use a more efficient configuration of computing resources to accelerate code launch in project cells.

## If the issue persists {#if-issue-still-persists}

If the tips we provided did not help you resolve the issue, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ ml-platform-name }} project URL (copy it from the address bar of your browser).
1. Screenshots of the error and the piece of code that causes the error.
1. Approximate date and time when the issue occurred.
1. Information about third-party Docker images used in the project.
1. Typical project loading time.