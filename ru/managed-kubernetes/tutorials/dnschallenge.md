# Проверка DNS Challenge для сертификатов Let's Encrypt®

Чтобы добавить возможность пройти проверку DNS Challenge при выписывании [сертификатов Let's Encrypt®](../../certificate-manager/concepts/managed-certificate.md):
1. [{#T}](#create-cert).
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
     --service-account-name <имя_сервисного_аккаунта> \
     --format json \
     --output iamkey.json
   ```

## Создайте сертификат {#create-cert}

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

1. Установите приложение Cert-manager c плагином CloudDNS ACME webhook [по инструкции](../../managed-kubernetes/operations/applications/cert-manager-cloud-dns.md).

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
       - <доменное_имя>
   ```

1. Передайте сертификат в кластер {{ managed-k8s-name }}:

   ```bash
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

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Удалите публичную доменную зону](../../dns/operations/zone-delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).
