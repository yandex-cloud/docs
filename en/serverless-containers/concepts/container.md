---
title: Containers in {{ serverless-containers-full-name }}
description: In this article, you will learn about containers, their revision, and scaling.
---

# Container

A container allows you to run in {{ yandex-cloud }} the application contained in a [Docker image](../../container-registry/concepts/docker-image.md). After creating a container revision, you can invoke it:
* Over HTTPS.
* Using a trigger.
* Using a {{ api-gw-full-name }} extension.

Learn more about [invoking a container](./invoke.md).

## Container revision {#revision}

You can only create a container revision from a Docker image uploaded to a [registry](../../container-registry/concepts/registry.md) in {{ container-registry-full-name }}. No other registries are supported. The revision contains all the information you need to run the container.

Possible revision statuses include:
* `Active`: Active
* `Obsolete`: Obsolete

Invoking a container triggers the active revision. By default, it is the latest revision, but you have the option to [change the active revision](../operations/activate-revision.md). When you create a new revision, it automatically becomes active.

{% include [manage-revision-note](../../_includes/serverless-containers/manage-revision-note.md) %}

{% include [create-revision-note](../../_includes/serverless-containers/create-revision-note.md) %}

{% include [revision-service-account-note](../../_includes/serverless-containers/revision-service-account-note.md) %}

## Container instance {#container-instance}

A container instance is a virtual machine with:

* A loaded operating system.
* A running bootstrap process.
* Initialized {{ serverless-containers-name }} runtime environment components.
* A loaded and initialized user application.

{{ serverless-containers-name }} uses internal rules to dynamically manage the virtual machine lifecycle. These rules may change as the service evolves.

### Creating an instance {#instance-creating}

When a container is called, one of these two events takes place:

* A new container instance is started to process the call.
* The call is redirected to an already running container instance, either one that was not terminated after processing the previous calls or one that was created by the service in background before the user's request came in.

When deciding whether to start a new instance, {{ serverless-containers-name }} considers the following:

* Load on already running instances.
* Number of calls awaiting processing.
* Container [scaling settings](#scaling).
* [Quota usage](limits.md#serverless-containers-quotas).

#### The process of starting an instance {#starting-process}

1. {{ serverless-containers-name }} selects a service cluster node taking into consideration the resources (CPU, RAM, network), loaded user app images, and other factors affecting the duration of starting an instance. Priority is given to the node that ensures the shortest start. Start duration time may vary. Thus, it will be shorter if the node has cached the user app image from the previous call.
1. On the cluster node thus selected, a virtual machine starts. The service configures the virtual machine's network interfaces, allocates CPU and RAM resources, and connects disk images containing the operating system and user app.
1. The virtual machine starts the Linux core and the bootstrap process.
1. Following initialization, the bootstrap process starts the user app.

### Instance operation {#instance-work}

Once created, the instance can process calls. Calls sent to the instance enter a queue from where they are taken for execution. The result of call processing is forwarded to the sender. When there are no calls left, the instance stays in RAM for a variable time that depends on factors like container execution timeout.

### Suspending an instance {#instance-suspending}

If the new instance receives no new calls for a certain period of time, it gets suspended. The operating system and the running processes remain in RAM but are not processed by the CPU. The instance resumes operation in the following cases:

* It gets a new call.
* A service cycle is initiated to get the instance up and running again, e.g., to update timers or run maintenance tasks of the guest OS.
* Prior to [terminating the instance](#instance-termination).

{% note info %}

When suspended, the instance does not consume CPU resources; therefore, its network connections may get terminated. The user app must handle cases like this correctly.

{% endnote %}

### Terminating an instance {#instance-termination}

{{ serverless-containers-name }} decides to terminate a running instance based on a number of factors, for example:

* There are no new calls for an extended period of time.
* Container execution timeout has been reached.
* An unrecoverable runtime error was encountered.

In some cases, the service may [forcibly terminate](long-lived-containers.md#possible-termination) a container instance. In which case the user app will get a [notification](termination-notifications.md) about the upcoming forced termination.

## Container operation mode {#runtime}

{{ serverless-containers-name }} supports the following container operation modes:

Operation mode | How it works | Result returned when a container is invoked successfully | Data on the HTTP request to a container | Constraints
--- | --- | --- | --- | ---
**HTTP server** | HTTP requests to the container are received by an HTTP server, which must be running on the port specified in the `PORT` [environment variable](runtime.md#environment-variables). {{ serverless-containers-name }} sets the variable value automatically. | An HTTP response received from the HTTP server. When forwarded to the container, some HTTP response headers [get modified](invoke.md#filter) | Provided in an HTTP request to the HTTP server | —
**Commands** | Each HTTP request to the container initiates the `ENTRYPOINT` instructions from a Dockerfile or the commands set when [creating a revision](../operations/manage-revision.md). If the commands are set, they will override the `ENTRYPOINT` instructions from Dockerfile | Response code 200 and termination code in the `X-Task-Exit-Code` response header | Specified in the file located at the path from the`REQUEST_PATH` environment variable | Maximum number of concurrent requests to a single container instance: 1

## Scaling a container {#scaling}

A container instance processes one container invocation at a single point in time. If the container is invoked faster than the instance can process the request, the service scales the container by running additional instances of it. This ensures _concurrent request processing_.

To reduce the number of cold starts, {{ serverless-containers-name }} creates container instances in the background, not for the purpose of processing user requests. The number of instances created this way does not exceed the quota.

In addition, in {{ serverless-containers-name }}, you can [change](../operations/manage-revision.md#create) the maximum number of concurrent invocations of a single container instance and [specify](../operations/scaling-settings-add.md) the number of provisioned container instances.

{% include [provisioned-instances-time](../../_includes/functions/provisioned-instances-time.md) %}

### Provisioned instances {#provisioned-instances}

A _provisioned instance_ is a container instance that is guaranteed not to have a cold start when you run it. In the provisioned instance before the container is invoked:
* {{ serverless-containers-name }} runtime environment components are initialized.
* The user application is loaded and initialized.

The initialization and operation processes of a simple and provisioned container instances are identical. A provisioned instance is remains suspended and does not consume CPU unit it begins processing a call.

{% include [provisioned-instances-price](../../_includes/serverless-containers/provisioned-instances-price.md) %}

If the number of container invocations exceeds the number of provisioned instances, {{ serverless-containers-name }} scales the container within the [quotas](limits.md#functions-quotas), but unprovisioned instances have a cold start when they are first started.

Provisioned instances count towards the following [quotas](limits.md) even when they are not running:
* Number of container instances per availability zone.
* Total RAM for all running container instances per availability zone.	
* Number of provisioned container instances per cloud.

## Use cases {#examples}

* [{#T}](../tutorials/movies-database.md)
* [{#T}](../tutorials/pg-connect.md)
* [{#T}](../tutorials/deploy-app-container.md)
* [{#T}](../tutorials/functions-framework-to-container.md)

#### See also

* [Creating a container revision](../operations/manage-revision.md#create)
* [Adding scaling settings](../operations/scaling-settings-add.md)

