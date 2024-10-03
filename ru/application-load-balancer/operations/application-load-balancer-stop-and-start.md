---
title: Как остановить и запустить L7-балансировщик в {{ alb-full-name }}
description: Из статьи вы узнаете, как остановить и запустить L7-балансировщик {{ alb-name }}.
---

# Остановить и запустить L7-балансировщик

## Остановить балансировщик {#stop}

Команда **{{ ui-key.yacloud.common.stop }}** выключает [L7-балансировщик](../concepts/application-load-balancer.md). После выключения балансировщик переходит в статус `STOPPED`. Пока балансировщик остановлен, плата за него не взимается.

Вы сможете включить балансировщик в любой момент, чтобы продолжить работу. Все данные и внесенные вами изменения сохраняются.

Чтобы остановить L7-балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Напротив имени нужного балансировщика нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.stop }}**.
  
     Чтобы выполнить это действие с несколькими балансировщиками, выделите нужные в списке, в нижней части экрана нажмите кнопку **{{ ui-key.yacloud.common.stop }}** и в открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.stop }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для остановки балансировщика:

     ```bash
     yc application-load-balancer load-balancer stop --help
     ```

  1. Получите список всех балансировщиков в каталоге по умолчанию:

     ```bash
     yc application-load-balancer load-balancer list --format yaml
     ```

     Результат:
 

     ```bash
     - id: ds79cfnvmti3********
       name: test-load-balancer
       folder_id: b1gv87ssvu49********
       status: ACTIVE
       network_id: enp45glgitd6********
       listeners:
       - name: test-listener
         endpoints:
         - addresses:
           - external_ipv4_address:
               address: 51.250.35.12
           ports:
           - "80"
         http:
           handler:
             http_router_id: ds7bharmjfs3********
       allocation_policy:
         locations:
         - zone_id: {{ region-id }}-a
           subnet_id: e9bn57jvjnbu********
       log_group_id: ckgph76s449v********
       created_at: "2022-02-11T09:00:31.911019416Z"
     - id: ds7o71924t0h********
       name: balancer2
       folder_id: b1gv87ssvu49********
       status: ACTIVE
       network_id: enp45glgitd********
       allocation_policy:
         locations:
         - zone_id: {{ region-id }}-a
           subnet_id: e9bn57jvjnbu********
       log_group_id: ckgjhe81a23v********
       created_at: "2022-02-11T09:01:46.724279145Z"
     ```



  1. Остановите балансировщик, указав в команде его идентификатор или имя:

     ```bash
     yc application-load-balancer load-balancer stop <имя_балансировщика>
     ```

     Подробнее о команде `application-load-balancer load-balancer stop` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/stop.md).

- API {#api}

  Воспользуйтесь методом REST API [stop](../api-ref/LoadBalancer/stop.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Stop](../api-ref/grpc/load_balancer_service.md#Stop).

{% endlist %}

## Запустить балансировщик {#start}

Команда **{{ ui-key.yacloud.common.start }}** включает остановленный L7-балансировщик. После включения балансировщик переходит в статус `ACTIVE`. С этого момента начинает взиматься плата за использование балансировщика.

Чтобы запустить балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Напротив имени нужного балансировщика нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.start }}**.

     Чтобы выполнить это действие с несколькими балансировщиками, выделите нужные в списке, в нижней части экрана нажмите кнопку **{{ ui-key.yacloud.common.start }}**, в открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для запуска балансировщика:

     ```bash
     yc application-load-balancer load-balancer start --help
     ```

  1. Получите список всех балансировщиков в каталоге по умолчанию:

     ```bash
     yc application-load-balancer load-balancer list --format yaml
     ```

     Результат:


     ```bash
     - id: ds79cfnvmti3********
       name: test-load-balancer
       folder_id: b1gv87ssvu49********
       status: ACTIVE
       network_id: enp45glgitd6********
       listeners:
       - name: test-listener
         endpoints:
         - addresses:
           - external_ipv4_address:
               address: 51.250.35.12
           ports:
           - "80"
         http:
           handler:
             http_router_id: ds7bharmjfs3********
       allocation_policy:
         locations:
         - zone_id: {{ region-id }}-a
           subnet_id: e9bn57jvjnbu********
       log_group_id: ckgph76s449v********
       created_at: "2022-02-11T09:00:31.911019416Z"
     - id: ds7o71924t0h********
       name: balancer2
       folder_id: b1gv87ssvu49********
       status: STOPPED
       network_id: enp45glgitd********
       allocation_policy:
         locations:
         - zone_id: {{ region-id }}-a
           subnet_id: e9bn57jvjnbu********
       log_group_id: ckgjhe81a23v********
       created_at: "2022-02-11T09:01:46.724279145Z"
     ```



  1. Запустите балансировщик, указав в команде его идентификатор или имя:

     ```bash
     yc application-load-balancer load-balancer start <имя_балансировщика>
     ```

     Подробнее о команде `application-load-balancer load-balancer start` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/start.md).

- API {#api}

  Воспользуйтесь методом REST API [start](../api-ref/LoadBalancer/start.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancer/Start](../api-ref/grpc/load_balancer_service.md#Start).

{% endlist %}
