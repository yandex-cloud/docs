# Использование внешних политик Kyverno с {{ kspm-name }}

В модуле _Контроль {{ k8s }}®_ ({{ kspm-name }}) сервиса {{ sd-full-name }} можно использовать собственные политики на базе Kyverno, установленного модулем. Такие политики называются _внешними_: вы создаете и изменяете их напрямую через {{ k8s }} API — например, с помощью [`kubectl`]({{ k8s-docs }}/reference/kubectl/) или своего GitOps-процесса.

{{ kspm-name }} управляет установкой Kyverno и своими правилами. Внешними политиками и сбором результатов их работы управляет пользователь. Нарушения внешних политик не создают алерты {{ kspm-name }}. Для сбора результатов можно отдельно установить Policy Reporter и настроить отправку — например, в {{ objstorage-full-name }}.

В этом руководстве вы настроите две CEL-политики из [`policies.kyverno.io/v1`](https://kyverno.io/docs/writing-policies/cel/): [GeneratingPolicy](https://kyverno.io/docs/writing-policies/generate/) для автоматического создания NetworkPolicy, запрещающей входящие соединения, и [ValidatingPolicy](https://kyverno.io/docs/writing-policies/validate/) для проверки запросов и лимитов контейнеров Deployment. Затем проверите режимы `Audit` и `Deny`, настроив через Policy Reporter отправку результатов в {{ objstorage-name }}.

Чтобы настроить внешние политики и сбор результатов:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте политику генерации NetworkPolicy](#verify-generation).
1. [Создайте политику проверки ValidatingPolicy](#create-policies).
1. [Настройте отправку результатов в {{ objstorage-name }}](#configure-storage).
1. [Проверьте доставку результатов](#verify-delivery).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* мастер кластера ([тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md));
* вычислительные ресурсы и хранилище узлов ([тарифы {{ compute-full-name }}](../../compute/pricing.md));
* публичные IP-адреса мастера и узлов, если для них включен публичный доступ ([тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip));
* хранение данных и операции с объектами в {{ objstorage-name }} ([тарифы {{ objstorage-name }}](../../storage/pricing.md)).

## Подготовьте инфраструктуру {#infra}

{% note info %}

Если у вас уже есть кластер {{ k8s }} с внешними политиками, перенесите свои политики на Kyverno по [инструкции диагностики {{ kspm-name }}](../../security-deck/diagnostics/kspm-diagnostics.md#existing-kyverno-installation).

{% endnote %}

1. [Создайте бакет](../../storage/operations/buckets/create.md) {{ objstorage-name }}.
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с именем `kyverno-sa` и [назначьте ему роли](../../iam/operations/sa/assign-role-for-sa.md) на каталог:

    * `k8s.clusters.agent` — для управления кластером {{ k8s }}.
    * `vpc.publicAdmin` — для работы с сетью {{ vpc-name }}.
    * `container-registry.images.puller` — для скачивания необходимых Docker-образов.
    * `storage.uploader` — для загрузки объектов в бакет.
    * `security-deck.worker` — для работы в модуле {{ kspm-name }}.

1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md) для сервисного аккаунта. Сохраните идентификатор ключа и секретный ключ.
1. [Создайте облачную сеть](../../vpc/operations/network-create.md) `kyverno-network` и [подсеть] (../../vpc/operations/subnet-create.md) `kyverno-subnet`.
1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) `kyverno-sg` в той же сети. Добавьте правила из таблицы:

   | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник /<br/>назначение | CIDR-блоки /<br/>группа безопасности | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} |
   | --- | --- | --- | --- | --- | --- |
   | `Входящий` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `k8s-api` |
   | `Входящий` | `6443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `k8s-api` |
   | `Входящий` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` | `master-node` |
   | `Входящий` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.96.0.0/16`, `10.112.0.0/16` | `pods-services` |
   | `Входящий` | `{{ port-any }}` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — | `healthchecks` |
   | `Исходящий` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` | `master-node` |
   | `Исходящий` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `nodes-external` |

1. [Создайте кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) {{ k8s }}:

   * **{{ ui-key.yacloud.k8s.clusters.create.field_network }}** — `kyverno-network`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_subnetwork }}** — `kyverno-subnet`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}** — `kyverno-sa`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}** — `kyverno-sa`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_cluster-cidr }}** — `10.96.0.0/16`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_service-cidr }}** — `10.112.0.0/16`.

   Убедитесь, что кластер соответствует [требованиям {{ kspm-name }}](../../security-deck/operations/kspm/requirements.md).

