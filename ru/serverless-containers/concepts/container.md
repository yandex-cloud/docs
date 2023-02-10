# Контейнер

Контейнер позволяет запустить в {{ yandex-cloud }} приложение, которое содержится в [Docker-образе](../../container-registry/concepts/docker-image.md). После создания ревизии контейнера его можно вызвать:
* через HTTPS;
* с помощью триггера;
* с помощью расширения {{ api-gw-full-name }}.

Подробнее о [вызове контейнера](./invoke.md).

## Ревизия контейнера {#revision}

Ревизия контейнера создается из Docker-образа, который размещен в {{ container-registry-full-name }}. Ревизия содержит всю информацию, необходимую для запуска контейнера.

{% include [manage-revision-note](../../_includes/serverless-containers/manage-revision-note.md) %}

{% include [create-revision-note](../../_includes/serverless-containers/create-revision-note.md) %}

{% include [revision-service-account-note](../../_includes/serverless-containers/revision-service-account-note.md) %}

## Масштабирование контейнера {#scaling}

Экземпляр контейнера обрабатывает один его вызов в один момент времени. Если контейнер вызывается быстрее, чем экземпляр успевает обработать запрос, сервис масштабирует контейнер — запускает его дополнительные экземпляры. Таким образом обеспечивается _параллельная обработка запросов_.

Можно [изменить](../operations/manage-revision.md#create) максимальное количество одновременных вызовов одного экземпляра контейнера и [указать](../operations/scaling-settings-add.md) количество подготовленных экземпляров контейнера.

### Подготовленные экземпляры {#provisioned-instances}

_Подготовленный экземпляр_ — это экземпляр контейнера, при запуске которого гарантированно нет холодного старта. В подготовленном экземпляре до вызова контейнера:
* инициализируются компоненты среды выполнения {{ serverless-containers-name }};
* загружается и инициализируется пользовательское приложение.

{% include [provisioned-instances-price](../../_includes/serverless-containers/provisioned-instances-price.md) %}

Если количество вызовов контейнера превышает количество подготовленных экземпляров, {{ serverless-containers-name }} масштабирует контейнер в пределах [квот](limits.md#functions-quotas), но в неподготовленных экземплярах при их первом запуске происходит холодный старт.

#### См. также

* [Создать ревизию контейнера.](../operations/manage-revision.md#create)
* [Добавить настройки масштабирования.](../operations/scaling-settings-add.md)

