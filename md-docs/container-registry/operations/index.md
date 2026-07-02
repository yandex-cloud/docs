[Документация Yandex Cloud](../../index.md) > [Yandex Container Registry](../index.md) > Пошаговые инструкции > Все инструкции

# Пошаговые инструкции для Container Registry

Чтобы работать с Docker-образами, [настройте Docker](configure-docker.md) и [аутентифицируйтесь в Container Registry](authentication.md).

## Управление Docker-образом {#docker-images}

* [Получить информацию об имеющихся Docker-образах](docker-image/docker-image-list.md)
* [Создать Docker-образ](docker-image/docker-image-create.md)
* [Загрузить Docker-образ в реестр](docker-image/docker-image-push.md)
* [Скачать Docker-образ из реестра](docker-image/docker-image-pull.md)
* [Удалить Docker-образ из реестра](docker-image/docker-image-delete.md)

## Управление Helm-чартом {#helm-charts}

* [Получить информацию об имеющихся Helm-чартах](helm-chart/helm-chart-list.md)
* [Загрузить Helm-чарт в реестр](helm-chart/helm-chart-push.md)
* [Скачать Helm-чарт из реестра](helm-chart/helm-chart-pull.md)
* [Удалить Helm-чарт из реестра](helm-chart/helm-chart-delete.md)

## Управление реестром {#registry}

* [Получить информацию об имеющихся реестрах](registry/registry-list.md)
* [Создать реестр](registry/registry-create.md)
* [Настроить доступ к реестру](registry/registry-access.md)
* [Изменить реестр](registry/registry-update.md)
* [Получить информацию о политике доступа к реестру](registry/registry-permissions-get.md)
* [Удалить реестр](registry/registry-delete.md)

## Управление репозиторием {#repository}

* [Получить информацию об имеющихся репозиториях](repository/repository-list.md)
* [Создать репозиторий](repository/repository-create.md)

## Управление политиками автоматического удаления Docker-образов {#lifecycle-policy}

* [Получить информацию о политиках удаления](lifecycle-policy/lifecycle-policy-list.md)
* [Создать политику удаления](lifecycle-policy/lifecycle-policy-create.md)
* [Изменить политику удаления](lifecycle-policy/lifecycle-policy-update.md)
* [Протестировать политику удаления](lifecycle-policy/lifecycle-policy-dry-run.md)
* [Удалить политику удаления](lifecycle-policy/lifecycle-policy-delete.md)

## Сканирование Docker-образа на наличие уязвимостей {#scanning}

* [Сканирование Docker-образа на наличие уязвимостей](scanning-docker-image.md)

## Создание триггера для реестра {#trigger}

* [Создание триггера для реестра](trigger-create.md)

## Работа с ролями {#roles}

* [Назначить роль на ресурс](roles/grant.md)
* [Просмотреть роли на ресурс](roles/get-assigned-roles.md)
* [Отозвать роль на ресурс](roles/revoke.md)

## Работа с Container Optimized Image {#coi}

Подробнее о том, как работать с образом Container Optimized Image, читайте в документации [Container Solution](../../cos/index.md).