---
title: Проверить состояние целевых ресурсов
description: Следуя данной инструкции, вы сможете проверить состояние целевых ресурсов.
---

# Проверить состояние целевых ресурсов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога.
  1. [Перейдите]({{ link-console-main }}/link/network-load-balancer/) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Нажмите на имя нужного сетевого балансировщика.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Запросите состояния ресурсов целевой группы:
  
  ```bash
  yc load-balancer network-load-balancer target-states <имя_или_идентификатор_балансировщика> \
    --target-group-id=<идентификатор_целевой_группы>
  ```

  Идентификатор, имя балансировщика и идентификаторы подключенных целевых групп можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- API {#api}

  Воспользуйтесь методом REST API [getTargetStates](../api-ref/NetworkLoadBalancer/getTargetStates.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/GetTargetStates](../api-ref/grpc/NetworkLoadBalancer/getTargetStates.md) и передайте в запросе:

  * Идентификатор балансировщика в параметре `networkLoadBalancerId` (REST API) или `network_load_balancer_id` (gRPC API).
  * Идентификатор целевой группы в параметре `targetGroupId` (REST API) или `target_group_id` (gRPC API).

  Идентификатор балансировщика и идентификаторы подключенных целевых групп можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

{% endlist %}
