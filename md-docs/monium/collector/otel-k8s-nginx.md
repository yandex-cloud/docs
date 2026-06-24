# Настройка сбора телеметрии Nginx в Kubernetes

Вы настроите веб-сервер Nginx в кластере Kubernetes и передадите его метрики и логи в Monium. В инструкции для разворачивания кластера используется сервис Managed Service for Kubernetes, но вы можете использовать любой ваш кластер Kubernetes.

Чтобы настроить сбор телеметрии веб-сервера в кластере:

1. [Настройте кластер Kubernetes](#cluster-settings).
1. [Настройте аутентификацию](#auth-settings) — создайте сервисный аккаунт и API-ключ для отправки данных в Monium.
1. [Установите и настройте Nginx](#nginx-install) — разверните веб-сервер с экспортером метрик.
1. [Установите OpenTelemetry Collector](#install-otel-collector) — настройте сбор и отправку метрик.
1. [Просмотрите метрики в Monium](#view-metrics).
1. [Настройте сбор логов](#logs-settings).
1. [Просмотрите логи в Monium](#view-logs).
1. [Настройте дополнительные метрики по логам](#metrics-from-logs).
1. [Создайте дашборд и алерты](#dashboard-alerts).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов для работы с Monium входит:
* Плата за использование [мастера Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#master) — [тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md).
* Плата за [вычислительные ресурсы](../../compute/concepts/vm-platforms.md) и [диски](../../compute/concepts/disk.md) [группы узлов Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#node-group) — [тарифы Yandex Compute Cloud](../../compute/pricing.md).
* Плата за использование Monium — [тарифы Monium](../pricing.md).

## Настройка кластера {#cluster-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте кластер [Kubernetes](../../managed-kubernetes/quickstart.md).

  1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

{% endlist %}


## Настройка аутентификации {#auth-settings}

На этом шаге вам нужно получить и сохранить API-ключ и идентификатор каталога, которые используются на шаге [настройки OpenTelemetry Collector](#install-otel-collector).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `monium.telemetry.writer`:
     1. Перейдите в сервис **Identity and Access Management**.
     1. Нажмите кнопку **Создать сервисный аккаунт**.
     1. Введите имя сервисного аккаунта, например, `monium-ca`.
     1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите `monium.telemetry.writer`.
     1. Нажмите **Создать**.
  
  1. Создайте [API-ключ](../../iam/operations/authentication/manage-api-keys.md) с областью действия `yc.monium.telemetry.write`:
     1. Выберите в списке созданный сервисный аккаунт.
     1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите пункт **Создать API-ключ**.
     1. В поле **Область действия** выберите `yc.monium.telemetry.write`.
     1. Нажмите кнопку **Создать**.
  
  1. Скопируйте API-ключ и сохраните его в безопасном месте, он понадобится дальше.
  1. Скопируйте идентификатор каталога, в котором создан кластер и сервисный аккаунт. Для этого вверху нажмите название каталога и в списке напротив нужного каталога нажмите ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/copy.svg) **Копировать ID**.
  

{% endlist %}

## Установка и настройка Nginx {#nginx-install}

1. Создайте файл с конфигурацией веб-сервера и HTML-страницей Nginx:
  
     {% cut "configmap.yaml" %}

     ```yaml
     apiVersion: v1
     kind: ConfigMap
     metadata:
       name: nginx-config
       namespace: nginx-demo
     data:
       nginx.conf: |
         server {
           listen 80;
     
           root /usr/share/nginx/html;
           index index.html;
     
           ssi on;
           ssi_types text/html;
           ssi_last_modified on;
     
           location / {
             try_files $uri $uri/ =404;
           }
     
           location /nginx_status {
             stub_status;
             access_log off;
             allow 127.0.0.1;
             deny all;
           }
         }
     
       index.html: |
         <!DOCTYPE html>
         <html lang="en">
         <head>
           <meta charset="utf-8" />
           <meta name="viewport" content="width=device-width, initial-scale=1" />
           <title>Nginx Demo</title>
           <style>
             body { font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Arial,sans-serif; background:#0b1020; color:#e6edf3; margin:0; }
             .wrap { max-width: 900px; margin: 80px auto; padding: 0 20px; }
             .card { background:#111a33; border:1px solid rgba(255,255,255,.08); border-radius: 16px; padding: 28px; box-shadow: 0 10px 30px rgba(0,0,0,.35); }
             h1 { margin:0 0 10px; font-size: 28px; }
             p { margin: 8px 0; color:#b7c3d0; }
             code { background: rgba(255,255,255,.06); padding: 2px 6px; border-radius: 8px; }
             .ok { display:inline-block; margin-top:14px; padding:8px 12px; border-radius: 999px; background: rgba(56,189,248,.12); border:1px solid rgba(56,189,248,.35); color:#7dd3fc; }
             .grid { display:grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-top: 18px; }
             .mini { background: rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.06); border-radius: 14px; padding: 14px; }
             .mini b { color:#e6edf3; }
             @media (max-width: 700px) { .grid { grid-template-columns: 1fr; } }
           </style>
         </head>
         <body>
           <div class="wrap">
             <div class="card">
               <h1>🚀 Nginx is serving this page</h1>
               <p>This is a simple demo page served from a Kubernetes pod.</p>
               <div class="ok">Status: OK</div>
     
               <div class="grid">
                 <div class="mini">
                   <p><b>Endpoint:</b> <code>/</code></p>
                   <p>Static HTML from <code>/usr/share/nginx/html/index.html</code></p>
                 </div>
                 <div class="mini">
                   <p><b>Metrics:</b> <code>/metrics</code> (exporter)</p>
                   <p>Nginx stub status: <code>/nginx_status</code> (localhost-only)</p>
                 </div>
               </div>
     
               <!-- New grid section: runtime pod info -->
               <div class="grid" style="margin-top:18px;">
                 <div class="mini">
                   <p><b>Pod (hostname):</b></p>
                   <p><code><!--# echo var="hostname" --></code></p>
                 </div>
                 <div class="mini">
                   <p><b>Pod IP:</b></p>
                   <p><code><!--# echo var="server_addr" --></code></p>
                 </div>
                 <div class="mini">
                   <p><b>Client IP:</b></p>
                   <p><code><!--# echo var="remote_addr" --></code></p>
                 </div>
                 <div class="mini">
                   <p><b>Request time:</b></p>
                   <p><code><!--# echo var="time_local" --></code></p>
                 </div>
               </div>
     
               <p style="margin-top:18px;">
                 Refresh the page to see load balancing between pods.
               </p>
     
               <p style="margin-top:18px;">
                 If you see this page via LoadBalancer/Ingress — publishing works.
               </p>
             </div>
             
           </div>
         </body>
         </html>
     ```
     
     {% endcut %} 

1. Создайте файл для управления запуском и масштабированием подов с Nginx.

     {% cut "deployment.yaml" %}

     ```yaml
     apiVersion: apps/v1
     kind: Deployment
     metadata:
       name: nginx-server
       namespace: nginx-demo
       labels:
         app: nginx
     spec:
       replicas: 3
       selector:
         matchLabels:
           app: nginx
       template:
         metadata:
           labels:
             app: nginx
         spec:
           containers:
             - name: nginx
               image: nginx:stable
               ports:
                 - name: http
                   containerPort: 80
               volumeMounts:
                 - name: nginx-config
                   mountPath: /etc/nginx/conf.d/default.conf
                   subPath: nginx.conf
                 - name: nginx-config
                   mountPath: /usr/share/nginx/html/index.html
                   subPath: index.html
             - name: nginx-exporter
               image: nginx/nginx-prometheus-exporter:0.10.0
               args:
                 - -nginx.scrape-uri=http://localhost/nginx_status
               ports:
                 - name: metrics
                   containerPort: 9113
               resources:
                 limits:
                   memory: 128Mi
                   cpu: 500m
           volumes:
             - name: nginx-config
               configMap:
                 name: nginx-config
     ```
     
     {% endcut %}
   
   Для мониторинга Nginx в Kubernetes потребуется экспортер (nginx-exporter), который преобразует внутреннюю статистику Nginx в формат для OpenTelemetry Collector.

   В файле `deployment.yaml` экспортер добавлен в виде сайдкара:

   ```yaml
   - name: nginx-exporter
     image: nginx/nginx-prometheus-exporter:0.10.0
     args:
       - -nginx.scrape-uri=http://localhost/nginx_status
     ports:
       - name: metrics
         containerPort: 9113
     resources:
       limits:
         memory: 128Mi
         cpu: 500m
   ```

   Каждый под приложения Nginx будет содержать в себе два контейнера: `nginx` и `nginx-exporter`.
  
     
1. Создайте файл с параметрами доступа к Nginx:
  
     {% cut "services.yaml" %}

     ```yaml
     apiVersion: v1
     kind: Service
     metadata:
       name: nginx-web
       namespace: nginx-demo
       labels:
         app: nginx
     spec:
       externalTrafficPolicy: Local
       type: LoadBalancer
       selector:
         app: nginx
       ports:
         - name: http
           port: 80
           targetPort: 80
     ---
     apiVersion: v1
     kind: Service
     metadata:
       name: nginx-metrics
       namespace: nginx-demo
       labels:
         app: nginx
     spec:
       selector:
         app: nginx
       ports:
         - name: metrics
           port: 9113
           targetPort: metrics
     ```
     
     {% endcut %}

1. Разверните Nginx:

    ```bash
    kubectl create namespace nginx-demo
    kubectl apply -f configmap.yaml
    kubectl apply -f deployment.yaml
    kubectl apply -f services.yaml
    ```

1. Проверьте, что приложение запустилось:

    ```bash
    kubectl get service -n nginx-demo nginx-web
    ```

    Результат:
    ```bash
    NAME        TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
    nginx-web   LoadBalancer   10.96.238.139   158.260.329.4   80:32761/TCP   104s
    ```

1. Откройте в браузере адрес, указанный в столбце `EXTERNAL-IP`. Например: `http://158.260.329.4`. Должна быть показана HTML-страница из файла `configmap.yaml`.

   {% cut "Страница веб-сервера Nginx" %}
        
   ![image](../../_assets/monium/nginx-page.png)
        
   {% endcut %}

## Установка и настройка OpenTelemetry Collector {#install-otel-collector}

На этом шаге вы установите [OpenTelemetry Collector Contrib](https://github.com/open-telemetry/opentelemetry-collector-contrib) — расширенную версию коллектора с дополнительными компонентами для сбора логов, парсинга и других задач. Для сбора только метрик достаточно базовой версии [OpenTelemetry Collector](https://github.com/open-telemetry/opentelemetry-collector), но для работы с логами требуется Contrib-версия, будем сразу использовать ее.

1. Создайте файл для установки OpenTelemetry Collector и отправки метрик в Monium:
  
     {% cut "otel-config.yaml" %}

     ```yaml
     ---
     apiVersion: v1
     kind: Secret
     metadata:
       name: monium-secrets
       namespace: nginx-demo
     stringData:
       MONIUM_API_KEY: '<API-ключ>'
     ---
     apiVersion: v1
     kind: ConfigMap
     metadata:
       name: otel-collector-conf
       namespace: nginx-demo
       labels:
         app: opentelemetry
         component: otel-collector-conf
     data:
       otel-collector-config: |
         receivers:
           prometheus:
             config:
               scrape_configs:
                 - job_name: "nginx"
                   scrape_interval: 15s
                   kubernetes_sd_configs:
                     - role: pod
                       namespaces:
                         names:
                           - nginx-demo
     
                   relabel_configs:
                     - source_labels: [__meta_kubernetes_namespace]
                       action: keep
                       regex: nginx-demo
     
                     - source_labels: [__meta_kubernetes_pod_label_app]
                       action: keep
                       regex: nginx
     
                     - source_labels: [__meta_kubernetes_pod_container_port_name]
                       action: keep
                       regex: metrics
     
                     - source_labels: [__meta_kubernetes_pod_name]
                       target_label: pod
     
                     - source_labels: [__meta_kubernetes_namespace]
                       target_label: namespace
     
         processors:
           batch:
             timeout: 5s
             send_batch_size: 1024
           memory_limiter:
             limit_mib: 1500
             spike_limit_mib: 512
             check_interval: 5s
           resource:
             attributes:
               - key: service.name
                 value: nginx
                 action: upsert
               - key: service.namespace
                 value: nginx-demo
                 action: upsert
     
         exporters:
           otlp/monium:
             compression: none
             endpoint: ingest.monium.yandex.cloud:443
             headers:
               Authorization: Api-Key ${env:MONIUM_API_KEY}
               x-monium-project: folder__<идентификатор_каталога>
           debug:
             verbosity: basic
     
         extensions:
           zpages: {}
     
         service:
           extensions: [zpages]
           pipelines:
             metrics:
               receivers: [prometheus]
               processors: [memory_limiter, resource, batch]
               exporters: [otlp/monium, debug]
     ---
     apiVersion: v1
     kind: Service
     metadata:
       name: otel-collector
       namespace: nginx-demo
       labels:
         app: opentelemetry
         component: otel-collector
     spec:
       ports:
         - name: otlp-grpc
           port: 4317
           protocol: TCP
           targetPort: 4317
         - name: otlp-http
           port: 4318
           protocol: TCP
           targetPort: 4318
         - name: metrics
           port: 8888
       selector:
         component: otel-collector
     ---
     apiVersion: apps/v1
     kind: Deployment
     metadata:
       name: otel-collector
       namespace: nginx-demo
       labels:
         app: opentelemetry
         component: otel-collector
     spec:
       selector:
         matchLabels:
           app: opentelemetry
           component: otel-collector
       replicas: 1
       template:
         metadata:
           labels:
             app: opentelemetry
             component: otel-collector
         spec:
           serviceAccountName: otel-collector
           containers:
             - command:
                 - "/otelcol-contrib"
                 - "--config=/conf/otel-collector-config.yaml"
               image: otel/opentelemetry-collector-contrib:latest
               name: otel-collector
               resources:
                 limits:
                   cpu: 1
                   memory: 2Gi
                 requests:
                   cpu: 200m
                   memory: 400Mi
               ports:
                 - containerPort: 55679
                 - containerPort: 4317
                 - containerPort: 4318
                 - containerPort: 8888
               env:
                 - name: MY_POD_IP
                   valueFrom:
                     fieldRef:
                       apiVersion: v1
                       fieldPath: status.podIP
                 - name: GOMEMLIMIT
                   value: 1600MiB
                 - name: MONIUM_API_KEY
                   valueFrom:
                     secretKeyRef:
                       name: monium-secrets
                       key: MONIUM_API_KEY
               volumeMounts:
                 - name: otel-collector-config-vol
                   mountPath: /conf
           volumes:
             - name: otel-collector-config-vol
               configMap:
                 name: otel-collector-conf
                 items:
                   - key: otel-collector-config
                     path: otel-collector-config.yaml
     ---
     apiVersion: v1
     kind: ServiceAccount
     metadata:
       name: otel-collector
       namespace: nginx-demo
     ---
     apiVersion: rbac.authorization.k8s.io/v1
     kind: Role
     metadata:
       name: otel-collector-discovery
       namespace: nginx-demo
     rules:
       - apiGroups: [""]
         resources: ["pods"]
         verbs: ["get", "list", "watch"]
     ---
     apiVersion: rbac.authorization.k8s.io/v1
     kind: RoleBinding
     metadata:
       name: otel-collector-discovery
       namespace: nginx-demo
     subjects:
       - kind: ServiceAccount
         name: otel-collector
         namespace: nginx-demo
     roleRef:
       apiGroup: rbac.authorization.k8s.io
       kind: Role
       name: otel-collector-discovery
     ```
     
     {% endcut %}

    В этом файле подставьте свои значения `<API-ключ>` и `<идентификатор_каталога>`, сохраненные на шаге [Настройка аутентификации](#auth-settings).

1. Установите OTel Collector и начните отправку метрик:

    ```bash
    kubectl apply -f otel-config.yaml
    ```

1. Проверьте, что появился новый под `otel-collector`:

    ```bash
    kubectl get pods --namespace nginx-demo
    ```

    Результат:
    ```bash
    NAME                              READY   STATUS    RESTARTS   AGE
    nginx-server-949d9f98b-kzlrd      2/2     Running   0          2d2h
    nginx-server-949d9f98b-ngtsp      2/2     Running   0          2d2h
    nginx-server-949d9f98b-tclvh      2/2     Running   0          2d2h
    otel-collector-6cd848c59d-k6g2p   1/1     Running   0          12s
    ```

## Просмотр метрик в Monium {#view-metrics}

{% list tabs group=instructions %}

- Интерфейс Monium {#console}

  1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите **Метрики**.
       
  1. В строке запроса последовательно выберите:
     * `project=folder__<идентификатор_каталога>`; 
     * `cluster=default`;
     * `service=nginx`;
     * `name=nginx_up`.
     
     Для запроса можно использовать [текстовый режим](../concepts/visualization/query-string.md#query-text). Для этого нажмите кнопку ![image](../../_assets/console-icons/code.svg) и введите запрос текстом:

     ```text
     `project=folder__<идентификатор_каталога>; cluster=default; service=nginx; name=nginx_up`.
     ```
     
     Метрика показывает статус доступности Nginx: `1` — доступен, `0` — недоступен. Агрегированное значение равно `3` по количеству подов.

  1. Нажмите **Выполнить запрос**.

{% endlist %}

Подробнее о [работе с метриками](../metrics/metric-explorer.md).

Если данные не появились в Monium, обратитесь к разделу [Устранение неполадок при поставке данных](troubleshooting.md).

Комбинируя различные метрики в запросах, вы можете определять, справляется ли веб-сервер с текущей нагрузкой, есть ли отброшенные соединения из-за нехватки ресурсов, как быстро обрабатываются запросы.

### Количество активных соединений {#active-connections}

Чтобы оценить количество активных соединений, для метрики `name` укажите значение:
* `nginx_connections_accepted` — количество принятых соединений с момента запуска Nginx. Используется для отслеживания общей нагрузки.
* `nginx_connections_reading` — количество соединений, из которых Nginx читает запросы клиентов. Показывает активность входящих запросов.
* `nginx_connections_writing` — количество соединений, в которые Nginx отправляет ответы клиентам. Показывает активность исходящих ответов.

### Количество необработанных соединений {#unprocessed-connections}

Чтобы оценить количество соединений, которые Nginx не обрабатывает, используются метрики:
* `nginx_connections_accepted` — количество принятых соединений.
* `nginx_connections_handled` — количество обработанных соединений.

Разница между обработанными и принятыми соединениями покажет количество соединений, которые были приняты, но не были корректно обработаны Nginx.

Создайте три запроса: `Запрос A` — для метрики `nginx_connections_accepted`, `Запрос B` — для метрики `nginx_connections_handled`, `Запрос C` — для вычисления разницы между метриками. Чтобы создать дополнительный запрос, нажмите кнопку **Добавить запрос**.

* Запрос A:
  ```text
  `project=folder__<идентификатор_каталога>; cluster=default; service=nginx; name=nginx_connections_accepted`.
  ```

* Запрос B:
  ```text
  `project=folder__<идентификатор_каталога>; cluster=default; service=nginx; name=nginx_connections_handled`.
  ```
* Запрос C: в строке запроса введите `A - B`.

{% cut "График необработанных запросов" %}
       
![image](../../_assets/monium/nginx-unprocessed.png)
       
{% endcut %}

Чтобы отображать на графике только результирующий запрос, рядом с запросами `A` и `B` нажмите ![image](../../_assets/console-icons/eye.svg) — графики будут скрыты. Чтобы показать скрытые графики, нажмите ![image](../../_assets/console-icons/eye-slash.svg).

В тестовом примере необработанных соединений нет, поэтому в запросе `C` все значения нулевые. Для реальных систем эти значения удобно отображать в виде отношения `(A - B) / A` — доля соединений, которые Nginx принял, но не обработал. На этот показатель можно завести [алерт](../concepts/alerting/alert.md), который будет уведомлять, например, когда доля отброшенных соединений больше `5%`.

## Настройка сбора логов {#logs-settings}

1. Создайте новый файл конфигурации для сбора логов:
  
    {% cut "otel-config-logs.yaml" %}

    ```yaml
    ---
    apiVersion: v1
    kind: Secret
    metadata:
      name: monium-secrets
      namespace: nginx-demo
    stringData:
      MONIUM_API_KEY: '<API_ключ>'
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: otel-collector-conf
      namespace: nginx-demo
      labels:
        app: opentelemetry
        component: otel-collector-conf
    data:
      otel-collector-config: |
        receivers:
          prometheus:
            config:
              scrape_configs:
                - job_name: "nginx"
                  scrape_interval: 15s
                  kubernetes_sd_configs:
                    - role: pod
                      namespaces:
                        names:
                          - nginx-demo
    
                  relabel_configs:
                    - source_labels: [__meta_kubernetes_namespace]
                      action: keep
                      regex: nginx-demo
    
                    - source_labels: [__meta_kubernetes_pod_label_app]
                      action: keep
                      regex: nginx
    
                    - source_labels: [__meta_kubernetes_pod_container_port_name]
                      action: keep
                      regex: metrics
    
                    - source_labels: [__meta_kubernetes_pod_name]
                      target_label: pod
    
                    - source_labels: [__meta_kubernetes_namespace]
                      target_label: namespace
          filelog:
            include:
              - /var/log/pods/nginx-demo_nginx-server-*/nginx/*.log
            operators:
              - type: container
                id: container-parser
    
        processors:
          batch:
            timeout: 5s
            send_batch_size: 1024
          memory_limiter:
            limit_mib: 1500
            spike_limit_mib: 512
            check_interval: 5s
          resource:
            attributes:
              - key: service.name
                value: nginx
                action: upsert
              - key: service.namespace
                value: nginx-demo
                action: upsert
    
        exporters:
          otlp/monium:
            compression: none
            endpoint: ingest.monium.yandex.cloud:443
            headers:
              Authorization: Api-Key ${env:MONIUM_API_KEY}
              x-monium-project: folder__<идентификатор_каталога>
          debug:
            verbosity: basic
    
        extensions:
          zpages: {}
    
        service:
          extensions: [zpages]
          pipelines:
            metrics:
              receivers: [prometheus]
              processors: [memory_limiter, resource, batch]
              exporters: [otlp/monium, debug]
            logs:
              receivers: [filelog]
              processors: [memory_limiter, resource, batch]
              exporters: [otlp/monium, debug]
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: otel-collector
      namespace: nginx-demo
      labels:
        app: opentelemetry
        component: otel-collector
    spec:
      ports:
        - name: otlp-grpc
          port: 4317
          protocol: TCP
          targetPort: 4317
        - name: otlp-http
          port: 4318
          protocol: TCP
          targetPort: 4318
        - name: metrics
          port: 8888
      selector:
        component: otel-collector
    ---
    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: otel-collector
      namespace: nginx-demo
      labels:
        app: opentelemetry
        component: otel-collector
    spec:
      selector:
        matchLabels:
          app: opentelemetry
          component: otel-collector
      template:
        metadata:
          labels:
            app: opentelemetry
            component: otel-collector
        spec:
          serviceAccountName: otel-collector
          containers:
            - command:
                - "/otelcol-contrib"
                - "--config=/conf/otel-collector-config.yaml"
              image: otel/opentelemetry-collector-contrib:latest
              name: otel-collector
              resources:
                limits:
                  cpu: 1
                  memory: 2Gi
                requests:
                  cpu: 200m
                  memory: 400Mi
              ports:
                - containerPort: 55679
                - containerPort: 4317
                - containerPort: 4318
                - containerPort: 8888
              env:
                - name: MY_POD_IP
                  valueFrom:
                    fieldRef:
                      apiVersion: v1
                      fieldPath: status.podIP
                - name: GOMEMLIMIT
                  value: 1600MiB
                - name: MONIUM_API_KEY
                  valueFrom:
                    secretKeyRef:
                      name: monium-secrets
                      key: MONIUM_API_KEY
              volumeMounts:
                - name: otel-collector-config-vol
                  mountPath: /conf
                - name: varlogpods
                  mountPath: /var/log/pods
                  readOnly: true
          volumes:
            - name: otel-collector-config-vol
              configMap:
                name: otel-collector-conf
                items:
                  - key: otel-collector-config
                    path: otel-collector-config.yaml
            - name: varlogpods
              hostPath:
                path: /var/log/pods
    ---
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: otel-collector
      namespace: nginx-demo
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      name: otel-collector-discovery
      namespace: nginx-demo
    rules:
      - apiGroups: [""]
        resources: ["pods"]
        verbs: ["get", "list", "watch"]
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: otel-collector-discovery
      namespace: nginx-demo
    subjects:
      - kind: ServiceAccount
        name: otel-collector
        namespace: nginx-demo
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: Role
      name: otel-collector-discovery
    ```
        
    {% endcut %}
    
    В этом файле добавлен блок с ресивером:

    ```yaml
    filelog:
      include:
        - /var/log/pods/nginx-demo_nginx-server-*/nginx/*.log
      operators:
        - type: container
          id: container-parser
    ```

    А также маршрут (`pipeline`) для сбора логов и параметры монтирования (`volumeMounts`, `volumes`) для доступа к логам подов.

1. Удалите прежний файл конфигурации и примените новый:

   ```bash
   kubectl delete -f otel-config.yaml
   kubectl apply -f otel-config-logs.yaml
   ```

## Просмотр логов в Monium {#view-logs}

{% list tabs group=instructions %}

- Интерфейс Monium {#console}

  1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите **Логи**.
       
  1. В строке запроса выберите:
     * `project=folder__<идентификатор_каталога>`; 
     * `service=nginx`.

  1. Нажмите **Выполнить запрос**.

   {% cut "Пример страницы с логами Nginx" %}
        
   ![image](../../_assets/monium/nginx-logs.png)
        
   {% endcut %}

{% endlist %}

Подробнее о [работе с логами](../logs/logs-explorer.md).

## Настройка сбора метрик из логов {#metrics-from-logs}

Помимо стандартных метрик, которые Nginx отправляет через экспортер Prometheus, OTel Collector позволяет извлекать дополнительные метрики из логов приложения. Например, подсчитывать количество HTTP-ответов с разными кодами статуса.

Для получения этих метрик создайте и примените новый файл конфигурации:

{% cut "otel-config-metrics.yaml" %}

```yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: monium-secrets
  namespace: nginx-demo
stringData:
  MONIUM_API_KEY: "<API_ключ>"
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: otel-collector-conf
  namespace: nginx-demo
  labels:
    app: opentelemetry
    component: otel-collector-conf
data:
  otel-collector-config: |
    receivers:
      prometheus:
        config:
          scrape_configs:
            - job_name: "nginx"
              scrape_interval: 15s
              kubernetes_sd_configs:
                - role: pod
                  namespaces:
                    names:
                      - nginx-demo

              relabel_configs:
                - source_labels: [__meta_kubernetes_namespace]
                  action: keep
                  regex: nginx-demo

                - source_labels: [__meta_kubernetes_pod_label_app]
                  action: keep
                  regex: nginx

                - source_labels: [__meta_kubernetes_pod_container_port_name]
                  action: keep
                  regex: metrics

                - source_labels: [__meta_kubernetes_pod_name]
                  target_label: pod

                - source_labels: [__meta_kubernetes_namespace]
                  target_label: namespace
      filelog:
        include:
          - /var/log/pods/nginx-demo_nginx-server-*/nginx/*.log
        operators:
          - type: container
            id: container-parser

          - type: regex_parser
            id: nginx-access
            parse_from: body
            regex: '^(?P<remote_addr>\S+) - (?P<remote_user>\S+) \[(?P<time_local>[^\]]+)\] "(?P<method>\S+) (?P<target>\S+) (?P<protocol>[^"]+)" (?P<status>\d{3}) (?P<body_bytes_sent>\d+)'

    processors:
      batch:
        timeout: 5s
        send_batch_size: 1024
      memory_limiter:
        limit_mib: 1500
        spike_limit_mib: 512
        check_interval: 5s
      resource:
        attributes:
          - key: service.name
            value: nginx
            action: upsert
          - key: service.namespace
            value: nginx-demo
            action: upsert
    
    connectors:
      count/nginx:
        logs:
          nginx_http_2xx_total:
            description: nginx 2xx responses
            conditions:
              - 'IsMatch(attributes["status"], "^2..$")'

          nginx_http_4xx_total:
            description: nginx 4xx responses
            conditions:
              - 'IsMatch(attributes["status"], "^4..$")'

          nginx_http_5xx_total:
            description: nginx 5xx responses
            conditions:
              - 'IsMatch(attributes["status"], "^5..$")'

    exporters:
      otlp/monium:
        compression: none
        endpoint: ingest.monium.yandex.cloud:443
        headers:
          Authorization: Api-Key ${env:MONIUM_API_KEY}
          x-monium-project: folder__<идентификатор_каталога>
      debug:
        verbosity: basic

    extensions:
      zpages: {}

    service:
      extensions: [zpages]
      pipelines:
        metrics:
          receivers: [prometheus]
          processors: [memory_limiter, resource, batch]
          exporters: [otlp/monium, debug]
        logs:
          receivers: [filelog]
          processors: [memory_limiter, resource, batch]
          exporters: [count/nginx, otlp/monium, debug]
        metrics/logs:
          receivers: [count/nginx]
          processors: [memory_limiter, resource, batch]
          exporters: [otlp/monium, debug]
---
apiVersion: v1
kind: Service
metadata:
  name: otel-collector
  namespace: nginx-demo
  labels:
    app: opentelemetry
    component: otel-collector
spec:
  ports:
    - name: otlp-grpc
      port: 4317
      protocol: TCP
      targetPort: 4317
    - name: otlp-http
      port: 4318
      protocol: TCP
      targetPort: 4318
    - name: metrics
      port: 8888
  selector:
    component: otel-collector
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: otel-collector
  namespace: nginx-demo
  labels:
    app: opentelemetry
    component: otel-collector
spec:
  selector:
    matchLabels:
      app: opentelemetry
      component: otel-collector
  template:
    metadata:
      labels:
        app: opentelemetry
        component: otel-collector
    spec:
      serviceAccountName: otel-collector
      containers:
        - command:
            - "/otelcol-contrib"
            - "--config=/conf/otel-collector-config.yaml"
          image: otel/opentelemetry-collector-contrib:0.147.0
          name: otel-collector
          resources:
            limits:
              cpu: 1
              memory: 2Gi
            requests:
              cpu: 200m
              memory: 400Mi
          ports:
            - containerPort: 55679
            - containerPort: 4317
            - containerPort: 4318
            - containerPort: 8888
          env:
            - name: MY_POD_IP
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: status.podIP
            - name: GOMEMLIMIT
              value: 1600MiB
            - name: MONIUM_API_KEY
              valueFrom:
                secretKeyRef:
                  name: monium-secrets
                  key: MONIUM_API_KEY
          volumeMounts:
            - name: otel-collector-config-vol
              mountPath: /conf
            - name: varlogpods
              mountPath: /var/log/pods
              readOnly: true
      volumes:
        - name: otel-collector-config-vol
          configMap:
            name: otel-collector-conf
            items:
              - key: otel-collector-config
                path: otel-collector-config.yaml
        - name: varlogpods
          hostPath:
            path: /var/log/pods
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: otel-collector
  namespace: nginx-demo
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: otel-collector-discovery
  namespace: nginx-demo
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: otel-collector-discovery
  namespace: nginx-demo
subjects:
  - kind: ServiceAccount
    name: otel-collector
    namespace: nginx-demo
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: otel-collector-discovery
```
        
{% endcut %}

В этой конфигурации есть следующие дополнения:

1. Извлечение данных из логов.

   В блок `filelog` добавлен оператор `regex_parser`, который будет извлекать из строки access-лога Nginx нужные поля (метод запроса, URL, HTTP-код ответа и другие):

   ```yaml
   filelog:
     include:
       - /var/log/pods/nginx-demo_nginx-server-*/nginx/*.log
     operators:
       - type: container
         id: container-parser

       - type: regex_parser
         id: nginx-access
         parse_from: body
         regex: '^(?P<remote_addr>\S+) - (?P<remote_user>\S+) \[(?P<time_local>[^\]]+)\] "(?P<method>\S+) (?P<target>\S+) (?P<protocol>[^"]+)" (?P<status>\d{3}) (?P<body_bytes_sent>\d+)'
   ```

   Этот оператор извлечет из каждой строки лога поле `status` (HTTP-код ответа), которое будем использовать для создания метрик.

1. Создание метрик из логов.

   Добавлен коннектор `count` для подсчета количества записей в логах по заданным условиям. В примере подсчитываются ответы с кодами `2xx`, `4xx` и `5xx`:

   ```yaml
   connectors:
     count/nginx:
       logs:
         nginx_http_2xx_total:
           description: Количество успешных ответов (2xx)
           conditions:
             - 'IsMatch(attributes["status"], "^2..$")'

         nginx_http_4xx_total:
           description: Количество клиентских ошибок (4xx)
           conditions:
             - 'IsMatch(attributes["status"], "^4..$")'

         nginx_http_5xx_total:
           description: Количество серверных ошибок (5xx)
           conditions:
             - 'IsMatch(attributes["status"], "^5..$")'
   ```

1. Настройка маршрутов (pipelines).

   Добавлен pipeline `metrics/logs`, который будет получать метрики от коннектора `count/nginx` и отправлять их в Monium вместе с остальными метриками:

   ```yaml
   service:
     extensions: [zpages]
     pipelines:
       metrics:
         receivers: [prometheus]
         processors: [memory_limiter, resource, batch]
         exporters: [otlp/monium, debug]
       
       logs:
         receivers: [filelog]
         processors: [memory_limiter, resource, batch]
         exporters: [count/nginx, otlp/monium, debug]
       
       metrics/logs:
         receivers: [count/nginx]
         processors: [memory_limiter, resource, batch]
         exporters: [otlp/monium, debug]
   ```

После применения конфигурации в Monium будут доступны новые метрики:
* `nginx_http_2xx_total` — количество успешных ответов.
* `nginx_http_4xx_total` — количество клиентских ошибок.
* `nginx_http_5xx_total` — количество серверных ошибок.

{% cut "Пример страницы с метриками Nginx, собранным по логам" %}
        
![image](../../_assets/monium/nginx-metrics-4xx.png)
        
{% endcut %}

Эти метрики полезны для мониторинга качества обслуживания и выявления проблем. Например, резкий рост `5xx` ошибок может указывать на сбой в приложении.

## Создание дашборда и алертов {#dashboard-alerts}

Для постоянного мониторинга состояния Nginx [создайте дашборд](../operations/dashboard/create.md) с ключевыми метриками и [настройте алерты](../operations/alert/create-alert.md) для оповещения о проблемах.

Для Nginx рекомендуется добавить на дашборд графики с метриками:

* `nginx_connections_accepted` — количество принятых соединений с момента запуска.
* `nginx_connections_active` — количество активных соединений в данный момент.
* `nginx_connections_handled` — количество обработанных соединений.
* `nginx_connections_reading` — количество соединений, из которых Nginx читает запросы.
* `nginx_connections_waiting` — количество соединений в режиме ожидания.
* `nginx_connections_writing` — количество соединений, в которые Nginx отправляет ответы.
* `nginx_requests_total` — общее количество обработанных запросов.
* `nginx_http_2xx_total` — количество успешных ответов (код 2xx).
* `nginx_http_4xx_total` — количество клиентских ошибок (код 4xx).
* `nginx_http_5xx_total` — количество серверных ошибок (код 5xx).

Для уведомления о критических ситуациях рекомендуются алерты:

* **Рост серверных ошибок** — увеличение `nginx_http_5xx_total`.
   
   Условие срабатывания: значение больше `10` в течение пяти минут.

* **Рост клиентских ошибок** — увеличение `nginx_http_4xx_total`.
   
   Условие срабатывания: значение больше `50` в течение пяти минут.   

* [Необработанные соединения](#unprocessed-connections) — разница между принятыми и обработанными соединениями.

   Условие срабатывания: значение больше `0` в течение пяти минут.

Пороговые значения и временные интервалы настраивайте в соответствии с требованиями вашего приложения.