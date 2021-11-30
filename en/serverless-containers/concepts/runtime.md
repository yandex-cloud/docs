# Runtime environment

The application is run in a virtual environment. The container image files and directories are readable on the virtual environment file system. The file system is writable. Space available for writing is limited, for more information, see [Quotas and limits](./limits.md).

Runtime environment characteristics:
* Operating system: Ubuntu 18.04 LTS.
* Linux kernel: 4.14.
* Architecture: AMD64.

## Environment variables

List of environment variables defined in the {{ serverless-containers-name }} runtime environment and available to the application:
Key  | Value
---- | ----
PORT | Network port to which the runtime environment passes HTTP queries to the application.

You can add environment variables when you [create a container revision](../operations/manage-revision.md#create) or build a Docker image.

## Metadata service

The metadata service is available inside the container's virtual runtime environment. Using it, you can [get an IAM token for a service account](../operations/sa.md) if you specified the service account when creating the container revision.