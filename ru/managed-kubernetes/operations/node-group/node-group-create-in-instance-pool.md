---
title: Создание группы с узлами из пула резервов ВМ {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете создать группу с узлами из пула резервов ВМ {{ compute-name }}.
---

# Создание группы с узлами из пула резервов ВМ {{ compute-full-name }}


{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

{% include [reserved-pools-intro](../../../_includes/compute/reserved-pools-intro.md) %}

{% include [reserved-pools-mk8s-intro](../../../_includes/managed-kubernetes/reserved-pools-mk8s-intro.md) %}

Подробнее читайте на страницах [{#T}](../../concepts/node-group/reserved-pools.md) и [{#T}](../../../compute/concepts/reserved-pools.md). 

{% note warning %}

{% include [reserved-pools-mk8s-restrictions](../../../_includes/managed-kubernetes/reserved-pools-mk8s-restrictions.md) %}

{% endnote %}

## Создать группу узлов в одной зоне доступности с узлами из пула резервов ВМ этой зоны {#single-zone}

1. [Создайте](../../../compute/operations/reserved-pools/create-reserved-pool.md) пул резервов ВМ с конфигурацией, которую вы хотите использовать для узлов кластера {{ managed-k8s-name }}.

    {% include [reserved-pools-mk8s-resources-warning](../../../_includes/managed-kubernetes/reserved-pools-mk8s-resources-warning.md) %}

1. [Создайте](../kubernetes-cluster/kubernetes-cluster-create.md) кластер {{ managed-k8s-name }}.
1. Создайте группу узлов:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      В терминале выполните команду:

      {% include [reserved-pools-cli-single-zone](../../../_includes/managed-kubernetes/reserved-pools-cli-single-zone.md) %}

      Подробнее о команде читайте в [справочнике CLI](../../cli-ref/node-group/create.md).

    - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. Опишите в конфигурационном файле параметры группы узлов:

          {% include [reserved-pools-tf-single-zone](../../../_includes/managed-kubernetes/reserved-pools-tf-single-zone.md) %}

      1. Создайте группу узлов:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Подробнее о ресурсе `yandex_kubernetes_node_group` читайте в [справочнике {{ TF }}](../../../terraform/resources/kubernetes_node_group.md).

    {% endlist %}

## Создать группу узлов в трех зонах доступности с узлами из пулов резервов ВМ в каждой зоне {#multi-zone}

1. [Создайте](../../../compute/operations/reserved-pools/create-reserved-pool.md) пулы резервов ВМ в трех зонах доступности с конфигурацией, которую вы хотите использовать для узлов кластера {{ managed-k8s-name }}.

    {% include [reserved-pools-mk8s-resources-warning](../../../_includes/managed-kubernetes/reserved-pools-mk8s-resources-warning.md) %}

1. [Создайте](../kubernetes-cluster/kubernetes-cluster-create.md) кластер {{ managed-k8s-name }}.
1. Создайте группу узлов:

    {% include [reserved-pools-mk8s-variable-tip](../../../_includes/managed-kubernetes/reserved-pools-mk8s-variable-tip.md) %}

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      В терминале выполните команду:

      {% include [reserved-pools-cli-multi-zone](../../../_includes/managed-kubernetes/reserved-pools-cli-multi-zone.md) %}

      Подробнее о команде читайте в [справочнике CLI](../../cli-ref/node-group/create.md).

    - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. Опишите в конфигурационном файле параметры группы узлов:

          {% include [reserved-pools-tf-multi-zone](../../../_includes/managed-kubernetes/reserved-pools-tf-multi-zone.md) %}

      1. Создайте группу узлов:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Подробнее о ресурсе `yandex_kubernetes_node_group` читайте в [справочнике {{ TF }}](../../../terraform/resources/kubernetes_node_group.md).

    {% endlist %}

### См. также {#see-also}

* [{#T}](../../concepts/node-group/reserved-pools.md)
* [{#T}](../../concepts/node-group/variables-in-the-template.md)
* [{#T}](../../../compute/concepts/reserved-pools.md)
* [Работа с пулами резервов ВМ](../../../compute/operations/index.md#reserved-pools)
* [{#T}](../../../compute/concepts/instance-groups/variables-in-the-template.md)
* [{#T}](./node-group-create.md)
