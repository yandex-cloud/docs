# Настройка Gateway API


[Gateway API](https://github.com/kubernetes-sigs/gateway-api) — набор ресурсов API, моделирующих сетевое взаимодействие в [кластере {{ k8s }}](../../concepts/index.md#kubernetes-cluster).

Из этой статьи вы узнаете, как организовать доступ к приложениям, находящимся в двух тестовых средах `dev` и `prod`, с помощью [{{ alb-full-name }}](../../../application-load-balancer/) через Gateway API. Для этого потребуется создать [публичную доменную зону](../../../dns/concepts/dns-zone.md#public-zones) и делегировать домен сервису [{{ dns-full-name }}](../../../dns).

Чтобы интегрировать Gateway API и {{ alb-name }}:
1. [{#T}](#k8s-create).
1. [{#T}](#install-gateway-api).
1. [{#T}](#prepare-apps).
1. [{#T}](#install-apps).
1. [{#T}](#check-apps).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../../dns/operations/zone-create-public.md).

## Создайте ресурсы {{ managed-k8s-name }} {#k8s-create}

1. Создайте кластер и [группу узлов](../../../managed-kubernetes/concepts/index.md#node-group) {{ k8s }}.

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
     1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md) в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер {{ k8s }} и группа узлов.
     1. [Создайте кластер {{ k8s }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации.
     1. {% include [configure-sg-manual](../../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

     1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-gateway-api.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-gateway-api.tf). В файле описаны:
        * Сеть.
        * Подсеть.
        * Кластер {{ k8s }}.
        * Сервисный аккаунт, необходимый для работы кластера и группы узлов {{ k8s }}.
        * {% include [configure-sg-terraform](../../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Укажите в файле конфигурации:
        * [Идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
        * Версию {{ k8s }} для кластера и групп узлов {{ k8s }}.
        * CIDR кластера {{ k8s }}.
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [kubectl-install-links](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы Gateway API.
1. [Назначьте ему роли](../../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor` — для создания необходимых ресурсов.
   * `certificate-manager.admin` — для работы с сертификатами, зарегистрированными в сервисе [{{ certificate-manager-full-name }}](../../../certificate-manager/).
   * `compute.viewer` — для использования узлов кластера {{ managed-k8s-name }} в [целевых группах](../../../application-load-balancer/concepts/target-group.md) [балансировщика нагрузки](../../../application-load-balancer/concepts/application-load-balancer.md).
   * `vpc.publicAdmin` — для управления [внешней связностью](../../../vpc/security/index.md#vpc-public-admin).
1. Создайте для него [статический ключ](../../../iam/operations/sa/create-access-key.md) и сохраните в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта_для_Gateway_API> \
     --output sa-key.json
   ```

## Установите Gateway API и настройте доменные зоны {#install-gateway-api}

1. Установите [приложение Gateway API](/marketplace/products/yc/gateway-api) [с помощью инструкции](../../operations/applications/gateway-api.md). При установке используйте ключ сервисного аккаунта, [созданный ранее](#k8s-create).
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

   Где `<зона_доступности>` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой расположен ваш кластер {{ k8s }}.

   Сохраните публичные IP-адреса — они понадобятся для дальнейшей настройки.
1. Создайте [ресурсные записи](../../../dns/concepts/resource-record.md) для вашей публичной DNS-зоны:

   ```bash
   yc dns zone add-records \
     --name <имя_вашей_DNS-зоны> \
     --record '*.prod.<имя_вашей_DNS-зоны> 60 A <IP-адрес_для_среды_prod>' && \
   yc dns zone add-records \
     --name <имя_вашей_DNS-зоны> \
     --record '*.dev.<имя_вашей_DNS-зоны> 60 A <IP-адрес_для_среды_dev>'
   ```

   >Пример корректной команды:
   >
   >```bash
   >yc dns zone add-records \
   >  --name my-test-domain.com \
   >  --record '*.dev.my-test-domain.com 60 A 171.154.241.41'
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
     -subj '/CN=*.prod.<имя_вашей_DNS-зоны>' && \
   openssl req -x509 \
      -newkey rsa:4096 \
      -keyout gateway-key-dev.pem \
      -out gateway-cert-dev.pem \
      -nodes \
      -days 365 \
      -subj '/CN=*.dev.<имя_вашей_DNS-зоны>'
   ```

   На основании этих сертификатов в кластере {{ k8s }} будут созданы секреты для тестовых сред `prod` и `dev`.
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
  * [Группу безопасности](../../operations/connect/security-groups.md), в которой развернут ваш кластер {{ k8s }}, в параметре `metadata.annotations.gateway.alb.yc.io/security-groups`.
  * Имя вашей DNS-зоны с префиксами `*.dev` и `*.prod` в параметрах `hostname`.
  * IP-адреса для сред `dev` и `prod` в параметре `spec.addresses.value`.
* `dev-route.yaml` и `prod-route.yaml` — настройка маршрутизации для приложений. В этих манифестах нужно указать имя вашей DNS-зоны с префиксами `app.dev` и `app.prod` в параметре `spec.hostnames`.
* `dev-app.yaml` и `prod-app.yaml` — настройки приложений. С помощью этих манифестов будут созданы:
  * Пространство имен (уникальное для каждого приложения).
  * [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) приложения.
  * [Сервис](../../concepts/index.md#service).

### Настройте приложение для среды dev {#configure-dev}

1. Создайте манифест `dev-gw.yaml`:

   {% cut "dev-gw.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1alpha2
   kind: Gateway
   metadata:
     name: gateway-api-dev
     annotations:
       gateway.alb.yc.io/security-groups: <группа_безопасности_кластера>
    spec:
     gatewayClassName: yc-df-class
     listeners:
     - name: gateway-api-dev
       protocol: HTTP
       port: 80
       hostname: "*.dev.<имя_вашей_DNS-зоны>"
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
       hostname: "*.dev.<имя_вашей_DNS-зоны>"
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
         value: <IP-адрес_для_среды_dev>
   ```

   {% endcut %}

1. Создайте файл `dev-route.yaml`:

   {% cut "dev-route.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1alpha2
   kind: HTTPRoute
   metadata:
     name: dev-app-http-route
     namespace: dev-app
   spec:
     hostnames:
     - "app.dev.<имя_вашей_DNS-зоны>"
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
   apiVersion: gateway.networking.k8s.io/v1alpha2
   kind: Gateway
   metadata:
     name: gateway-api-prod
     annotations:
       gateway.alb.yc.io/security-groups: <группа_безопасности_кластера>
   spec:
     gatewayClassName: yc-df-class
     listeners:
     - name: gateway-api-prod
       protocol: HTTP
       port: 80
       hostname: "*.prod.<имя_вашей_DNS-зоны>"
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
       hostname: "*.prod.<имя_вашей_DNS-зоны>"
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
         value: <IP-адрес_для_среды_prod>
   ```

   {% endcut %}

1. Создайте манифест `prod-route.yaml`:

   {% cut "prod-route.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1alpha2
   kind: HTTPRoute
   metadata:
     name: prod-app-http-route
     namespace: prod-app
   spec:
     hostnames:
     - "app.prod.<имя_вашей_DNS-зоны>"
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

   {% note info %}

   Создание балансировщика нагрузки может занять несколько минут.

   {% endnote %}

## Проверьте работу Gateway API {#check-apps}

Для проверки работы Gateway API перейдите по ссылкам в браузере:
* `app.prod.<имя_вашей_DNS-зоны>`.
* `dev.prod.<имя_вашей_DNS-зоны>`.

{% include [Настройка групп безопасности при недоступности ресурса](../../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер {{ k8s }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. [Удалите созданные подсети](../../../vpc/operations/subnet-delete.md) и [сети](../../../vpc/operations/network-delete.md).
  1. [Удалите созданный сервисный аккаунт](../../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

  1. В командной строке перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  1. Удалите конфигурационный файл `k8s-gateway-api.tf`.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     Все ресурсы, которые были описаны в конфигурационном файле `k8s-gateway-api.tf`, будут удалены.

{% endlist %}
