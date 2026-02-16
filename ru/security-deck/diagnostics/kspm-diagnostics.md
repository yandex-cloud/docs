---
title: Какие ошибки возникают при работе с модулем Контроль {{ k8s }} (KSPM) в {{ sd-full-name }}
description: Из статьи вы узнаете, какие бывают ошибки в работе модуля Контроль {{ k8s }} (KSPM).
---

# Диагностика ошибок в работе модуля Контроль {{ k8s }} (KSPM)

## Existing Kyverno installation detected and has to be removed manually {#existing-kyverno-installation}

В кластере ранее был установлен Admission Controller на базе Kyverno. Для корректной работы KSPM Admission Controller требуется отсутствие Kyverno при установке. При удалении версии Kyverno также нужно удалить все [CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions), созданные Kyverno:

```bash
kubectl delete crd $(kubectl get crd -o name | grep kyverno.io)
```

## Unable to check for existing Kyverno installation {#kyverno-check-error}

Произошла непредвиденная ошибка во время проверки на наличие Kyverno в кластере. Обратитесь в [службу поддержки]({{ link-console-support }}).

## Cluster version too old {#outdated-cluster}

Версия указанного кластера не поддерживается. Обновите кластер до [поддерживаемой версии](../concepts/kspm.md).

## Insufficient permissions in the cluster {#insufficient-permissions}

У сервисного аккаунта, который был указан при [активации модуля](../operations/kspm/enable-kspm.md), нет доступа к кластеру. Убедитесь, что аккаунту назначена роль [`security-deck.worker`](../security/index.md#security-deck-worker).

## Unable to check permissions in the cluster {#cluster-access-error}

 Произошла непредвиденная ошибка во время проверки прав доступа в кластере. Возможно, кластер недоступен, либо доступ ограничен [сетевыми политиками](../../managed-kubernetes/concepts/network-policy.md). 

 ## Component is unhealthy {#unhealthy-component}
 
 Ошибка в работе компонента. Обратитесь в [службу поддержки]({{ link-console-support }}).

 ## Component sync failed {#failed-sync}
 
 Произошла непредвиденная ошибка во время изменения компонента. Обратитесь в [службу поддержки]({{ link-console-support }}).