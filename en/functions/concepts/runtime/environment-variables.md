---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Environment

## Environment variables {#env}

A list of environment variables that are defined in the {{ sf-name }} runtime environment and can be used by functions.

| Key | Value |
| ---- | ---- |
| `_HANDLER` | The handler location specified for the function. |
| `AWS_LAMBDA_RUNTIME_API` | The runtime host and API port. |
| `LAMBDA_RUNTIME_DIR` | The path to the runtime libraries. |
| `LAMBDA_TASK_ROOT` | The path to your function code. |
| `PATH` | The set of folders with executable files. |

You can [add environment variables](../../operations/function/version-manage.md#version-env) in the management console.

## User files {#files}

User files are stored in two directories:

- `/function/code`: The user's working directory. It contains all the code of your function and all the files uploaded as a ZIP archive. You can use a relative path to access it.
- `/tmp`: A directory to store temporary files used for optimizing repeated function instance calls. [The maximum size of temporary files is limited](../limits.md#limits) to 512 MB.

