# Контейнер

Контейнер позволяет запустить в {{ yandex-cloud }} приложение, которое содержится в Docker-образе. После создания ревизии контейнера его можно вызвать:
* через HTTPS;
* с помощью триггера {{ sf-full-name }};
* с помощью расширения {{ api-gw-full-name }}.

Подробнее о [вызове контейнера](./invoke.md).

## Ревизия контейнера {#revision}

Ревизия контейнера создается из Docker-образа, который размещен в {{ container-registry-full-name }}. Ревизия содержит всю информацию, необходимую для запуска контейнера.

{% include [manage-revision-note](../../_includes/serverless-containers/manage-revision-note.md) %}

{% include [create-revision-note](../../_includes/serverless-containers/create-revision-note.md) %}

{% include [revision-service-account-note](../../_includes/serverless-containers/revision-service-account-note.md) %}

## Масштабирование контейнера {#scale}

Поступающие запросы обрабатываются контейнером по одному. Если контейнер вызывается быстрее, чем один экземпляр успевает обрабатывать запрос, сервис масштабирует контейнер — запускает его дополнительные экземпляры. Таким образом обеспечивается параллельная обработка запросов. Вы можете [изменить](../operations/manage-revision.md##create) максимальное количество одновременных вызовов одного экземпляра контейнера.
