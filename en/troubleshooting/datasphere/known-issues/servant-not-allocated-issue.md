# Resolving the "Servant not allocated" error when running code within DataSphere project cells



## Issue description {#issue-description}

When trying to execute code from Jupyter notebook cells within the DataSphere project, you see one or more error messages:

* `Preparing c1.4 instance`
* `Execute error: Servant c1.4 not allocated: Internal Error`.

## Solution {#issue-resolution}

The `Execute error: Servant g1.1 not allocated: Internal Error` message can appear due to a temporary shortage of free GPUs in the DataSphere service.
Try to use another configuration (for example, `c1.8`) or try to rerun the code in the cell later.

If you are using a custom Docker image in your project, check whether the issue is reproducible on a public image (for example, [an `Ubuntu` image](https://hub.docker.com/_/ubuntu)).
If the issue persists for a long time, try to open the project page in private mode of your browser - this will rule out issues on the side of the browser cache.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. Link to the project in DataSphere from the address bar of your browser.
2. Screenshots of the error and the piece of code that causes the error.
3. Approximate date and time when the issue occurred.
4. Information about third-party Docker images used in the project.
5. Description of the use case where you need the `c1.4` configuration and tasks you want to solve with it.
