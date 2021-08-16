# Установка NGINX Ingress Controller с менеджером для сертификатов Let's Encrypt<sup>®</sup>

Чтобы с помощью [{{ k8s }}](https://kubernetes.io/) создать [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/) и защитить его сертификатом [Let's Encrypt<sup>®</sup>](https://letsencrypt.org/), выполните следующие действия.

## Перед началом работы {#before-begin}

1. Установите {{ k8s }} CLI [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl).

1. [Настройте](../operations/kubernetes-cluster/kubernetes-cluster-get-credetials.md) конфигурацию kubectl.

1. Установите менеджер пакетов {{ k8s }} [Нelm 3](https://helm.sh/docs/intro/install/).

1. Добавьте в Helm репозиторий для NGINX:

   {% list tabs %}

   - CLI

     Выполните команду:

     ```bash
     helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
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
     ...Successfully got an update from the "ingress-nginx" chart repository
     Update Complete. ⎈Happy Helming!⎈
     ```

   {% endlist %}

## Установите NGINX Ingress Controller {#install-controller}

Установите контроллер в стандартной конфигурации:

{% list tabs %}

- CLI

  Выполните команду:

  ```bash
  helm install ingress-nginx ingress-nginx/ingress-nginx
  ```

  Результат выполнения команды:

  ```bash
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
   
   An example Ingress that makes use of the controller:
   
     apiVersion: networking.k8s.io/v1beta1
     kind: Ingress
     metadata:
       annotations:
         kubernetes.io/ingress.class: nginx
       name: example
       namespace: foo
     spec:
       rules:
         - host: www.example.com
           http:
             paths:
               - backend:
                   serviceName: exampleService
                   servicePort: 80
                 path: /
       # This section is only required if TLS is to be enabled for the Ingress
       tls:
           - hosts:
               - www.example.com
             secretName: example-tls
   
   If TLS is enabled for the Ingress, a Secret containing the certificate and key must also be provided:
   
     apiVersion: v1
     kind: Secret
     metadata:
       name: example-tls
       namespace: foo
     data:
       tls.crt: <base64 encoded cert>
       tls.key: <base64 encoded key>
     type: kubernetes.io/tls
  ```

{% endlist %}

Созданный контроллер будет установлен за {{ network-load-balancer-full-name }}.

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

1. Чтобы протестировать работу менеджера сертификатов, необходимо создать Ingress, Service и Deployment.
   Cохраните следующую спецификацию для создания приложения в YAML-файл с именем `app.yaml`:

    ```yaml
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: www-ingress
      annotations:
        kubernetes.io/ingress.class: "nginx"
        cert-manager.io/cluster-issuer: "letsencrypt"
    spec:
      tls:
        - hosts:
          - <ваш домен>
          secretName: <имя домена>
      rules:
        - host: <ваш домен>
          http:
            paths:
            - backend:
                serviceName: app
                servicePort: 80
              path: /
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
      replicas: 3
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
            image: gcr.io/google-samples/frontend:v0.1.2
            ports:
            - containerPort: 80
    ```

    * <ваш домен> — URL адрес вашего домена.
    * <имя домена> — название вашего домена.

1. Создайте приложение в kubernetes:

   {% list tabs %}

   - CLI

     Выполните команду:

     ```bash
     kubectl apply -f app.yaml
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
