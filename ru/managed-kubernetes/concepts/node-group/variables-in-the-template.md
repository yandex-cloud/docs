---
title: Переменные в шаблоне узла {{ managed-k8s-full-name }}
description: Из статьи вы узнаете, как использовать переменные в шаблоне узла {{ managed-k8s-name }}.
---

# Переменные в шаблоне узла {{ managed-k8s-full-name }}

В {{ managed-k8s-name }} создаются [группы однотипных узлов](../index.md#node-group) кластера из шаблона. Чтобы такие узлы имели разные характеристики, используйте механизм подстановок переменных в шаблоне.

Поддерживаются [системные](../../../compute/concepts/instance-groups/variables-in-the-template.md#first-stage) и [пользовательские](../../../compute/concepts/instance-groups/variables-in-the-template.md#second-stage) переменные.

Подробнее о переменных и этапах их подстановки читайте на странице [{#T}](../../../compute/concepts/instance-groups/variables-in-the-template.md).

Например, с помощью переменных вы можете [создать](../../operations/node-group/node-group-create-in-instance-pool.md) мультизональную группу узлов из пулов резервов ВМ, размещенных в разных [зонах доступности](../../../overview/concepts/geo-scope.md).

Использование переменных доступно с помощью [CLI](../../cli-ref/node-group/create.md), [{{ TF }}](../../../terraform/resources/kubernetes_node_group.md) и [API](../../managed-kubernetes/api-ref/NodeGroup/create.md).

## Примеры {#examples}

В примере создается группа узлов в трех зонах доступности с одним узлом из пулов резервов ВМ в каждой зоне.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [reserved-pools-cli-multi-zone](../../../_includes/managed-kubernetes/reserved-pools-cli-multi-zone.md) %}

- {{ TF }} {#tf}

  {% include [reserved-pools-tf-multi-zone](../../../_includes/managed-kubernetes/reserved-pools-tf-multi-zone.md) %}

{% endlist %}

Примеры для группы с узлами из пула резервов ВМ в одной зоне доступности приведены на странице [Пулы резервов виртуальных машин для групп узлов](./reserved-pools.md#examples).

### См. также {#see-also}

* [{#T}](../../../compute/concepts/instance-groups/variables-in-the-template.md)
* [{#T}](./reserved-pools.md)
* [{#T}](../../operations/node-group/node-group-create-in-instance-pool.md)
