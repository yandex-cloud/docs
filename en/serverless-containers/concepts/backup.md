# Backups

Data in {{ serverless-containers-name }} is stored securely and replicated within the {{ yandex-cloud }} infrastructure. You can get:

* [Container lists](containers-list).
* [Container revision lists](#revision-list).
* [Information about container revisions](#revision-get).

For more information about backing up Docker images used to create container revisions, see the [{{ container-registry-full-name }} documentation](../../container-registry/concepts/backup.md).

## Getting a container list {#containers-list}

{% include [container-list](../../_includes/serverless-containers/container-list.md) %}

## Getting a container revision list {#revision-list}

{% include [container-list](../../_includes/serverless-containers/revision-list.md) %}

## Getting information about a container revision {#revision-get}

{% include [container-ger](../../_includes/serverless-containers/revision-get.md) %}

