# Настройка контроллера сетевых политик Cilium

В этом сценарии демонстрируется [работа сетевых политик уровней L3/L4 и L7](https://docs.cilium.io/en/v1.10/gettingstarted/http/), которыми управляет [контроллер сетевых политик Cilium](../concepts/network-policy.md#cilium).

Чтобы использовать контроллер сетевых политик Cilium в кластере:
* [Установите и настройте средство наблюдения за сетевыми событиями Hubble UI](#install-hubble-ui).
* [Создайте тестовое окружение](#create-test-environment).
* [Создайте сетевую политику уровня L3/L4](#l3-l4-policy).
* [Создайте сетевую политику уровня L7](#l7-policy).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) и [назначьте ему роли](../../iam/operations/sa/assign-role-for-sa.md) `k8s.tunnelClusters.agent` и `vpc.publicAdmin`.

    1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

    1. [Создайте кластер](kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации.

        * Для полей **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}** и **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}** выберите `{{ ui-key.yacloud.component.service-account-field.label_sg-from-list }}` и затем выберите созданный сервисный аккаунт из выпадающего списка.

        * В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}** выберите следующие значения:

            * **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}** — `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}`.
            * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `{{ ui-key.yacloud.component.security-group-field.label_sg-from-list }}`. Укажите группы безопасности для кластера.

        * В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}** выберите опцию **{{ ui-key.yacloud.k8s.clusters.create.field_tunnel-mode }}**.

    1. [Создайте для кластера группу узлов](node-group/node-group-create.md) любой подходящей конфигурации.

        В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}** выберите следующие значения:

        * **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** — `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `{{ ui-key.yacloud.component.security-group-field.label_sg-from-list }}`. Укажите группы безопасности для групп узлов.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
    1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-cilium.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cilium-setup/blob/main/k8s-cilium.tf). С помощью файла будут созданы ресурсы:

        * [Сеть](../../vpc/concepts/network.md#network).
        * [Подсеть](../../vpc/concepts/network.md#subnet).
        * Кластер {{ managed-k8s-name }}.
        * Группа узлов для кластера.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и его группы узлов.

        * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-with-audience-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

    1. Укажите в файле `k8s-cilium.tf`:

        * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
        * [Версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов.
        * Имя сервисного аккаунта.

    1. {% include [terraform-validate](../../_includes/managed-kubernetes/terraform-validate.md) %}

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Подготовьтесь к работе с кластером {#do-preparations}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Установите утилиту Cilium CLI](https://github.com/cilium/cilium-cli?tab=readme-ov-file#installation) (`cilium`).

## Установите и настройте Hubble UI {#install-hubble-ui}

1. Проверьте текущее состояние Cilium в кластере:

    ```bash
    cilium status
    ```

    Cilium, Operator и Hubble Relay должны иметь статус `OK`.

    {% cut "Пример результата выполнения команды" %}

    ```text
        /¯¯\
     /¯¯\__/¯¯\    Cilium:             OK
     \__/¯¯\__/    Operator:           OK
     /¯¯\__/¯¯\    Envoy DaemonSet:    disabled (using embedded mode)
     \__/¯¯\__/    Hubble Relay:       OK
        \__/       ClusterMesh:        disabled

    DaemonSet              cilium             Desired: 1, Ready: 1/1, Available: 1/1
    Deployment             cilium-operator    Desired: 1, Ready: 1/1, Available: 1/1
    Deployment             hubble-relay       Desired: 1, Ready: 1/1, Available: 1/1
    Containers:            cilium             Running: 1
                           cilium-operator    Running: 1
                           hubble-relay       Running: 1
    Cluster Pods:          5/5 managed by Cilium
    Helm chart version:
    Image versions         cilium             {{ registry }}/******/k8s-addons/cilium/cilium:v1.12.9: 1
                           cilium-operator    {{ registry }}/******/k8s-addons/cilium/operator-generic:v1.12.9: 1
                           hubble-relay       {{ registry }}/******/k8s-addons/cilium/hubble-relay:v1.12.9: 1
    ```

    {% endcut %}

1. Создайте файл `hubble-ui.yaml` со спецификацией ресурсов, необходимых для Hubble UI:

    {% cut "hubble-ui.yaml" %}

    ```yaml
    ---
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: "hubble-ui"
      namespace: kube-system
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: hubble-ui-nginx
      namespace: kube-system
    data:
      nginx.conf: |
        server
        {
          listen 8081;
          listen [::]:8081;
          server_name localhost;
          root /app;
          index index.html;
          client_max_body_size 1G;

          location /
          {
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;

            # CORS
            add_header Access-Control-Allow-Methods 'GET, POST, PUT, HEAD, DELETE, OPTIONS';
            add_header Access-Control-Allow-Origin *;
            add_header Access-Control-Max-Age 1728000;
            add_header Access-Control-Expose-Headers content-length,grpc-status,grpc-message;
            add_header Access-Control-Allow-Headers range,keep-alive,user-agent,cache-control,content-type,content-transfer-encoding,x-accept-content-transfer-encoding,x-accept-response-streaming,x-user-agent,x-grpc-web,grpc-timeout;
            if ($request_method = OPTIONS)
            {
              return 204;
            }
            # /CORS

            location /api
            {
              proxy_http_version 1.1;
              proxy_pass_request_headers on;
              proxy_hide_header Access-Control-Allow-Origin;
              proxy_pass http://127.0.0.1:8090;
            }

            location /
            {
              # double `/index.html` is required here
              try_files $uri $uri/ /index.html /index.html;
            }

            # Liveness probe
            location /healthz
            {
              access_log off;
              add_header Content-Type text/plain;
              return 200 'ok';
            }
          }
        }
    ---
    kind: ClusterRole
    apiVersion: rbac.authorization.k8s.io/v1
    metadata:
      name: hubble-ui
      labels:
        app.kubernetes.io/part-of: cilium
    rules:
    - apiGroups:
      - networking.k8s.io
      resources:
      - networkpolicies
      verbs:
      - get
      - list
      - watch
    - apiGroups:
      - ""
      resources:
      - componentstatuses
      - endpoints
      - namespaces
      - nodes
      - pods
      - services
      verbs:
      - get
      - list
      - watch
    - apiGroups:
      - apiextensions.k8s.io
      resources:
      - customresourcedefinitions
      verbs:
      - get
      - list
      - watch
    - apiGroups:
      - cilium.io
      resources:
      - "*"
      verbs:
      - get
      - list
      - watch
    ---
    kind: ClusterRoleBinding
    apiVersion: rbac.authorization.k8s.io/v1
    metadata:
      name: hubble-ui
      labels:
        app.kubernetes.io/part-of: cilium
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ClusterRole
      name: hubble-ui
    subjects:
    - kind: ServiceAccount
      name: "hubble-ui"
      namespace: kube-system
    ---
    kind: Service
    apiVersion: v1
    metadata:
      name: hubble-ui
      namespace: kube-system
      labels:
        k8s-app: hubble-ui
        app.kubernetes.io/name: hubble-ui
        app.kubernetes.io/part-of: cilium
    spec:
      type: "ClusterIP"
      selector:
        k8s-app: hubble-ui
      ports:
        - name: http
          port: 80
          targetPort: 8081
    ---
    kind: Deployment
    apiVersion: apps/v1
    metadata:
      name: hubble-ui
      namespace: kube-system
      labels:
        k8s-app: hubble-ui
        app.kubernetes.io/name: hubble-ui
        app.kubernetes.io/part-of: cilium
    spec:
      replicas: 1
      selector:
        matchLabels:
          k8s-app: hubble-ui
      strategy:
        rollingUpdate:
          maxUnavailable: 1
        type: RollingUpdate
      template:
        metadata:
          annotations:
          labels:
            k8s-app: hubble-ui
            app.kubernetes.io/name: hubble-ui
            app.kubernetes.io/part-of: cilium
        spec:
          priorityClassName:
          serviceAccount: "hubble-ui"
          serviceAccountName: "hubble-ui"
          automountServiceAccountToken: true
          containers:
          - name: frontend
            image: "quay.io/cilium/hubble-ui:v0.13.0@sha256:7d663dc16538dd6e29061abd1047013a645e6e69c115e008bee9ea9fef9a6666"
            imagePullPolicy: IfNotPresent
            ports:
            - name: http
              containerPort: 8081
            livenessProbe:
              httpGet:
                path: /healthz
                port: 8081
            readinessProbe:
              httpGet:
                path: /
                port: 8081
            volumeMounts:
            - name: hubble-ui-nginx-conf
              mountPath: /etc/nginx/conf.d/default.conf
              subPath: nginx.conf
            - name: tmp-dir
              mountPath: /tmp
            terminationMessagePolicy: FallbackToLogsOnError
          - name: backend
            image: "quay.io/cilium/hubble-ui-backend:v0.13.0@sha256:1e7657d997c5a48253bb8dc91ecee75b63018d16ff5e5797e5af367336bc8803"
            imagePullPolicy: IfNotPresent
            env:
            - name: EVENTS_SERVER_PORT
              value: "8090"
            - name: FLOWS_API_ADDR
              value: "hubble-relay:80"
            ports:
            - name: grpc
              containerPort: 8090
            volumeMounts:
            terminationMessagePolicy: FallbackToLogsOnError
          nodeSelector:
            kubernetes.io/os: linux
          volumes:
          - configMap:
              defaultMode: 420
              name: hubble-ui-nginx
            name: hubble-ui-nginx-conf
          - emptyDir: {}
            name: tmp-dir
   ```

   {% endcut %}

1. Создайте ресурсы:

    ```bash
    kubectl apply -f hubble-ui.yaml
    ```

    {% cut "Результат выполнения команды" %}

    ```text
    serviceaccount/hubble-ui created
    configmap/hubble-ui-nginx created
    clusterrole.rbac.authorization.k8s.io/hubble-ui created
    clusterrolebinding.rbac.authorization.k8s.io/hubble-ui created
    service/hubble-ui created
    deployment.apps/hubble-ui created
    ```

    {% endcut %}

1. Проверьте состояние Cilium после установки Hubble UI:

    ```bash
    cilium status
    ```

    Cilium, Operator и Hubble Relay должны иметь статус `OK`. Контейнер `hubble-ui` должен находиться в состоянии `Running: 1`.

    {% cut "Пример результата выполнения команды" %}

    ```text
        /¯¯\
     /¯¯\__/¯¯\    Cilium:             OK
     \__/¯¯\__/    Operator:           OK
     /¯¯\__/¯¯\    Envoy DaemonSet:    disabled (using embedded mode)
     \__/¯¯\__/    Hubble Relay:       OK
        \__/       ClusterMesh:        disabled

    Deployment             cilium-operator    Desired: 1, Ready: 1/1, Available: 1/1
    Deployment             hubble-ui          Desired: 1, Ready: 1/1, Available: 1/1
    DaemonSet              cilium             Desired: 1, Ready: 1/1, Available: 1/1
    Deployment             hubble-relay       Desired: 1, Ready: 1/1, Available: 1/1
    Containers:            cilium             Running: 1
                           hubble-relay       Running: 1
                           cilium-operator    Running: 1
                           hubble-ui          Running: 1
    Cluster Pods:          6/6 managed by Cilium
    Helm chart version:
    Image versions         cilium             {{ registry }}/******/k8s-addons/cilium/cilium:v1.12.9: 1
                           hubble-relay       {{ registry }}/******/k8s-addons/cilium/hubble-relay:v1.12.9: 1
                           cilium-operator    {{ registry }}/******/k8s-addons/cilium/operator-generic:v1.12.9: 1
                           hubble-ui          quay.io/cilium/hubble-ui-backend:v0.13.0@sha256:******: 1
                           hubble-ui          quay.io/cilium/hubble-ui:v0.13.0@sha256:******: 1
    ```

    {% endcut %}

1. Получите доступ к веб-интерфейсу Hubble UI, выполнив команду:

    ```bash
    cilium hubble ui
    ```

    Откроется браузер и вы будете перенаправлены в веб-интерфейс Hubble UI.

    {% note info %}

    Если вы закроете сессию терминала, в которой выполняется команда, то доступ к веб-интерфейсу будет потерян.

    {% endnote %}

## Создайте тестовое окружение {#create-test-environment}

1. Создайте файл `http-sw-app.yaml` со спецификацией ресурсов для тестовых приложений:

   {% cut "http-sw-app.yaml" %}

   ```yaml
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: deathstar
   spec:
     type: ClusterIP
     ports:
     - port: 80
     selector:
       org: empire
       class: deathstar
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: deathstar
   spec:
     replicas: 2
     selector:
       matchLabels:
         org: empire
         class: deathstar
     template:
       metadata:
         labels:
           org: empire
           class: deathstar
       spec:
         containers:
         - name: deathstar
           image: docker.io/cilium/starwars
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: tiefighter
     labels:
       org: empire
       class: tiefighter
   spec:
     containers:
     - name: spaceship
       image: docker.io/tgraf/netperf
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: xwing
     labels:
       org: alliance
       class: xwing
   spec:
     containers:
     - name: spaceship
       image: docker.io/tgraf/netperf
   ```

   {% endcut %}

1. Создайте приложения:

   ```bash
   kubectl apply -f http-sw-app.yaml
   ```

   {% cut "Результат выполнения команды" %}

   ```text
   service/deathstar created
   deployment.apps/deathstar created
   pod/tiefighter created
   pod/xwing created
   ```

   {% endcut %}

1. Убедитесь, что созданные поды и сервисы работают:

   ```bash
   kubectl get pods,svc
   ```

   {% cut "Пример результата выполнения команды" %}

   ```text
   NAME                            READY   STATUS    RESTARTS   AGE
   pod/deathstar-c74d84667-6x4gx   1/1     Running   1          7d
   pod/deathstar-c74d84667-jrdsp   1/1     Running   0          7d
   pod/tiefighter                  1/1     Running   0          7d
   pod/xwing                       1/1     Running   0          7d

   NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
   service/deathstar    ClusterIP   10.96.18.169  <none>        80/TCP    7d
   service/kubernetes   ClusterIP   10.96.0.1     <none>        443/TCP   8d
   ```

   {% endcut %}

1. Посмотрите текущее состояние эндпоинтов Cilium:

    ```bash
    kubectl -n kube-system exec daemonset/cilium -- cilium endpoint list
    ```

    Убедитесь, что сетевые политики не действуют для всех эндпоинтов: в колонках `POLICY (ingress) ENFORCEMENT` и `POLICY (egress) ENFORCEMENT` должно быть указано значение `Disabled`.

    {% cut "Пример части результата выполнения команды" %}

    ```text
    Defaulted container "cilium-agent" out of: cilium-agent, clean-cilium-state (init), install-cni-binaries (init)
    ENDPOINT   POLICY (ingress)   POLICY (egress)   IDENTITY   LABELS (source:key[=value])                                                  IPv6   IPv4          STATUS
               ENFORCEMENT        ENFORCEMENT
    51         Disabled           Disabled          2204       k8s:app.kubernetes.io/name=hubble-ui                                                10.112.0.97   ready
                                                               k8s:app.kubernetes.io/part-of=cilium
                                                               k8s:io.cilium.k8s.namespace.labels.kubernetes.io/metadata.name=kube-system
                                                               k8s:io.cilium.k8s.policy.cluster=default
                                                               k8s:io.cilium.k8s.policy.serviceaccount=hubble-ui
                                                               k8s:io.kubernetes.pod.namespace=kube-system
                                                               k8s:k8s-app=hubble-ui
    274        Disabled           Disabled          23449      k8s:io.cilium.k8s.namespace.labels.kubernetes.io/metadata.name=kube-system          10.112.0.224  ready
                                                               k8s:io.cilium.k8s.policy.cluster=default
                                                               k8s:io.cilium.k8s.policy.serviceaccount=kube-dns-autoscaler
                                                               k8s:io.kubernetes.pod.namespace=kube-system
                                                               k8s:k8s-app=kube-dns-autoscaler

    ...
    ```

    {% endcut %}

1. Убедитесь, что приложения `tiefighter` и `xwing` имеют доступ к [API](../../glossary/rest-api.md) сервиса `deathstar` и возвращают строку `Ship landed`, т. к. сетевые политики не активированы:

   ```bash
   kubectl exec tiefighter -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing && \
   kubectl exec xwing -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
   ```

   Результаты выполнения обеих команд должны совпадать:

   ```text
   Ship landed
   Ship landed
   ```

1. Перейдите в веб-интерфейс Hubble UI и посмотрите потоки данных для подов и сервисов в пространстве имен `default`.

    Для всех потоков должен быть вердикт `forwarded`.

## Создайте политику L3/L4 {#l3-l4-policy}

Примените политику уровня L3/L4, чтобы заблокировать доступ пода `xwing` к сервису `deathstar`. Правила доступа для пода `tiefighter` останутся без изменений.

Для разграничения доступа подам при создании присвоены {{ k8s }}-метки:

* `org: empire` для пода `tiefighter`.
* `org: alliance` для пода `xwing`.

Политика L3/L4 разрешит доступ к сервису `deathstar` только подам с меткой `org: empire`.

1. Создайте файл `sw_l3_l4_policy.yaml` со спецификацией политики:

   {% cut "sw_l3_l4_policy.yaml" %}

   ```yaml
   ---
   apiVersion: "cilium.io/v2"
   kind: CiliumNetworkPolicy
   metadata:
     name: "rule1"
   spec:
     description: "L3-L4 policy to restrict deathstar access to empire ships only"
     endpointSelector:
       matchLabels:
         org: empire
         class: deathstar
     ingress:
     - fromEndpoints:
       - matchLabels:
           org: empire
       toPorts:
       - ports:
         - port: "80"
           protocol: TCP
   ```

   {% endcut %}

1. Создайте политику `rule1`:

   ```bash
   kubectl apply -f sw_l3_l4_policy.yaml
   ```

   Результат выполнения команды:

   ```text
   ciliumnetworkpolicy.cilium.io/rule1 created
   ```

1. Снова посмотрите текущее состояние эндпоинтов Cilium:

    ```bash
    kubectl -n kube-system exec daemonset/cilium -- cilium endpoint list
    ```

    Убедитесь, что для эндпоинта, связанного с меткой `k8s:class=deathstar`, действует политика на входящем направлении: в колонке `POLICY (ingress) ENFORCEMENT` должно быть указано значение `Enabled`.

    {% cut "Пример части результата выполнения команды" %}

    ```text
    Defaulted container "cilium-agent" out of: cilium-agent, clean-cilium-state (init), install-cni-binaries (init)
    ENDPOINT   POLICY (ingress)   POLICY (egress)   IDENTITY   LABELS (source:key[=value])                                                  IPv6   IPv4          STATUS
               ENFORCEMENT        ENFORCEMENT

    ...

    3509       Enabled            Disabled          52725      k8s:class=deathstar                                                                 10.112.0.43   ready
                                                               k8s:io.cilium.k8s.namespace.labels.kubernetes.io/metadata.name=default
                                                               k8s:io.cilium.k8s.policy.cluster=default
                                                               k8s:io.cilium.k8s.policy.serviceaccount=default
                                                               k8s:io.kubernetes.pod.namespace=default
                                                               k8s:org=empire
    
    ...
    ```

    {% endcut %}

1. Проверьте доступность сервиса `deathstar` для пода `tiefighter`:

   ```bash
   kubectl exec tiefighter -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
   ```

   Результат выполнения команды:

   ```text
   Ship landed
   ```

1. Проверьте отсутствие доступа пода `xwing` к сервису `deathstar`:

   ```bash
   kubectl exec xwing -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
   ```

   Нажмите **Ctrl** + **C**, чтобы прервать выполнение команды. Сетевая политика заблокировала доступ этого пода к сервису.

1. Изучите работу политики:

   * Посмотрите спецификацию и статус политики, выполнив команду:

     ```bash
     kubectl describe cnp rule1
     ```

   * Перейдите в веб-интерфейс Hubble UI и посмотрите потоки данных для подов и сервисов в пространстве имен `default`.

        * Для потоков от `tiefighter` к `deathstar.default.svc.cluster.local/v1/request-landing` должен быть вердикт `forwarded`.
        * Для потоков от `xwing` к `deathstar.default.svc.cluster.local/v1/request-landing` должен быть вердикт `dropped`.

## Создайте политику L7 {#l7-policy}

В этой части сценария политика доступа для пода `tiefighter` будет изменена:

* Доступ к методу API `deathstar.default.svc.cluster.local/v1/exhaust-port` будет запрещен.
* Доступ к методу API `deathstar.default.svc.cluster.local/v1/request-landing` будет оставлен без изменений.

Доступ для пода `xwing` останется без изменений. Этот под не имеет доступа к `deathstar`.

1. Проверьте, что при использовании существующей политики `rule1` под `tiefighter` имеет доступ к методу `deathstar.default.svc.cluster.local/v1/exhaust-port`:

   ```bash
   kubectl exec tiefighter -- curl -s -XPUT deathstar.default.svc.cluster.local/v1/exhaust-port
   ```

   Результат выполнения команды:

   ```text
   Panic: deathstar exploded

   goroutine 1 [running]:
   main.HandleGarbage(0x2080c3f50, 0x2, 0x4, 0x425c0, 0x5, 0xa)
     /code/src/github.com/empire/deathstar/
     temp/main.go:9 +0x64
   main.main()
     /code/src/github.com/empire/deathstar/
     temp/main.go:5 +0x85
   ```

1. Создайте файл `sw_l3_l4_l7_policy.yaml` с обновленной спецификацией политики:

   {% cut "sw_l3_l4_l7_policy.yaml" %}

   ```yaml
   ---
   apiVersion: "cilium.io/v2"
   kind: CiliumNetworkPolicy
   metadata:
     name: "rule1"
   spec:
     description: "L7 policy to restrict access to specific HTTP call"
     endpointSelector:
       matchLabels:
         org: empire
         class: deathstar
     ingress:
     - fromEndpoints:
       - matchLabels:
           org: empire
       toPorts:
       - ports:
         - port: "80"
           protocol: TCP
         rules:
           http:
           - method: "POST"
             path: "/v1/request-landing"
   ```

   {% endcut %}

1. Обновите существующую политику `rule1`:

   ```bash
   kubectl apply -f sw_l3_l4_l7_policy.yaml
   ```

   Результат выполнения команды:

   ```text
   ciliumnetworkpolicy.cilium.io/rule1 configured
   ```

1. Убедитесь, что под `tiefighter` имеет доступ к методу `deathstar.default.svc.cluster.local/v1/request-landing`:

   ```bash
   kubectl exec tiefighter -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
   ```

   Результат выполнения команды:

   ```text
   Ship landed
   ```

1. Убедитесь, что доступ к методу `deathstar.default.svc.cluster.local/v1/exhaust-port` для пода `tiefighter` запрещен:

   ```bash
   kubectl exec tiefighter -- curl -s -XPUT deathstar.default.svc.cluster.local/v1/exhaust-port
   ```

   Результат выполнения команды:

   ```text
   Access denied
   ```

1. Проверьте, что под `xwing` не имеет доступа к сервису `deathstar`:

   ```bash
   kubectl exec xwing -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
   ```

   Нажмите **Ctrl** + **C**, чтобы прервать выполнение команды.

1. Изучите работу политики:

   * Посмотрите спецификацию и статус политики, выполнив команду:

     ```bash
     kubectl describe cnp rule1
     ```

   * Перейдите в веб-интерфейс Hubble UI и посмотрите потоки данных для подов и сервисов в пространстве имен `default`:

        * Для потоков от `tiefighter` к `deathstar.default.svc.cluster.local/v1/request-landing` должен быть вердикт `forwarded`.
        * Для потоков от `tiefighter` к `deathstar.default.svc.cluster.local/v1/exhaust-port` должен быть вердикт `dropped`.
        * Для потоков от `xwing` к `deathstar.default.svc.cluster.local` должет быть вердикт `dropped`.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер {{ managed-k8s-name }}](kubernetes-cluster/kubernetes-cluster-delete.md).
  1. Если для доступа к кластеру или узлам использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.

- {{ TF }} {#tf}

  1. В командной строке перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  1. Удалите конфигурационный файл `k8s-cilium.tf`.
  1. {% include [terraform-validate](../../_includes/managed-kubernetes/terraform-validate.md) %}
  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     Все ресурсы, которые были описаны в конфигурационном файле `k8s-cilium.tf`, будут удалены.

{% endlist %}
