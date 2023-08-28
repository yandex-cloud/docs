# Управление доступом в {{ load-testing-name }}

Для управления правами доступа в {{ load-testing-name }} используются [роли](../../iam/concepts/access-control/roles.md).

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/load-testing/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

* `loadtesting.viewer` — разрешает просмотр отчетов и созданных агентов.
* `loadtesting.editor` — разрешает просмотр и удаление отчетов, создание, удаление или редактирование [ВМ](../../glossary/vm.md) с агентами, разрешает запуск нагрузочных тестов, остановку теста, загрузку тестовых данных и результатов в хранилище.
* `loadtesting.admin` — на данный момент в сервисе не предусмотрено администрирование, поэтому разрешения роли совпадают с разрешениями `loadtesting.editor`.
* `loadtesting.loadTester` — разрешает просмотр и удаление отчетов, создание, удаление или редактирование ВМ с агентами, разрешает запуск нагрузочных тестов, остановку теста, загрузку тестовых данных.
* `loadtesting.generatorClient` — разрешает запуск ВМ, запуск теста на агенте и загрузку результатов в хранилище (назначается на сервисный аккаунт, от которого создается ВМ с агентом).

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### Что дальше {#next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
