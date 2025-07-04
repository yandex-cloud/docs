# Развертывание и нагрузочное тестирование gRPC-сервиса с масштабированием в {{ managed-k8s-full-name }}


По этому руководству вы развернете автомасштабируемый [gRPC](https://grpc.io/docs/)-сервис в [кластере {{ k8s }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) с помощью [Ingress-контроллера](../../application-load-balancer/tools/k8s-ingress-controller/index.md) [{{ alb-full-name }}](../../application-load-balancer/) и проведете нагрузочное тестирование сервиса.

Чтобы развернуть сервис и осуществить нагрузочное тестирование:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте цель тестирования](#prepare-target).
1. [Подготовьте домен](#prepare-domain).
1. [Установите Ingress](#install-ingress).
1. [Настройте горизонтальное автомасштабирование подов](#configure-autoscaling).
1. [Проведите нагрузочное тестирование gRPC-сервиса](#load-testing).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

1. Зарегистрируйте [доменное имя](../../dns/concepts/resource-record.md) для вашего сайта.
1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [configure-sg-alb-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-alb-manual.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Подготовьте](../../managed-kubernetes/quickstart.md) кластер {{ managed-k8s-name }} к работе.
1. [Установите](../../managed-kubernetes/operations/applications/metrics-provider.md) Metrics Provider в пространство имен `kube-public`.
1. [Установите](../../application-load-balancer/operations/k8s-ingress-controller-install.md) ALB Ingress Controller.


1. {% include [install externaldns](../../_includes/managed-kubernetes/install-externaldns.md) %}



### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* Плата за использование [мастера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) и исходящий трафик  (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за использование вычислительных ресурсов [L7-балансировщика](../../application-load-balancer/concepts/index.md) (см. [тарифы {{ alb-name }}](../../application-load-balancer/pricing.md)).
* Плата за публичные [DNS-запросы](../../glossary/dns.md) и [зоны DNS](../../dns/concepts/dns-zone.md), если вы используете [{{ dns-full-name }}](../../dns/) (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).



## Подготовьте цель тестирования {#prepare-target}

В этой инструкции в качестве цели тестирования будет использоваться gRPC-сервис.

1. Сохраните следующую спецификацию для создания приложения в файле `grpc-server.yaml`:

   ```yaml
   ### Deployment.
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
   ---
   ### Service.
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

1. Создайте приложение:

   ```bash
   kubectl apply -f grpc-server.yaml
   ```


## Подготовьте домен {#prepare-domain}

1. [Создайте](../../dns/operations/zone-create-public.md) публичную зону DNS и делегируйте домен.

   {% note info %}

   Для домена example.com зона должна называться `example.com.` (с точкой в конце).

   {% endnote %}

1. [Добавьте](../../certificate-manager/operations/managed/cert-create.md) [сертификат](../../certificate-manager/concepts/managed-certificate.md) от `Let's Encrypt®`.
1. [Пройдите](../../certificate-manager/operations/managed/cert-validate.md) процедуры проверки прав на домен.


## Установите Ingress {#install-ingress}

1. Создайте манифест ресурса [Ingress](../../managed-kubernetes/alb-ref/ingress.md) в файле `ingress.yaml`:

   ```yaml
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

   * `ingress.alb.yc.io/subnets` — список идентификаторов [подсетей](../../vpc/concepts/network.md#subnet) через запятую.
   * `ingress.alb.yc.io/external-ipv4-address` — предоставление публичного доступа к {{ alb-name }} из интернета.

     При значении `auto` Ingress-контроллер получит [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) автоматически. При удалении Ingress-контроллера IP-адрес также будет удален из облака.

   * `ingress.alb.yc.io/security-groups` — идентификатор группы безопасности, созданной при [подготовке облака к работе](#before-you-begin). Если в вашем облаке не включены группы безопасности, удалите эту аннотацию.
   * `secretName` — указание на [TLS-сертификат](../../certificate-manager/concepts/index.md) из [{{ certificate-manager-full-name }}](../../certificate-manager/) в формате `yc-certmgr-cert-id-<идентификатор_сертификата>`.
   * `hosts`, `host` — доменное имя, которому соответствует TLS-сертификат.

   Подробнее см. [поля и аннотации ресурса Ingress](../../managed-kubernetes/alb-ref/ingress.md).

1. Создайте ресурс `Ingress`:

   ```bash
   kubectl apply -f ingress.yaml
   ```

1. Проверьте, что ресурс создан и получил публичный IP-адрес:

   ```bash
   kubectl get ingress grpc-demo
   ```

   Результат:

   ```text
   NAME       CLASS   HOSTS        ADDRESS     PORTS    AGE
   grpc-demo  <none>  <имя_сайта>  <IP-адрес>  80, 443  2m
   ```

   Где:

   * `<имя_сайта>` — доменное имя, которому соответствует TLS-сертификат.
   * `<IP-адрес>` — IP-адрес сайта.

   В столбце `ADDRESS` должен появиться IP-адрес. В противном случае балансировщик не создался или создался некорректно — проверьте логи [пода](../../managed-kubernetes/concepts/index.md#pod) `yc-alb-ingress-controller-*`.

1. Если вы не устанавливали [ExternalDNS с плагином для {{ dns-name }}](/marketplace/products/yc/externaldns), [создайте](../../dns/operations/resource-record-create.md) в {{ dns-name }} [A-запись](../../dns/concepts/resource-record.md#a-a), указывающую на публичный адрес балансировщика. При использовании ExternalDNS c плагином для {{ dns-name }} запись создастся автоматически.


## Настройте горизонтальное автомасштабирование подов {#configure-autoscaling}

1. Создайте файл `hpa.yaml` со спецификацией {{ k8s-hpa }}:

   ```yaml
   ### HPA.
   apiVersion: autoscaling/v2
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
   * `backend_group` — идентификатор [группы бэкендов](../../application-load-balancer/concepts/backend-group.md).

   Найти их можно в консоли {{ alb-name }} или выполнив команды:

   ```bash
   yc alb load-balancer list
   yc alb backend-group list
   ```

1. Создайте {{ k8s-hpa }}:

   ```bash
   kubectl apply -f hpa.yaml
   ```


## Проведите нагрузочное тестирование gRPC-сервиса {#load-testing}

1. Создайте сервисный аккаунт:

   1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `sa-loadtest` в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), где будет размещаться [агент](../../load-testing/concepts/agent.md), с которого будет подаваться [нагрузка](../../load-testing/concepts/index.md).
   1. [Назначьте](../../iam/operations/roles/grant.md) [роли](../../iam/concepts/access-control/roles.md) сервисному аккаунту:

      * `loadtesting.generatorClient` — позволяет запускать агент, тест на агенте и загружать результаты в хранилище.
      * `compute.admin` — позволяет управлять [виртуальной машиной](../../compute/concepts/vm.md) в [{{ compute-full-name }}](../../compute/).
      * `vpc.user` — позволяет подключаться к сетевым ресурсам [{{ vpc-full-name }}](../../vpc/) и использовать их.

1. [Создайте и настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) в подсети, где размещается цель тестирования и будет размещен агент. Это обеспечит доступ агента к сервису [{{ load-testing-full-name }}](../../load-testing/).
1. [Создайте](../../load-testing/tutorials/loadtesting-grpc.md#create-agent) агент тестирования.
1. Подготовьте файл с [тестовыми данными](../../load-testing/concepts/payload.md) `ammo.json`:

   ```json
   {"tag": "/Add", "call": "api.Adder.Add", "payload": {"x": 21, "y": 12}}
   ```

1. Подготовьте файл конфигурации `load.yaml`:

   ```yaml
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
           target: <название_вашего_сайта>:<порт>
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
   autostop:
       enabled: true
       package: yandextank.plugins.Autostop
       autostop:
         - limit (5m)
   uploader:
     enabled: true
     package: yandextank.plugins.DataUploader
     job_name: '[pandora][grpc][tls]'
     job_dsc: ''
     ver: ''
     api_address: loadtesting.{{ api-host }}:443
   ```

1. [Запустите тест](../../load-testing/tutorials/loadtesting-grpc.md#run-test):

   * В блоке **{{ ui-key.yacloud.load-testing.test-data-section }}** нажмите **{{ ui-key.yacloud_portal.component.file-input.button_choose-multiple }}** и выберите сохраненный ранее файл `ammo.json`.
   * В блоке настроек **{{ ui-key.yacloud.load-testing.label_test-settings }}**:

     * В поле **{{ ui-key.yacloud.load-testing.field_settings-type }}** выберите `{{ ui-key.yacloud.load-testing.label_settings-type-config }}`.
     * В поле **{{ ui-key.yacloud.load-testing.field_config-file }}** нажмите **{{ ui-key.yacloud_portal.component.file-input.button_choose-multiple }}** и загрузите подготовленный ранее файл `load.yaml`.

1. Наблюдайте за прохождением теста:

   1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Выберите ваш тестовый кластер {{ managed-k8s-name }}.
   1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
   1. Наблюдайте за изменением количества подов приложения по мере увеличения и уменьшения нагрузки.
   1. По завершении теста в [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Выберите созданный L7-балансировщик.
   1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}**.
   1. Просмотрите графики нагрузки за время работы теста.

## Как удалить созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. Если вы настраивали [CNAME-записи](../../dns/concepts/resource-record.md#cname) в {{ dns-name }}, [удалите зону DNS](../../dns/operations/zone-delete.md).
1. [Удалите L7-балансировщик](../../application-load-balancer/operations/application-load-balancer-delete.md).
1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
1. [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
