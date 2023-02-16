# Проверка DNS Challenge для сертификатов Let's Encrypt®

Чтобы добавить возможность пройти проверку DNS Challenge при выписывании [сертификатов Let's Encrypt®](../../certificate-manager/concepts/managed-certificate.md):
1. [{#T}](#install-certs-manager).
1. [{#T}](#install-webhook).
1. [{#T}](#install-objects).
1. [{#T}](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролью](../../iam/concepts/access-control/roles.md) `dns.editor` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет находиться [доменная зона](../../dns/concepts/dns-zone.md).
1. [Создайте кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../operations/node-group/node-group-create.md) любой подходящей конфигурации.
1. [Настройте группы безопасности кластера и группы узлов](../operations/connect/security-groups.md).

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md).
1. [Создайте авторизованный ключ](../../iam/operations/authorized-key/create.md) для [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) и сохраните его в виде JSON-файла:

   ```bash
   yc iam key create \
     --service-account-name <имя сервисного аккаунта> \
     --format json \
     --output iamkey.json
   ```

1. Создайте [пространство имен](../concepts/index.md#namespace) `cert-manager`:

   ```bash
   kubectl create namespace cert-manager
   ```

1. Создайте [секрет](../../certificate-manager/concepts/index.md#types) в пространстве имен `cert-manager`:

   ```bash
   kubectl create secret generic cert-manager-secret \
     --from-file=iamkey.json \
     --namespace=cert-manager
   ```

## Установите менеджер сертификатов {#install-certs-manager}

1. Установите менеджер сертификатов:

   ```bash
   kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml
   ```

1. Убедитесь, что в пространстве имен `cert-manager` созданы три [пода](../concepts/index.md#pod) с готовностью `1/1` и статусом `Running`:

   ```bash
   kubectl get pods -n cert-manager --watch
   ```

   Результат:

   ```text
   NAME                                      READY  STATUS   RESTARTS  AGE
   cert-manager-69cf79df7f-ghw6s             1/1    Running  0         54s
   cert-manager-cainjector-7648dc6696-gnrzz  1/1    Running  0         55s
   cert-manager-webhook-7746f64877-wz9bh     1/1    Running  0         54s
   ```

## Установите Webhook {#install-webhook}

1. {% include [Установка Helm](../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с NGINX Ingress Controller выполните команду:

   ```bash
   git clone https://github.com/yandex-cloud/cert-manager-webhook-yandex.git && \
   helm install -n cert-manager yandex-webhook \
     cert-manager-webhook-yandex/deploy/cert-manager-webhook-yandex
   ```

## Создайте тестовые объекты {#install-objects}

1. Создайте файл `issuer.yaml` с манифестом объекта `ClusterIssuer`:

   ```yaml
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
       email: <ваш email>
       server: https://acme-staging-v02.api.letsencrypt.org/directory
       privateKeySecretRef:
         # Secret resource that will be used to store the account's private key.
         name: secret-ref
       solvers:
         - dns01:
             webhook:
               config:
                 # The ID of the folder where dns-zone located in
                 folder: <идентификатор каталога>
                 # This is the secret used to access the service account
                 serviceAccountSecretRef:
                   name: cert-manager-secret
                   key: iamkey.json
               groupName: acme.cloud.yandex.com
               solverName: yandex-cloud-dns
   ```

1. Создайте файл `certificate.yaml`:

   ```yaml
   apiVersion: cert-manager.io/v1
   kind: Certificate
   metadata:
     name: example-com
     namespace: default
   spec:
     secretName: example-com-secret
     issuerRef:
       # The issuer created previously
       name: clusterissuer
       kind: ClusterIssuer
     dnsNames:
       - <доменное имя>
   ```

1. Создайте объекты в кластере {{ managed-k8s-name }}:

   ```bash
   kubectl apply -f issuer.yaml && \
   kubectl apply -f certificate.yaml
   ```

## Проверьте результат {#check-result}

Чтобы убедиться, что сертификат находится в статусе `READY`, выполните команду:

```bash
kubectl get certificate example-com
```

Результат:

```text
NAME         READY  SECRET              AGE
example-com  True   example-com-secret  24h
```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Удалите публичную доменную зону](../../dns/operations/zone-delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).