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

### Use cases {#examples}

* [{#T}](../../tutorials/datalens.md)
* [{#T}](../../tutorials/monitoring.md)
* [{#T}](../../tutorials/nodejs-cron-restart-vm.md)

## Certificate for accessing managed databases {#mdb-certificate}

The environment has an SSL certificate available for accessing managed databases from your code. The certificate is stored in the `/usr/local/share/ca-certificates/yandex-internal-ca.crt` file.

## Trusted root certificates {#trusted-certificates}

You can access the trusted certificate system store at `/etc/ssl/certs/ca-certificates.crt`. Apart from the standard public certificate authorities, it includes:

* Russian Trusted Root CA.
* {{ yandex-cloud }}'s in-house certificate authority.

Trusted certificates are supported in all runtimes (Node.js 22, Python 3.12, PHP 8.2, Go 1.23, Java 21, Kotlin 2.0, .NET Core 8, R 4.3, Bash 22.04 and higher), while trusted certificate system stores, in all runtimes, except for Node.js and Python. For more information on working with trusted certificates in Node.js and Python, see the relevant sections below.

Code that uses a trusted certificate system store trusts the added certificates without any additional settings. You do not need to disable the TLS check. However, if the web site provides an incomplete certificate chain and does not provide an intermediate certificate, you need to add the missing intermediate certificate together with the function code.

### Python {#python-certificates}

The `requests` library verifies certificates against the `certifi` package bundle rather than the system store. In the {{ sf-name }} runtime, this bundle already includes the Russian CA root certificate and {{ yandex-cloud }}'s in-house CA root certificate.

If you specify `requests` or `certifi` in the `requirements.txt` file, a copy of `certifi` will be installed in the function code during the build without any added certificates, and `requests` will use it instead of the preset one. In this case, explicitly specify the runtime bundle using one of these methods:

* Add the `REQUESTS_CA_BUNDLE` function version's [environment variable](../../operations/function/environment-variables-add.md) set to `/function/runtime/yc-ca-bundle.crt`.
* Provide the bundle under `verify` when calling `requests`:

    ```python
    import requests
    requests.get(url, verify="/function/runtime/yc-ca-bundle.crt")
    ```

### Node.js {#nodejs-certificates}

Node.js does not use a trusted certificate system store; therefore, the runtime uses the `NODE_EXTRA_CA_CERTS` environment variable to provide the bundle path to it.

Do not set `NODE_EXTRA_CA_CERTS` in the function version's environment variables: Node.js reads this variable only when starting a process, and the set value will not apply. However, it will overwrite the value set by the runtime, and the function will stop trusting the added certificates.

To add an additional certificate to Node.js functions, enable it from code using the HTTP client or TLS context parameters.

## User files {#files}

User files are stored in two directories:

* `/function/code`: User's working directory. It contains all the code of your function and all the files uploaded as a ZIP archive. You can use a relative path to access it.
* `/tmp`: Directory for temporary files. It is used by the service to optimize repeat function calls that are sequentially processed by one of its instances. When a function instance ceases to operate, the data is deleted from `/tmp`. The maximum size of temporary files is [limited](../limits.md#functions-limits) to 512 MB.

    When creating a function version, you can [allocate some of the function instance's RAM](../../operations/function/allocate-memory-tmp.md) for the `tmp` directory. The specified amount of RAM will thus be mounted as a RAM disk to the `/tmp` directory. A function version needs at least 1 GB of RAM.

    If you enable **Allocate memory for the /tmp directory**, [preloaded runtime environments](preload-runtime.md) start as regular ones.

## Dynamic libraries {#dynamic-library}

If a function requires dynamic libraries to operate, these can be [uploaded as a ZIP archive](../function.md#upload), in the `/shared-libs` directory at the root of the archive. The directory will be added to the `LD_LIBRARY_PATH` environment variable.

The dynamic libraries must be assembled on Ubuntu 18.04 LTS and linked with `libc` 2.27.
