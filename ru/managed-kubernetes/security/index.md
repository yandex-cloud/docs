---
title: "Управление доступом в {{ managed-k8s-name }}"
description: "Управление доступом в сервисе для работы с контейнеризованными приложениями {{ managed-k8s-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы сервисным аккаунтам кластера {{ managed-k8s-name }}, какие роли нужны для работы с {{ managed-k8s-name }} через консоль управления {{ yandex-cloud }}."
---

# Управление доступом в {{ managed-k8s-name }}

В этом разделе вы узнаете:
* [На какие ресурсы можно назначить роль](#resources).
* [Какие роли действуют в сервисе](#roles-list).
* [Какие роли необходимы сервисным аккаунтам кластера {{ managed-k8s-name }}](#sa-annotation).
* [Какие роли нужны для работы с {{ managed-k8s-name }} через консоль управления {{ yandex-cloud }}](#ui-annotation).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/managed-kubernetes/security/service-roles-hierarchy.svg)

### Роли для доступа к {{ k8s }} API {#k8s-api}

Следующие роли дают права на управление ресурсами кластера через {{ k8s }} API. Роли {{ k8s }} API работают по [модели ролевого управления доступом](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) – Role-Based Access Control (RBAC). Для управления кластером эти роли необходимо компоновать с [ролями для API {{ yandex-cloud }}](#yc-api). Подробнее о ролях в {{ k8s }} RBAC читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles).

#### {{ roles.k8s.cluster-api.viewer }} {#k8s-clusters-api-viewer}

{% include notitle [k8s-cluster-api-viewer](../../_includes/roles-k8s-cluster-api-viewer.md) %}

#### {{ roles.k8s.cluster-api.editor }} {#k8s-clusters-api-editor}

{% include notitle [k8s-cluster-api-editor](../../_includes/roles-k8s-cluster-api-editor.md) %}

#### {{ roles.k8s.cluster-api.cluster-admin }} {#k8s-clusters-api-cluster-admin}

{% include notitle [k8s-cluster-api-cluster-admin](../../_includes/roles-k8s-cluster-api-cluster-admin.md) %}

Чтобы просмотреть права на ресурсы кластера {{ k8s }}, доступные для определенной роли, выполните команду:

```bash
kubectl describe clusterrole <роль в {{ k8s }} RBAC>
```

### Роли {{ managed-k8s-name }} {#yc-api}

Описанные ниже роли позволяют управлять кластерами и группами узлов {{ managed-k8s-name }} без публичного доступа через API {{ yandex-cloud }}. Для управления ресурсами кластера эти роли необходимо компоновать с [ролями для {{ k8s }} API](#k8s-api). При создании кластера проверяются роли его сервисного аккаунта.

Для создания кластера и групп узлов без публичного доступа необходима роль `k8s.clusters.agent`.

Для создания кластера и групп узлов с публичным доступом необходимы роли:
* `k8s.clusters.agent`.
* `vpc.publicAdmin`.

Для создания кластера с [туннельным режимом](../concepts/network-policy.md#cilium) необходима роль `k8s.tunnelClusters.agent`.

#### {{ roles.k8s.tunnelClusters.agent }} {#k8s-tunnel-clusters-agent}

{% include notitle [k8s-tunnel-clusters-agent](../../_includes/roles-k8s-tunnel-clusters-agent.md) %}

#### {{ roles.k8s.clusters.agent }} {#k8s-clusters-agent}

{% include notitle [k8s-clusters-agent](../../_includes/roles-k8s-clusters-agent.md) %}

#### {{ roles.k8s.viewer }} {#k8s-viewer}

{% include notitle [k8s-viewer](../../_includes/roles-k8s-viewer.md) %}

#### {{ roles.k8s.editor }} {#k8s-editor}

{% include notitle [k8s-editor](../../_includes/roles-k8s-editor.md) %}

#### {{ roles.k8s.admin }} {#k8s-admin}

{% include notitle [k8s-admin](../../_includes/roles-k8s-admin.md) %}

### Примитивные роли {#primitive}

#### {{ roles-viewer }} {#viewer}

{% include notitle [roles-viewer](../../_includes/roles-viewer.md) %}

#### {{ roles-editor }} {#editor}

{% include notitle [roles-editor](../../_includes/roles-editor.md) %}

#### {{ roles-admin }} {#admin}

{% include notitle [roles-admin](../../_includes/roles-admin.md) %}

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
