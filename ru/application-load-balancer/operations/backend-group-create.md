# Создать группу бэкендов

Чтобы создать [группу бэкендов](../concepts/backend-group.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создаваться группа бэкендов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/backgrs.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. Введите имя группы бэкендов.
  1. Выберите [тип группы бэкендов](../concepts/backend-group.md#group-types):
     
      * `{{ ui-key.yacloud.alb.label_proto-http }}` — для HTTP- или HTTPS-трафика.
      * `{{ ui-key.yacloud.alb.label_proto-grpc }}` — для HTTP- или HTTPS-трафика с вызовами [gRPC](https://{{ lang }}.wikipedia.org/wiki/GRPC)-процедур.
      * `{{ ui-key.yacloud.alb.label_proto-stream }}` — для TCP-трафика без шифрования или с TLS-шифрованием.

  1. (Опционально) Включите [привязку сессий](../concepts/backend-group.md#session-affinity). Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-http-plain }}` или `{{ ui-key.yacloud.alb.label_proto-grpc }}` доступны следующие режимы привязки:
      
     * `{{ ui-key.yacloud.alb.label_affinity-connection }}`.
     * `{{ ui-key.yacloud.alb.label_affinity-header }}`.
     * `{{ ui-key.yacloud.alb.label_affinity-cookie }}`.
 
     Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-stream }}` сессии привязываются по IP-адресу клиента. 

     {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

  1. В блоке **{{ ui-key.yacloud.alb.label_backends }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}**. Задайте настройки бэкенда:
     
     {% include [backend-settings-console](../../_includes/application-load-balancer/backend-settings-console.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% note info %}

  Создать группу бэкендов типа `gRPC` можно в [консоли управления]({{ link-console-main }}) или с помощью {{ TF }}.

  {% endnote %}

  1. Посмотрите описание команды CLI для создания группы бэкендов:
     ```
     yc alb backend-group create --help
     ```

  1. Создайте группу бэкендов, выполнив команду:
     ```
     yc alb backend-group create <имя_группы_бэкендов>
     ```

     Результат:

     ```
     id: a5dg2cv4ngne8575fb1p
     name: test-backend-group
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

  1. Добавьте в группу бэкенд и проверку состояния. Внутри группы все бэкенды должны быть одного [типа](../concepts/backend-group.md#group-types) — `HTTP`, `gRPC` или `Stream`.

     {% cut "HTTP-бэкенд" %}    

     Выполните команду:

     ```bash
     yc alb backend-group add-http-backend \
       --backend-group-name <имя_бэкенд_группы> \
       --name <имя_добавляемого_бэкенда> \
       --weight <вес_бэкенда> \
       --port <порт_бэкенда> \
       --target-group-id=<идентификатор_целевой_группы> \
       --panic-threshold 90 \
       --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,host=<адрес_хоста>,path=<путь>
     ```

     Где:

     * `--panic-threshold` — порог для режима паники.
     * `--http-healthcheck` — параметры проверки состояния ресурсов:
       * `port` — порт.
       * `healthy-threshold` — порог работоспособности.
       * `unhealthy-threshold` — порог неработоспособности.
       * `timeout` — таймаут.
       * `interval` — интервал.
       * `host` — адрес хоста.
       * `path` — путь.

     Результат:

     ```text
     id: a5dqkr2mk3rr********
     name: <имя_группы_бэкендов>
     folder_id: aoe197919j8e********
     http:
       backends:
       - name: <имя_бэкенда>
         backend_weight: "1"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - a5d2iap3nue9********
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: <адрес_хоста>
             path: <путь>
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

     {% endcut %}

     {% cut "gRPC-бэкенд" %}

     ```bash
     yc alb backend-group add-grpc-backend \
       --backend-group-name <имя_бэкенд_группы> \
       --name <имя_добавляемого_бэкенда> \
       --weight <вес_бэкенда> \
       --port <порт_бэкенда> \
       --target-group-id=<идентификатор_целевой_группы> \
       --panic-threshold 90 \
       --grpc-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,service-name=<имя_gRPC-сервиса>
     ``` 

     Где:

     * `--panic-threshold` — порог для режима паники.
     * `--grpc-healthcheck` — параметры проверки состояния ресурсов:
       * `port` — порт.
       * `healthy-threshold` — порог работоспособности.
       * `unhealthy-threshold` — порог неработоспособности.
       * `timeout` — таймаут.
       * `interval` — интервал.
       * `service-name` — имя проверяемого gRPC-сервиса. Если сервис не указан, проверяется общее состояние бэкенда.

     Результат:

     ```text
     id: a5dqkr2mk3rr********
     name: <имя_группы_бэкендов>
     folder_id: aoe197919j8e********
     grpc:
       backends:
         - name: <имя_бэкенда>
           backend_weight: "12"
           load_balancing_config:
             panic_threshold: "90"
           port: "80"
           target_groups:
             target_group_ids:
               - a5d2iap3nue9********
           healthchecks:
             - timeout: 10s
               interval: 2s
               healthy_threshold: "10"
               unhealthy_threshold: "15"
               healthcheck_port: "80"
               grpc:
                 service_name: <имя_gRPC_сервиса>
     created_at: "2023-06-17T13:04:08.567141292Z"
     ```

     {% endcut %}

     {% cut "Stream-бэкенд" %}

     Выполните команду:

     ```bash
     yc alb backend-group add-stream-backend \
       --backend-group-name <имя_бэкенд_группы> \
       --name <имя_добавляемого_бэкенда> \
       --weight <вес_бэкенда> \
       --port <порт_бэкенда> \
       --target-group-id=<идентификатор_целевой_группы> \
       --panic-threshold 90 \
       --stream-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,send-text=<данные_к_эндпоинту>,receive-text=<данные_от_эндпоинта>
     ```

     Где:

     * `--panic-threshold` — порог для режима паники.
     * `--stream-healthcheck` — параметры проверки состояния ресурсов:
       * `port` — порт.
       * `healthy-threshold` — порог работоспособности.
       * `unhealthy-threshold` — порог неработоспособности.
       * `timeout` — таймаут.
       * `interval` — интервал.
       * `send-text` — данные, которые отправляются на эндпоинт для проверки состояния.
       * `receive-text` — данные, которые должны поступить с эндпоинта, чтобы он прошел проверку состояния.

     Результат:

     ```text
     id: ds77tero4f5********
     name: <имя_группы_бэкендов>
     folder_id: b1gu6g9ielh6********
     stream:
       backends:
       - name: <имя_бэкенда>
     backend_weight: "1"
         port: "80"
         target_groups:
           target_group_ids:
           - ds7eof3r2cte********
         healthchecks:
           - timeout: 10s
             interval: 2s
             healthy_threshold: "10"
             unhealthy_threshold: "15"
             healthcheck_port: "80"
             stream:
               send:
                 text: <данные_к_эндпоинту>
               receive:
                 text: <данные_от_эндпоинта>
     created_at: "2022-04-06T09:17:57.104324513Z"
     ```

     {% endcut %}

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  1. Опишите в конфигурационном файле {{ TF }} параметры ресурса, который необходимо создать:

      ```hcl
      resource "yandex_alb_backend_group" "test-backend-group" {
        name                     = "<имя_группы_бэкендов>"
        session_affinity {
          connection {
            source_ip = <true_или_false>
          }
        }

        http_backend {
          name                   = "<имя_бэкенда>"
          weight                 = 1
          port                   = 80
          target_group_ids       = ["<идентификатор_целевой_группы>"]
          load_balancing_config {
            panic_threshold      = 90
          }    
          healthcheck {
            timeout              = "10s"
            interval             = "2s"
            healthy_threshold    = 10
            unhealthy_threshold  = 15 
            http_healthcheck {
              path               = "/"
            }
          }
        }
      }
      ```

      Где:

      * `yandex_alb_backend_group` — параметры группы бэкендов:
       * `name` — имя группы бэкендов.
       * `session_affinity` — настройки [привязки сессий](../../application-load-balancer/concepts/backend-group.md#session-affinity) (необязательный параметр).

         {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

         * `connection` — режим привязки сессий по IP-адресу (`source_ip`). Также доступны режимы `cookie` и `header`. Должен быть указан только один из режимов. Если группа бэкендов имеет тип `Stream` (состоит из ресурсов `stream_backend`), то привязка сессий может иметь только режим `connection`.
      
       * `http_backend`, `grpc_backend` и `stream_backend` — [тип бэкенда](../concepts/backend-group.md#group-types). Внутри группы все бэкенды должны быть одного типа — `HTTP`, `gRPC` или `Stream`.
        
      Параметры бэкенда:
      * `name` — имя бэкенда.
      * `port` — порт бэкенда.
      * `weight` — вес бэкенда.
      * `target_group_ids` — идентификатор целевой группы. Получить список доступных целевых групп можно с помощью команды [CLI](../../cli/quickstart.md): `yc alb target-group list`.
      * `load_balancing_config` — параметры балансировки:
        * `panic_threshold` — порог для режима паники.
      * `healthcheck` — параметры проверки состояния:
        * `timeout` — таймаут.
        * `interval` — интервал.
        * `healthy_threshold` — порог работоспособности.
        * `unhealthy_threshold` — порог неработоспособности.
        * `http_healthcheck` — параметры проверки состояния типа `HTTP`: 
          * `path` — путь.

      Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Создайте ресурсы:
  
      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc alb backend-group list
      ```

- API

  Воспользуйтесь методом REST API [create](../api-ref/BackendGroup/create.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/Create](../api-ref/grpc/backend_group_service.md#Create).

{% endlist %}
