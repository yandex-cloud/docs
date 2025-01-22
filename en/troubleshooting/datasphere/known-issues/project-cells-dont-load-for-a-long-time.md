# Resolving issues with long code execution within DataSphere project cells



## Issue description {#issue-description}

* When you try to execute the code from the Jupyter notebook cells within the DataSphere project, you see the `Preparing $CONF_NAME instance` message, where `$CONF_NAME` is the name of the [DataSphere computing resource configuration](../../../datasphere/concepts/configurations.md) you are using.
* Allocating a VM instance with the computing resource configuration selected in the DataSphere project properties takes a long time.
* Code execution in the DataSphere project cells takes a very long time.

## Solution {#issue-resolution}

Here are possible reasons for the long code execution time in the DataSphere project cells:

1. The slow start of the code in the cells may be related to the number of cells and the amount of code in them.
   Loading a full project with many cells can take a considerable amount of time. For loading large-scale projects with hundreds of cells, the loading time can exceed 10 minutes.
   If possible, try to reduce the number of cells in the project or use a better performing configuration of computing resources.

2. When launching code in project cells for the first time, VM instances with the relevant resource configuration are allocated and started. This operation also requires some time.
   You can use a more productive configuration of computing resources to accelerate code launch in project cells.

## If the issue persists {#if-issue-still-persists}

If the above recommendations did not help solve the issue, [create a request for technical support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. Link to the project in DataSphere from the address bar of your browser.
2. Screenshots of the error and the piece of code that causes the error.
3. Approximate date and time when the issue occurred.
4. Information about third-party Docker images used in the project.
5. Typical project loading time.