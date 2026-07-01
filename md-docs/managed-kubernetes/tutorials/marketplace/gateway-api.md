# Настройка Gateway API

# Настройка Gateway API в Yandex Managed Service for Kubernetes

[Gateway API](https://github.com/kubernetes-sigs/gateway-api) — набор ресурсов [API](../../../glossary/rest-api.md), моделирующих сетевое взаимодействие в [кластере Kubernetes](../../concepts/index.md#kubernetes-cluster).

Из этой статьи вы узнаете, как организовать доступ к приложениям, находящимся в двух тестовых средах `dev` и `prod`, с помощью [Yandex Application Load Balancer](../../../application-load-balancer/index.md) через Gateway API. Для этого потребуется создать [публичную доменную зону](../../../dns/concepts/dns-zone.md#public-zones) и делегировать домен сервису [Yandex Cloud DNS](../../../dns/index.md).

Чтобы интегрировать Gateway API и Application Load Balancer:
1. [Создайте ресурсы Managed Service for Kubernetes](#k8s-create).
1. [Установите Gateway API и настройте доменные зоны](#install-gateway-api).
1. [Подготовьте тестовые приложения](#prepare-apps).
1. [Создайте тестовые приложения](#install-apps).
1. [Проверьте работу Gateway API](#check-apps).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за DNS-зону и DNS-запросы ([тарифы Cloud DNS](../../dns/pricing.md)).
* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../../pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за использование вычислительных ресурсов L7-балансировщика ([тарифы Application Load Balancer](../../application-load-balancer/pricing.md)).
* Плата за публичные IP-адреса ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../../dns/operations/zone-create-public.md).

## Создайте ресурсы Managed Service for Kubernetes {#k8s-create}

1. Создайте кластер и [группу узлов](../../concepts/index.md#node-group) Kubernetes.

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
     1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md) в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер Kubernetes и группа узлов.

     1. [Создайте группы безопасности](../../operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

     1. [Создайте кластер Kubernetes](../../operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.

   - Terraform {#tf}

     1. Если у вас еще нет Terraform, [установите его](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. [Получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
     1. [Настройте и инициализируйте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
     1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

     1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-gateway-api.tf](https://github.com/yandex-cloud-examples/yc-mk8s-gateway-api/blob/main/k8s-gateway-api.tf). В файле описаны:
        * Сеть.
        * Подсеть.
        * Кластер Kubernetes.
        * Сервисный аккаунт, необходимый для работы кластера и группы узлов Kubernetes.
        * [Группы безопасности](../../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

            {% note warning %}
            
            От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
            
            {% endnote %}

     1. Укажите в файле конфигурации:
        * [Идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
        * Версию Kubernetes для кластера и групп узлов Kubernetes.
        * CIDR кластера Kubernetes.
     1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.
     1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

   {% endlist %}

   {% note warning %}
   
   Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
   
   {% endnote %}

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../operations/connect/index.md#kubectl-connect).

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы Gateway API.
1. [Назначьте ему роли](../../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor` — для создания необходимых ресурсов.
   * `certificate-manager.admin` — для работы с сертификатами, зарегистрированными в сервисе [Yandex Certificate Manager](../../../certificate-manager/index.md).
   * `compute.viewer` — для использования узлов кластера Managed Service for Kubernetes в [целевых группах](../../../application-load-balancer/concepts/target-group.md) [балансировщика нагрузки](../../../application-load-balancer/concepts/application-load-balancer.md).
   * `vpc.publicAdmin` — для управления [внешней связностью](../../../vpc/security/index.md#vpc-public-admin).
1. Создайте для него [статический ключ](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) и сохраните в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта_для_Gateway_API> \
     --output sa-key.json
   ```

## Установите Gateway API и настройте доменные зоны {#install-gateway-api}

1. Установите [приложение Gateway API](https://yandex.cloud/ru/marketplace/products/yc/gateway-api) [с помощью инструкции](../../operations/applications/gateway-api.md). При установке используйте ключ сервисного аккаунта, [созданный ранее](#k8s-create).
1. Зарезервируйте [публичные IP-адреса](../../../vpc/concepts/address.md#public-addresses) для тестовых сред `prod` и `dev`:

   ```bash
   yc vpc address create \
     --name=prod \
     --labels reserved=true \
     --external-ipv4 \
     zone=<зона_доступности> && \
   yc vpc address create \
     --name=dev \
     --labels reserved=true \
     --external-ipv4 \
     zone=<зона_доступности>
   ```

   Где `<зона_доступности>` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой расположен ваш кластер Kubernetes.

   Сохраните публичные IP-адреса — они понадобятся для дальнейшей настройки.
1. Создайте [ресурсные записи](../../../dns/concepts/resource-record.md) для вашей публичной DNS-зоны:

   ```bash
   yc dns zone add-records \
     --name <имя_DNS-зоны> \
     --record '*.prod 60 A <IP-адрес_для_среды_prod>' && \
   yc dns zone add-records \
     --name <имя_DNS-зоны> \
     --record '*.dev 60 A <IP-адрес_для_среды_dev>'
   ```

   >Пример корректной команды:
   >
   >```bash
   >yc dns zone add-records \
   >  --name my-domain-name \
   >  --record '*.dev 60 A 171.154.241.41'
   >```

1. Создайте [пространство имен](../../concepts/index.md#namespace) для TLS-секретов:

   ```bash
   kubectl create namespace gateway-api-tls-secrets
   ```

1. Создайте сертификаты OpenSSL:

   ```bash
   openssl req -x509 \
     -newkey rsa:4096 \
     -keyout gateway-key-prod.pem \
     -out gateway-cert-prod.pem \
     -nodes \
     -days 365 \
     -subj '/CN=*.prod.<доменная_зона>' && \
   openssl req -x509 \
      -newkey rsa:4096 \
      -keyout gateway-key-dev.pem \
      -out gateway-cert-dev.pem \
      -nodes \
      -days 365 \
      -subj '/CN=*.dev.<доменная_зона>'
   ```

   >Пример корректной команды:
   >
   >```bash
   >openssl req -x509 \
   >  -newkey rsa:4096 \
   >  -keyout gateway-key-prod.pem \
   >  -out gateway-cert-prod.pem \
   >  -nodes \
   >  -days 365 \
   >  -subj '/CN=*.prod.my-test-domain.com'
   >```

   На основании этих сертификатов в кластере Kubernetes будут созданы секреты для тестовых сред `prod` и `dev`.

1. Создайте секреты:

   ```bash
   kubectl create -n gateway-api-tls-secrets secret tls gateway-prod-tls \
     --cert=gateway-cert-prod.pem \
     --key=gateway-key-prod.pem && \
   kubectl create -n gateway-api-tls-secrets secret tls gateway-dev-tls \
     --cert=gateway-cert-dev.pem \
     --key=gateway-key-dev.pem
   ```

## Подготовьте тестовые приложения {#prepare-apps}

Для проверки работы Gateway API будут созданы два приложения (`tutum/hello-world` и `nginxdemos/hello`). Для каждого приложения понадобится настройка и выполнение трех YAML-файлов:
* `dev-gw.yaml` и `prod-gw.yaml` — настройки Gateway. В этих манифестах нужно указать:
  * [Группы безопасности](../../operations/connect/security-groups.md), в которых развернут кластер Kubernetes, в параметре `metadata.annotations.gateway.alb.yc.io/security-groups`.
  * Доменную зону с префиксами `*.dev` и `*.prod` в параметрах `hostname`.
  * IP-адреса для сред `dev` и `prod` в параметре `spec.addresses.value`.
* `dev-route.yaml` и `prod-route.yaml` — настройка маршрутизации для приложений. В этих манифестах нужно указать доменную зону с префиксами `app.dev` и `app.prod` в параметре `spec.hostnames`.
* `dev-app.yaml` и `prod-app.yaml` — настройки приложений. С помощью этих манифестов будут созданы:
  * Пространство имен (уникальное для каждого приложения).
  * [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) приложения.
  * [Сервис](../../concepts/index.md#service).

### Настройте приложение для среды dev {#configure-dev}

1. Создайте манифест `dev-gw.yaml`:

   {% cut "dev-gw.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1
   kind: Gateway
   metadata:
     name: gateway-api-dev
     annotations:
       gateway.alb.yc.io/security-groups: <идентификаторы_групп_безопасности_кластера>
   spec:
     gatewayClassName: yc-df-class
     listeners:
     - name: gateway-api-dev
       protocol: HTTP
       port: 80
       hostname: "*.dev.<доменная_зона>"
       allowedRoutes:
         namespaces:
           from: Selector
           selector:
             matchExpressions:
             - key: kubernetes.io/metadata.name
               operator: In
               values:
               - dev-app
     - name: gateway-api-dev-tls
       protocol: HTTPS
       port: 443
       hostname: "*.dev.<доменная_зона>"
       allowedRoutes:
         namespaces:
           from: Selector
           selector:
             matchExpressions:
             - key: kubernetes.io/metadata.name
               operator: In
               values:
               - dev-app
       tls:
         certificateRefs:
         - group: ""
           kind: Secret
           name: gateway-dev-tls
           namespace: gateway-api-tls-secrets
         mode: Terminate
     addresses:
      - type: IPAddress
        value: "<IP-адрес_для_среды_dev>"
   ```

   {% endcut %}

1. Создайте файл `dev-route.yaml`:

   {% cut "dev-route.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1
   kind: HTTPRoute
   metadata:
     name: dev-app-http-route
     namespace: dev-app
   spec:
     hostnames:
     - "app.dev.<доменная_зона>"
     parentRefs:
     - name: gateway-api-dev
       namespace: default
     rules:
     - matches:
       - path:
           value: /
       backendRefs:
       - name: app
         port: 80
   ```

   {% endcut %}

1. Создайте манифест `dev-app.yaml`:

   {% cut "dev-app.yaml" %}

   ```yaml
   ---
   apiVersion: v1
   kind: Namespace
   metadata:
     name: dev-app
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: app
     namespace: dev-app
   spec:
     selector:
       matchLabels:
         app: app
     template:
       metadata:
         labels:
           app: app
       spec:
         containers:
         - name: app
           image: tutum/hello-world
           resources:
             limits:
               memory: "128Mi"
               cpu: "500m"
           ports:
           - containerPort: 80
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: app
     namespace: dev-app
   spec:
     type: NodePort
     selector:
       app: app
     ports:
     - port: 80
       targetPort: 80
   ```

   {% endcut %}

### Настройте приложение для среды prod {#configure-prod}

1. Создайте манифест `prod-gw.yaml`:

   {% cut "prod-gw.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1
   kind: Gateway
   metadata:
     name: gateway-api-prod
     annotations:
       gateway.alb.yc.io/security-groups: <идентификаторы_групп_безопасности_кластера>
   spec:
     gatewayClassName: yc-df-class
     listeners:
     - name: gateway-api-prod
       protocol: HTTP
       port: 80
       hostname: "*.prod.<доменная_зона>"
       allowedRoutes:
         namespaces:
           from: Selector
           selector:
             matchExpressions:
             - key: kubernetes.io/metadata.name
               operator: In
               values:
               - prod-app
     - name: gateway-api-prod-tls
       protocol: HTTPS
       port: 443
       hostname: "*.prod.<доменная_зона>"
       allowedRoutes:
         namespaces:
           from: Selector
           selector:
             matchExpressions:
             - key: kubernetes.io/metadata.name
               operator: In
               values:
               - prod-app
       tls:
         certificateRefs:
         - group: ""
           kind: Secret
           name: gateway-prod-tls
           namespace: gateway-api-tls-secrets
         mode: Terminate
     addresses:
       - type: IPAddress
         value: "<IP-адрес_для_среды_prod>"
   ```

   {% endcut %}

1. Создайте манифест `prod-route.yaml`:

   {% cut "prod-route.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1
   kind: HTTPRoute
   metadata:
     name: prod-app-http-route
     namespace: prod-app
   spec:
     hostnames:
     - "app.prod.<доменная_зона>"
     parentRefs:
     - name: gateway-api-prod
       namespace: default
     rules:
     - matches:
       - path:
           value: /
       backendRefs:
       - name: app
         port: 80
   ```

   {% endcut %}

1. Создайте манифест `prod-app.yaml`:

   {% cut "prod-app.yaml" %}

   ```yaml
   ---
   apiVersion: v1
   kind: Namespace
   metadata:
     name: prod-app
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: app
     namespace: prod-app
   spec:
     selector:
       matchLabels:
         app: app
     template:
       metadata:
         labels:
           app: app
       spec:
         containers:
         - name: app
           image: tutum/hello-world
           resources:
             limits:
               memory: "128Mi"
               cpu: "500m"
           ports:
           - containerPort: 80
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: app
     namespace: prod-app
   spec:
     type: NodePort
     selector:
       app: app
     ports:
     - port: 80
       targetPort: 80
   ```

   {% endcut %}

### Создайте тестовые приложения {#install-apps}

1. Для установки приложений выполните команду:

   ```bash
   kubectl apply -f prod-gw.yaml && \
   kubectl apply -f prod-app.yaml && \
   kubectl apply -f prod-route.yaml && \
   kubectl apply -f dev-gw.yaml && \
   kubectl apply -f dev-app.yaml && \
   kubectl apply -f dev-route.yaml
   ```

1. Убедитесь, что [поды](../../concepts/index.md#pod) приложений перешли в состояние `Running`:

   ```bash
   kubectl get pods --namespace dev-app && \
   kubectl get pods --namespace prod-app
   ```

1. Убедитесь, что для Gateway API создан балансировщик нагрузки:

   ```bash
   yc application-load-balancer load-balancer list
   ```

   Создание балансировщика нагрузки может занять несколько минут.

   {% note warning %}
   
   Не изменяйте и не удаляйте балансировщик нагрузки и его дочерние ресурсы, созданные с помощью Managed Service for Kubernetes, через интерфейсы Yandex Cloud (консоль управления, Terraform, CLI и API). Это может привести к некорректной работе кластера.
   
   {% endnote %}

## Проверьте работу Gateway API {#check-apps}

Для проверки работы Gateway API перейдите по ссылкам в браузере:
* `app.prod.<доменная_зона>`.
* `app.dev.<доменная_зона>`.

{% note info %}

Если ресурс недоступен по указанному URL, то [убедитесь](../../operations/connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../../vpc/operations/security-group-add-rule.md).

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер Kubernetes](../../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. [Удалите созданные подсети](../../../vpc/operations/subnet-delete.md) и [сети](../../../vpc/operations/network-delete.md).
  1. [Удалите созданный сервисный аккаунт](../../../iam/operations/sa/delete.md).

- Terraform {#tf}

  1. В терминале перейдите в директорию с планом инфраструктуры.
  
      {% note warning %}
  
      Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
  
      {% endnote %}
  
  1. Удалите ресурсы:
  
      1. Выполните команду:
  
          ```bash
          terraform destroy
          ```
  
      1. Подтвердите удаление ресурсов и дождитесь завершения операции.
  
      Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}