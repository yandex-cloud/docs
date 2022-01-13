# Environment

## Environment variables {#env}

The table provides a list of environment variables defined in the {{ sf-name }} runtime and available to a function. You cannot override these.

| Key | Value |
| ---- | ---- |
| `_HANDLER` | The handler location specified for the function. |
| `AWS_LAMBDA_RUNTIME_API` | The runtime host and API port. |
| `LAMBDA_RUNTIME_DIR` | Path to runtime libraries. |
| `LAMBDA_TASK_ROOT` | Path to folder containing external function files. |
| `PATH` | The set of folders with executable files. |

You can [add other environment variables](../../operations/function/version-manage.md#version-env) when creating a function version. Environment variables, including variable names, are [limited](../limits.md#limits) to 4 KB of space.

You cannot calculate environment variables. Environment variable values are string constants. You can only calculate these within function code.

You can retrieve environment variables using standard programming language tools.

## User files {#files}

User files are stored in two directories:

- `/function/code`: The user's working directory. It contains all the code of your function and all the files uploaded as a ZIP archive. You can use a relative path to access it.
- `/tmp`: directory for temporary files. It is used by the service to optimize repeat function calls that are sequentially processed by one of its instances. When a function instance runs its course, its data in `/tmp` are deleted. [The maximum size](../limits.md#limits) of temporary files is limited to 512 MB.

