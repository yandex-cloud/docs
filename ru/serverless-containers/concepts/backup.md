# Резервное копирование в {{ serverless-containers-name }}

Данные в сервисе {{ serverless-containers-name }} надежно хранятся и реплицируются в инфраструктуре {{ yandex-cloud }}. Вы можете получить:
* [списки контейнеров](#containers-list);
* [списки ревизий контейнеров](#revision-list);
* [информацию о ревизиях контейнеров](#revision-get);
* [списки триггеров](#trigger-list);
* [информацию о триггерах](#trigger-get).

О резервном копировании [Docker-образов](../../container-registry/concepts/docker-image.md), которые используются для создания ревизий контейнеров, читайте в [документации {{ container-registry-full-name }}](../../container-registry/concepts/backup.md).

## Получить список контейнеров {#containers-list}

{% include [container-list](../../_includes/serverless-containers/container-list.md) %}

## Получить список ревизий контейнера {#revision-list}

{% include [container-list](../../_includes/serverless-containers/revision-list.md) %}

## Получить информацию о ревизии контейнера {#revision-get}

{% include [container-ger](../../_includes/serverless-containers/revision-get.md) %}

## Получить список триггеров {#trigger-list}

{% include [version-list](../../_includes/serverless-containers/trigger-list.md) %}

## Получить информацию о триггере {#trigger-get}

{% include [version-list](../../_includes/serverless-containers/trigger-get.md) %}
