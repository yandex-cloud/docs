---
title: Какие ошибки возникают при работе с модулем Контроль {{ k8s }} ({{ kspm-name }}) в {{ sd-full-name }}
description: Из статьи вы узнаете, какие бывают ошибки в работе модуля Контроль {{ k8s }} ({{ kspm-name }}).
---

# Диагностика ошибок в работе модуля Контроль {{ k8s }} ({{ kspm-name }})

## Existing Kyverno installation detected and has to be removed manually {#existing-kyverno-installation}

Установке {{ kspm-name }} мешают [CRD](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions) Kyverno, не принадлежащие {{ kspm-name }}. Для корректной работы {{ kspm-name }} Admission Controller требуется отсутствие Kyverno при установке. Если вам нужны собственные политики, используйте [пользовательские правила](../concepts/custom-rules.md) {{ sd-name }} или [устанавливайте внешние политики Kyverno](../tutorials/kspm-external-kyverno-policies.md) после установки {{ kspm-name }}.

{% cut "Чтобы удалить конфликтующие CRD:" %}

1. Получите полный список конфликтующих CRD:

   ```bash
   kubectl get crd -l 'kspm.yandex.cloud/managed-by!=kspm' \
     -o custom-columns=NAME:.metadata.name,GROUP:.spec.group --no-headers \
     | awk '$2 ~ /(^|\.)kyverno\.io$/ || $2 == "wgpolicyk8s.io" {print $1}'
   ```

   Результат:
   
   ```text
   clusterpolicies.kyverno.io
   policyreports.wgpolicyk8s.io
   validatingpolicies.policies.kyverno.io
   ```

1. До удаления сохраните определения выбранных CRD, исходные манифесты политик и необходимые данные. Для каждого выбранного CRD выгрузите его ресурсы во всех пространствах имен. Например, для `validatingpolicies.policies.kyverno.io`:

   ```bash
   crd_name=validatingpolicies.policies.kyverno.io
   kubectl get crd "$crd_name" -o yaml > "$crd_name.crd.yaml"
   kubectl get "$crd_name" --all-namespaces -o yaml > "$crd_name.resources.yaml"
   ```

   {% note info %}
   
   Удаление CRD удаляет все ресурсы этого типа во всем кластере. Если CRD используется другими инструментами, согласуйте с их владельцами порядок удаления и восстановления.
   
   {% endnote %}

1. Удалите прежнюю установку Kyverno штатным для нее способом.

1. Удалите только выбранные и проверенные CRD, если они остались после удаления Kyverno на предыдущем шшаге.
В команде укажите имя CRD, для которого уже сохранены данные:

   ```bash
   kubectl delete crd "$crd_name"
   ```

1. Дождитесь установки: KSPM периодически повторяет проверку и продолжит установку после удаления всех конфликтующих CRD. Если часть CRD осталась, сообщение об ошибке обновится и покажет оставшиеся имена.

1. При необходимости после готовности KSPM восстановите совместимые внешние политики из сохраненных манифестов и проверьте их работу.

{% endcut %}

## Unable to check for existing Kyverno installation {#kyverno-check-error}

Произошла непредвиденная ошибка во время проверки на наличие Kyverno в кластере. Обратитесь в [службу поддержки]({{ link-console-support }}).

## Cluster version too old {#outdated-cluster}

Версия указанного кластера не поддерживается. Обновите кластер до [поддерживаемой версии](../operations/kspm/enable-kspm.md).

## Insufficient permissions in the cluster {#insufficient-permissions}

У сервисного аккаунта, который был указан при [активации модуля](../operations/kspm/enable-kspm.md), нет доступа к кластеру. Убедитесь, что аккаунту назначена роль [`security-deck.worker`](../security/index.md#security-deck-worker).

## Unable to check permissions in the cluster {#cluster-access-error}

 Произошла непредвиденная ошибка во время проверки прав доступа в кластере. Возможно, кластер недоступен, либо доступ ограничен [сетевыми политиками](../../managed-kubernetes/concepts/network-policy.md). 

## Component is unhealthy {#unhealthy-component}

Ошибка в работе компонента. Одна из возможных причин — на узле не хватает свободных ресурсов для компонента. Чтобы проверить это, посмотрите состояние подов {{ kspm-name }}:

```bash
kubectl get pods -n yc-security
```

Если под находится в статусе `Pending` или `Evicted`, посмотрите причину в разделе `Events`:

```bash
kubectl describe pod <имя_пода> -n yc-security
```

Сообщения `Insufficient cpu` и `Insufficient memory` означают, что поду не хватило свободных ресурсов на узле, сообщение `The node was low on resource` означает, что под остановлен из-за нехватки ресурсов на узле. Освободите ресурсы на узле или [измените конфигурацию группы узлов](../../managed-kubernetes/operations/node-group/node-group-update.md#update-settings), увеличив количество vCPU и объем памяти. Подробнее в разделе [{#T}](../operations/kspm/requirements.md#resource-planning).

Если ресурсов достаточно, а ошибка сохраняется, обратитесь в [службу поддержки]({{ link-console-support }}).

## Component sync failed {#failed-sync}
 
Произошла непредвиденная ошибка во время изменения компонента. Обратитесь в [службу поддержки]({{ link-console-support }}).