# Остановить и запустить L7-балансировщик

## Остановить балансировщик {#stop}

Команда **Остановить** выключает L7-балансировщик. После выключения балансировщик переходит в статус `STOPPED`. Пока балансировщик остановлен, плата за него не взимается.

Вы сможете включить балансировщик в любой момент, чтобы продолжить работу. Все данные и внесенные вами изменения сохраняются.

Чтобы остановить L7-балансировщик:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ alb-name }}**.
  1. Напротив имени нужного балансировщика нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Остановить**.
  
     Чтобы выполнить это действие с несколькими балансировщиками, выделите нужные в списке, в нижней части экрана нажмите кнопку **Остановить** и в открывшемся окне нажмите кнопку **Остановить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для остановки балансировщика:

     ```bash
     yc application-load-balancer load-balancer stop --help
     ```

  1. Получите список всех балансировщик в каталоге по умолчанию:

     ```bash
     yc application-load-balancer load-balancer list --format yaml
     ```

     Результат:
 
     

     ```bash
     - id: ds79cfnvmti39p7k83sa
       name: test-load-balancer
       folder_id: b1gv87ssvu497lpgjh5o
       status: ACTIVE
       network_id: enp45glgitd6e44dn1fj
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
             http_router_id: ds7bharmjfs30dll9r3s
       allocation_policy:
         locations:
         - zone_id: {{ region-id }}-a
           subnet_id: e9bn57jvjnbujnmk3mba
         - zone_id: {{ region-id }}-b
           subnet_id: e2ltcj4urgpbsbaq9977
         - zone_id: {{ region-id }}-c
           subnet_id: b0c29k6anelkik7jg5v1
       log_group_id: ckgph76s449vsca8ho9p
       created_at: "2022-02-11T09:00:31.911019416Z"
     - id: ds7o71924t0hqmu9h0n2
       name: balancer2
       folder_id: b1gv87ssvu497lpgjh5o
       status: ACTIVE
       network_id: enp45glgitd6e44dn1fj
       allocation_policy:
         locations:
         - zone_id: {{ region-id }}-a
           subnet_id: e9bn57jvjnbujnmk3mba
         - zone_id: {{ region-id }}-b
           subnet_id: e2ltcj4urgpbsbaq9977
         - zone_id: {{ region-id }}-c
           subnet_id: b0c29k6anelkik7jg5v1
       log_group_id: ckgjhe81a23v2miqfl7u
       created_at: "2022-02-11T09:01:46.724279145Z"
     ```




  1. Остановите балансировщик, указав в команде его идентификатор `id` или имя `name`, например `balancer2`:

     ```bash
     yc application-load-balancer load-balancer stop balancer2
     ```

     Подробнее о команде `application-load-balancer load-balancer stop` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/stop.md).

- API

  Воспользуйтесь методом REST API [stop](../api-ref/LoadBalancer/stop.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Stop](../api-ref/grpc/load_balancer_service.md#Stop).

{% endlist %}

## Запустить балансировщик {#start}

Команда **Запустить** включает остановленный L7-балансировщик. После включения балансировщик переходит в статус `ACTIVE`. С этого момента начинает взиматься плата за использование балансировщика.

Чтобы запустить балансировщик:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ alb-name }}**.
  1. Напротив имени нужного балансировщика нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Запустить**.

     Чтобы выполнить это действие с несколькими балансировщиками, выделите нужные в списке, в нижней части экрана нажмите кнопку **Запустить**, в открывшемся окне нажмите кнопку **Запустить**.

- CLI

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
     - id: ds79cfnvmti39p7k83sa
       name: test-load-balancer
       folder_id: b1gv87ssvu497lpgjh5o
       status: ACTIVE
       network_id: enp45glgitd6e44dn1fj
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
             http_router_id: ds7bharmjfs30dll9r3s
       allocation_policy:
         locations:
         - zone_id: {{ region-id }}-a
           subnet_id: e9bn57jvjnbujnmk3mba
         - zone_id: {{ region-id }}-b
           subnet_id: e2ltcj4urgpbsbaq9977
         - zone_id: {{ region-id }}-c
           subnet_id: b0c29k6anelkik7jg5v1
       log_group_id: ckgph76s449vsca8ho9p
       created_at: "2022-02-11T09:00:31.911019416Z"
     - id: ds7o71924t0hqmu9h0n2
       name: balancer2
       folder_id: b1gv87ssvu497lpgjh5o
       status: STOPPED
       network_id: enp45glgitd6e44dn1fj
       allocation_policy:
         locations:
         - zone_id: {{ region-id }}-a
           subnet_id: e9bn57jvjnbujnmk3mba
         - zone_id: {{ region-id }}-b
           subnet_id: e2ltcj4urgpbsbaq9977
         - zone_id: {{ region-id }}-c
           subnet_id: b0c29k6anelkik7jg5v1
       log_group_id: ckgjhe81a23v2miqfl7u
       created_at: "2022-02-11T09:01:46.724279145Z"
     ```




  1. Запустите балансировщик, указав в команде его идентификатор `id` или имя `name`, например `balancer2`:

     ```bash
     yc application-load-balancer load-balancer start balancer2
     ```

     Подробнее о команде `application-load-balancer load-balancer start` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/start.md).

- API

  Воспользуйтесь методом REST API [start](../api-ref/LoadBalancer/start.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancer/Start](../api-ref/grpc/load_balancer_service.md#Start).

{% endlist %}