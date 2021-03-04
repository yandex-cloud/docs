# Установка NGINX Ingress Controller с менеджером для сертификатов Let's Encrypt<sup>®</sup>

Чтобы с помощью [{{ k8s }}](https://kubernetes.io/) создать [NGINX Ingress Controller](https://www.nginx.com/products/nginx-ingress-controller/) и защитить его сертификатом [Let's Encrypt<sup>®</sup>](https://letsencrypt.org/), выполните следующие действия.

## Перед началом работы {#before-begin}

1. Установите {{ k8s }} CLI [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl).

1. Установите менеджер пакетов {{ k8s }} [Нelm 3](https://helm.sh/docs/intro/install/).

1. Добавьте в Helm репозиторий для NGINX:

   {% list tabs %}

   - CLI

     Выполните команду:

     ```bash
     helm repo add nginx-stable https://helm.nginx.com/stable
     ```

     Результат выполнения команды:

     ```bash
     "nginx-stable" has been added to your repositories
     ```

   {% endlist %}

1. Обновите набор данных для создания экземпляра приложения в кластере {{ k8s }}:

   {% list tabs %}

   - CLI

     Выполните команду:

     ```bash
     helm repo update
     ```

     Результат выполнения команды:

     ```bash
     Hang tight while we grab the latest from your chart repositories...
     ...Successfully got an update from the "nginx-stable" chart repository
     Update Complete. ⎈Happy Helming!⎈
     ```

   {% endlist %}

## Установите NGINX Ingress Controller {#install-controller}

Установите контроллер в стандартной конфигурации:

{% list tabs %}

- CLI

  Выполните команду:

  ```bash
  helm install nginx-ingress nginx-stable/nginx-ingress
  ```

  Результат выполнения команды:

  ```bash
  NAME: nginx-ingress
  LAST DEPLOYED: Thu Dec 10 18:33:28 2020
  NAMESPACE: default
  STATUS: deployed
  REVISION: 1
  TEST SUITE: None
  NOTES:
  The NGINX Ingress Controller has been installed.
  ```

{% endlist %}

Созданный контроллер будет установлен за {{ load-balancer-full-name }}.

Чтобы настроить конфигурацию контроллера самостоятельно, обратитесь к [документации Helm](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing) и отредактируйте файл [values.yaml](https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/values.yaml).

## Установите менеджер сертификатов {#install-certs-manager}

1. Установите менеджер сертификатов версии 1.0.4, настроенный для выпуска сертификатов от Let's Encrypt<sup>®</sup> (проверьте наличие более новой версии на [странице проекта](https://github.com/jetstack/cert-manager/releases/)):

   {% list tabs %}

   - CLI

     Выполните команду:

     ```bash
     kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.0.4/cert-manager.yaml
     ```

     Результат выполнения команды:

     ```bash
     customresourcedefinition.apiextensions.k8s.io/certificaterequests.cert-manager.io created
     ...
     validatingwebhookconfiguration.admissionregistration.k8s.io/cert-manager-webhook created
     ```

   {% endlist %}

1. Убедитесь, что в пространстве имен `cert-manager` появится три пода, все они имеют готовность `1/1` и статус `Running`:

   {% list tabs %}

   - CLI

     Выполните команду:

     ```bash
     kubectl get pods -n cert-manager
     ```

     Результат выполнения команды:

     ```bash
     NAME                                       READY   STATUS    RESTARTS   AGE
     cert-manager-69cf79df7f-ghw6s              1/1     Running   0          54s
     cert-manager-cainjector-7648dc6696-gnrzz   1/1     Running   0          55s
     cert-manager-webhook-7746f64877-wz9bh      1/1     Running   0          54s
     ```

   {% endlist %}

## Настройте DNS-запись для ingress-контроллера {#connecting-certs-manager}

1. Узнайте IP-адрес контроллера:

   {% list tabs %}

   - CLI

     Выполните команду:

     ```bash
     kubectl get svc
     ```

     Результат выполнения команды:

     ```bash
     NAME                          TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)                      AGE
     ...
     nginx-ingress-nginx-ingress    LoadBalancer   10.96.164.252   84.201.153.122   80:31248/TCP,443:31151/TCP   2m19s
     ...
     ```

   {% endlist %}

1. Разместите у своего DNS-провайдера или на собственном DNS-сервере A-запись:

   ```bash
   <ваш домен> IN A 84.201.153.122
   ```

## Проверьте работу {#test-controller}

Проверьте работоспособность TLS:

{% list tabs %}

- CLI

  Выполните команду:

  ```bash
  curl https://<ваш домен>
  ```

{% endlist %}