# Fixing the `Servant not allocated` error when running code within {{ ml-platform-name }} project cells



## Issue description {#issue-description}

When trying to execute code from {{ jlab }} notebook cells within the {{ ml-platform-name }} project, you get one or more error messages:

* `Preparing c1.4 instance`
* `Execute error: Servant c1.4 not allocated: Internal Error`

## Solution {#issue-resolution}

The `Execute error: Servant g1.1 not allocated: Internal Error` message may appear due to a temporary lack of free GPUs in {{ ml-platform-name }}. Try using another configuration, e.g., c1.8, or execute code in the cell once again later.

If you are using a custom Docker image in your project, check whether you can reproduce the issue on a public image, e.g., on [Ubuntu](https://hub.docker.com/_/ubuntu).

{% note tip %}

If the issue persists for a while, try opening the project page in private mode of your browser; this will rule out issues on the browser cache side.

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}).
Provide the following information in your ticket:

1. Link to the project in {{ ml-platform-name }} from the address bar of your browser.
1. Screenshots of the error and the code snippet that causes the error.
1. Approximate date and time when the issue occurred.
1. Information about third-party Docker images used in the project.
1. Description of the scenario where you need the `c1.4` configuration and issues it will help you solve.
