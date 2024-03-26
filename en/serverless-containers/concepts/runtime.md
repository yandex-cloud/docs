# Runtime environment

The application is run in a virtual environment.

Runtime environment characteristics:

* Operating system: Ubuntu 22.04 LTS.
* Linux kernel: 5.15.
* Architecture: AMD64.

## Supported languages and images {#image}

You can write your application in any programming language and have it use any image that meets the following requirements:
* The executables are compiled under Linux x86_64.
* Available image formats: [Docker Image Manifest V 2, Schema 2](https://docs.docker.com/registry/spec/manifest-v2-2/) and [OCI Image Format](https://github.com/opencontainers/image-spec).

## Container response {#response}

{% include [port-variable-note.md](../../_includes/serverless-containers/port-variable-note.md) %}

After receiving a request, a container instance must send a response within the timeout specified in the **{{ ui-key.yacloud.serverless-containers.label_timeout }}** field of the container revision settings. It includes the container instance launch time. Otherwise, the request terminates returning a 504 error.

## Environment variables {#environment-variables}

The table provides a list of environment variables defined in the {{ serverless-containers-name }} runtime and available to an application. You cannot override these.

| Key | Value |
---- | ----
| PORT | Network port the runtime uses to send HTTP requests to an application. |

You can add other environment variables when you [create a container revision](../operations/manage-revision.md#create) or build a [Docker image](../../container-registry/concepts/docker-image.md). The [limit](./limits.md#serverless-containers-limits) for maximum environment variable size, including variable names, is 4 KB.

You cannot calculate environment variables. Environment variable values are string constants. You can only calculate these within application code.

You can retrieve environment variables using standard programming language tools.

## File system {#file-system}

The container image files and directories are readable on the virtual environment file system. The file system is writable. The space available for writing is limited. For more detail, please see [Quotas and limits](./limits.md).

The file system is stored in RAM. Data written to the file system is not saved when a container instance is stopped.

## Container instance resources {#resource}

### CPU {#cpu}

A CPU resource is allocated whenever a container instance is processing at least one request. Currently, no more than 2 vCPUs may be allocated.

### RAM {#ram}

Each container instance is allocated RAM. The default value is 128 MB.

For example, RAM is consumed for:

* File system writes
* Container process launches
* Request processing

### Ratio between RAM and vCPU {#ratio}

The number of available cores depends on the specified RAM size.

| RAM | CPU |
--- | ---
| 128 MB to less than 4 GB | 1 vCPU with a guaranteed vCPU share up to 100% |
| 4 GB | 2 vCPUs with a guaranteed vCPU share of 100% |

## Metadata service {#metadata}

The metadata service is available inside the container's virtual runtime environment. Using it, you can [get an IAM token for a service account](../operations/sa.md) if you specified the service account when creating the container revision.
