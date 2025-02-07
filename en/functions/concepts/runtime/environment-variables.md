---
title: Function environment content in {{ sf-full-name }}
description: In this tutorial, you will learn what a function environment consists of in {{ sf-name }}.
---

# Environment

## Environment variables {#env}

The table provides a list of environment variables defined in the {{ sf-name }} runtime and available to a function. You cannot override these.

Key | Value
---- | ----
`_HANDLER` | Handler location specified for the function. 
`AWS_LAMBDA_RUNTIME_API` | Runtime host and API port.
`LAMBDA_RUNTIME_DIR` | Path to runtime libraries.
`LAMBDA_TASK_ROOT` | Path to folder containing your function's files.
`PATH` | Set of folders containing the executables.
`LD_LIBRARY_PATH` | Set of folders containing the [dynamic libraries](#dynamic-library).

You can [add other environment variables](../../operations/function/environment-variables-add.md) when creating a function version. The [limit](../limits.md#functions-limits) for maximum environment variable size, including variable names, is 4 KB.

You cannot calculate environment variables. Environment variable values are string constants. You can only calculate these within function code.

You can retrieve environment variables using standard programming language tools.

## Certificate for accessing managed databases {#mdb-certificate}

The environment has an SSL certificate available for accessing managed databases from your code. The certificate is stored in the `/usr/local/share/ca-certificates/yandex-internal-ca.crt` file.

## User files {#files}

User files are stored in two directories:

* `/function/code`: User's working directory. It contains all the code of your function and all the files uploaded as a ZIP archive. You can use a relative path to access it.
* `/tmp`: Directory for temporary files. It is used by the service to optimize repeat function calls that are sequentially processed by one of its instances. When a function instance ceases to operate, the data is deleted from `/tmp`. The maximum size of temporary files is [limited](../limits.md#functions-limits) to 512 MB.

    When creating a function version, you can [allocate some of the function instance's RAM](../../operations/function/allocate-memory-tmp.md) for the `tmp` directory. The specified amount of RAM will thus be mounted as a RAM disk to the `/tmp` directory. A function version needs at least 1 GB of RAM.

    If you enable **Allocate memory for the /tmp directory**, [preloaded runtime environments](preload-runtime.md) start as regular ones.

## Dynamic libraries {#dynamic-library}

If a function requires dynamic libraries to operate, these can be [uploaded as a ZIP archive](../function.md#upload), in the `/shared-libs` directory at the root of the archive. The directory will be added to the `LD_LIBRARY_PATH` environment variable.

The dynamic libraries must be assembled on Ubuntu 18.04 LTS and linked with `libc` 2.27.
