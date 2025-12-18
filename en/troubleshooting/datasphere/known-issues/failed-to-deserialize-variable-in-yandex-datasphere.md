# Fixing the `Failed to deserialize variable` error


## Issue description {#issue-description}

When you open a {{ ml-platform-name }} project, you see the following error message: 
```
Failed to deserialize variable %VAR_NAME%
Run the following code to delete it: del_datasphere_variables
```
Where `%VAR_NAME%` is the name of the variable the system was unable to deserialize.

## Solution {#issue-resolution}

`The following variables cannot be serialized` means that some variables cannot be serialized and saved. The interpreter keeps its current state when the configuration changes. All computation results, including variable values, are also saved. 

{% note info %}

Since some variables cannot get serialized, they cannot be saved. For example, let's assume there is a variable with a file open for writing: `f = open("file.txt", "w")`. You will see the following warning when assigning values to such variables: `The following variables cannot be serialized`. Such a warning will not affect your code execution and further computation results.

{% endnote %}

`Run the following code to delete it: del_datasphere_variables` means that the variable previously resided in GPU memory but was not moved to the current CPU memory. 

The error message suggests how to reset the variable: use the `del_datasphere_variables` method to delete it, and then run all associated cells in the same configuration.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Project URL from the browser address bar.
1. Full text of the error message.
1. [HAR file](../../../support/create-har.md) with the recorded communications between the browser and the server hosting the {{ ml-platform-name }} project.