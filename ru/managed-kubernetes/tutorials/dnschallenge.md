---
title: Как добавить возможность пройти проверку DNS Challenge при выписывании сертификатов Let's Encrypt® в {{ managed-k8s-full-name }}
description: Следуя данному руководству, вы сможете добавить возможность пройти проверку DNS Challenge при выписывании сертификатов Let's Encrypt®.
---

# Проверка DNS Challenge для сертификатов Let's Encrypt®


Чтобы добавить возможность пройти проверку DNS Challenge при выписывании [сертификатов Let's Encrypt®](../../certificate-manager/concepts/managed-certificate.md):
1. [{#T}](#create-cert).
1. [{#T}](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролью](../../iam/concepts/access-control/roles.md) `dns.editor` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет находиться [доменная зона](../../dns/concepts/dns-zone.md).

1. [Создайте авторизованный ключ](../../iam/operations/authorized-key/create.md) для [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) и сохраните его в виде JSON-файла:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта> \
     --format json \
     --output key.json
   ```

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md). Сертификат Let's Encrypt® будет выписан для домена в этой зоне с прохождением [проверки DNS-01](https://letsencrypt.org/ru/docs/challenge-types/#проверка-dns-01).

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Создайте кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Создайте сертификат {#create-cert}

1. Установите приложение cert-manager c плагином {{ dns-full-name }} ACME webhook [по инструкции](../../managed-kubernetes/operations/applications/cert-manager-cloud-dns.md).

    При установке укажите сервисный аккаунт и авторизованный ключ, которые были созданы [перед началом работы](#before-begin).

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
       name: yc-clusterissuer
       kind: ClusterIssuer
     dnsNames:
       - <доменное_имя>
   ```

1. Передайте сертификат в кластер {{ managed-k8s-name }}:

   ```bash
   kubectl apply -f certificate.yaml
   ```

## Проверьте результат {#check-result}

1. Проверьте готовность сертификата:

    ```bash
    kubectl get certificate example-com
    ```

    Результат:

    ```text
    NAME         READY  SECRET              AGE
    example-com  True   example-com-secret  24h
    ```

    Статус `True` в колонке `READY` означает, что сертификат был выпущен успешно.

1. (Опционально) получите подробную информацию о сертификате:

    ```bash
    kubectl -n default describe certificate example-com
    ```

    {% include [События cert-manager при выпуске сертификата](../../_includes/managed-kubernetes/cert-manager-events-explained.md) %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Удалите публичную доменную зону](../../dns/operations/zone-delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).
