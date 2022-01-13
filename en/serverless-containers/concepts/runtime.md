# Runtime environment

The application is run in a virtual environment. The container image files and directories are readable on the virtual environment file system. The file system is writable. Space available for writing is limited, for more information, see [Quotas and limits](./limits.md).

Runtime environment characteristics:

* Operating system: Ubuntu 18.04 LTS.
* Linux kernel: 4.19.
* Architecture: AMD64.

## Environment variables

The table provides a list of environment variables defined in the {{ serverless-containers-name }} runtime and available to an application. You cannot override these.

| Key | Value |
| ---- | ---- |
| PORT | Network port the runtime uses to send HTTP requests to an application. |

You can add other environment variables when you [create a container revision](../operations/manage-revision.md#create) or build a Docker image. Environment variables, including variable names, are [limited](./limits.md#serverless-containers-limits) to 4 KB of space.

You cannot calculate environment variables. Environment variable values are string constants. You can only calculate these within application code.

You can retrieve environment variables using standard programming language tools.

## Metadata service

The metadata service is available inside the container's virtual runtime environment. Using it, you can [get an IAM token for a service account](../operations/sa.md) if you specified the service account when creating the container revision.

