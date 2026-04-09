---
title: Пулы резервов виртуальных машин для групп узлов {{ managed-k8s-full-name }}
description: Из статьи вы узнаете, как использовать пулы резервов виртуальных машин для групп узлов в {{ managed-k8s-name }}.
---

# Пулы резервов виртуальных машин для групп узлов {{ managed-k8s-full-name }}

{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

{% include [reserved-pools-intro](../../../_includes/compute/reserved-pools-intro.md) %}

Подробнее читайте на странице [{#T}](../../../compute/concepts/reserved-pools.md).

{% include [reserved-pools-mk8s-intro](../../../_includes/managed-kubernetes/reserved-pools-mk8s-intro.md) %}

Использование пулов резервов в {{ managed-k8s-name }} доступно с помощью [CLI](../../cli-ref/node-group/create.md), [{{ TF }}](../../../terraform/resources/kubernetes_node_group.md) и [API](../../managed-kubernetes/api-ref/NodeGroup/create.md).

{% include [reserved-pools-mk8s-variable-tip](../../../_includes/managed-kubernetes/reserved-pools-mk8s-variable-tip.md) %}

## Ограничения {#restrictions}

{% include [reserved-pools-mk8s-restrictions](../../../_includes/managed-kubernetes/reserved-pools-mk8s-restrictions.md) %}

{% include [reserved-pools-mk8s-resources-warning](../../../_includes/managed-kubernetes/reserved-pools-mk8s-resources-warning.md) %}

## Примеры {#examples}

В примере создается группа узлов в одной зоне доступности с двумя узлами из пула резервов ВМ этой зоны.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [reserved-pools-cli-single-zone](../../../_includes/managed-kubernetes/reserved-pools-cli-single-zone.md) %}

- {{ TF }} {#tf}

  {% include [reserved-pools-tf-single-zone](../../../_includes/managed-kubernetes/reserved-pools-tf-single-zone.md) %}

{% endlist %}

Примеры для мультизональной группы с узлами из пула резервов ВМ с использованием переменных приведены на странице [Переменные в шаблоне узла](./variables-in-the-template.md#examples).

### См. также {#see-also}

* [{#T}](../../../compute/concepts/reserved-pools.md)
* [Работа с пулами резервов ВМ](../../../compute/operations/index.md#reserved-pools)
* [{#T}](./variables-in-the-template.md)
* [{#T}](../../operations/node-group/node-group-create-in-instance-pool.md)
