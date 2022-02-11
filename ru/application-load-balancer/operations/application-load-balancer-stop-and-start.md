# Остановить и запустить L7-балансировщик

## Остановить балансировщик {#stop}

Команда **Остановить** выключает L7-балансировщик. После выключения балансировщик переходит в статус `STOPPED`. Пока балансировщик остановлен, плата за него не взимается.

Вы сможете включить балансировщик в любой момент, чтобы продолжить работу. Все данные и внесенные вами изменения сохраняются.

Чтобы остановить L7-балансировщик:

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит балансировщик.
  1. Выберите сервис **{{ alb-name }}**.
  1. Чтобы остановить один балансировщик, выберите его и нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) → **Остановить**.
  
      Чтобы выполнить это действие с несколькими балансировщиками, выделите нужные в списке, в нижней части экрана нажмите кнопку **Остановить** и подтвердите действие.
  
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
          - zone_id: ru-central1-a
            subnet_id: e9bn57jvjnbujnmk3mba
          - zone_id: ru-central1-b
            subnet_id: e2ltcj4urgpbsbaq9977
          - zone_id: ru-central1-c
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
          - zone_id: ru-central1-a
            subnet_id: e9bn57jvjnbujnmk3mba
          - zone_id: ru-central1-b
            subnet_id: e2ltcj4urgpbsbaq9977
          - zone_id: ru-central1-c
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

  Используйте метод gRPC API [LoadBalancerService/Stop](../api-ref/grpc/load_balancer_service.md#Stop) или метод REST API [stop](../api-ref/LoadBalancer/stop.md).

{% endlist %}

## Запустить балансировщик {#start}

Команда **Запустить** включает остановленный L7-балансировщик. После включения балансировщик переходит в статус `ACTIVE`. С этого момента начинает взиматься плата за использование балансировщика.

Чтобы запустить балансировщик:

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит балансировщик.
  1. Выберите сервис **{{ alb-name }}**.
  1. Чтобы запустить один балансировщик, выберите его и нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) → **Запустить**.
  
      Чтобы выполнить это действие с несколькими балансировщиками, выделите нужные в списке, в нижней части экрана нажмите кнопку **Запустить** и подтвердите действие.
  
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
          - zone_id: ru-central1-a
            subnet_id: e9bn57jvjnbujnmk3mba
          - zone_id: ru-central1-b
            subnet_id: e2ltcj4urgpbsbaq9977
          - zone_id: ru-central1-c
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
          - zone_id: ru-central1-a
            subnet_id: e9bn57jvjnbujnmk3mba
          - zone_id: ru-central1-b
            subnet_id: e2ltcj4urgpbsbaq9977
          - zone_id: ru-central1-c
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

  Используйте метод gRPC API [LoadBalancerService/Start](../api-ref/grpc/load_balancer_service.md#Start) или метод REST API [start](../api-ref/LoadBalancer/start.md).

{% endlist %}
