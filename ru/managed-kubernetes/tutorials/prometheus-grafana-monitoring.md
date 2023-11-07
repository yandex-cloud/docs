# Мониторинг кластера с помощью {{ prometheus-name }} и {{ grafana-name }}

{{ managed-k8s-name }} позволяет выгружать метрики объектов кластера в системы мониторинга.

Из этой статьи вы узнаете, как настроить систему сбора метрик [{{ prometheus-name }}](https://prometheus.io/) и систему визуализации [{{ grafana-name }}](https://grafana.com/) в [кластере {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster). Для ускорения передачи метрик будет установлен [кеширующий прокси trickster](https://github.com/trickstercache/trickster).

Чтобы настроить систему мониторинга кластера {{ managed-k8s-name }}:
* [{#T}](#install-prometheus).
* [{#T}](#install-trickster).
* [{#T}](#install-grafana).
* [{#T}](#configure-grafana).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер {{ managed-k8s-name }} ](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации с доступом в интернет.
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

1. Убедитесь, что все [поды](../concepts/index.md#pod) перешли в состояние `Running`:

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
1. Добавьте репозиторий, содержащий дистрибутив trickster:

   ```bash
   helm repo add tricksterproxy https://helm.tricksterproxy.io && \
   helm repo update
   ```

1. Создайте конфигурационный файл `trickster.yaml`, содержащий настройки trickster:

   {% cut "trickster.yaml" %}

   ```yaml
   frontend:
     listenAddress: ""
     tlsListenAddress: ""
     tlsListenPort: ""
     connectionsLimit: "0"
   origins:
     - name: default
       originType: prometheus
       originURL: http://my-prom-prometheus-server:80
   profiler:
     enabled: false
     port: 6060
   prometheusScrape: false
   prometheus:
     serviceMonitor:
       enabled: false
       interval: 30s
       labels: {}
   replicaCount: 1
   image:
     repository: tricksterproxy/trickster
     tag: "1.1"
     pullPolicy: IfNotPresent
   service:
     annotations: {}
     labels: {}
     clusterIP: ""
     externalIPs: []
     loadBalancerIP: ""
     loadBalancerSourceRanges: []
     metricsPort: 8481
     servicePort: 8480
     type: ClusterIP
   ingress:
     enabled: false
     annotations: {}
     extraLabels: {}
     hosts: []
     tls: []
   volumes:
     persistent:
       type: "persistentVolume"
       enabled: false
       mountPath: "/tmp/trickster"
       accessModes:
         - ReadWriteOnce
       annotations: {}
       existingClaim: ""
       size: 15Gi
     generic:
       type: "generic"
       enabled: true
       mountPath: "/tmp/trickster"
   podAnnotations: {}
   resources: {}
   securityContext: {}
   ```

   {% endcut %}

   Вы можете изменить размер хранилища, отведенного для работы кеширующего прокси. Укажите нужное значение размера хранилища в параметре `volumes.persistent.size`.
1. Установите trickster:

   ```bash
   helm install trickster tricksterproxy/trickster --namespace default -f trickster.yaml
   ```

1. Убедитесь, что под trickster перешел в состояние `Running`:

   ```bash
   kubectl get pods -l "app=trickster"
   ```

Кеширующий прокси доступен внутри кластера {{ managed-k8s-name }} по адресу `http://trickster:8480`. {{ grafana-name }} будет обращаться по этому URL для получения метрик.

## Установите {{ grafana-name }} {#install-grafana}

При развертывании приложения будут созданы:
* `Deployment` приложения {{ grafana-name }}.
* [PersistentVolumeClaim](../concepts/volume.md#persistent-volume) для резервирования внутреннего хранилища.
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