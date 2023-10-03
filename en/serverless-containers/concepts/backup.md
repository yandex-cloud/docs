# Backups in {{ serverless-containers-name }}

Data in {{ serverless-containers-name }} is stored securely and replicated within the {{ yandex-cloud }} infrastructure. You can get:
* [List of containers](#containers-list).
* [Container revision lists](#revision-list).
* [Information about container revisions](#revision-get).
* [Lists of triggers](#trigger-list).
* [Information about triggers](#trigger-get).

For more information about backing up [Docker images](../../container-registry/concepts/docker-image.md) used to create container revisions, see the [{{ container-registry-full-name }} documentation](../../container-registry/concepts/backup.md).

## Getting a container list {#containers-list}

{% include [container-list](../../_includes/serverless-containers/container-list.md) %}

## Getting a container revision list {#revision-list}

{% include [revision-list](../../_includes/serverless-containers/revision-list.md) %}

## Getting information about a container revision {#revision-get}

{% include [revision-get](../../_includes/serverless-containers/revision-get.md) %}

## Getting a list of triggers {#trigger-list}

{% include [trigger-list](../../_includes/serverless-containers/trigger-list.md) %}

## Getting information about a trigger {#trigger-get}

{% include [trigger-get](../../_includes/serverless-containers/trigger-get.md) %}