1. Создайте [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md), которая соответствует [требованиям {{ kspm-name }}](../../security-deck/operations/kspm/requirements.md#worker-node-requirements).
1. [Активируйте {{ kspm-name }}](../../security-deck/operations/kspm/enable-kspm.md) для кластера. Для модуля должно быть включено хотя бы одно [правило](../../security-deck/operations/kspm/view-rules.md) типа `Admission`.
1. Установите [kubectl]({{ k8s-docs }}/tasks/tools/#kubectl) и [Helm](https://helm.sh/docs/intro/install/).
1. [Настройте доступ к кластеру](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) через kubectl. Проверьте настройку:

   1. Проверьте выбранный контекст:

      ```bash
      kubectl config current-context
      ```
  
      Команда должна вывести контекст вашего кластера.

   1. Убедитесь, что доступны типы политик из примера:

      ```bash
      kubectl get crd validatingpolicies.policies.kyverno.io generatingpolicies.policies.kyverno.io -o name
      ```
  
      Результат:
  
      ```text
      ...
      customresourcedefinition.apiextensions.k8s.io/validatingpolicies.policies.kyverno.io
      customresourcedefinition.apiextensions.k8s.io/generatingpolicies.policies.kyverno.io
      ```

{% cut "Какими ресурсами управляет {{ kspm-name }}" %}

Пространство имен `yc-security` зарезервировано для компонентов {{ kspm-name }}. {{ kspm-name }} управляет служебными ресурсами в этом пространстве имен. Размещайте внешние политики уровня пространства имен, Policy Reporter и свои приложения в отдельных пространствах имен.

{{ kspm-name }} сохраняет за собой право создавать, изменять, пересоздавать и удалять свои ресурсы при установке, обновлении, восстановлении состояния и удалении компонентов. Это относится к служебным ресурсам в `yc-security`, а также к политикам и CRD Kyverno с меткой `kspm.yandex.cloud/managed-by: kspm`.

Не изменяйте и не удаляйте служебные ресурсы {{ kspm-name }} вручную: {{ kspm-name }} может перезаписать ручные изменения таких ресурсов при дальнейшей работе.

Метка `kspm.yandex.cloud/managed-by: kspm` зарезервирована для ресурсов {{ kspm-name }}. Не устанавливайте ее на внешние политики — {{ kspm-name }} может принять их за свои и удалить.

Если нужно изменить конфигурацию Kyverno, который управляется {{ kspm-name }}, обратитесь в [техническую поддержку]({{ link-docs }}/support/overview).

{% endcut %}

## Создайте политику генерации GeneratingPolicy {#verify-generation}

GeneratingPolicy автоматически создает NetworkPolicy, которая ограничивает входящие соединения. Она применяется ко всем подам этого пространства имен. Чтобы создать политику генерации:

1. Создайте файл `generate-policy.yaml` с манифестом политики:

   ```yaml
   apiVersion: policies.kyverno.io/v1
   kind: GeneratingPolicy
   metadata:
     name: external-default-deny-ingress
   spec:
     matchConstraints:
       objectSelector:
         matchLabels:
           example.com/network-isolation: enabled
       resourceRules:
         - apiGroups: [""]
           apiVersions: [v1]
           operations: [CREATE, UPDATE]
           resources: [namespaces]
     variables:
       - name: namespace
         expression: object.metadata.name
     generate:
       - expression: >-
           generator.Apply(variables.namespace, [
             {
               "apiVersion": dyn("networking.k8s.io/v1"),
               "kind": dyn("NetworkPolicy"),
               "metadata": dyn({"name": "default-deny-ingress"}),
               "spec": dyn({
                 "podSelector": dyn({}),
                 "policyTypes": dyn(["Ingress"]),
                 "ingress": dyn([])
               })
             }
           ])
   ```

1. Примените политику и дождитесь ее готовности:

    ```bash
    kubectl apply -f generate-policy.yaml
    kubectl wait generatingpolicy.policies.kyverno.io/external-default-deny-ingress \
      --for=jsonpath='{.status.conditionStatus.ready}'=true --timeout=120s
    ```

    Результат:

    ```text
    generatingpolicy.policies.kyverno.io/external-default-deny-ingress created
    generatingpolicy.policies.kyverno.io/external-default-deny-ingress condition met
    ```

1. Создайте файл `namespace.yaml` с манифестом пространства имен:

   ```yaml
   apiVersion: v1
   kind: Namespace
   metadata:
     name: external-policy-workloads
     labels:
       example.com/network-isolation: enabled
   ```

1. Создайте пространство имен и дождитесь создания NetworkPolicy:

    ```bash
    kubectl apply -f namespace.yaml
    kubectl wait --for=create networkpolicy/default-deny-ingress \
      -n external-policy-workloads --timeout=120s
    kubectl get networkpolicy default-deny-ingress -n external-policy-workloads -o yaml
    ```

    Результат:

    ```text
    namespace/external-policy-workloads created
    networkpolicy.networking.k8s.io/default-deny-ingress condition met
    ```

    Фрагмент вывода команды `kubectl get networkpolicy`:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: default-deny-ingress
      namespace: external-policy-workloads
    spec:
      podSelector: {}
      policyTypes:
        - Ingress
    ```

## Создайте политику проверки ValidatingPolicy {#create-policies}

ValidatingPolicy используется для проверки запросов и лимитов контейнеров Deployment. Чтобы создать политику проверки:

1. Создайте файл `validate-policy.yaml` с манифестом политики:

   ```yaml
   apiVersion: policies.kyverno.io/v1
   kind: ValidatingPolicy
   metadata:
     name: external-require-resources
     annotations:
       policies.kyverno.io/title: Require resource requests and memory limits
       policies.kyverno.io/severity: medium
   spec:
     validationActions:
       - Audit
     failurePolicy: Ignore
     evaluation:
       admission:
         enabled: true
       background:
         enabled: true
     matchConstraints:
       namespaceSelector:
         matchLabels:
           kubernetes.io/metadata.name: external-policy-workloads
       resourceRules:
         - apiGroups: [apps]
           apiVersions: [v1]
           operations: [CREATE, UPDATE]
           resources: [deployments]
     variables:
       - name: containers
         expression: object.spec.template.spec.containers + object.spec.template.spec.?initContainers.orValue([])
     validations:
       - expression: >-
           variables.containers.all(c,
             has(c.resources) &&
             has(c.resources.requests) &&
             'cpu' in c.resources.requests &&
             'memory' in c.resources.requests &&
             has(c.resources.limits) &&
             'memory' in c.resources.limits)
         message: "Each container must specify CPU and memory requests and a memory limit."
   ```

1. Примените политику и дождитесь ее готовности:

    ```bash
    kubectl apply -f validate-policy.yaml
    kubectl wait validatingpolicy.policies.kyverno.io/external-require-resources \
      --for=jsonpath='{.status.conditionStatus.ready}'=true --timeout=120s
    ```

    Результат:

    ```text
    validatingpolicy.policies.kyverno.io/external-require-resources created
    validatingpolicy.policies.kyverno.io/external-require-resources condition met
    ```

Политика `external-require-resources` проверяет развертывания в пространстве имен `external-policy-workloads`: каждый основной и init-контейнер должен иметь параметры `request` для CPU и памяти, а также параметр `limit` памяти. Параметр `limit` CPU не требуется. Параметр `spec.evaluation.background.enabled: true` также включает проверку существующих подходящих ресурсов.

Для CEL-политик в режиме `Audit` с фоновыми проверками рекомендуется указывать `spec.failurePolicy: Ignore`, чтобы недоступность Kyverno или ошибки в политике не блокировали запросы к кластеру. Действие при нарушении задается отдельно в `spec.validationActions`: `Audit` фиксирует нарушение, `Deny` отклоняет запрос.

## Настройте отправку результатов в {{ objstorage-name }} {#configure-storage}

Для CEL-политик обычные результаты имеют источник `KyvernoValidatingPolicy`. Для заблокированных запросов плагин Kyverno создает отчеты на основе событий {{ k8s }} с источником `Kyverno Event`. Разрешите оба источника в настройках отправки.

В этом руководстве в Policy Reporter настраивается отправка результатов в {{ objstorage-name }}. Policy Reporter также поддерживает вебхуки, Loki, Elasticsearch, Kinesis и другие [направления отправки](https://kyverno.github.io/policy-reporter-docs/policy-reporter/integrations.html).

### Установите Policy Reporter {#install-policy-reporter}

Policy Reporter будет сохранять отчеты о проверка в бакет в формате JSON. Чтобы установить Policy Reporter:

1. Создайте пространство имен для Policy Reporter:

   ```bash
   kubectl create namespace policy-reporter
   ```

   Результат:

   ```text
   namespace/policy-reporter created
   ```

1. Создайте файл `s3-secret.yaml`. Укажите в нем идентификатор и секретную часть статического ключа:

   ```yaml
   apiVersion: v1
   kind: Secret
   metadata:
     name: policy-reporter-s3
     namespace: policy-reporter
   type: Opaque
   stringData:
     accessKeyId: "<идентификатор_статического_ключа>"
     secretAccessKey: "<секретный_ключ>"
   ```

1. Создайте секрет:

   ```bash
   kubectl apply -f s3-secret.yaml
   ```

   Результат:

   ```text
   secret/policy-reporter-s3 created
   ```

1. Создайте файл `values.yaml` с настройками Policy Reporter. В поле `bucket` укажите имя подготовленного бакета:

    ```yaml
    fullnameOverride: external-policy-reporter
    image:
      tag: "3.11.2"
    ui:
      enabled: false
    plugin:
      kyverno:
        enabled: true
        image:
          tag: "0.7.3"
        blockReports:
          enabled: true
          eventNamespace: ""
    sourceFilters: []
    target:
      s3:
        endpoint: https://storage.yandexcloud.net
        region: ru-central1
        bucket: "<имя_бакета>"
        prefix: external-policies
        secretRef: policy-reporter-s3
        skipExistingOnStartup: true
        sources:
          - kyverno
          - KyvernoValidatingPolicy
          - Kyverno Event
        filter:
          policies:
            exclude:
              - "kspm.*"
              - "*/kspm.*"
    ```

    Шаблоны `kspm.*` и `*/kspm.*` исключают политики, которые управляются {{ kspm-name }}. Не используйте префикс `kspm.` для внешних политик.

    Параметр `eventNamespace` с пустым значением включает наблюдение за событиями во всех пространствах имен. Результаты будут сохраняться в бакете с префиксом `external-policies/`.

1. Установите Policy Reporter:

    ```bash
    helm repo add policy-reporter https://kyverno.github.io/policy-reporter
    helm repo update policy-reporter
    helm upgrade --install external-policy-reporter policy-reporter/policy-reporter \
      --version 3.11.1 \
      --namespace policy-reporter --create-namespace \
      --values values.yaml \
      --wait --timeout 5m
    ```

1. Убедитесь, что поды Policy Reporter запущены:

    ```bash
    kubectl get deployments -n policy-reporter
    ```

    Результат:

    ```text
    NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE
    external-policy-reporter                  1/1     1            1           1m
    external-policy-reporter-kyverno-plugin   1/1     1            1           1m
    ```

## Проверьте доставку результатов {#verify-delivery}

Проверьте работу политики `external-require-resources` в двух режимах: `Audit` и `Deny`. В режиме `Audit` политика фиксирует нарушения, но не блокирует создание ресурсов. В режиме `Deny` политика отклоняет запросы, не соответствующие правилам. Результаты работы обоих режимов должны появиться в {{ objstorage-name }}.

### Проверьте нарушение в режиме Audit {#verify-audit}

1. Создайте файл `deployment.yaml` с манифестом Deployment без параметров `requests` и `limits`:

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: external-audit-violation
     namespace: external-policy-workloads
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: external-audit-violation
     template:
       metadata:
         labels:
           app: external-audit-violation
       spec:
         containers:
           - name: nginx
             image: nginx:stable
   ```

1. Создайте Deployment:

    ```bash
    kubectl create -f deployment.yaml
    ```

    Результат:

    ```text
    deployment.apps/external-audit-violation created
    ```

1. Проверьте результат срабатывания политики:

    ```bash
    kubectl get policyreports.wgpolicyk8s.io -n external-policy-workloads -o yaml
    ```

    Дождитесь результата `fail` в PolicyReport. Фрагмент вывода:

    ```yaml
    items:
      - scope:
          apiVersion: apps/v1
          kind: Deployment
          name: external-audit-violation
          namespace: external-policy-workloads
        results:
          - policy: external-require-resources
            result: fail
            source: KyvernoValidatingPolicy
    ```

1. В [консоли управления]({{ link-console-main }}) откройте подготовленный бакет {{ objstorage-name }}. В префиксе `external-policies/` найдите и [скачайте](../../storage/operations/objects/download.md) JSON-объект с результатом этой проверки. Проверьте следующие поля:

    ```json
    {
      "policy": "external-require-resources",
      "status": "fail",
      "source": "KyvernoValidatingPolicy",
      "resource": {
        "kind": "Deployment",
        "namespace": "external-policy-workloads",
        "name": "external-audit-violation"
      }
    }
    ```

### Проверьте блокировку запроса в режиме Deny {#verify-enforce}

1. Переведите политику в режим `Deny`:

    ```bash
    kubectl patch validatingpolicy.policies.kyverno.io external-require-resources \
      --type=merge \
      -p '{"spec":{"validationActions":["Deny"]}}'
    kubectl wait validatingpolicy.policies.kyverno.io/external-require-resources \
      --for=jsonpath='{.status.conditionStatus.ready}'=true --timeout=120s
    ```

    Результат:

    ```text
    validatingpolicy.policies.kyverno.io/external-require-resources patched
    validatingpolicy.policies.kyverno.io/external-require-resources condition met
    ```

1. Создайте новый Deployment без параметров `requests` и `limits`:

    ```bash
    kubectl create deployment external-denied --image=nginx:stable \
      -n external-policy-workloads
    ```

    Запрос будет отклонен:

    ```text
    error: failed to create deployment: admission webhook "vpol.validate.kyverno.svc-ignore" denied the request: Policy external-require-resources failed: Each container must specify CPU and memory requests and a memory limit.
    ```

1. Убедитесь, что ресурс не создан:

    ```bash
    kubectl get deployment external-denied -n external-policy-workloads --ignore-not-found
    ```

    Команда не должна ничего вывести.

1. Дождитесь нового JSON-объекта в префиксе `external-policies/` вашего бакета. Скачайте его и проверьте следующие поля:

    ```json
    {
      "policy": "external-require-resources",
      "status": "fail",
      "source": "Kyverno Event",
      "resource": {
        "kind": "Deployment",
        "namespace": "external-policy-workloads",
        "name": "external-denied"
      }
    }
    ```

1. Исправьте Deployment, созданный в режиме `Audit`:

    ```bash
    kubectl set resources deployment external-audit-violation \
      -n external-policy-workloads \
      --requests=cpu=100m,memory=64Mi --limits=memory=128Mi
    ```

    Результат:

    ```text
    deployment.apps/external-audit-violation resource requirements updated
    ```

1. Повторно получите отчеты:

    ```bash
    kubectl get policyreports.wgpolicyk8s.io -n external-policy-workloads -o yaml
    ```

    Дождитесь результата `pass` для исправленного Deployment:

    ```yaml
    items:
      - scope:
          apiVersion: apps/v1
          kind: Deployment
          name: external-audit-violation
          namespace: external-policy-workloads
        results:
          - policy: external-require-resources
            result: pass
            source: KyvernoValidatingPolicy
    ```

### Проверьте исключение результатов {{ kspm-name }} {#verify-exclusions}

Новые результаты нарушений правил {{ kspm-name }} не должны появляться в бакете, а результаты нарушений внешних политик — продолжать поступать.

Результаты {{ kspm-name }} сохраняются в отчетах {{ k8s }} и хранилище Policy Reporter. Фильтр исключает их только из отправки в {{ objstorage-name }}.

Не удаляйте отчеты и результаты {{ kspm-name }} ради фильтрации своих уведомлений: {{ kspm-name }} использует их для доставки событий.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) {{ managed-k8s-name }}.
1. [Удалите группу безопасности](../../vpc/operations/security-group-delete.md).
1. [Удалите подсеть](../../vpc/operations/subnet-delete.md).
1. [Удалите облачную сеть](../../vpc/operations/network-delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md). Если аккаунт используется в настройках коннектора {{ kspm-name }} или для других задач, не удаляйте его.
1. [Удалите объекты](../../storage/operations/objects/delete.md) из бакета.
1. [Удалите бакет](../../storage/operations/buckets/delete.md).
