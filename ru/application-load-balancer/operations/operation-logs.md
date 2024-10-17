# Посмотреть операции с ресурсами сервиса

Все действия с ресурсами сервиса {{ alb-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для [L7-балансировщика](../concepts/application-load-balancer.md). Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится балансировщик.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/branches-down.svg) **{{ ui-key.yacloud.alb.label_load-balancers }}**.
  1. Выберите нужный балансировщик.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного балансировщика.

     В открывшемся списке отображаются операции с выбранным балансировщиком.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для ресурса сервиса {{ alb-name }}, воспользуйтесь командой:

  ```bash
  yc alb <тип_ресурса> list-operations <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для балансировщика:

  ```bash
  yc alb load-balancer list-operations ds7857cmjtuv********
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |          DESCRIPTION           |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  | ds71vdf0jqut******** | 2024-05-14 14:36:06 | aje9k8luj4qf******** | 2024-05-14 14:36:06 | DONE   | update loadbalancer            |
  |                      |                     |                      |                     |        | 'ds7857cmjtuv********'         |
  | ds7nspb18tkg******** | 2024-05-14 12:29:53 | aje9k8luj4qf******** | 2024-05-14 12:34:46 | DONE   | create loadbalancer            |
  |                      |                     |                      |                     |        | 'ds7857cmjtuv********'         |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc alb load-balancer list-operations ds7857cmjtuv******** --format yaml
  ```

  Результат:

  ```text
  - id: ds71vdf0jqut********
    description: update loadbalancer 'ds7857cmjtuv********'
    created_at: "2024-05-14T14:36:06.637766633Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T14:36:06.666429213Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.apploadbalancer.v1.UpdateLoadBalancerMetadata
      load_balancer_id: ds7857cmjtuv********
    response:
      '@type': type.googleapis.com/yandex.cloud.apploadbalancer.v1.LoadBalancer
      id: ds7857cmjtuv********
      name: my-alb
      folder_id: b1g681qpemb4********
      status: ACTIVE
      ...
      created_at: "2024-05-14T12:29:53.571411960Z"
      log_options: {}
  - id: ds7nspb18tkg********
    description: create loadbalancer 'ds7857cmjtuv********'
    created_at: "2024-05-14T12:29:53.571411960Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T12:34:46.963930680Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.apploadbalancer.v1.CreateLoadBalancerMetadata
      load_balancer_id: ds7857cmjtuv********
    response:
      '@type': type.googleapis.com/yandex.cloud.apploadbalancer.v1.LoadBalancer
      id: ds7857cmjtuv********
      name: my-alb
      folder_id: b1g681qpemb4********
      status: ACTIVE
      ...
      created_at: "2024-05-14T12:29:53.571411960Z"
      log_options: {}
  ```

- API {#api}

  Воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListOperations`.

  Например, для балансировщика воспользуйтесь методом REST API [listOperations](../api-ref/LoadBalancer/listOperations.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/ListOperations](../api-ref/grpc/LoadBalancer/listOperations.md).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для ресурса.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

   {% list tabs group=instructions %}

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Выполните команду:

     ```bash
     yc operation get <идентификатор_операции>
     ```

     ```yaml
     id: ds7nspb18tkg********
     description: create loadbalancer 'ds7857cmjtuv********'
     created_at: "2024-05-14T12:29:53.571411960Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-05-14T12:34:46.963930680Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.apploadbalancer.v1.CreateLoadBalancerMetadata
       load_balancer_id: ds7857cmjtuv********
     response:
       '@type': type.googleapis.com/yandex.cloud.apploadbalancer.v1.LoadBalancer
       id: ds7857cmjtuv********
       name: my-alb
       folder_id: b1g681qpemb4********
       status: ACTIVE
       region_id: {{ region-id }}
       network_id: enp3srbi9u49********
       allocation_policy:
         locations:
           - zone_id: {{ region-id }}-a
             subnet_id: e9bpric55er9********
           - zone_id: {{ region-id }}-b
             subnet_id: e2l15qssjar5********
           - zone_id: {{ region-id }}-d
             subnet_id: fl85ebb396ub********
       created_at: "2024-05-14T12:29:53.571411960Z"
       log_options: {}
     ```

   - API {#api}

     Воспользуйтесь вызовом gRPC API [OperationService/Get](../api-ref/grpc/Operation/get.md).

   {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
