# Развертывание и нагрузочное тестирование gRPC-сервиса с масштабированием 

По этому руководству вы развернете автомасштабируемый gRPC-сервис в кластере {{ managed-k8s-name }} с помощью Ingress-контроллера {{ alb-name }} и проведете нагрузочное тестирование сервиса.

Чтобы развернуть сервис и осуществить нагрузочное тестирование:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Подготовьте цель тестирования](#prepare-target).
1. [Подготовьте домен](#prepare-domain).
1. [Установите Ingress](#install-ingress).
1. [Настройте горизонтальное автомасштабирование подов](#configure-autoscaling).
1. [Проведите нагрузочное тестирование gRPC-сервиса](#load-testing).

По окончании тестирования [удалите созданные ресурсы](#clear-out), если они больше не нужны.

## Подготовьте облако к работе {#prepare-cloud}

1. Зарегистрируйте доменное имя для вашего сайта. 

1. Если для вашего облака включены [группы безопасности](../../vpc/concepts/security-groups.md), [создайте](../../vpc/operations/security-group-create.md) группу с правилами, описанными в разделе [{#T}](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

   Если группы безопасности недоступны в вашем облаке, для ресурсов будет разрешен весь входящий и исходящий трафик, и дополнительной настройки не требуется.

1. [Подготовьте кластер {{managed-k8s-name}}](../../managed-kubernetes/quickstart.md) к работе.

1. [Установите Metrics Provider](../../managed-kubernetes/operations/applications/metrics-provider.md).

1. Установите Ingress-контроллер:

   1. [Создайте](../../application-load-balancer/tools/k8s-ingress-controller/service-account.md) сервисный аккаунт для Ingress-контроллера.

   2. [Установите](../../application-load-balancer/operations/k8s-ingress-controller-install.md) Ingress-контроллер {{alb-name}} для {{managed-k8s-name}}.

{% if product == "yandex-cloud" and audience != "internal" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за использование мастера и исходящий трафик {{managed-k8s-name}} (см. {% if audience != "internal" %}[тарифы {{managed-k8s-name}}](../../managed-kubernetes/pricing.md){% else %}тарифы {{managed-k8s-name}}{% endif %});
* плата за использование вычислительных ресурсов L7-балансировщика (см. {% if audience != "internal" %}[тарифы {{ alb-name }}](../../application-load-balancer/pricing.md){% else %}тарифы {{ alb-name }}{% endif %});
* плата за публичные DNS-запросы и DNS-зоны, если вы используете {{ dns-full-name }} (см. {% if audience != "internal" %}[тарифы {{ dns-name }}](../../dns/pricing.md){% else %}тарифы {{ dns-name }}{% endif %}).

{% endif %}

## Подготовьте цель тестирования {#prepare-target}

В этой инструкции в качестве цели тестирования будет использоваться gRPC-сервис.

1. Сохраните следующую спецификацию для создания приложения в файле `grpc-server.yaml`:

   ```
   ### Deployment
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: grpc-app
     labels:
       app: grpc-app
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: grpc-app
     template:
       metadata:
         name: grpc-app
         labels:
           app: grpc-app
       spec:
         affinity:
           podAntiAffinity:
             requiredDuringSchedulingIgnoredDuringExecution:
               - labelSelector:
                   matchExpressions:
                     - key: app
                       operator: In
                       values:
                         - grpc-app
                 topologyKey: "kubernetes.io/hostname"
   
         containers:
           - name: grpc-app
             image: {{ registry }}/crp6a9o7k9q5rrtt2hoq/grpc-test-server
             resources:
               requests:
                 memory: "256Mi"
                 cpu: "500m"
               limits:
                 memory: "500Mi"
                 cpu: "1"
   
   ### Service
   apiVersion: v1
   kind: Service
   metadata:
     name: grpc-service
   spec:
     selector:
       app: grpc-app
     type: NodePort
     ports:
       - name: grpc
         port: 80
         targetPort: 8080
         protocol: TCP
         nodePort: 30085    
   ```

2. Создайте приложение:

   ```
   kubectl apply -f grpc-server.yaml
   ```

## Подготовьте домен {#prepare-domain}

1. [Создайте](../../dns/operations/zone-create-public.md) публичную зону {% if lang == "ru" and audience != "internal" %}[DNS](../../glossary/dns.md){% else %}DNS{% endif %} и делегируйте домен.

   {% note info %}

   Для домена example.com зона должна называться `example.com.` (с точкой в конце)

   {% endnote %}

2. [Создайте](../../certificate-manager/operations/managed/cert-create.md) сертификат от `Let's Encrypt®`.

3. [Пройдите](../../certificate-manager/operations/managed/cert-validate.md) процедуры проверки прав на домен.


## Установите Ingress {#install-ingress}

1. Создайте манифест ресурса [Ingress](../../application-load-balancer/k8s-ref/ingress.md) в файле `ingress.yaml`:

   ```
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: grpc-demo
     annotations:
       ingress.alb.yc.io/subnets: <идентификаторы_подсетей>
       ingress.alb.yc.io/external-ipv4-address: auto 
       ingress.alb.yc.io/protocol: grpc
       ingress.alb.yc.io/security-groups: <идентификатор_группы_безопасности>
   spec:
     tls:
       - hosts:
           - <имя_сайта>
         secretName: yc-certmgr-cert-id-<идентификатор_сертификата> 
     rules:
       - host: <имя_сайта>
         http:
           paths:
             - pathType: Prefix
               path: "/api.Adder/Add"
               backend:
                 service:
                   name: grpc-service
                   port:
                     number: 80
             - pathType: Prefix
               path: "/grpc.reflection.v1alpha.ServerReflection"
               backend:
                 service:
                   name: grpc-service
                   port:
                     number: 80
   ```

   Где:

   * `ingress.alb.yc.io/subnets` — список идентификаторов подсетей через запятую.
   * `ingress.alb.yc.io/external-ipv4-address` — предоставление публичного доступа к {{ alb-name }} из интернета. 

     При значении `auto` Ingress-контроллер получит публичный IP-адрес автоматически. При удалении Ingress-контроллера IP-адрес также будет удален из облака.
   * `ingress.alb.yc.io/security-groups` — идентификатор группы безопасности, созданной при [подготовке облака к работе](#prepare-cloud). Если в вашем облаке не включены группы безопасности, удалите эту аннотацию.
   * `secretName` — указание на TLS-сертификат из {{certificate-manager-full-name}} в формате `yc-certmgr-cert-id-<идентификатор сертификата>`.
   * `hosts`, `host`  — доменное имя, которому соответствует TLS-сертификат.
   
   Подробнее см. [поля и аннотации ресурса Ingress](../../application-load-balancer/k8s-ref/ingress.md).

2. Создайте ресурс `Ingress`:

   ```
   kubectl apply -f ingress.yaml
   ```

3. Проверьте, что ресурс создан и получил публичный IP-адрес:

   ```
   kubectl get ingress grpc-demo
   ```

   Ожидаемый результат:
   
   ```
   NAME        CLASS    HOSTS            ADDRESS         PORTS     AGE
   grpc-demo   <none>   <имя_сайта>      <IP-адрес>      80, 443   2m
   ```

   Где:

   * `<имя_сайта>` — доменное имя, которому соответствует TLS-сертификат.
   * `<IP-адрес>` — IP-адрес сайта.

   В столбце ADDRESS должен появиться IP-адрес. В противном случае балансировщик не создался или создался некорректно — проверьте логи пода `yc-alb-ingress-controller-*`.

4. [Создайте](../../dns/operations/resource-record-create.md) в {{dns-name}} A-запись, указывающую на публичный адрес балансировщика.


## Настройте горизонтальное автомасштабирование подов {#configure-autoscaling}

1. Создайте файл `hpa.yaml` со спецификацией {{k8s-hpa}}:

   ```
   ### HPA
   apiVersion: autoscaling/v2beta2
   kind: HorizontalPodAutoscaler
   metadata:
     name: grpc-app
   spec:
     scaleTargetRef:
      apiVersion: apps/v1
      kind: Deployment
      name: grpc-app
     minReplicas: 1
     maxReplicas: 10
     metrics:
      - type: External
        external:
         metric:
           name: "load_balancer.requests_count_per_second"
           selector:
            matchLabels:
              service: "application-load-balancer"
              load_balancer: <идентификатор_балансировщика>
              code: "total"
              backend_group: <идентификаторы_группы_бэкендов>
         target:
           type: AverageValue
           averageValue: 2
   ```   

   Где:

   * `load_balancer` — идентификатор L7-балансировщика.
   * `backend_group` — идентификатор группы бэкендов.
   
   Найти их можно в консоли {{alb-name}} или выполнив команды:
   
   ```
   yc alb load-balancer list
   yc alb backend-group list
   ```

2. Создайте {{k8s-hpa}}:

   ```
   kubectl apply -f hpa.yaml
   ```

## Проведите нагрузочное тестирование gRPC-сервиса {#load-testing}

1. Создайте сервисный аккаунт:
   1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `sa-loadtest` в каталоге, где будет размещаться агент, с которого будет подаваться нагрузка.
   2. [Назначьте](../../iam/operations/roles/grant.md) роли сервисному аккаунту:
      * `loadtesting.generatorClient` — позволяет запускать агент, тест на агенте и загружать результаты в хранилище.
      * `compute.admin` — позволяет управлять виртуальной машиной в {{compute-name}}.
      * `vpc.user` — позволяет подключаться к сетевым ресурсам {{vpc-name}} и использовать их.
      
2. [Создайте и настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) в подсети, где размещается цель тестирования и будет размещен агент. Это обеспечит доступ агента к сервису {{load-testing-name}}.

3. [Создайте](../../load-testing/tutorials/loadtesting-grpc.md#create-agent) агент тестирования.

4. Подготовьте файл с тестовыми данными `ammo.json`:

   ```
   {"tag": "/Add", "call": "api.Adder.Add", "payload": {"x": 21, "y": 12}}
   ```

5. Подготовьте файл конфигурации `load.yaml`:

   ```
   phantom:
     enabled: false
     package: yandextank.plugins.Phantom
   pandora:
     enabled: true
     package: yandextank.plugins.Pandora
     config_content:
      pools:
        - id: Gun
         gun:
           type: grpc
           target: <your-site-name>:<port>
           tls: true
         ammo:
           type: grpc/json
           file: ammo.json
         result:
           type: phout
           destination: ./phout.log
         rps:
           - duration: 60s
            type: line
            from: 1
            to: 10
         startup:
           - type: once
            times: 1000
      log:
        level: debug
      monitoring:
        expvar:
         enabled: true
         port: 1234
   uploader:
     enabled: true
     package: yandextank.plugins.DataUploader
     job_name: '[pandora][grpc][tls]'
     job_dsc: ''
     ver: ''
     api_address: loadtesting.{{ api-host }}:443
   ```

   Где:

   * `target` — название вашего сайта и порт (для HTTPS: 443).
   
6. [Запустите тест](../../load-testing/tutorials/loadtesting-grpc.md#run-test):

   * В поле **Файл с тестовыми данными** загрузите файл `ammo.json`.
   * В поле **Файл конфигурации** загрузите файл `load.yaml`.

7. Наблюдайте за прохождением теста:

   1. В [консоли управления]({{ link-console-main }}) выберите сервис {{managed-k8s-name}}.
   1. Выберите ваш тестовый кластер.
   1. Перейдите на вкладку **Рабочая нагрузка**.
   1. Наблюдайте за изменением количества подов приложения по мере увеличения и уменьшения нагрузки.
   1. По завершении теста в [консоли управления]({{ link-console-main }}) выберите сервис {{alb-name}}.
   1. Выберите созданный L7-балансировщик.
   1. Перейдите на вкладку **Мониторинг**.
   1. Просмотрите графики нагрузки за время работы теста. 

## Как удалить созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

1. Если вы настраивали CNAME-записи в {{ dns-name }}, {% if audience != "internal" %}[удалите](../../dns/operations/zone-delete.md){% else %}удалите{% endif %} зону DNS.
1. {% if audience != "internal" %}[Удалите](../../application-load-balancer/operations/application-load-balancer-delete.md){% else %}Удалите{% endif %} L7-балансировщик.
1. [Удалите](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) кластер {{ managed-k8s-name }}.
