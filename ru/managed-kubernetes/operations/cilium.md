# Настройка контроллера сетевых политик Cilium

В этом сценарии демонстрируется [работа сетевых политик уровней L3/L4 и L7](https://docs.cilium.io/en/v1.10/gettingstarted/http/), которыми управляет [контроллер сетевых политик Cilium](../concepts/network-policy.md#cilium).

Чтобы использовать контроллер сетевых политик Cilium в кластере:
* [Установите и настройте средство наблюдения за сетевыми событиями Hubble](#install-hubble).
* [Создайте тестовое окружение](#create-test-environment).
* [Создайте сетевую политику уровня L3/L4](#l3-l4-policy).
* [Создайте сетевую политику уровня L7](#l7-policy).

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) и [назначьте ему роли](../../iam/operations/sa/assign-role-for-sa.md) `k8s.tunnelClusters.agent` и `vpc.publicAdmin`.
1. [Создайте кластер](kubernetes-cluster/kubernetes-cluster-create.md) {{ k8s }} любой подходящей конфигурации.

   В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}** выберите опцию **{{ ui-key.yacloud.k8s.clusters.create.field_tunnel-mode }}**.

1. [Создайте группу узлов](node-group/node-group-create.md) любой подходящей конфигурации.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Установите и настройте сервис Hubble {#install-hubble}

1. Создайте файл `hubble-ui.yaml` со спецификацией ресурсов, необходимых для Hubble:

   {% cut "hubble-ui.yaml" %}

   ```yaml
   ---
   # Source: cilium/templates/hubble-ui-serviceaccount.yaml
   apiVersion: v1
   kind: ServiceAccount
   metadata:
     name: "hubble-ui"
     namespace: kube-system
   ---
   # Source: cilium/templates/hubble-ui-configmap.yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: hubble-ui-envoy
     namespace: kube-system
   data:
     envoy.yaml: |
       static_resources:
         listeners:
           - name: listener_hubble_ui
             address:
               socket_address:
                 address: 0.0.0.0
                 port_value: 8081
             filter_chains:
               - filters:
                   - name: envoy.filters.network.http_connection_manager
                     typed_config:
                       "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
                       codec_type: auto
                       stat_prefix: ingress_http
                       route_config:
                         name: local_route
                         virtual_hosts:
                           - name: local_service
                             domains: ["*"]
                             routes:
                               - match:
                                   prefix: "/api/"
                                 route:
                                   cluster: backend
                                   prefix_rewrite: "/"
                                   timeout: 0s
                                   max_stream_duration:
                                     grpc_timeout_header_max: 0s
                               - match:
                                   prefix: "/"
                                 route:
                                   cluster: frontend
                             cors:
                               allow_origin_string_match:
                                 - prefix: "*"
                               allow_methods: GET, PUT, DELETE, POST, OPTIONS
                               allow_headers: keep-alive,user-agent,cache-control,content-type,content-transfer-encoding,x-accept-content-transfer-encoding,x-accept-response-streaming,x-user-agent,x-grpc-web,grpc-timeout
                               max_age: "1728000"
                               expose_headers: grpc-status,grpc-message
                       http_filters:
                         - name: envoy.filters.http.grpc_web
                         - name: envoy.filters.http.cors
                         - name: envoy.filters.http.router
         clusters:
           - name: frontend
             connect_timeout: 0.25s
             type: strict_dns
             lb_policy: round_robin
             load_assignment:
               cluster_name: frontend
               endpoints:
                 - lb_endpoints:
                     - endpoint:
                         address:
                           socket_address:
                             address: 127.0.0.1
                             port_value: 8080
           - name: backend
             connect_timeout: 0.25s
             type: logical_dns
             lb_policy: round_robin
             http2_protocol_options: {}
             load_assignment:
               cluster_name: backend
               endpoints:
                 - lb_endpoints:
                     - endpoint:
                         address:
                           socket_address:
                             address: 127.0.0.1
                             port_value: 8090
   ---
   # Source: cilium/templates/hubble-ui-clusterrole.yaml
   kind: ClusterRole
   apiVersion: rbac.authorization.k8s.io/v1
   metadata:
     name: hubble-ui
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
   # Source: cilium/templates/hubble-ui-clusterrolebinding.yaml
   kind: ClusterRoleBinding
   apiVersion: rbac.authorization.k8s.io/v1
   metadata:
     name: hubble-ui
   roleRef:
     apiGroup: rbac.authorization.k8s.io
     kind: ClusterRole
     name: hubble-ui
   subjects:
     - kind: ServiceAccount
       namespace: kube-system
       name: "hubble-ui"
   ---
   # Source: cilium/templates/hubble-ui-service.yaml
   kind: Service
   apiVersion: v1
   metadata:
     name: hubble-ui
     labels:
       k8s-app: hubble-ui
     namespace: kube-system
   spec:
     selector:
       k8s-app: hubble-ui
     ports:
       - name: http
         port: 80
         targetPort: 8081
     type: ClusterIP
   ---
   # Source: cilium/templates/hubble-ui-deployment.yaml
   kind: Deployment
   apiVersion: apps/v1
   metadata:
     namespace: kube-system
     labels:
       k8s-app: hubble-ui
     name: hubble-ui
   spec:
     replicas: 1
     selector:
       matchLabels:
         k8s-app: hubble-ui
     template:
       metadata:
         annotations:
         labels:
           k8s-app: hubble-ui
       spec:
         securityContext:
           runAsUser: 1001
         serviceAccount: "hubble-ui"
         serviceAccountName: "hubble-ui"
         containers:
           - name: frontend
             image: "quay.io/cilium/hubble-ui:v0.7.9@sha256:e0e461c680ccd083ac24fe4f9e19e675422485f04d8720635ec41f2ba9e5562c"
             imagePullPolicy: IfNotPresent
             ports:
               - containerPort: 8080
                 name: http
             resources: {}
           - name: backend
             image: "quay.io/cilium/hubble-ui-backend:v0.7.9@sha256:632c938ef6ff30e3a080c59b734afb1fb7493689275443faa1435f7141aabe76"
             imagePullPolicy: IfNotPresent
             env:
               - name: EVENTS_SERVER_PORT
                 value: "8090"
               - name: FLOWS_API_ADDR
                 value: "hubble-relay:80"
             ports:
               - containerPort: 8090
                 name: grpc
             resources: {}
           - name: proxy
             image: "docker.io/envoyproxy/envoy:v1.18.2@sha256:e8b37c1d75787dd1e712ff389b0d37337dc8a174a63bed9c34ba73359dc67da7"
             imagePullPolicy: IfNotPresent
             ports:
               - containerPort: 8081
                 name: http
             resources: {}
             command: ["envoy"]
             args: ["-c", "/etc/envoy.yaml", "-l", "info"]
             volumeMounts:
               - name: hubble-ui-envoy-yaml
                 mountPath: /etc/envoy.yaml
                 subPath: envoy.yaml
         volumes:
           - name: hubble-ui-envoy-yaml
             configMap:
               name: hubble-ui-envoy
   ```

   {% endcut %}

1. Создайте ресурсы:

   ```bash
   kubectl apply -f hubble-ui.yaml
   ```

   Результат выполнения команды:

   ```text
   serviceaccount/hubble-ui created
   configmap/hubble-ui-envoy created
   clusterrole.rbac.authorization.k8s.io/hubble-ui created
   clusterrolebinding.rbac.authorization.k8s.io/hubble-ui created
   service/hubble-ui created
   deployment.apps/hubble-ui created
   ```

1. Убедитесь, что поды Hubble перешли в статус `Running`. Для этого выполните команду:

   ```bash
   kubectl get pod -A -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase \
     | grep hubble | grep -v certs
   ```

   Результат выполнения команды:

   ```text
   hubble-relay-6b9c774ffc-2jm7t  Running
   hubble-ui-95d74d44c-7jpvl      Running
   ```

1. Скачайте клиент Hubble на локальный компьютер:

   ```bash
   export HUBBLE_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/hubble/master/stable.txt) && \
   curl -LO "https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/hubble-linux-amd64.tar.gz" && \
   curl -LO "https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/hubble-linux-amd64.tar.gz.sha256sum" && \
   sha256sum --check hubble-linux-amd64.tar.gz.sha256sum && \
   tar zxf hubble-linux-amd64.tar.gz
   ```

1. Настройте переадресацию порта Hubble на локальный компьютер:

   ```bash
   kubectl port-forward -n kube-system svc/hubble-ui 12000:80
   ```

   {% note info %}

   Переадресация порта будет остановлена, если закрыть окно терминала или прервать выполнение команды.

   {% endnote %}

1. Чтобы открыть Hubble UI в браузере, [перейдите по ссылке](http://localhost:12000).

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
   kubectl create -f http-sw-app.yaml
   ```

   Результат выполнения команды:

   ```text
   service/deathstar created
   deployment.apps/deathstar created
   pod/tiefighter created
   pod/xwing created
   ```

1. Убедитесь, что созданные поды и сервисы работают:

   ```bash
   kubectl get pods,svc
   ```

   Результат выполнения команды:

   ```text
   NAME                            READY   STATUS    RESTARTS   AGE
   pod/deathstar-c74d84667-6x4gx   1/1     Running   1          7d
   pod/deathstar-c74d84667-jrdsp   1/1     Running   0          7d
   pod/tiefighter                  1/1     Running   0          7d
   pod/xwing                       1/1     Running   0          7d

   NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
   service/deathstar    ClusterIP   10.4.207.162   <none>        80/TCP    7d
   service/kubernetes   ClusterIP   10.4.0.1       <none>        443/TCP   8d
   ```

1. Выясните имя пода, обслуживающего контроллер Cilium:

   ```bash
   kubectl -n kube-system get pods -l k8s-app=cilium
   ```

   Результат выполнения команды:

   ```text
   NAME           READY   STATUS    RESTARTS   AGE
   cilium-67c4p   1/1     Running   0          42h
   ```

   В этом примере имя пода контроллера Cilium — `cilium-67c4p`. Если в созданной группе узлов больше одного узла, под контроллера Cilium будет запущен на каждом из них. В этом случае используйте имя любого из подов.
1. Убедитесь, что сетевые политики не действуют — в колонках `POLICY (ingress) ENFORCEMENT` и `POLICY (egress) ENFORCEMENT` указано значение `Disabled`:

   ```bash
   kubectl -n kube-system exec <имя_пода_контроллера_Cilium> -- cilium endpoint list
   ```

1. Убедитесь, что приложения `xwing` и `tiefighter` имеют доступ к API сервиса `deathstar` и возвращают строку `Ship landed`, т. к. сетевые политики не активированы:

   ```bash
   kubectl exec xwing -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing && \
   kubectl exec tiefighter -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
   ```

   Результат выполнения команды:

   ```text
   Ship landed
   Ship landed
   ```

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

1. Создайте политику:

   ```bash
   kubectl create -f sw_l3_l4_policy.yaml
   ```

1. Убедитесь, что политика для объекта `k8s:class=deathstar` перешла в состояние `Enabled`:

   ```bash
   kubectl -n kube-system exec <имя_пода_контроллера_Cilium> -- cilium endpoint list
   ```

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
   * Чтобы посмотреть спецификацию и статус политики, выполните команду:

     ```bash
     kubectl describe cnp rule1
     ```

   * Чтобы проверить возможность подключения подов к сервису `deathstar`, откройте Hubble UI. Для этого [перейдите по ссылке](http://localhost:12000/default).

## Создайте политику L7 {#l7-policy}

В этой части сценария политика доступа для пода `tiefighter` будет изменена:
* Доступ к методу API `deathstar.default.svc.cluster.local/v1/exhaust-port` будет запрещен.
* Доступ к методу API `deathstar.default.svc.cluster.local/v1/request-landing` будет оставлен без изменений.

Доступ для пода `xwing` останется без изменений. Этот под не имеет доступа к `deathstar`.
1. Проверьте, что в текущей версии политики под `tiefighter` имеет доступ к методу `deathstar.default.svc.cluster.local/v1/exhaust-port`:

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

1. Создайте файл `sw_l3_l4_l7_policy.yaml` со спецификацией политики:

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

1. Создайте новую политику:

   ```bash
   kubectl apply -f sw_l3_l4_l7_policy.yaml
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
   * Чтобы посмотреть обновленную спецификацию и статус политики, выполните команду:

     ```bash
     kubectl describe cnp rule1
     ```

   * Чтобы проверить возможность подключения подов к сервису `deathstar`, откройте Hubble UI. Для этого [перейдите по ссылке](http://localhost:12000/default).

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. [Удалите кластер {{ k8s }}](kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если для доступа к кластеру или узлам использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.