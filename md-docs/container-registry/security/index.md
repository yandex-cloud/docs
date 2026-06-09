# Управление доступом в {{ container-registry-name }}

В этом разделе вы узнаете:
* [На какие ресурсы можно назначить роль](#resources).
* [Какие роли действуют в сервисе](#roles-list).
* [Какие роли необходимы](#choosing-roles) для того или иного действия.

## Об управлении доступом {#about-access-control}

Все операции в {{ yandex-cloud }} проверяются в сервисе [{{ iam-full-name }}](../../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.


Чтобы выдать разрешения к ресурсу, [назначьте роли](../../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить [аккаунту на Яндексе](../../iam/concepts/users/accounts.md#passport), [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [локальному пользователю](../../iam/concepts/users/accounts.md#local), [федеративному пользователю](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее читайте в разделе [{#T}](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `container-registry.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [организацию](../../organization/concepts/organization.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.

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

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `{{ roles-editor }}` входят все разрешения `{{ roles-viewer }}`. После диаграммы дано описание каждой роли.

![service-roles-hierarchy](../../_assets/container-registry/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### container-registry.viewer {#container-registry.viewer}

Роль `container-registry.viewer` позволяет просматривать информацию о реестрах, Docker-образах и репозиториях, а также об облаке, каталоге и квотах сервиса.

Пользователи с этой ролью могут:
* просматривать список [реестров](../concepts/registry.md) и информацию о них и о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также о [настройках политик доступа](../operations/registry/registry-access.md) для IP-адресов и настройках [сканера уязвимостей](../concepts/vulnerability-scanner.md);
* просматривать информацию о [репозиториях](../concepts/repository.md) и назначенных правах доступа к ним;
* просматривать список [политик](../concepts/lifecycle-policy.md) автоматического удаления [Docker-образов](../concepts/docker-image.md) и информацию о таких политиках;
* просматривать список результатов [тестирования](../operations/lifecycle-policy/lifecycle-policy-dry-run.md) политик автоматического удаления Docker-образов и информацию о таких результатах;
* просматривать список Docker-образов в реестре и информацию о них, а также скачивать Docker-образы из реестра;
* просматривать историю сканирования Docker-образов на уязвимости и информацию о результатах такого сканирования;
* просматривать информацию о [квотах](../concepts/limits.md#container-registry-quotas) сервиса Container Registry;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

#### container-registry.editor {#container-registry.editor}

Роль `container-registry.editor` позволяет управлять реестрами, Docker-образами, репозиториями и их настройками.

Пользователи с этой ролью могут:
* просматривать список [реестров](../concepts/registry.md) и информацию о них, а также создавать, изменять и удалять реестры;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к реестрам, а также о [настройках политик доступа](../operations/registry/registry-access.md) для IP-адресов;
* просматривать информацию о настройках [сканера уязвимостей](../concepts/vulnerability-scanner.md), а также создавать, изменять и удалять правила сканирования;
* просматривать список [Docker-образов](../concepts/docker-image.md) в реестре и информацию о них, а также создавать, скачивать, изменять и удалять Docker-образы;
* [запускать](../operations/scanning-docker-image.md#manual) и отменять сканирование Docker-образов на уязвимости, а также просматривать историю сканирования и информацию о его результатах;
* просматривать информацию о [репозиториях](../concepts/repository.md) и назначенных правах доступа к ним, а также создавать и удалять репозитории;
* просматривать список [политик](../concepts/lifecycle-policy.md) автоматического удаления Docker-образов и информацию о таких политиках, а также создавать, изменять и удалять такие политики;
* запускать [тестирование](../operations/lifecycle-policy/lifecycle-policy-dry-run.md) политик автоматического удаления Docker-образов, просматривать список результатов тестирования и информацию о таких результатах;
* просматривать информацию о [квотах](../concepts/limits.md#container-registry-quotas) сервиса Container Registry;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `container-registry.viewer`.

#### container-registry.admin {#container-registry.admin}

Роль `container-registry.admin` позволяет управлять доступом к реестрам и репозиториям, а также управлять реестрами, Docker-образами, репозиториями и их настройками.

Пользователи с этой ролью могут:
* просматривать список [реестров](../concepts/registry.md) и информацию о них, а также создавать, изменять и удалять реестры;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к реестрам и изменять такие права доступа;
* просматривать информацию о [настройках политик доступа](../operations/registry/registry-access.md) для IP-адресов и изменять такие настройки;
* просматривать информацию о настройках [сканера уязвимостей](../concepts/vulnerability-scanner.md), а также создавать, изменять и удалять правила сканирования;
* просматривать список [Docker-образов](../concepts/docker-image.md) в реестре и информацию о них, а также создавать, скачивать, изменять и удалять Docker-образы;
* [запускать](../operations/scanning-docker-image.md#manual) и отменять сканирование Docker-образов на уязвимости, а также просматривать историю сканирования и информацию о его результатах;
* просматривать информацию о [репозиториях](../concepts/repository.md), а также создавать и удалять репозитории;
* просматривать информацию о назначенных правах доступа к репозиториям и изменять такие права доступа; 
* просматривать список [политик](../concepts/lifecycle-policy.md) автоматического удаления Docker-образов и информацию о таких политиках, а также создавать, изменять и удалять такие политики;
* запускать [тестирование](../operations/lifecycle-policy/lifecycle-policy-dry-run.md) политик автоматического удаления Docker-образов, просматривать список результатов тестирования и информацию о таких результатах;
* просматривать информацию о [квотах](../concepts/limits.md#container-registry-quotas) сервиса Container Registry;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `container-registry.editor`.

#### container-registry.images.pusher {#container-registry-images-pusher}

Роль `container-registry.images.pusher` позволяет управлять Docker-образами и репозиториями, а также просматривать информацию о Docker-образах, репозиториях и реестрах.

Пользователи с этой ролью могут:
* просматривать список [реестров](../concepts/registry.md) и информацию о них;
* просматривать список [Docker-образов](../concepts/docker-image.md) в реестре и информацию о них, а также загружать, скачивать, обновлять, и удалять Docker-образы;
* создавать и удалять [репозитории](../concepts/repository.md).

#### container-registry.images.puller {#container-registry-images-puller}

Роль `container-registry.images.puller` позволяет скачивать [Docker-образы](../concepts/docker-image.md) из реестра и просматривать список [реестров](../concepts/registry.md) и Docker-образов, а также информацию о них.

#### container-registry.images.scanner {#container-registry-images-scanner}

Роль `container-registry.images.scanner` позволяет сканировать Docker-образы на наличие уязвимостей, а также просматривать информацию о реестрах, Docker-образах и репозиториях, а также об облаке, каталоге и квотах сервиса.

Пользователи с этой ролью могут:
* просматривать список [Docker-образов](../concepts/docker-image.md) в реестре и информацию о них, а также скачивать Docker-образы из реестра;
* [запускать](../operations/scanning-docker-image.md#manual) и отменять сканирование Docker-образов на уязвимости, а также просматривать историю сканирования и информацию о его результатах;
* просматривать список [реестров](../concepts/registry.md) и информацию о них и о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также о [настройках политик доступа](../operations/registry/registry-access.md) для IP-адресов и настройках [сканера уязвимостей](../concepts/vulnerability-scanner.md);
* просматривать информацию о [репозиториях](../concepts/repository.md) и назначенных правах доступа к ним;
* просматривать список [политик](../concepts/lifecycle-policy.md) автоматического удаления Docker-образов и информацию о таких политиках;
* просматривать список результатов [тестирования](../operations/lifecycle-policy/lifecycle-policy-dry-run.md) политик автоматического удаления Docker-образов и информацию о таких результатах;
* просматривать информацию о [квотах](../concepts/limits.md#container-registry-quotas) сервиса Container Registry;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `container-registry.viewer`.

Более подробную информацию о сервисных ролях читайте на странице [{#T}](../../iam/concepts/access-control/roles.md) в документации сервиса {{ iam-full-name }}.

### Примитивные роли {#primitive-roles}

Примитивные роли позволяют пользователям совершать действия во [всех сервисах](../../overview/concepts/services.md) {{ yandex-cloud }}.

#### {{ roles-auditor }} {#auditor}

Роль `auditor` предоставляет разрешения на чтение конфигурации и метаданных любых ресурсов Yandex Cloud без возможности доступа к данным.

Например, пользователи с этой ролью могут:
* просматривать информацию о [ресурсе]({{ link-docs }}/resource-manager/concepts/resources-hierarchy);
* просматривать метаданные ресурса;
* просматривать список операций с ресурсом.

Роль `auditor` — наиболее безопасная роль, исключающая доступ к данным [сервисов]({{ link-docs }}/overview/concepts/services). Роль подходит для пользователей, которым необходим минимальный уровень доступа к ресурсам Yandex Cloud.

#### {{ roles-viewer }} {#viewer}

Роль `viewer` предоставляет разрешения на чтение информации о любых [ресурсах]({{ link-docs }}/resource-manager/concepts/resources-hierarchy) Yandex Cloud.

Включает разрешения, предоставляемые ролью `auditor`.

В отличие от роли `auditor`, роль `viewer` предоставляет доступ к данным [сервисов]({{ link-docs }}/overview/concepts/services) в режиме чтения.

#### {{ roles-editor }} {#editor}

Роль `editor` предоставляет разрешения на управление любыми [ресурсами]({{ link-docs }}/resource-manager/concepts/resources-hierarchy) Yandex Cloud, кроме назначения ролей другим пользователям, передачи прав владения [организацией]({{ link-docs }}/organization/concepts/organization) и ее удаления, а также удаления [ключей шифрования]({{ link-docs }}/kms/concepts/) Key Management Service.

Например, пользователи с этой ролью могут создавать, изменять и удалять ресурсы.

Включает разрешения, предоставляемые ролью `viewer`.

#### {{ roles-admin }} {#admin}

Роль `admin` позволяет назначать любые роли, кроме `resource-manager.clouds.owner` и `organization-manager.organizations.owner`, а также предоставляет разрешения на управление любыми [ресурсами]({{ link-docs }}/resource-manager/concepts/resources-hierarchy) Yandex Cloud, кроме передачи прав владения [организацией]({{ link-docs }}/organization/concepts/organization) и ее удаления.

Прежде чем назначить роль `admin` на организацию, [облако]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) или [платежный аккаунт]({{ link-docs }}/billing/concepts/billing-account), ознакомьтесь с информацией о защите [привилегированных аккаунтов]({{ link-docs }}/security/standard/all#privileged-users).

Включает разрешения, предоставляемые ролью `editor`.

Вместо примитивных ролей мы рекомендуем использовать роли сервисов. Такой подход позволит более гранулярно управлять доступом и обеспечить соблюдение [принципа минимальных привилегий](../../security/standard/all.md#min-privileges).

Подробнее о примитивных ролях см. в [справочнике ролей {{ yandex-cloud }}](../../iam/roles-reference.md#primitive-roles).

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