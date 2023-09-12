# Fixing the «Failed to deserialize variable» error

## Issue description {#issue-description}

When you open a DataSphere project, you see the following error message:
```
Failed to deserialize variable %VAR_NAME%
Run the following code to delete it: del_datasphere_variables
```
Where `%VAR_NAME%` is the name of the variable that you couldn't deserialize.

## Solution {#issue-resolution}

The message `The following variables cannot be serialized` means that some variables fail to be serialized, so you cannot save them.
The interpreter state will be saved on configuration change. All the computation results, including values of variables, will also be saved at this point.

Some variables fail to be serialized and cannot be saved. For example, a variable with a file open for writing: `f = open("file.txt", "w")`.
When you assign values to such variables, you'll see the warning: `The following variables cannot be serialized`.
Such a warning will not affect your code execution and further computation results.

The `Run the following code to delete it: del_datasphere_variables` message means that the variable was probably stored in the RAM of your GPU configuration previously, but hasn't been moved to the RAM of the current GPU configuration.

The error text includes a recommendation how to reset the variable (the `del_datasphere_variables` method) to fix the error. In such a case, try running all the cells linked to this variable within the same configuration.

## If the issue persists {#if-problem-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:
1. Project URL from the browser address bar.
2. Full text of the error message.
3. [HAR file](../../../support/create-har.md) with the recorded results of browser and server interaction with the DataSphere project.