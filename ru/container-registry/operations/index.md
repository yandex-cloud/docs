---
title: "Как работать с Docker-образами. Пошаговые инструкции"
description: "Пошаговые инструкции по работе с Docker-образами в {{ yandex-cloud }}. Из статьи вы узнаете, как управлять Docker-образом, реестром, репозиторием и автоматическими политиками. Подробно рассказываем о создании, удалении, загрузке и скачиванию Docker-образов."
---

# Пошаговые инструкции для {{ container-registry-name }}

Чтобы работать с Docker-образами, [аутентифицируйтесь в {{ container-registry-name }}](authentication.md).

## Работа с {{ coi }} {#coi}

Подробнее о том, как работать с образом {{ coi }}, читайте в документации [{{ cos-name }}](../../cos/).

## Управление Docker-образом {#docker-images}

* [{#T}](docker-image/docker-image-list.md)
* [{#T}](docker-image/docker-image-create.md)
* [{#T}](docker-image/docker-image-push.md)
* [{#T}](docker-image/docker-image-pull.md)
* [{#T}](docker-image/docker-image-delete.md)

## Управление Helm-чартом {#helm-charts}

* [{#T}](helm-chart/helm-chart-list.md)
* [{#T}](helm-chart/helm-chart-push.md)
* [{#T}](helm-chart/helm-chart-pull.md)
* [{#T}](helm-chart/helm-chart-delete.md)

## Управление реестром {#registry}

* [{#T}](registry/registry-list.md)
* [{#T}](registry/registry-create.md)
* [{#T}](registry/registry-access.md)
* [{#T}](registry/registry-update.md)
* [{#T}](registry/registry-permissions-get.md)
* [{#T}](registry/registry-delete.md)

## Управление репозиторием {#repository}

* [{#T}](repository/repository-list.md)
* [{#T}](repository/repository-create.md)

## Управление политиками автоматического удаления Docker-образов {#lifecycle-policy}

* [{#T}](lifecycle-policy/lifecycle-policy-list.md)
* [{#T}](lifecycle-policy/lifecycle-policy-create.md)
* [{#T}](lifecycle-policy/lifecycle-policy-update.md)
* [{#T}](lifecycle-policy/lifecycle-policy-dry-run.md)
* [{#T}](lifecycle-policy/lifecycle-policy-delete.md)

## Сканирование Docker-образа на наличие уязвимостей {#scanning}

* [{#T}](scanning-docker-image.md)

## Создание триггера для реестра {#trigger}

* [{#T}](trigger-create.md)

## Работа с ролями {#roles}

* [{#T}](roles/grant.md)
* [{#T}](roles/get-assigned-roles.md)
* [{#T}](roles/revoke.md)