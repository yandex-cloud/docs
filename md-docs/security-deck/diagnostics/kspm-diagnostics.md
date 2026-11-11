[Документация Yandex Cloud](../../index.md) > [Yandex Security Deck](../index.md) > [Диагностика ошибок](index.md) > Ошибки в работе KSPM

# Диагностика ошибок в работе модуля Контроль Kubernetes (KSPM)

## Existing Kyverno installation detected and has to be removed manually {#existing-kyverno-installation}

В кластере ранее был установлен Admission Controller на базе Kyverno. Для корректной работы KSPM Admission Controller требуется отсутствие Kyverno при установке. При удалении версии Kyverno также нужно удалить все [CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions), созданные Kyverno:

```bash
kubectl delete crd $(kubectl get crd -o name | grep kyverno.io)
```

## Unable to check for existing Kyverno installation {#kyverno-check-error}

Произошла непредвиденная ошибка во время проверки на наличие Kyverno в кластере. Обратитесь в [службу поддержки](https://center.yandex.cloud/support).

## Cluster version too old {#outdated-cluster}

Версия указанного кластера не поддерживается. Обновите кластер до [поддерживаемой версии](../operations/kspm/enable-kspm.md).

## Insufficient permissions in the cluster {#insufficient-permissions}

У сервисного аккаунта, который был указан при [активации модуля](../operations/kspm/enable-kspm.md), нет доступа к кластеру. Убедитесь, что аккаунту назначена роль [`security-deck.worker`](../security/index.md#security-deck-worker).

## Unable to check permissions in the cluster {#cluster-access-error}

 Произошла непредвиденная ошибка во время проверки прав доступа в кластере. Возможно, кластер недоступен, либо доступ ограничен [сетевыми политиками](../../managed-kubernetes/concepts/network-policy.md). 

## Component is unhealthy {#unhealthy-component}

Ошибка в работе компонента. Одна из возможных причин — на узле не хватает свободных ресурсов для компонента. Чтобы проверить это, посмотрите состояние подов KSPM:

```bash
kubectl get pods -n yc-security
```

Если под находится в статусе `Pending` или `Evicted`, посмотрите причину в разделе `Events`:

```bash
kubectl describe pod <имя_пода> -n yc-security
```

Сообщения `Insufficient cpu` и `Insufficient memory` означают, что поду не хватило свободных ресурсов на узле, сообщение `The node was low on resource` означает, что под остановлен из-за нехватки ресурсов на узле. Освободите ресурсы на узле или [измените конфигурацию группы узлов](../../managed-kubernetes/operations/node-group/node-group-update.md#update-settings), увеличив количество vCPU и объем памяти. Подробнее в разделе [Ресурсы кластера для работы KSPM](../operations/kspm/requirements.md#resource-planning).

Если ресурсов достаточно, а ошибка сохраняется, обратитесь в [службу поддержки](https://center.yandex.cloud/support).

## Component sync failed {#failed-sync}
 
Произошла непредвиденная ошибка во время изменения компонента. Обратитесь в [службу поддержки](https://center.yandex.cloud/support).