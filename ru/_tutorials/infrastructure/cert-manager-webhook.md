# Создание веб-хука резолвера ACME для ответов на DNS01-проверки

Чтобы автоматически проходить проверки [прав на домен](../../certificate-manager/concepts/challenges.md) с использованием утилиты [cert-manager](https://cert-manager.io/docs/), добавьте веб-хук с резолвером DNS01 в конфигурацию утилиты.

Ниже приведен пример создания объекта `ClusterIssuer` с веб-хуком резолвера DNS01 для домена, зарегистрированного в {{ dns-full-name }}.

Чтобы запустить веб-хук в кластере {{ managed-k8s-name }}:

1. [Установите веб-хук](#install-yandex-webhook).
1. [Подготовьте конфигурационные файлы](#prepare-files).
1. [Запустите менеджер сертификатов с веб-хуком](#run-webhook).

## Перед началом работы {#before-you-begin}

1. [Подготовьте кластер {{ managed-k8s-name }}](../../managed-kubernetes/quickstart.md) к работе.
1. [Установите менеджер сертификатов](../../managed-kubernetes/tutorials/ingress-cert-manager.md#install-certs-manager) последней версии.
1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/).
1. [Настройте CLI](../../cli/operations/authentication/service-account.md) для работы от имени сервисного аккаунта.

## Установите веб-хук {#install-yandex-webhook}

1. Клонируйте репозиторий веб-хука:

    ```
    git clone https://github.com/yandex-cloud/cert-manager-webhook-yandex.git
    ```

1. Установите веб-хук с помощью Helm:

    ```
    helm install -n cert-manager yandex-webhook ./deploy/cert-manager-webhook-yandex
    ```

## Подготовьте конфигурационные файлы {#prepare-files}

1. Создайте [авторизованный ключ](../../iam/operations/sa/create-access-key.md) и сохраните его в файл `iamkey.json`:

    ```
    yc iam key create iamkey \
        --service-account-id=<идентификатор_сервисного_аккаунта> \
        --format=json \
        --output=iamkey.json
    ```

    {% note warning %}

    Сервисный аккаунт должен иметь роль `dns.editor` в каталоге c публичной зоной.

    {% endnote %}

1. Создайте секрет с ключом сервисного аккаунта:

    ```
    kubectl create secret generic cert-manager-secret --from-file=iamkey.json -n cert-manager
    ```

1. Создайте файл `cluster-issuer.yml` с манифестом объекта `ClusterIssuer`:

    ```
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
     name: clusterissuer
     namespace: default
    spec:
     acme:
      # You must replace this email address with your own.
      # Let's Encrypt will use this to contact you about expiring
      # certificates, and issues related to your account.
      email: your@email.com
      server: https://acme-v02.api.letsencrypt.org/directory
      privateKeySecretRef:
       # Secret resource that will be used to store the account's private key.
       name: secret-ref
      solvers:
       - dns01:
          webhook:
            config:
              # The ID of the folder where dns-zone located in
              folder: <идентификатор_каталога>
              # This is the secret used to access the service account
              serviceAccountSecretRef:
                name: cert-manager-secret
                key: iamkey.json
            groupName: acme.cloud.yandex.com
            solverName: yandex-cloud-dns
    ```

1. Создайте файл `cluster-certificate.yml` с манифестом объекта `Certificate`:

    ```
    apiVersion: cert-manager.io/v1
    kind: Certificate
    metadata:
     name: your-site-com
     namespace: default
    spec:
     secretName: example-com-secret
     issuerRef:
      # The issuer created previously
      name: clusterissuer
      kind: ClusterIssuer
     dnsNames:
       - your-site.com
    ```

## Запустите менеджер сертификатов с веб-хуком {#run-webhook}

1. Создайте объекты в кластере Kubernetes:

    ```
    kubectl apply -f cluster-issuer.yml && \
    kubectl apply -f cluster-certificate.yaml
    ```

2. Убедитесь, что веб-хук запущен:

    ```
    kubectl get pods -n cert-manager –watch
    ```

    Проверьте, что среди записей присутствует веб-хук ACME для {{ dns-full-name }}:

    ```
    NAME                                                         READY   STATUS    RESTARTS   AGE
    ... 
    yandex-webhook-cert-manager-webhook-yandex-5578cfb98-tw4mq   1/1     Running   1          43h
    ```

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, [удалите кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) {{ managed-k8s-name }}.
