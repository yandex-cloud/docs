# Политика аудита в {{ managed-k8s-name }}

Политика аудита ([audit policy](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/#audit-policy)) определяет [правила](#rules-audit-policy) о том, какие события должны записываться в [журнал аудита](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/) и какие данные они должны содержать. События аудита генерируются запросами на сервер API {{ k8s }} на каждой [стадии](#stages) их выполнения. Правила политики аудита применяются по порядку. Первое правило, соответствующее событию, устанавливает [уровень](#levels) аудита события.

## Стадии {#stages}

Стадия | Момент генерации события
--- | ---
`RequestReceived` | Как только обработчик аудита получает запрос.
`ResponseStarted` | После отправки заголовков ответа, но до отправки тела ответа.
`ResponseComplete` | После отправки тела ответа.
`Panic` | После появления критических ошибок.

## Уровни {#levels}

Уровень | Описание
--- | ---
`None` | Не записывать события.
`Metadata` | Записывать метаданные событий, но не включать тело запроса или ответа.
`Request` | Записывать метаданные событий и тело запроса, но не включать тело ответа.
`RequestResponse` | Записывать метаданные событий, тело запроса и ответа.

## Файл политики аудита в {{ managed-k8s-name }} {#rules-audit-policy}

Файл политики аудита в {{ managed-k8s-name }} выглядит так:

```yaml
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
  - level: None
    users: ["system:kube-proxy"]
    verbs: ["watch"]
    resources:
      - group: "" # Core.
        resources: ["endpoints", "services", "services/status"]
  - level: None
    users: ["system:unsecured"]
    namespaces: ["kube-system"]
    verbs: ["get"]
    resources:
      - group: "" # Core.
        resources: ["configmaps"]
  - level: None
    users: ["kubelet"] # Legacy kubelet identity.
    verbs: ["get"]
    resources:
      - group: "" # Core.
        resources: ["nodes", "nodes/status"]
  - level: None
    userGroups: ["system:nodes"]
    verbs: ["get"]
    resources:
      - group: "" # Core.
        resources: ["nodes", "nodes/status"]
  - level: None
    users:
      - system:kube-controller-manager
      - system:kube-scheduler
      - system:serviceaccount:kube-system:endpoint-controller
    verbs: ["get", "update"]
    namespaces: ["kube-system"]
    resources:
      - group: "" # Core.
        resources: ["endpoints"]
  - level: None
    users: ["system:apiserver"]
    verbs: ["get"]
    resources:
      - group: "" # Core.
        resources: ["namespaces", "namespaces/status", "namespaces/finalize"]
  - level: None
    users: ["cluster-autoscaler"]
    verbs: ["get", "update"]
    namespaces: ["kube-system"]
    resources:
      - group: "" # Core.
        resources: ["configmaps", "endpoints"]
  - level: None
    users:
      - system:kube-controller-manager
    verbs: ["get", "list"]
    resources:
      - group: "metrics.k8s.io"
  - level: None
    nonResourceURLs:
      - /healthz*
      - /version
      - /swagger*
  - level: None
    resources:
      - group: "" # Core.
        resources: ["events"]
  - level: Request
    users: ["kubelet", "system:node-problem-detector", "system:serviceaccount:kube-system:node-problem-detector"]
    verbs: ["update","patch"]
    resources:
      - group: "" # Core.
        resources: ["nodes/status", "pods/status"]
    omitStages:
      - "RequestReceived"
  - level: Request
    userGroups: ["system:nodes"]
    verbs: ["update","patch"]
    resources:
      - group: "" # Core.
        resources: ["nodes/status", "pods/status"]
    omitStages:
      - "RequestReceived"
  - level: Request
    users: ["system:serviceaccount:kube-system:namespace-controller"]
    verbs: ["deletecollection"]
    omitStages:
      - "RequestReceived"
  - level: Metadata
    resources:
      - group: "" # Core.
        resources: ["secrets", "configmaps", "serviceaccounts/token"]
      - group: authentication.k8s.io
        resources: ["tokenreviews"]
    omitStages:
      - "RequestReceived"
  - level: Request
    verbs: ["get", "list", "watch"]
    resources: 
      - group: "" # Core.
      - group: "admissionregistration.k8s.io"
      - group: "apiextensions.k8s.io"
      - group: "apiregistration.k8s.io"
      - group: "apps"
      - group: "authentication.k8s.io"
      - group: "authorization.k8s.io"
      - group: "autoscaling"
      - group: "batch"
      - group: "certificates.k8s.io"
      - group: "extensions"
      - group: "metrics.k8s.io"
      - group: "networking.k8s.io"
      - group: "policy"
      - group: "rbac.authorization.k8s.io"
      - group: "scheduling.k8s.io"
      - group: "settings.k8s.io"
      - group: "storage.k8s.io"
    omitStages:
      - "RequestReceived"
  - level: RequestResponse
    resources: 
      - group: "" # Core.
      - group: "admissionregistration.k8s.io"
      - group: "apiextensions.k8s.io"
      - group: "apiregistration.k8s.io"
      - group: "apps"
      - group: "authentication.k8s.io"
      - group: "authorization.k8s.io"
      - group: "autoscaling"
      - group: "batch"
      - group: "certificates.k8s.io"
      - group: "extensions"
      - group: "metrics.k8s.io"
      - group: "networking.k8s.io"
      - group: "policy"
      - group: "rbac.authorization.k8s.io"
      - group: "scheduling.k8s.io"
      - group: "settings.k8s.io"
      - group: "storage.k8s.io"
    omitStages:
      - "RequestReceived"
  - level: Metadata
    omitStages:
      - "RequestReceived"
```

### Описания правил политики аудита {#rule-descriptions}

Ниже приведены примеры правил политики аудита.

#### Правило для уровня `None` {#none}

```yaml
- level: None
  users: ["kubelet"] # Legacy kubelet identity.
  verbs: ["get"]
  resources:
    - group: "" # Core.
      resources: ["nodes", "nodes/status"]
```

Означает, что сведения о событиях не должны записываться, если верны условия:
* Запрос отправляется компонентом `kubelet` с [узла](../concepts/index.md#node-group) [кластера {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster).
* Тип запроса — `get`.
* Запрос относится к ресурсам `nodes` или `nodes/status`.

#### Правило для уровня `Metadata` {#metadata}

```yaml
- level: Metadata
  resources:
    - group: "" # Core.
      resources: ["secrets", "configmaps", "serviceaccounts/token"]
    - group: authentication.k8s.io
      resources: ["tokenreviews"]
  omitStages:
    - "RequestReceived"
```

Означает, что необходимо записывать метаданные событий, если верны условия:
* Событие не соответствует ни одному предыдущему правилу в политики аудита.
* Запрос относится к ресурсам `secrets`, `configmaps`, `serviceaccounts/token` или `tokenreviews`.
* Событие не относится к стадии `RequestReceived`.

#### Правило для уровня `Request` {#request}

```yaml
- level: Request
  userGroups: ["system:nodes"]
  verbs: ["update","patch"]
  resources:
    - group: "" # Core.
      resources: ["nodes/status", "pods/status"]
  omitStages:
    - "RequestReceived"
```

Означает, что необходимо записывать метаданные событий и тело запроса, если верны условия:
* Событие не соответствует ни одному предыдущему правилу в политики аудита.
* Запрос отправляется компонентом, который состоит в группе `system:nodes`.
* Тип запроса — `update` или `patch`.
* Запрос относится к ресурсам `nodes/status` или `pods/status`.
* Событие не относится к стадии `RequestReceived`.

#### Правило для уровня `Request` {#request2}

```yaml
- level: Request
  verbs: ["get", "list", "watch"]
  resources: 
    - group: "" # Core.
    - group: "admissionregistration.k8s.io"
    - group: "apiextensions.k8s.io"
    - group: "apiregistration.k8s.io"
    - group: "apps"
    - group: "authentication.k8s.io"
    - group: "authorization.k8s.io"
    - group: "autoscaling"
    - group: "batch"
    - group: "certificates.k8s.io"
    - group: "extensions"
    - group: "metrics.k8s.io"
    - group: "networking.k8s.io"
    - group: "policy"
    - group: "rbac.authorization.k8s.io"
    - group: "scheduling.k8s.io"
    - group: "settings.k8s.io"
    - group: "storage.k8s.io"
  omitStages:
    - "RequestReceived"
```

Означает, что необходимо записывать метаданные событий и тело запроса, если верны условия:
* Событие не соответствует ни одному предыдущему правилу в политики аудита.
* Тип запроса — `get`, `list` или `watch`.
* Запрос относится к группе ресурсов из списка.
* Событие не относится к стадии `RequestReceived`.

#### Правило для уровня `RequestResponse` {#requestresponse}

```yaml
- level: RequestResponse
  resources: 
    - group: "" # Core.
    - group: "admissionregistration.k8s.io"
    - group: "apiextensions.k8s.io"
    - group: "apiregistration.k8s.io"
    - group: "apps"
    - group: "authentication.k8s.io"
    - group: "authorization.k8s.io"
    - group: "autoscaling"
    - group: "batch"
    - group: "certificates.k8s.io"
    - group: "extensions"
    - group: "metrics.k8s.io"
    - group: "networking.k8s.io"
    - group: "policy"
    - group: "rbac.authorization.k8s.io"
    - group: "scheduling.k8s.io"
    - group: "settings.k8s.io"
    - group: "storage.k8s.io"
  omitStages:
    - "RequestReceived"
```

Означает, что необходимо записывать метаданные событий, тело запроса и ответа, если верны условия:
* Событие не соответствует ни одному предыдущему правилу в политики аудита.
* Тип запроса — `create`, `update` или `delete`. Это не указано явно, но следует из того, что правило не применяется к указанным ранее типам запросов: `get`, `list` или `watch`.
* Запрос относится к группе ресурсов из списка.
* Событие не относится к стадии `RequestReceived`.

Подробнее о политике аудита см. в [документации {{ k8s }}](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/#audit-policy).