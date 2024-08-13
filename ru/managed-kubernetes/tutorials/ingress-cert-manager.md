---
title: "Как создать Ingress-контроллер NGINX и защитить его сертификатом {{ lets-encrypt }} в {{ managed-k8s-full-name }}"
description: "Следуя данному руководству, вы сможете создать Ingress-контроллер NGINX и защитить его сертификатом {{ lets-encrypt }}." 
---

# Установка Ingress-контроллера NGINX с менеджером для сертификатов {{ lets-encrypt }}

Чтобы с помощью [{{ k8s }}](https://kubernetes.io/ru/) создать [Ingress-контроллер NGINX](https://kubernetes.github.io/ingress-nginx/) и защитить его сертификатом:

1. [{#T}](#install-controller).
1. [{#T}](#connecting-certs-manager).
1. [{#T}](#install-certs-manager).
1. [{#T}](#create-issuer).
1. [{#T}](#install-objects).
1. [{#T}](#test-controller).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролями](../../iam/concepts/access-control/roles.md) `editor`, `container-registry.images.puller` и `load-balancer.admin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роль `load-balancer.admin` нужна для создания [сетевого балансировщика нагрузки](../../network-load-balancer/concepts/index.md).
1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Создайте кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../operations/node-group/node-group-create.md) любой подходящей конфигурации. В настройках кластера укажите сервисный аккаунт и группы безопасности, созданные ранее.
1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md).
1. {% include [install externaldns](../../_includes/managed-kubernetes/install-externaldns.md) %}

## Установите Ingress-контроллер NGINX с помощью Helm-чарта {#install-controller}

1. [Установите менеджер пакетов {{ k8s }} Helm](https://helm.sh/ru/docs/intro/install).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Ingress-контроллером NGINX выполните команду:

   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && \
   helm repo update && \
   helm install ingress-nginx ingress-nginx/ingress-nginx
   ```

Созданный контроллер будет установлен за [{{ network-load-balancer-full-name }}](../../network-load-balancer/).

Чтобы настроить конфигурацию контроллера самостоятельно, обратитесь к [документации Helm](https://helm.sh/ru/docs/intro/using_helm/#настройка-chart-а-перед-установкой) и отредактируйте файл [values.yaml](https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/values.yaml).

Чтобы пробросить определенные порты при установке Ingress-контроллера NGINX, следуйте [инструкции](../operations/create-load-balancer-with-ingress-nginx.md#port-forwarding).

## Настройте DNS-запись для Ingress-контроллера {#connecting-certs-manager}

Если вы используете [ExternalDNS c плагином для {{ dns-name }}](/marketplace/products/yc/externaldns), настраивать DNS-запись не нужно — она создается автоматически. В противном случае:
1. Узнайте [IP-адрес](../../vpc/concepts/address.md) Ingress-контроллера (значение в колонке `EXTERNAL-IP`):

   ```bash
   kubectl get svc
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
* С помощью [{{ marketplace-full-name }}](../../marketplace/): будет установлен cert-manager, [интегрированный с сервисом {{ dns-name }}](../operations/applications/cert-manager-cloud-dns.md).

  В кластере будет создан объект `ClusterIssuer`, настроенный на прохождение [проверки DNS-01](https://letsencrypt.org/ru/docs/challenge-types/#проверка-dns-01) с помощью {{ dns-name }}.

  При необходимости можно вручную создать и настроить другие объекты: `Issuer` или `ClusterIssuer`. Подробнее об этих объектах см. в [документации cert-manager](https://cert-manager.io/docs/configuration/).
* Вручную: будет установлен cert-manager без дополнительных интеграций.

  Любые объекты `Issuer` и `ClusterIssuer` потребуется создать и настроить вручную.

{% list tabs group=instructions %}

- {{ marketplace-full-name }} {#marketplace}

  Установите приложение cert-manager c плагином {{ dns-name }} ACME webhook [по инструкции](../operations/applications/cert-manager-cloud-dns.md).

- Вручную {#manual}

  1. Установите [актуальную версию](https://github.com/cert-manager/cert-manager/releases) cert-manager. Например, для версии 1.21.1 выполните команду:

     ```bash
     kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.1/cert-manager.yaml
     ```

  1. Убедитесь, что в [пространстве имен](../concepts/index.md#имен-namespace) `cert-manager` создано три [пода](../concepts/index.md#pod) с готовностью `1/1` и статусом `Running`:

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

Создайте объект [ClusterIssuer](https://cert-manager.io/docs/configuration/), с помощью которого можно выпускать сертификаты {{ lets-encrypt }}.

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
        email: <ваш_email>
        privateKeySecretRef:
          name: http01-clusterissuer-secret
        solvers:
        - http01:
            ingress:
              class: nginx
    ```

1. Создайте объект в кластере {{ managed-k8s-name }}:

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

1. Создайте объекты в кластере {{ managed-k8s-name }}:

   ```bash
   kubectl apply -f app.yaml
   ```

## Проверьте работоспособность TLS {#test-controller}

1. Убедитесь, что [проверка прав на домен](../../certificate-manager/operations/managed/cert-validate.md) завершилась успешно и сертификат перешел в статус `Issued`:

   ```bash
   kubectl describe certificate domain-name-secret
   ```

   {% include [События cert-manager при выпуске сертификата](../../_includes/managed-kubernetes/cert-manager-events-explained.md) %}

   {% note info %}

   Проверка прав на домен сертификата {{ lets-encrypt }} может занять несколько часов.

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

   {% include [Настройка групп безопасности при недоступности ресурса](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Удалите публичную доменную зону](../../dns/operations/zone-delete.md).
