---
title: Управление доступом в {{ managed-k8s-name }}
description: "Управление доступом в сервисе для работы с контейнеризованными приложениями {{ managed-k8s-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы сервисным аккаунтам кластера {{ managed-k8s-name }}, какие роли нужны для работы с {{ managed-k8s-name }} через консоль управления {{ yandex-cloud }}."
---

# Управление доступом в {{ managed-k8s-name }}

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

![image](../../_assets/managed-kubernetes/security/service-roles-hierarchy.svg)

### Роли {{ managed-k8s-name }} {#yc-api}

Описанные ниже роли позволяют управлять кластерами и группами узлов {{ managed-k8s-name }} без публичного доступа через API {{ yandex-cloud }}. Для управления ресурсами кластера эти роли необходимо компоновать с [ролями для {{ k8s }} API](#k8s-api). При создании кластера проверяются роли его сервисного аккаунта.
Для создания кластера и групп узлов без публичного доступа необходима роль `k8s.clusters.agent`.
Для создания кластера и групп узлов с публичным доступом необходимы роли:
* `k8s.clusters.agent`.
* `vpc.publicAdmin`.

Для создания кластера с [туннельным режимом](../concepts/network-policy.md#cilium) необходима роль `k8s.tunnelClusters.agent`.

Роль | Разрешения
--- | ---
`k8s.admin` | Дает права на создание, удаление, изменение, остановку и запуск кластеров и групп узлов. В дальнейшем позволит управлять гранулярным доступом к кластерам и группам.
`k8s.editor` | Дает права на создание, удаление, изменение, остановку и запуск кластеров и групп узлов.
`k8s.viewer` | Позволяет просматривать информацию о кластерах и группах узлов {{ managed-k8s-name }}.
`k8s.clusters.agent` | Специальная роль для сервисного аккаунта кластера. Дает право на создание групп узлов, дисков, внутренних балансировщиков. Позволяет использовать заранее созданные [KMS-ключи](../../kms/concepts/key.md) для шифрования и расшифровки секретов, а также подключать заранее созданные [группы безопасности](../operations/connect/security-groups.md).<br>В комбинации с ролью `load-balancer.admin` позволяет создать сетевой балансировщик нагрузки с публичным IP-адресом.<br>Включает роли `compute.admin`, `iam.serviceAccounts.user`, `kms.keys.encrypterDecrypter`, `load-balancer.privateAdmin`, `vpc.privateAdmin`.
`k8s.tunnelClusters.agent` | Специальная роль для создания кластера с туннельным режимом. Дает право на создание групп узлов, дисков, внутренних балансировщиков. Позволяет использовать заранее созданные KMS-ключи для шифрования и расшифровки секретов.<br>Включает роли: `compute.admin`, `iam.serviceAccounts.user`, `k8s.viewer`, `kms.keys.encrypterDecrypter`, `load-balancer.privateAdmin`.

### Роли для доступа к {{ k8s }} API {#k8s-api}

{% note warning %}

Роли `k8s.cluster-api.cluster-admin`, `k8s.cluster-api.editor` и `k8s.cluster-api.viewer` доступны в {{ k8s }} начиная с версии 1.17.

{% endnote %}

Следующие роли дают права на [управление ресурсами кластера через {{ k8s }} API на основе ролей](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) (Role-Based Access Control, RBAC). Для управления кластером эти роли необходимо компоновать с [ролями для API {{ yandex-cloud }}](#yc-api). Подробнее о ролях в {{ k8s }} RBAC читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles).

Следующие роли дают права на управление ресурсами кластера через {{ k8s }} API. Роли {{ k8s }} API работают по [модели ролевого управления доступом](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) – Role-Based Access Control (RBAC). Для управления кластером эти роли необходимо компоновать с [ролями для API {{ yandex-cloud }}](#yc-api). Подробнее о ролях в {{ k8s }} RBAC читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles).

Роль | Разрешения
--- | ---
`k8s.cluster-api.cluster-admin` | Пользователь с этой ролью {{ iam-full-name }} получает группу `yc:cluster-admin` и роль `cluster-admin` в {{ k8s }} RBAC.
`k8s.cluster-api.editor` | Пользователь с этой ролью {{ iam-name }} получает группу `yc:edit` и роль `edit` в {{ k8s }} RBAC для всех [пространств имен](../concepts/index.md#namespace) в кластере.
`k8s.cluster-api.viewer` | Пользователь с этой ролью {{ iam-name }} получает группу `yc:view` и роль `view` в {{ k8s }} RBAC для всех пространств имен в кластере.

Подробнее о ролях в {{ k8s }} RBAC читайте в [руководстве](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles).

Чтобы просмотреть права на ресурсы кластера {{ k8s }}, доступные для определенной роли, выполните команду:

```bash
kubectl describe clusterrole <роль в {{ k8s }} RBAC>
```

### Примитивные роли {#primitive}

Примитивные роли {{ iam-name }} содержат вышеописанные роли в следующих комбинациях:

Примитивная роль | Комбинация ролей {{ managed-k8s-name }}
--- | ---
`admin` | `k8s.cluster-api.cluster-admin`, `k8s.admin`, `vpc.publicAdmin`.
`editor` | `k8s.cluster-api.cluster-admin`, `k8s.editor`, `vpc.publicAdmin`.
`viewer`| `k8s.cluster-api.viewer`, `k8s.viewer`.

## Сервисные аккаунты кластера {{ managed-k8s-name }} {#sa-annotation}

При создании кластера в {{ managed-k8s-name }} необходимо указать два сервисных аккаунта:
* **Сервисный аккаунт кластера** — от имени этого сервисного аккаунта сервис {{ managed-k8s-name }} управляет узлами кластера, подсетями для подов и сервисов, дисками, балансировками нагрузки, а также шифрует и дешифрует секреты. Минимально рекомендуемая роль для такого аккаунта — `k8s.clusters.agent`.
* **Сервисный аккаунт группы узлов** — от имени этого сервисного аккаунта узлы кластера аутентифицируются в [{{ container-registry-full-name }}](../../container-registry/concepts/index.md). Для развертывания в кластере приложений с использованием образов из {{ container-registry-name }} этому аккаунту нужно назначить какую-либо [сервисную роль](../../container-registry/security/index.md#service-roles) {{ container-registry-name }}. Если используется другой container registry, то роли этому сервисному аккаунту можно не назначать.

## Доступ к консоли управления {{ managed-k8s-name }} {#ui-annotation}

Для доступа к {{ managed-k8s-name }} через [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} минимально необходимая роль `k8s.viewer.`

Чтобы получить подробную информацию о кластере и группе узлов необходима дополнительная роль `k8s.cluster-api.viewer`. Эта роль соответствует роли `viewer` в {{ k8s }} RBAC и предоставляет права доступа к ограниченному набору ресурсов в {{ k8s }} API, поэтому возможности консоли будут ограничены.

Пользователи с ролью `k8s.cluster-api.cluster-admin` имеют полный доступ к {{ k8s }} API кластера и могут использовать все возможности консоли управления.

Чтобы предоставить более гранулярный доступ к необходимым ресурсам вы можете:
* Настроить дополнительные права в {{ k8s }} RBAC для соответствующих пользователей.
* Расширить роли `view` и `edit` в {{ k8s }} RBAC с помощью [агрегации ролей](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles). Например, вы можете разрешить всем пользователям с ролью `view` в {{ k8s }} API (в том числе пользователям с облачной ролью `k8s.cluster-api.viewer`) просмотр информации об узлах, добавив следующую роль в кластер:

  ```yaml
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRole
  metadata:
    name: view-extensions
    labels:
      rbac.authorization.k8s.io/aggregate-to-view: "true"
  rules:
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["get", "list", "watch"]
  ```