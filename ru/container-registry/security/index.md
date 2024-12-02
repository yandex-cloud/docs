---
title: Управление доступом в {{ container-registry-full-name }}
description: Управление доступом в сервисе для хранения и распространения Docker-образов — {{ container-registry-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом в {{ container-registry-name }}

В этом разделе вы узнаете:
* [На какие ресурсы можно назначить роль](#resources).
* [Какие роли действуют в сервисе](#roles-list).
* [Какие роли необходимы](#choosing-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `container-registry.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Вы также можете назначать роли на отдельные ресурсы сервиса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Через [консоль управления]({{ link-console-main }}) вы можете назначить роли на [реестр](../concepts/registry.md).

- CLI {#cli}

  Через [{{ yandex-cloud }} CLI](../../cli/cli-ref/container/cli-ref/index.md) вы можете назначить роли на следующие ресурсы:

  * [Реестр](../concepts/registry.md)
  * [Репозиторий](../concepts/repository.md)

- {{ TF }} {#tf}

  Через [{{ TF }}]({{ tf-provider-link }}) вы можете назначить роли на следующие ресурсы:

  * [Реестр](../concepts/registry.md)
  * [Репозиторий](../concepts/repository.md)

- API {#api}

  Через [API {{ yandex-cloud }}](../api-ref/authentication.md) вы можете назначить роли на следующие ресурсы:

  * [Реестр](../concepts/registry.md)
  * [Репозиторий](../concepts/repository.md)

{% endlist %}

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/container-registry/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### container-registry.viewer {#container-registry.viewer}

{% include [container-registry.viewer](../../_roles/container-registry/viewer.md) %}

#### container-registry.editor {#container-registry.editor}

{% include [container-registry.editor](../../_roles/container-registry/editor.md) %}

#### container-registry.admin {#container-registry.admin}

{% include [container-registry.admin](../../_roles/container-registry/admin.md) %}

#### container-registry.images.pusher {#container-registry-images-pusher}

{% include [container-registry.images.pusher](../../_roles/container-registry/images/pusher.md) %}

#### container-registry.images.puller {#container-registry-images-puller}

{% include [container-registry.images.puller](../../_roles/container-registry/images/puller.md) %}

#### container-registry.images.scanner {#container-registry-images-scanner}

{% include [container-registry.images.scanner](../../_roles/container-registry/images/scanner.md) %}

Более подробную информацию о сервисных ролях читайте на странице [{#T}](../../iam/concepts/access-control/roles.md) в документации сервиса {{ iam-full-name }}.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.


Действие | Методы | Необходимые роли
--- | --- | ---
**Просмотр информации** |
[Получение списка реестров](../operations/registry/registry-list.md). | `list` | `container-registry.viewer` на каталог.
Получение информации о реестрах, [Docker-образах](../operations/docker-image/docker-image-list.md) и [репозиториях](../operations/repository/repository-list.md). | `get`, `list` | `container-registry.viewer` на реестр с указанным ресурсом.
[Скачивание Docker-образа](../operations/docker-image/docker-image-pull.md). | `pull` | `container-registry.images.puller`<br>на указанный реестр или репозиторий.
Получение информации о [политиках удаления](../operations/lifecycle-policy/lifecycle-policy-list.md) и результатах их [тестовых запусков](../operations/lifecycle-policy/lifecycle-policy-dry-run.md). | `get`, `list`, `getDryRunResult`, `listDryRunResults`| `container-registry.viewer` на реестр или репозиторий, для которого создана политика удаления.
**Управление ресурсами** |
[Создание реестров в каталоге](../operations/registry/registry-create.md). | `create` | `container-registry.editor` на каталог.
[Изменение](../operations/registry/registry-update.md) и [удаление](../operations/registry/registry-delete.md) реестров. | `update`, `delete` | `container-registry.editor` на указанный реестр.
[Создание Docker-образов](../operations/docker-image/docker-image-create.md) с использованием базовых Docker-образов из реестра. | — | `container-registry.images.puller`<br>на указанный реестр или репозиторий.
[Создание Docker-образов](../operations/docker-image/docker-image-create.md) без использования базовых Docker-образов из реестра. | — | Не требует ролей.
[Загрузка Docker-образов в реестр](../operations/docker-image/docker-image-push.md). | `push` | `container-registry.images.pusher`<br>на указанный реестр или репозиторий.
[Удаление Docker-образов](../operations/docker-image/docker-image-delete.md). | `delete` | `container-registry.images.pusher` на реестр или репозиторий с Docker-образом.
[Создание](../operations/lifecycle-policy/lifecycle-policy-create.md), [изменение](../operations/lifecycle-policy/lifecycle-policy-update.md), [удаление](../operations/lifecycle-policy/lifecycle-policy-delete.md) и [тестовый запуск](../operations/lifecycle-policy/lifecycle-policy-dry-run.md) политики удаления. | `create`, `update`, `delete`, `dryRun` | `container-registry.editor` на реестр или репозиторий, для которого создана политика удаления.
**Управление доступом к ресурсам** |
[Назначение роли](../../iam/operations/roles/grant.md), [отзыв роли](../../iam/operations/roles/revoke.md) и просмотр назначенных ролей на каталог, облако или реестр. | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` на этот ресурс.
**Сканирование на наличие уязвимостей** |
[Запуск сканирования](../operations/scanning-docker-image.md) Docker-образа. | `scan` | `container-registry.images.scanner` на реестр или репозиторий с Docker-образом.
Получение результатов сканирования Docker-образа. | `get`, `getLast`, `list`, `listVulnerabilities` | `container-registry.images.scanner` на реестр или репозиторий с Docker-образом.



#### Что дальше {what-is-next}

* [Назначить роль](../operations/roles/grant.md).
* [Посмотреть назначенные роли](../operations/roles/get-assigned-roles.md).
* [Отозвать роль](../operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).