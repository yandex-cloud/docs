# Установка Ingress-контроллера NGINX с менеджером для сертификатов Let's Encrypt®

Чтобы с помощью [{{ k8s }}](https://kubernetes.io/ru/) создать [Ingress-контроллер NGINX](https://kubernetes.github.io/ingress-nginx/) и защитить его сертификатом [Let's Encrypt®](https://letsencrypt.org/ru/):
1. [{#T}](#install-controller).
1. [{#T}](#install-certs-manager).
1. [{#T}](#install-objects).
1. [{#T}](#connecting-certs-manager).
1. [{#T}](#test-controller).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролями](../../iam/concepts/access-control/roles.md) `editor` и `container-registry.images.puller` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
1. [Создайте кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../operations/node-group/node-group-create.md) любой подходящей конфигурации.
1. [Настройте группы безопасности кластера и группы узлов](../operations/connect/security-groups.md).

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md).
1. Если у вас уже есть сертификат для доменной зоны, [добавьте сведения о нем](../../certificate-manager/operations/import/cert-create.md) в сервис {[{ certificate-manager-full-name }}](../../certificate-manager/). Или [создайте новый сертификат от Let's Encrypt®](../../certificate-manager/operations/managed/cert-create.md).

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

## Установите менеджер сертификатов {#install-certs-manager}

1. Установите [актуальную версию](https://github.com/jetstack/cert-manager/releases/) менеджера сертификатов, настроенного для выпуска сертификатов от Let's Encrypt®. Например, для версии 1.9.1 выполните команду:

   ```bash
   kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.9.1/cert-manager.yaml
   ```

1. Убедитесь, что в пространстве имен `cert-manager` создано три [пода](../concepts/index.md#pod) с готовностью `1/1` и статусом `Running`:

   ```bash
   kubectl get pods -n cert-manager --watch
   ```

   Результат:

   ```bash
   NAME                                      READY  STATUS   RESTARTS  AGE
   cert-manager-69cf79df7f-ghw6s             1/1    Running  0         54s
   cert-manager-cainjector-7648dc6696-gnrzz  1/1    Running  0         55s
   cert-manager-webhook-7746f64877-wz9bh     1/1    Running  0         54s
   ```

## Создайте объекты {#install-objects}

Чтобы протестировать работу менеджера сертификатов, необходимо создать объекты `ClusterIssuer`, `Ingress`, `Service` и `Deployment`.
1. Создайте YAML-файл `acme-issuer.yaml` с манифестом объекта `ClusterIssuer`:

   ```yaml
   apiVersion: cert-manager.io/v1
   kind: ClusterIssuer
   metadata:
     name: letsencrypt
     namespace: cert-manager
   spec:
     acme:
       server: https://acme-v02.api.letsencrypt.org/directory
       email: <ваш email>
       privateKeySecretRef:
         name: letsencrypt
       solvers:
       - http01:
           ingress:
             class: nginx
   ```

1. Создайте YAML-файл `app.yaml` с манифестами объектов `Ingress`, `Service` и `Deployment`:

   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: minimal-ingress
     annotations:
       kubernetes.io/ingress.class: "nginx"
       cert-manager.io/cluster-issuer: "letsencrypt"
   spec:
     tls:
       - hosts:
         - <URL адрес вашего домена>
         secretName: letsencrypt
     rules:
       - host: <URL адрес вашего домена>
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

1. Создайте объекты в кластере {{ k8s }}:

   ```bash
   kubectl apply -f acme-issuer.yaml && \
   kubectl apply -f app.yaml
   ```

## Настройте DNS-запись для Ingress-контроллера {#connecting-certs-manager}

1. Узнайте [IP-адрес](../../vpc/concepts/address.md) Ingress-контроллера (значение в колонке `EXTERNAL-IP`):

   ```bash
   kubectl get svc
   ```

   Результат:

   ```bash
   NAME                      TYPE          CLUSTER-IP     EXTERNAL-IP     PORT(S)                     AGE
   ...
   ingress-nginx-controller  LoadBalancer  10.96.164.252  84.201.153.122  80:31248/TCP,443:31151/TCP  2m19s
   ...
   ```

1. Разместите у своего DNS-провайдера или на собственном DNS-сервере A-запись, указывающую на публичный IP-адрес Ingress-контроллера:

   ```text
   <ваш домен> IN A <IP-адрес Ingress-контроллера>
   ```

{% note info %}

Регистрация сертификата Let's Encrypt® и A-записи может занять несколько минут.

{% endnote %}

## Проверьте работоспособность TLS {#test-controller}

```bash
curl https://<ваш домен>
```

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:
1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Удалите публичную доменную зону](../../dns/operations/zone-delete.md).
1. [Удалите сертификат](../../certificate-manager/operations/managed/cert-delete.md).