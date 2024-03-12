---
title: "Containers in {{ serverless-containers-full-name }}"
---

# Container

Containers enable you to launch an application in a [Docker image](../../container-registry/concepts/docker-image.md) in {{ yandex-cloud }}. After creating a container revision, you can invoke it:
* Over HTTPS.
* Using a trigger.
* Using a {{ api-gw-full-name }} extension.

Learn more about [invoking a container](./invoke.md).

## Container revision {#revision}

You can only create a container revision from a Docker image uploaded to a [registry](../../container-registry/concepts/registry) in {{ container-registry-full-name }}. No other registries are supported. The revision contains all the information needed to run the container.

Possible revision statuses include:
* `Active`
* `Obsolete`

Invoking a container triggers the active revision. By default, it is the latest revision, but you have the option to [change the active revision](../operations/activate-revision.md). When you create a new revision, it automatically becomes active.

{% include [manage-revision-note](../../_includes/serverless-containers/manage-revision-note.md) %}

{% include [create-revision-note](../../_includes/serverless-containers/create-revision-note.md) %}

{% include [revision-service-account-note](../../_includes/serverless-containers/revision-service-account-note.md) %}

## Scaling a container {#scaling}

A container instance processes one container invocation at a single point in time. If the container is invoked faster than the instance can process the request, the service scales the container by running additional container instances. This ensures _concurrent request processing_.


You can [change](../operations/manage-revision.md#create) the maximum number of concurrent invocations of a single container instance and [specify](../operations/scaling-settings-add.md) the number of provisioned container instances.


{% include [provisioned-instances-time](../../_includes/functions/provisioned-instances-time.md) %}


### Provisioned instances {#provisioned-instances}

A _provisioned instance_ is a container instance that, when started, is guaranteed not to have a cold start. In the provisioned instance before the container is invoked:
* {{ serverless-containers-name }} runtime environment components are initialized.
* The user application is loaded and initialized.

{% include [provisioned-instances-price](../../_includes/serverless-containers/provisioned-instances-price.md) %}

If the number of container invocations exceeds the number of provisioned instances, {{ serverless-containers-name }} scales the container within the [quotas](limits.md#functions-quotas), but unprovisioned instances have a cold start when they are first started.

Provisioned instances count towards the following [quotas](limits.md) even when they are not running:
* Number of container instances per availability zone.
* Total RAM for all running container instances per availability zone.
* Number of provisioned container instances per cloud.



#### See also

* [Creating a container revision.](../operations/manage-revision.md#create)
* [Adding scaling settings.](../operations/scaling-settings-add.md)
