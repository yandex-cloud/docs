# Установка Ingress-контроллера NGINX с менеджером для сертификатов Let's Encrypt® в Yandex Managed Service for Kubernetes

# Установка Ingress-контроллера NGINX с менеджером для сертификатов Let's Encrypt®

{% note alert %}

Поддержка контроллера Ingress NGINX прекращается в марте 2026 года. Подробнее см. на странице [Ingress NGINX Retirement: What You Need to Know](https://kubernetes.io/blog/2025/11/11/ingress-nginx-retirement/).

Рекомендуется [перейти](../../managed-kubernetes/alb-ref/nginx-gwin-migration.md) на новый контроллер [Yandex Cloud Gwin](../../managed-kubernetes/alb-ref/gwin-index.md).

{% endnote %}

Чтобы с помощью [Kubernetes](https://kubernetes.io/ru/) создать [Ingress-контроллер NGINX](https://kubernetes.github.io/ingress-nginx/) и защитить его сертификатом:

1. [Установите Ingress-контроллер NGINX](#install-controller).
1. [Настройте DNS-запись для Ingress-контроллера](#connecting-certs-manager).
1. [Установите менеджер сертификатов](#install-certs-manager).
1. [Создайте ClusterIssuer](#create-issuer).
1. [Создайте объекты для проверки работы cert-manager](#install-objects).
1. [Проверьте работоспособность TLS](#test-controller).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за DNS-зону и DNS-запросы (см. [тарифы Cloud DNS](../../dns/pricing.md)).
* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик (см. [тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за сетевой балансировщик нагрузки (см. [тарифы Network Load Balancer](../../network-load-balancer/pricing.md)).
* Плата за публичные IP-адреса, если они назначены узлам кластера, а также за публичный IP-адрес для сетевого балансировщика нагрузки (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролями](../../iam/concepts/access-control/roles.md) `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `load-balancer.admin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роль `load-balancer.admin` нужна для создания [сетевого балансировщика нагрузки](../../network-load-balancer/concepts/index.md).
1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Добавьте](../../vpc/operations/security-group-add-rule.md) в группы безопасности следующие правила:
   
     * В [группу безопасности кластера](../../managed-kubernetes/operations/connect/security-groups.md#rules-master) добавьте правило для исходящего трафика, которое разрешает проверку сертификатов через веб-хук cert-manager:
       * **Диапазон портов** — `10250`.
       * **Протокол** — `TCP`.
       * **Назначение** — `CIDR`.
       * **CIDR блоки** — `0.0.0.0/0`.
     * В [группу безопасности группы узлов](../../managed-kubernetes/operations/connect/security-groups.md#rules-internal-nodegroup) добавьте правило для исходящего трафика, которое разрешает подключение к серверам Let's Encrypt® для выпуска сертификатов:
       * **Диапазон портов** — `443`.
       * **Протокол** — `TCP`.
       * **Назначение** — `CIDR`.
       * **CIDR блоки** — `0.0.0.0/0`.
1. [Создайте кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. В настройках кластера укажите сервисный аккаунт и группы безопасности, созданные ранее.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md).


1. (Опционально) [Установите](../../managed-kubernetes/operations/applications/externaldns.md) ExternalDNS c Webhook Yandex Cloud DNS, чтобы автоматически создать [DNS-запись](../../dns/concepts/resource-record.md) в [Yandex Cloud DNS](../../dns/index.md) при создании Ingress-контроллера.


## Установите Ingress-контроллер NGINX {#install-controller}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Установите менеджер пакетов Kubernetes Helm](https://helm.sh/ru/docs/intro/install).
  1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Ingress-контроллером NGINX выполните команду:

     ```bash
     helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && \
     helm repo update && \
     helm install ingress-nginx ingress-nginx/ingress-nginx
     ```

  Созданный контроллер будет установлен за [Yandex Network Load Balancer](../../network-load-balancer/index.md).

  Чтобы настроить конфигурацию контроллера самостоятельно, обратитесь к [документации Helm](https://helm.sh/ru/docs/intro/using_helm/#настройка-chart-а-перед-установкой) и отредактируйте файл [values.yaml](https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/values.yaml).

{% endlist %}

Чтобы пробросить определенные порты при установке Ingress-контроллера NGINX, следуйте [инструкции](../../managed-kubernetes/operations/create-load-balancer-with-ingress-nginx.md#port-forwarding).

## Настройте DNS-запись для Ingress-контроллера {#connecting-certs-manager}

Если вы используете [ExternalDNS с плагином для Cloud DNS](https://yandex.cloud/ru/marketplace/products/yc/externaldns), настраивать DNS-запись не нужно — она создается автоматически. В противном случае:
1. Узнайте [IP-адрес](../../vpc/concepts/address.md) Ingress-контроллера (значение в колонке `EXTERNAL-IP`):

   ```bash
   kubectl get svc -n <пространство_имен_приложения_Ingress_NGINX>
   ```

   Результат:

   ```text
   NAME                      TYPE          CLUSTER-IP     EXTERNAL-IP     PORT(S)                     AGE
   ...
   ingress-nginx-controller  LoadBalancer  10.96.164.252  84.201.153.122  80:31248/TCP,443:31151/TCP  2m19s
   ...
   ```

1. Разместите у своего DNS-провайдера или на собственном DNS-сервере [A-запись](../../dns/concepts/resource-record.md#a), указывающую на публичный IP-адрес Ingress-контроллера:

   ```text
   <ваш_домен> IN A <IP-адрес_Ingress-контроллера>
   ```

## Установите менеджер сертификатов {#install-certs-manager}


Вы можете установить менеджер сертификатов одним из способов:
* С помощью [Yandex Cloud Marketplace](../../marketplace/index.md): будет установлен cert-manager, [интегрированный с сервисом Cloud DNS](../../managed-kubernetes/operations/applications/cert-manager-cloud-dns.md).

  В кластере будет создан объект `ClusterIssuer`, настроенный на прохождение [проверки DNS-01](https://letsencrypt.org/ru/docs/challenge-types/#проверка-dns-01) с помощью Cloud DNS.

  При необходимости можно вручную создать и настроить другие объекты: `Issuer` или `ClusterIssuer`. Подробнее об этих объектах см. в [документации cert-manager](https://cert-manager.io/docs/configuration/).
* Вручную: будет установлен cert-manager без дополнительных интеграций.

  Любые объекты `Issuer` и `ClusterIssuer` потребуется создать и настроить вручную.


{% list tabs group=instructions %}


- Yandex Cloud Marketplace {#marketplace}

  Установите приложение cert-manager c плагином Cloud DNS ACME webhook [по инструкции](../../managed-kubernetes/operations/applications/cert-manager-cloud-dns.md).


- Вручную {#manual}

  1. Установите [актуальную версию](https://github.com/cert-manager/cert-manager/releases) cert-manager. Например, для версии 1.12.1 выполните команду:

     ```bash
     kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.1/cert-manager.yaml
     ```

  1. Убедитесь, что в [пространстве имен](../../managed-kubernetes/concepts/index.md#namespace) `cert-manager` создано три [пода](../../managed-kubernetes/concepts/index.md#pod) с готовностью `1/1` и статусом `Running`:

     ```bash
     kubectl get pods -n cert-manager --watch
     ```

     Результат:

     ```text
     NAME                                      READY  STATUS   RESTARTS  AGE
     cert-manager-69********-ghw6s             1/1    Running  0         54s
     cert-manager-cainjector-76********-gnrzz  1/1    Running  0         55s
     cert-manager-webhook-77********-wz9bh     1/1    Running  0         54s
     ```

{% endlist %}

## Создайте ClusterIssuer {#create-issuer}

Создайте объект [ClusterIssuer](https://cert-manager.io/docs/configuration/), с помощью которого можно выпускать сертификаты Let's Encrypt®.

Сертификаты будут выпускаться после прохождения [проверки HTTP-01](https://letsencrypt.org/ru/docs/challenge-types/#проверка-http-01) с помощью [установленного ранее](#install-controller) Ingress-контроллера.

Создайте объект с нужными параметрами:

1. Создайте YAML-файл `http01-clusterissuer.yaml` с манифестом объекта:

    ```yaml
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: http01-clusterissuer
    spec:
      acme:
        server: https://acme-v02.api.letsencrypt.org/directory
        email: <электронная_почта_для_уведомлений_от_Lets_Encrypt>
        privateKeySecretRef:
          name: http01-clusterissuer-secret
        solvers:
        - http01:
            ingress:
              class: nginx
    ```

1. Создайте объект в кластере Managed Service for Kubernetes:

    ```bash
    kubectl apply -f http01-clusterissuer.yaml
    ```

## Создайте объекты для проверки работы cert-manager {#install-objects}

Чтобы протестировать работу менеджера сертификатов, создайте объекты `Ingress`, `Service` и `Deployment`:

1. Создайте YAML-файл `app.yaml` с манифестами объектов `Ingress`, `Service` и `Deployment`:

   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: minimal-ingress
     annotations:
       cert-manager.io/cluster-issuer: "http01-clusterissuer"
   spec:
     ingressClassName: nginx
     tls:
       - hosts:
         - <URL_адрес_вашего_домена>
         secretName: domain-name-secret
     rules:
       - host: <URL_адрес_вашего_домена>
         http:
           paths:
           - path: /
             pathType: Prefix
             backend:
               service:
                 name: app
                 port:
                   number: 80
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: app
   spec:
     selector:
       app: app
     ports:
       - protocol: TCP
         port: 80
         targetPort: 80
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: app-deployment
     labels:
       app: app
   spec:
     replicas: 1
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
           image: nginx:latest
           ports:
           - containerPort: 80
   ```

1. Создайте объекты в кластере Managed Service for Kubernetes:

   ```bash
   kubectl apply -f app.yaml
   ```

## Проверьте работоспособность TLS {#test-controller}

1. Убедитесь, что [проверка прав на домен](../../certificate-manager/operations/managed/cert-validate.md) завершилась успешно и сертификат перешел в статус `Issued`:

   ```bash
   kubectl describe certificate domain-name-secret
   ```

   В выводе команды будут содержаться подобные события (events):
   
   ```text
   Events:
     Type    Reason     Age   From                                       Message
     ----    ------     ----  ----                                       -------
     Normal  Issuing    ...   cert-manager-certificates-trigger          Issuing certificate as Secret does not exist
     Normal  Generated  ...   cert-manager-certificates-key-manager      Stored new private key in temporary Secret resource...
   ```
   
   Сертификаты [используются в связке с соответствующими им секретами Kubernetes](https://cert-manager.io/docs/), которые хранят пары ключей и служебную информацию. В случае отсутствия секрета сертификат перевыпускается автоматически с созданием нового секрета, о чем и сообщается в событиях. Подробнее о причинах, которые могут привести к перевыпуску сертификата, см. в [документации cert-manager](https://cert-manager.io/docs/faq/#when-do-certs-get-re-issued).
   
   Поскольку сертификат выпускается впервые, то соответствующий ему секрет отсутствует. Наличие событий, сообщающих об этом, не является ошибкой.

   {% note info %}

   Проверка прав на домен сертификата Let's Encrypt® может занять несколько часов.

   {% endnote %}

1. Выполните команду:

   ```bash
   curl https://<ваш_домен>
   ```

   Результат:

   ```text
   <!DOCTYPE html>
   <html>
   <head>
   <title>Welcome to nginx!</title>
   <style>
   html { color-scheme: light dark; }
   body { width: 35em; margin: 0 auto;
   font-family: Tahoma, Verdana, Arial, sans-serif; }
   </style>
   </head>
   <body>
   <h1>Welcome to nginx!</h1>
   <p>If you see this page, the nginx web server is successfully installed and
   working. Further configuration is required.</p>

   <p>For online documentation and support please refer to
   <a href="http://nginx.org/">nginx.org</a>.<br/>
   Commercial support is available at
   <a href="http://nginx.com/">nginx.com</a>.</p>

   <p><em>Thank you for using nginx.</em></p>
   </body>
   </html>
   ```

   {% note info %}
   
   Если ресурс недоступен по указанному URL, то [убедитесь](../../managed-kubernetes/operations/connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md).
   
   {% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. [Удалите кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Удалите публичную доменную зону](../../dns/operations/zone-delete.md).