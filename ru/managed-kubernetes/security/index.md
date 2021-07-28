---
title: Управление доступом в Managed Service for Kubernetes
description: "Управление доступом в сервисе для работы с контейнеризованными приложениями Managed Service for Kubernetes. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы сервисным аккаунтам кластера Managed Service for Kubernetes, какие роли нужны для работы с Managed Service for Kubernetes через консоль управления Yandex.Cloud."

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Управление доступом

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы сервисным аккаунтам кластера {{ managed-k8s-name }}](#sa-annotation);
* [какие роли нужны для работы с {{ managed-k8s-name }} через консоль управления {{ yandex-cloud }}](#ui-annotation).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](service-roles-hierarchy.svg)

### Роли {{ managed-k8s-name }} {#yc-api}

Описанные ниже роли позволяют управлять кластерами и группами узлов {{ managed-k8s-name }} без публичного доступа через API {{ yandex-cloud }}. Для управления ресурсами кластера эти роли необходимо компоновать с [ролями для {{ k8s }} API](#k8s-api). При создании кластера проверяются роли его сервисного аккаунта.
Для создания кластера и групп узлов без публичного доступа необходима роль `k8s.clusters.agent`.
Для создания кластера и групп узлов с публичным доступом необходимы роли:

* `k8s.clusters.agent`;
* `vpc.publicAdmin`.

Роль | Разрешения
----- | -----
`k8s.admin` | Дает права на создание, удаление, изменение, остановку и запуск кластеров и групп узлов. В дальнейшем позволит управлять гранулярным доступом к кластерам и группам.
`k8s.editor` | Дает права на создание, удаление, изменение, остановку и запуск кластеров и групп узлов.
`k8s.viewer` | Позволяет просматривать информацию о кластерах и группах узлов {{ managed-k8s-name }}.
`k8s.clusters.agent` | Специальная роль для сервисного аккаунта кластера. Дает право на создание групп узлов, дисков, внутренних балансировщиков. Позволяет использовать заранее созданные [KMS-ключи](../../kms/concepts/key.md) для шифрования и расшифровки секретов, а также подключать заранее созданные группы безопасности.<br/>В комбинации с ролью `load-balancer.admin` позволяет создать сетевой балансировщик нагрузки с публичным IP-адресом.<br/>Включает роли `compute.admin`, `vpc.privateAdmin`, `load-balancer.privateAdmin`, `kms.keys.encrypterDecrypter`, `iam.serviceAccounts.user`.

### Роли для доступа к {{ k8s }} API {#k8s-api}

{% note warning %}

Роли `k8s.cluster-api.cluster-admin`, `k8s.cluster-api.editor` и `k8s.cluster-api.viewer` доступны в {{ k8s }} начиная с версии 1.17.

{% endnote %}

Следующие роли дают права на управление ресурсами кластера через {{ k8s }} API. Для управления кластером эти роли необходимо компоновать с [ролями для API {{ yandex-cloud }}](#yc-api).

Роль | Разрешения
----- | -----
`k8s.cluster-api.cluster-admin` | Пользователь с этой ролью {{ iam-short-name }} получает группу `yc:cluster-admin` и роль `cluster-admin` для доступа к {{ k8s }} API.
`k8s.cluster-api.editor` | Пользователь с этой ролью {{ iam-short-name }} получает группу `yc:edit` и роль `edit` для доступа к {{ k8s }} API.
`k8s.cluster-api.viewer` | Пользователь с этой ролью {{ iam-short-name }} получает группу `yc:view` и роль `view` для доступа к {{ k8s }} API.

Подробнее о ролях для доступа к {{ k8s }} API читайте в [руководстве](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles).

Чтобы просмотреть права ролей на ресурсы кластера {{ k8s }} выполните команду:

```bash
kubectl describe clusterrole <роль для доступа к {{ k8s }} API>
```

### Примитивные роли {#primitive}

Примитивные роли {{ iam-short-name }} содержат вышеописанные роли в следующих комбинациях:

Примитивная роль | Комбинация ролей {{ managed-k8s-name }}
----- | -----
`admin` | `k8s.cluster-api.cluster-admin`, `k8s.admin`, `vpc.publicAdmin`.
`editor` | `k8s.cluster-api.cluster-admin`, `k8s.editor`, `vpc.publicAdmin`.
`viewer`| `k8s.cluster-api.viewer`, `k8s.viewer`.

## Сервисные аккаунты кластера {{ managed-k8s-name }} {#sa-annotation}

При создании кластера в {{ managed-k8s-name }} необходимо указать два сервисных аккаунта:

* **Сервисный аккаунт кластера** — от имени этого сервисного аккаунта сервис {{ managed-k8s-name }} управляет узлами кластера, подсетями для подов и сервисов, дисками, балансировками нагрузки, а также шифрует и дешифрует секреты. Минимально рекомендуемая роль для такого аккаунта — `k8s.clusters.agent`.

* **Сервисный аккаунт группы узлов** — от имени этого сервисного аккаунта узлы кластера аутентифицируются в [{{ container-registry-full-name }}](../../container-registry/concepts/index.md). Для развертывания в кластере приложений с использованием образов из {{ container-registry-full-name }} этому аккаунту нужно назначить какую-либо [сервисную роль](../../container-registry/security/index.md#servisnye-roli) {{ container-registry-short-name }}. Если используется другой container registry, то роли этому сервисному аккаунту можно не назначать.

## Доступ к консоли управления {{ managed-k8s-name }} {#ui-annotation}

Для доступа к {{ managed-k8s-name }} через [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} минимально необходимая роль `k8s.viewer.`

Чтобы получить подробную информацию о кластере и группе узлов понадобится дополнительная роль `k8s.cluster-api.viewer`. Поскольку роль `k8s.cluster-api.viewer` не предоставляет прав доступа ко всем объектам {{ k8s }} API, для использования всех возможностей консоли управления необходимы роли `k8s.cluster-api.editor` или `k8s.cluster-api.cluster-admin`.
