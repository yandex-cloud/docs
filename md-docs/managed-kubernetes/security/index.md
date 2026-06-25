# Управление доступом в Managed Service for Kubernetes

В этом разделе вы узнаете:
* [На какие ресурсы можно назначить роль](#resources).
* [Какие роли действуют в сервисе](#roles-list).
* [Какие роли необходимы для управления Managed Service for Kubernetes](#required-roles).
* [Какие роли необходимы сервисным аккаунтам кластера Managed Service for Kubernetes](#sa-annotation).
* [Какие роли нужны для работы с Managed Service for Kubernetes через консоль управления Yandex Cloud](#ui-annotation).

## Об управлении доступом {#about-access-control}

Все операции в Yandex Cloud проверяются в сервисе [Yandex Identity and Access Management](../../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.


Чтобы выдать разрешения к ресурсу, [назначьте роли](../../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить [аккаунту на Яндексе](../../iam/concepts/users/accounts.md#passport), [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [локальному пользователю](../../iam/concepts/users/accounts.md#local), [федеративному пользователю](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее читайте в разделе [Как устроено управление доступом в Yandex Cloud](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `k8s.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [организацию](../../organization/concepts/organization.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.

Также вы можете назначить [роли для доступа к Kubernetes API](#k8s-api) на отдельный кластер через Yandex Cloud [CLI](../../cli/cli-ref/managed-kubernetes/cli-ref/cluster/add-access-binding.md), [Terraform](../../terraform/resources/kubernetes_cluster_iam_binding.md) или [API](../api-ref/authentication.md). Подробнее на странице [Управление доступом к кластеру Managed Service for Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-access.md).

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `editor` входят все разрешения `viewer`. После диаграммы дано описание каждой роли.

```mermaid
flowchart BT
    k8s.cluster-api.editor ~~~ k8s.cluster-api.admin
    k8s.cluster-api.editor ~~~ k8s.cluster-api.cluster-admin
    k8s.cluster-api.viewer ~~~ k8s.cluster-api.editor
    k8s.editor --> k8s.admin
    k8s.viewer --> k8s.editor
    k8s.tunnelClusters.agent --> k8s.clusters.agent
    k8s.viewer --> k8s.tunnelClusters.agent
```

### Роли для доступа к Kubernetes API {#k8s-api}

Следующие [роли](../../iam/concepts/access-control/roles.md) дают права на управление ресурсами [кластера Managed Service for Kubernetes](../concepts/index.md#kubernetes-cluster) через Kubernetes API. Роли Kubernetes API работают по [модели ролевого управления доступом](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) – Role-Based Access Control (RBAC). Для управления кластером Managed Service for Kubernetes эти роли необходимо компоновать с [ролями для API Yandex Cloud](#yc-api). Подробнее о ролях в Kubernetes RBAC читайте в [документации Kubernetes](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles).

Чтобы просмотреть права на ресурсы кластера Managed Service for Kubernetes, доступные для определенной роли, выполните команду:

```bash
kubectl describe clusterrole <роль_в_Kubernetes_RBAC>
```

#### k8s.cluster-api.viewer {#k8s-cluster-api-viewer}

Пользователь с ролью `k8s.cluster-api.viewer` получает группу `yc:viewer` и роль `view` в Kubernetes RBAC для всех пространств имен в кластере.

#### k8s.cluster-api.editor {#k8s-cluster-api-editor}

Пользователь с ролью `k8s.cluster-api.editor` получает группу `yc:editor` и роль `edit` в Kubernetes RBAC для всех пространств имен в кластере.

#### k8s.cluster-api.admin {#k8s-cluster-api-admin}

Пользователь с ролью `k8s.cluster-api.admin` получает группу `yc:k8s-core-admin` и роль `admin` в Kubernetes RBAC.

#### k8s.cluster-api.cluster-admin {#k8s-cluster-api-cluster-admin}

Пользователь с ролью `k8s.cluster-api.cluster-admin` получает группу `yc:admin` и роль `cluster-admin` в Kubernetes RBAC.

### Роли Managed Service for Kubernetes {#yc-api}

Описанные ниже роли позволяют управлять кластерами Managed Service for Kubernetes и [группами узлов](../concepts/index.md#node-group) без публичного доступа через API Yandex Cloud. Для управления ресурсами кластера Managed Service for Kubernetes эти роли необходимо компоновать с [ролями для Kubernetes API](#k8s-api). При создании кластера Managed Service for Kubernetes проверяются роли его сервисного аккаунта.

Для управления кластером Managed Service for Kubernetes и группой узлов без публичного доступа необходима роль `k8s.clusters.agent`.

Для управления кластером Managed Service for Kubernetes и группой с публичным доступом необходимы роли:
* `k8s.clusters.agent`.
* `vpc.publicAdmin`.

Для управления кластером Managed Service for Kubernetes с облачной сетью из другого каталога дополнительно необходимы роли в этом каталоге:
* [vpc.privateAdmin](../../vpc/security/index.md#vpc-private-admin)
* [vpc.user](../../vpc/security/index.md#vpc-user)
* [vpc.bridgeAdmin](../../vpc/security/index.md#vpc-bridge-admin)

Для управления кластером Managed Service for Kubernetes с [туннельным режимом](../concepts/network-policy.md#cilium) достаточно роли `k8s.tunnelClusters.agent`.

#### k8s.viewer {#k8s-viewer}

Роль `k8s.viewer` позволяет просматривать информацию о кластерах и группах узлов Kubernetes.

Пользователи с этой ролью могут:
* просматривать список [кластеров Kubernetes](../concepts/index.md#kubernetes-cluster), информацию о них и настройках их взаимодействия с Cloud Marketplace, а также о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать список [групп узлов](../concepts/index.md#node-group) кластеров Kubernetes и информацию о таких группах узлов;
* просматривать информацию о приложениях из Cloud Marketplace, а также о назначенных правах доступа к ним;
* просматривать статистику использования ресурсов и информацию о [квотах](../concepts/limits.md#managed-k8s-quotas) сервиса Managed Service for Kubernetes;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

#### k8s.editor {#k8s-editor}

Роль `k8s.editor` позволяет управлять кластерами и группами узлов Kubernetes.

Пользователи с этой ролью могут:
* просматривать список [кластеров Kubernetes](../concepts/index.md#kubernetes-cluster), информацию о них и о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* создавать, изменять, запускать, останавливать и удалять кластеры Kubernetes;
* просматривать список [групп узлов](../concepts/index.md#node-group) кластеров Kubernetes и информацию о таких группах узлов;
* создавать, изменять и удалять группы узлов кластеров Kubernetes;
* просматривать и изменять настройки взаимодействия кластеров Kubernetes с Cloud Marketplace;
* просматривать информацию о приложениях из Cloud Marketplace и о назначенных правах доступа к ним, а также устанавливать, обновлять и удалять такие приложения;
* просматривать статистику использования ресурсов и информацию о [квотах](../concepts/limits.md#managed-k8s-quotas) сервиса Managed Service for Kubernetes;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `k8s.viewer`.

#### k8s.admin {#k8s-admin}

Роль `k8s.admin` позволяет управлять кластерами и группами узлов Kubernetes, а также доступом к кластерам Kubernetes.

Пользователи с этой ролью могут:
* просматривать список [кластеров Kubernetes](../concepts/index.md#kubernetes-cluster) и информацию о них, а также создавать, изменять, запускать, останавливать и удалять кластеры Kubernetes;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам Kubernetes и изменять такие права доступа;
* просматривать список [групп узлов](../concepts/index.md#node-group) кластеров Kubernetes и информацию о таких группах узлов, а также создавать, изменять и удалять группы узлов кластеров Kubernetes;
* просматривать и изменять настройки взаимодействия кластеров Kubernetes с Cloud Marketplace;
* просматривать информацию о приложениях из Cloud Marketplace, а также устанавливать, обновлять и удалять такие приложения;
* просматривать информацию о назначенных правах доступа к приложениям из Cloud Marketplace и изменять такие права доступа;
* просматривать статистику использования ресурсов и информацию о [квотах](../concepts/limits.md#managed-k8s-quotas) сервиса Managed Service for Kubernetes;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `k8s.editor`.

#### k8s.tunnelClusters.agent {#k8s-tunnelclusters-agent}

`k8s.tunnelClusters.agent` — специальная роль для создания [кластера Kubernetes](../concepts/index.md#kubernetes-cluster) с туннельным режимом. Дает право на создание [групп узлов](../concepts/index.md#node-group), дисков, внутренних балансировщиков. Позволяет использовать заранее созданные [ключи](../../kms/concepts/key.md) Yandex Key Management Service для шифрования и расшифрования секретов.

Включает разрешения, предоставляемые ролями `compute.admin`, `iam.serviceAccounts.user`, `k8s.viewer`, `kms.keys.encrypterDecrypter` и `load-balancer.privateAdmin`.

#### k8s.clusters.agent {#k8s-clusters-agent}

`k8s.clusters.agent` — специальная роль для сервисного аккаунта [кластера Kubernetes](../concepts/index.md#kubernetes-cluster). Дает право на создание [групп узлов](../concepts/index.md#node-group), дисков, внутренних балансировщиков. Позволяет использовать заранее созданные [ключи](../../kms/concepts/key.md) Yandex Key Management Service для шифрования и расшифрования секретов, а также подключать заранее созданные [группы безопасности](../../vpc/concepts/security-groups.md). В комбинации с [ролью](../../network-load-balancer/security/index.md#load-balancer-admin) `load-balancer.admin` позволяет создать [сетевой балансировщик нагрузки](../../network-load-balancer/concepts/index.md) с публичным IP-адресом.

Включает разрешения, предоставляемые ролями `k8s.tunnelClusters.agent` и `vpc.privateAdmin`.

### Примитивные роли {#primitive-roles}

#### viewer {#viewer}

Роль `viewer` предоставляет разрешения на чтение информации о любых [ресурсах](../../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud.

Включает разрешения, предоставляемые ролью `auditor`.

В отличие от роли `auditor`, роль `viewer` предоставляет доступ к данным [сервисов](../../overview/concepts/services.md) в режиме чтения.

#### editor {#editor}

Роль `editor` предоставляет разрешения на управление любыми [ресурсами](../../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud, кроме назначения ролей другим пользователям, передачи прав владения [организацией](../../organization/concepts/organization.md) и ее удаления, а также удаления [ключей шифрования](../../kms/concepts/index.md) Key Management Service.

Например, пользователи с этой ролью могут создавать, изменять и удалять ресурсы.

Включает разрешения, предоставляемые ролью `viewer`.

#### admin {#admin}

Роль `admin` позволяет назначать любые роли, кроме `resource-manager.clouds.owner` и `organization-manager.organizations.owner`, а также предоставляет разрешения на управление любыми [ресурсами](../../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud, кроме передачи прав владения [организацией](../../organization/concepts/organization.md) и ее удаления.

Прежде чем назначить роль `admin` на организацию, [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [платежный аккаунт](../../billing/concepts/billing-account.md), ознакомьтесь с информацией о защите [привилегированных аккаунтов](../../security/standard/all.md#privileged-users).

Включает разрешения, предоставляемые ролью `editor`.

{% note info %}

Вы можете предоставить пользователям гранулярный доступ в пространства имен кластера с помощью механизма Kubernetes RBAC.

{% cut "Пример" %}

1. Создайте в кластере роль, которая позволит управлять всеми ресурсами в заданном пространстве имен:

    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      namespace: <пространство_имен>
      name: <название_роли>
    rules:
    - apiGroups: [""]
      resources: ["*"]   
      verbs: ["*"]                   
    ```

1. Создайте связь с этой ролью для аккаунта пользователя:

    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: iam-user
      namespace: <пространство_имен>
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: Role
      name: <название_роли>
    subjects:
    - kind: User
      name: <идентификатор_аккаунта>
    ```

Подробности о получении идентификатора аккаунта смотрите на странице [Получение информации о пользователе](../../organization/operations/users-get.md).

Проверьте создание ресурсов в кластере. В других пространствах имен пользователь не будет иметь право на создание или редактирование ресурсов.

{% endcut %}

{% endnote %}

## Какие роли необходимы для создания Managed Service for Kubernetes {#required-roles}

Для создания кластера Managed Service for Kubernetes и группы узлов [аккаунт](../../iam/concepts/users/accounts.md), с помощью которого вы собираетесь создавать кластер, должен иметь [роли](../../iam/concepts/access-control/roles.md):
* [k8s.editor](#k8s-editor) или выше.
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user).

Чтобы создать кластер Managed Service for Kubernetes и группу узлов с публичным доступом, дополнительно нужна роль [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin).

## Сервисные аккаунты кластера Managed Service for Kubernetes {#sa-annotation}

При создании кластера Managed Service for Kubernetes необходимо указать два [сервисных аккаунта](../../iam/concepts/users/service-accounts.md):
* **Сервисный аккаунт кластера** — от имени этого сервисного аккаунта сервис Managed Service for Kubernetes управляет узлами кластера, [подсетями](../../vpc/concepts/network.md#subnet) для [подов](../concepts/index.md#pod) и [сервисов](../concepts/index.md#service), [дисками](../../compute/concepts/disk.md), [балансировками нагрузки](../../network-load-balancer/concepts/index.md), а также шифрует и дешифрует [секреты](../../lockbox/concepts/secret.md). Минимально рекомендуемая роль для такого аккаунта — `k8s.clusters.agent`.
* **Сервисный аккаунт группы узлов** — от имени этого сервисного аккаунта узлы кластера Managed Service for Kubernetes аутентифицируются в [Yandex Container Registry](../../container-registry/concepts/index.md) или в [Yandex Cloud Registry](../../cloud-registry/concepts/index.md). Для других container registry роли сервисному аккаунту назначать не требуется.
  
  Чтобы узлы могли скачивать Docker-образы из реестра:

  * Yandex Container Registry — назначьте сервисному аккаунту роль [container-registry.images.puller](../../container-registry/security/index.md#container-registry-images-puller).
  * Yandex Cloud Registry — назначьте сервисному аккаунту роль [cloud-registry.artifacts.puller](../../cloud-registry/security/index.md#cloud-registry-artifacts-puller).

Для управления кластером Managed Service for Kubernetes и группами узлов с публичным доступом дополнительно необходима роль `vpc.publicAdmin`.

При использовании в кластере Managed Service for Kubernetes облачной сети из другого каталога сервисному аккаунту кластера дополнительно необходимы роли в этом каталоге:
* [vpc.privateAdmin](../../vpc/security/index.md#vpc-private-admin)
* [vpc.user](../../vpc/security/index.md#vpc-user)
* [vpc.bridgeAdmin](../../vpc/security/index.md#vpc-bridge-admin)

## Доступ к консоли управления Managed Service for Kubernetes {#ui-annotation}

`k8s.viewer` — минимально необходимая роль для доступа к Managed Service for Kubernetes через [консоль управления](https://console.yandex.cloud) Yandex Cloud. Роль `k8s.viewer` дает доступ только к основной информации о [группах узлов](../operations/node-group/node-group-list.md#get). 

Комбинация ролей `k8s.viewer` и `k8s.clusters.agent` позволяет просматривать всю информацию о группах узлов, но не об отдельных узлах кластера.

Комбинация ролей `k8s.cluster-api.cluster-admin`, `k8s.clusters.agent` и `monitoring.viewer` дает доступ к просмотру подробной информации о группах узлов и отдельных [узлах кластера](../operations/node-group/node-group-list.md#get-node). В консоли управления для каждого узла становятся доступны все вкладки, включая вкладку **Мониторинг**.

Для просмотра ресурсов кластера [в разделе Ingress](../operations/kubernetes-console/network.md) нужна [роль](../../application-load-balancer/security/index.md#alb-auditor) `alb.auditor` или выше.

Чтобы предоставить более гранулярный доступ к необходимым ресурсам, вы можете:
* Настроить дополнительные права в Kubernetes RBAC для соответствующих пользователей.
* Расширить роли `view` и `edit` в Kubernetes RBAC с помощью [агрегации ролей](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles). Например, вы можете разрешить всем пользователям с ролью `view` в Kubernetes API (в том числе пользователям с облачной ролью `k8s.cluster-api.viewer`) просмотр информации об узлах, добавив следующую роль в кластер Managed Service for Kubernetes:

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

## Федерации сервисных аккаунтов Yandex Identity and Access Management

В Managed Service for Kubernetes реализована интеграция с _федерациями сервисных аккаунтов_ Identity and Access Management.

[Федерации сервисных аккаунтов](../../iam/concepts/workload-identity.md) (Workload Identity Federation) позволяют настроить связь между внешними системами и Yandex Cloud по протоколу [OpenID Connect](https://openid.net/developers/how-connect-works/) (OIDC). За счет этого внешние системы могут выполнять действия с ресурсами Yandex Cloud от имени [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md) IAM без использования [авторизованных ключей](../../iam/concepts/authorization/key.md). Это более безопасный способ, минимизирующий риск утечки учетных данных и возможность несанкционированного доступа.

При включении опции Managed Service for Kubernetes автоматически создает для конкретного кластера OIDC-провайдер и предоставляет следующие параметры для интеграции с федерациями сервисных аккаунтов:
* `URL эмитента`.
* `URL набора ключей JWKS`.

![image](../../_assets/managed-kubernetes/mk8s-wlif.svg)

Например, вы можете настроить [Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Identity and Access Management](../tutorials/wlif-managed-k8s-integration.md).