# Docker-образ

При создании виртуальной машины на базе Container Optimized Image есть возможность указать [Docker-образ](../../container-registry/concepts/docker-image.md), на основе которого будет запущен [Docker-контейнер](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers).

Этот Docker-образ может быть загружен как из публичного реестра Docker-образов, так и из Yandex Container Registry. В случае использования Container Registry для доступа к Docker-образу будет использован привязанный к ВМ [сервисный аккаунт](../../iam/concepts/index.md#sa). Образ Container Optimized Image в реестре Container Registry может обновляться и меняться в соответствии с [релизами](../release-notes.md). При этом образ на ВМ не обновится автоматически до последней версии.

Пример имени Docker-образа для разных реестров:
* Docker Hub: `ubuntu:16.04`.
* Container Registry: `cr.yandex/<идентификатор_реестра>/ubuntu:16.04`.

## Примеры использования {#examples}

* [Передача логов с Container Optimized Image в Yandex Cloud Logging](../tutorials/coi-fluent-bit-logging.md)
* [Запуск контейнерного приложения в Yandex Serverless Containers](../tutorials/deploy-app-container.md)
* [Создание ВМ с Container Optimized Image и несколькими Docker-контейнерами](../tutorials/docker-compose.md)
* [Настройка вывода информации из Docker-контейнера в серийный порт](../tutorials/serial-port.md)