# Проверить состояние целевых ресурсов

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Нажмите на имя нужного сетевого балансировщика.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Запросите состояния ресурсов целевой группы:
  
  ```bash
  yc load-balancer network-load-balancer target-states <идентификатор или имя балансировщика> \
    --target-group-id=<идентификатор целевой группы>
  ```

  Идентификатор, имя балансировщика и идентификаторы подключенных целевых групп можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- API

  Воспользуйтесь методом API [getTargetStates](../api-ref/NetworkLoadBalancer/getTargetStates.md) и передайте в запросе:

  * Идентификатор балансировщика в параметре `networkLoadBalancerId`.
  * Идентификатор целевой группы в параметре `targetGroupId`.

  Идентификатор балансировщика и идентификаторы подключенных целевых групп можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

{% endlist %}
