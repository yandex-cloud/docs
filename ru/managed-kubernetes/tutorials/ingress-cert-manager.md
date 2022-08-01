# Установка Ingress-контроллера NGINX с менеджером для сертификатов Let's Encrypt®

Чтобы с помощью [{{ k8s }}](https://kubernetes.io/ru/) создать [Ingress-контроллер NGINX](https://kubernetes.github.io/ingress-nginx/) и защитить его сертификатом [Let's Encrypt<sup>®</sup>](https://letsencrypt.org/ru/), выполните следующие действия.

## Перед началом работы {#before-begin}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Установите менеджер пакетов {{ k8s }} [Helm 3](https://helm.sh/ru/docs/intro/install).
1. Добавьте в Helm репозиторий для NGINX:

   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
   ```

   Результат:

   ```text
   "ingress-nginx" has been added to your repositories
   ```

1. Обновите набор данных для создания экземпляра приложения в кластере {{ k8s }}:

   ```bash
   helm repo update
   ```

   Результат:

   ```text
   Hang tight while we grab the latest from your chart repositories...
   ...Successfully got an update from the "ingress-nginx" chart repository
   Update Complete. ⎈Happy Helming!⎈
   ```

## Установите NGINX Ingress Controller {#install-controller}

Установите контроллер в стандартной конфигурации:

```bash
helm install ingress-nginx ingress-nginx/ingress-nginx
```

Результат:

```text
NAME: ingress-nginx
LAST DEPLOYED: Sun Jul 18 22:35:37 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The ingress-nginx controller has been installed.
It may take a few minutes for the LoadBalancer IP to be available.
You can watch the status by running 'kubectl --namespace default get services -o wide -w ingress-nginx-controller'
...
```

Созданный контроллер будет установлен за {{ network-load-balancer-full-name }}.

Чтобы настроить конфигурацию контроллера самостоятельно, обратитесь к [документации Helm](https://helm.sh/ru/docs/intro/using_helm/#настройка-chart-а-перед-установкой) и отредактируйте файл [values.yaml](https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/values.yaml).

## Установите менеджер сертификатов {#install-certs-manager}

1. Установите менеджер сертификатов версии 1.6.1, настроенный для выпуска сертификатов от Let's Encrypt<sup>®</sup> (проверьте наличие более новой версии на [странице проекта](https://github.com/jetstack/cert-manager/releases/)):

   ```bash
   kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.6.1/cert-manager.yaml
   ```

   Результат:

   ```bash
   customresourcedefinition.apiextensions.k8s.io/certificaterequests.cert-manager.io created
   ...
   validatingwebhookconfiguration.admissionregistration.k8s.io/cert-manager-webhook created
   ```

1. Убедитесь, что в пространстве имен `cert-manager` создано три пода с готовностью `1/1` и статусом `Running`:

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

Чтобы протестировать работу менеджера сертификатов, необходимо создать объекты ClusterIssuer, Ingress, Service и Deployment.
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

1. Узнайте IP-адрес Ingress-контроллера (значение в колонке `EXTERNAL-IP`):

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

   ```bash
   <ваш домен> IN A 84.201.153.122
   ```

{% note info %}

Регистрация сертификата Let's Encrypt<sup>®</sup> и A-записи может занять несколько минут.

{% endnote %}

## Проверьте работоспособность TLS {#test-controller}

```bash
curl https://<ваш домен>
```

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, [удалите кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) {{ managed-k8s-name }}.