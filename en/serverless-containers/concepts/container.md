# Container

Containers enable you to launch an application in a Docker image in {{ yandex-cloud }}. After creating a container revision, you can invoke it:

* Over HTTPS.
* Using a {{ sf-full-name }} trigger.
* Using a {{ api-gw-full-name }} extension.

Learn more about [invoking a container](./invoke.md).

## Container revision {#revision}

A container revision is created from a Docker image hosted in {{ container-registry-full-name }}. The revision contains all the information needed to run the container.

{% include [manage-revision-note](../../_includes/serverless-containers/manage-revision-note.md) %}

{% include [create-revision-note](../../_includes/serverless-containers/create-revision-note.md) %}

{% include [revision-service-account-note](../../_includes/serverless-containers/revision-service-account-note.md) %}

## Scaling a container {#scale}

Incoming requests are processed by the container one at a time. If the container is called faster than one instance can process the request, the service scales the container by running additional container instances. This ensures concurrent  request processing.

