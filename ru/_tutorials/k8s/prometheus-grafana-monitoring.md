# Мониторинг кластера с помощью {{ prometheus-name }} и {{ grafana-name }}

{{ managed-k8s-name }} позволяет выгружать метрики объектов кластера в системы мониторинга.

Из этой статьи вы узнаете, как настроить систему сбора метрик [{{ prometheus-name }}](https://prometheus.io/) и систему визуализации [{{ grafana-name }}](https://grafana.com/) в [кластере {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). Для ускорения передачи метрик будет установлен [кеширующий прокси trickster](https://github.com/trickstercache/trickster).

Чтобы настроить систему мониторинга кластера {{ managed-k8s-name }}:

* [Установите {{ prometheus-name }}](#install-prometheus).
* [Установите кеширующий прокси trickster](#install-trickster).
* [Установите {{ grafana-name }}](#install-grafana).
* [Настройте и проверьте работу {{ grafana-name }}](#configure-grafana).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за публичный IP-адрес для узлов кластера (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации с доступом в интернет и с группами безопасности, подготовленными ранее.
1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. {% include [Install Helm](../../_includes/managed-kubernetes/helm-install.md) %}

## Установите {{ prometheus-name }} {#install-prometheus}

Система мониторинга {{ prometheus-name }} сканирует объекты кластера {{ managed-k8s-name }} и собирает их метрики в собственную базу данных. Собранные метрики доступны внутри кластера {{ managed-k8s-name }} по протоколу HTTP.
1. Добавьте репозиторий, содержащий дистрибутив {{ prometheus-name }}:

   ```bash
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
   helm repo update
   ```

1. Установите {{ prometheus-name }}:

   ```bash
   helm install my-prom prometheus-community/prometheus
   ```

1. Убедитесь, что все [поды](../../managed-kubernetes/concepts/index.md#pod) перешли в состояние `Running`:

   ```bash
   kubectl get pods -l "app.kubernetes.io/instance=my-prom"
   ```

   Результат:

   ```text
   NAME                                              READY  STATUS   RESTARTS  AGE
   my-prom-prometheus-alertmanager-7b********-xt6ws  2/2    Running  0         81s
   my-prom-prometheus-node-exporter-*****            1/1    Running  0         81s
   my-prom-prometheus-pushgateway-69********-swrfb   1/1    Running  0         81s
   my-prom-prometheus-server-7b********-m4v78        2/2    Running  0         81s
   ```

## Установите кеширующий прокси trickster {#install-trickster}

Кеширующий прокси trickster [ускоряет чтение](https://github.com/trickstercache/trickster#time-series-database-accelerator) из БД {{ prometheus-name }}, что позволяет отображать метрики {{ grafana-name }} практически в реальном времени, а также снизить нагрузку на {{ prometheus-name }}.

1. Создайте конфигурационный файл `trickster.yaml`, содержащий настройки trickster:

   {% cut "trickster.yaml" %}

   ```yaml
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: trickster-pvc
    spec:
      accessModes:
        - ReadWriteOnce
      storageClassName: yc-network-hdd
      resources:
        requests:
          storage: 15Gi
    
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: trickster-conf
      labels:
        name: trickster-conf
    
    data:
      trickster.conf: |-
        [frontend]
        listen_port = 8480
        tls_listener = false
        connections_limit = 0
        [logging]
        log_level = "info"
    
        [caching]
        cache_type = "filesystem"
        filesystem_path = "/tmp/trickster"
    
        [proxy]
        origin = "default"
    
        [origins.default]
        origin_type = "prometheus"
        origin_url = "http://my-prom-prometheus-server:80"
        is_default = true
    
        [metrics]
        listen_port = 8481
        listen_address = ""
    
        [health]
        listen_port = 8481
        listen_address = ""
    
        [telemetry]
        prometheus_metrics = false
    
        [logging.profiler]
        enabled = false
        port = 6060
    
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: trickster
      labels:
        app: trickster
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: trickster
      template:
        metadata:
          labels:
            app: trickster
        spec:
          containers:
            - name: trickster
              image: tricksterproxy/trickster:1.1
              imagePullPolicy: IfNotPresent
              args:
                - -config
                - /etc/trickster/trickster.conf
              ports:
                - name: http
                  containerPort: 8480
                  protocol: TCP
                - name: metrics
                  containerPort: 8481
                  protocol: TCP
              volumeMounts:
                - name: config-volume
                  mountPath: /etc/trickster
                  readOnly: true
                - name: cache-volume
                  mountPath: /tmp/trickster
              env:
                - name: NAMESPACE
                  valueFrom:
                    fieldRef:
                      fieldPath: metadata.namespace
          volumes:
            - name: config-volume
              configMap:
                name: trickster-conf
                items:
                  - key: trickster.conf
                    path: trickster.conf
            - name: cache-volume
              persistentVolumeClaim:
                claimName: trickster-pvc
    
    ---
    apiVersion: v1
    kind: Service
    metadata:
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "8481"
        prometheus.io/path: "/metrics"
      name: trickster
    spec:
      ports:
        - name: http
          port: 8480
          targetPort: http
        - name: metrics
          port: 8481
          targetPort: metrics
      selector:
        app: trickster
   ```

   {% endcut %}

   Вы можете изменить размер хранилища, отведенного для работы кеширующего прокси. Укажите нужное значение размера хранилища в параметре `PersistentVolumeClaim.spec.resources.requests.storage`.
1. Установите trickster:

   ```bash
   kubectl apply -f trickster.yaml
   ```

1. Убедитесь, что под trickster перешел в состояние `Running`:

   ```bash
   kubectl get pods -l "app=trickster"
   ```

Кеширующий прокси доступен внутри кластера {{ managed-k8s-name }} по адресу `http://trickster:8480`. {{ grafana-name }} будет обращаться по этому URL для получения метрик.

## Установите {{ grafana-name }} {#install-grafana}

При развертывании приложения будут созданы:
* `Deployment` приложения {{ grafana-name }}.
* [PersistentVolumeClaim](../../managed-kubernetes/concepts/volume.md#persistent-volume) для резервирования внутреннего хранилища.
* `Service` типа `LoadBalancer` для организации сетевого доступа к консоли управления {{ grafana-name }}.

Чтобы установить {{ grafana-name }}:
1. Создайте конфигурационный файл `grafana.yaml`.

   {% cut "grafana.yaml" %}

   ```yaml
   ---
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: grafana-pvc
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 1Gi
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     labels:
       app: grafana
     name: grafana
   spec:
     selector:
       matchLabels:
         app: grafana
     template:
       metadata:
         labels:
           app: grafana
       spec:
         securityContext:
           fsGroup: 472
           supplementalGroups:
             - 0
         containers:
           - name: grafana
             image: grafana/grafana:latest
             imagePullPolicy: IfNotPresent
             ports:
               - containerPort: 3000
                 name: http-grafana
                 protocol: TCP
             readinessProbe:
               failureThreshold: 3
               httpGet:
                 path: /robots.txt
                 port: 3000
                 scheme: HTTP
               initialDelaySeconds: 10
               periodSeconds: 30
               successThreshold: 1
               timeoutSeconds: 2
             livenessProbe:
               failureThreshold: 3
               initialDelaySeconds: 30
               periodSeconds: 10
               successThreshold: 1
               tcpSocket:
                 port: 3000
               timeoutSeconds: 1
             resources:
               requests:
                 cpu: 250m
                 memory: 750Mi
             volumeMounts:
               - mountPath: /var/lib/grafana
                 name: grafana-pv
         volumes:
           - name: grafana-pv
             persistentVolumeClaim:
               claimName: grafana-pvc
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: grafana
   spec:
     ports:
       - port: 3000
         protocol: TCP
         targetPort: http-grafana
     selector:
       app: grafana
     sessionAffinity: None
     type: LoadBalancer
   ```

   {% endcut %}

   При необходимости измените:
   * Размер хранилища, отведенного для работы {{ grafana-name }}, в параметре `spec.resources.requests.storage` для `kind: PersistentVolumeClaim`.
   * Вычислительные ресурсы, выделяемые поду {{ grafana-name }}, в параметрах `spec.containers.resources` для `kind: Deployment`.
1. Установите {{ grafana-name }}:

   ```bash
   kubectl apply -f grafana.yaml
   ```

1. Убедитесь, что под {{ grafana-name }} перешел в состояние `Running`:

   ```bash
   kubectl get pods -l "app=grafana"
   ```

## Настройте и проверьте работу {{ grafana-name }} {#configure-grafana}

1. Узнайте адрес, на котором доступен сервис {{ grafana-name }}, и перейдите по этому адресу:

   ```bash
   export GRAFANA_IP=$(kubectl get service/grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}') && \
   export GRAFANA_PORT=$(kubectl get service/grafana -o jsonpath='{.spec.ports[0].port}') && \
   echo http://$GRAFANA_IP:$GRAFANA_PORT
   ```

   {% include [Настройка групп безопасности при недоступности ресурса](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

1. В открывшемся окне браузера введите логин и пароль `admin/admin`, после чего установите новый пароль для пользователя `admin`.
1. [Добавьте источник данных](https://grafana.com/docs/grafana/latest/datasources/add-a-data-source/) с типом `{{ prometheus-name }}` и следующими настройками:
   * **Name** — `{{ prometheus-name }}`.
   * **URL** — `http://trickster:8480`.
1. Нажмите кнопку **Save & test** и убедитесь, что источник данных успешно подключен (`Data source is working`).
1. [Импортируйте дашборд](https://grafana.com/docs/grafana/latest/dashboards/export-import/#import-dashboard) `{{ k8s }} Deployment Statefulset Daemonset metrics`, содержащий основные метрики {{ k8s }}. Укажите [идентификатор дашборда](https://grafana.com/grafana/dashboards/8588) (`8588`) при импорте.

   {% note tip %}

   Для проверки сценария вы можете использовать любой подходящий дашборд из [каталога {{ grafana-name }}](https://grafana.com/grafana/dashboards/?search=kubernetes).

   {% endnote %}

1. Откройте дашборд и убедитесь, что {{ grafana-name }} получает метрики от кластера {{ managed-k8s-name }}.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:
1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы зарезервировали для кластера {{ managed-k8s-name }} [публичный статический IP-адрес](../../vpc/concepts/address.md#public-addresses), [удалите его](../../vpc/operations/address-delete.md).
1. [Удалите диск](https://yandex.cloud/ru/docs/compute/operations/disk-control/delete), который был создан для хранилища `trickster`, определить его можно по метке в описании диска, метку можно узнать через `kubectl describe pvc trickster-pvc` она будет соответсвовать значению в поле `Volume:`
