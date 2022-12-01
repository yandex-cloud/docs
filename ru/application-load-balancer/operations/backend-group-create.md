# Создать группу бэкендов

При создании в [группу бэкендов](../concepts/backend-group.md) можно добавлять бэкенды двух [типов](../concepts/backend-group.md#types): с [целевыми группами](../concepts/target-group.md) и с [бакетами {{ objstorage-name }}](../../storage/concepts/bucket.md).

## Создание группы бэкендов с целевой группой {#with-target-group}

Создайте целевую группу по [инструкции](target-group-create.md).

Чтобы создать группу бэкендов с целевой группой:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создаваться группа бэкендов.
  1. В списке сервисов выберите **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
  1. Нажмите кнопку **Создать группу бэкендов**.
  1. Введите имя группы бэкендов: `test-backend-group`.
  1. Выберите [тип группы бэкендов](../concepts/backend-group.md#group-types):
      * `HTTP` — для HTTP- или HTTPS-трафика.
      * `gRPC` — для HTTP- или HTTPS-трафика с вызовами [gRPC](https://{{ lang }}.wikipedia.org/wiki/GRPC)-процедур.
      * `Stream` — для TCP-трафика без шифрования или с TLS-шифрованием.

      {% note alert %}

      Выбрать тип группы бэкендов можно только при ее создании. Изменить тип существующей группы невозможно.

      {% endnote %}

  1. (опционально) Для группы бэкендов типа `HTTP` или `gRPC` включите опцию **Привязка сессий**. Доступны следующие режимы:
     * `По IP-адресу`.
     * `По HTTP-заголовку`.
     * `По cookie`.

     {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

     Подробнее об опции см. в разделе [{#T}](../concepts/backend-group.md#session-affinity).

  1. В блоке **Бэкенды** нажмите кнопку **Добавить**. Задайте настройки бэкенда:
      * Введите имя бэкенда: `test-backend-1`.
      * Задайте вес бэкенда: `1`.
      * Выберите тип бэкенда `Целевая группа` для группы бэкендов типа `HTTP`. В группе бэкендов типа `gRPC` или `Stream` бэкендами могут быть только целевые группы и их наборы.
      * В списке **Целевые группы** выберите `test-target-group` и укажите **Порт**: `80`.
  1. Разверните поле **Настройки балансировки** и задайте их параметры:
     * **Порог для режима паники**: `90`.
     * **Локализация трафика**: `90`.
  1. Разверните поле **Настройки протокола** и выберите тип `HTTP`. По умолчанию для группы бэкендов типа `HTTP` используется протокол версии 1.1. Чтобы использовать протокол версии 2, включите опцию **HTTP/2**. Группы бэкендов типа `gRPC` поддерживают только HTTP/2-соединения.
  1. Нажмите кнопку **Добавить проверку состояния** и задайте настройки проверки:
     * **Таймаут**: `1`.
     * **Интервал**: `1`.
     * **Порог работоспособности**: `3`.
     * **Порог неработоспособности**: `10`.
     * **Тип**: `HTTP`.

        {% note info %}

        Поддерживаются проверки типов `HTTP`, `gRPC` и `Stream`. Они соответствуют типам групп бэкендов, но тип проверки не обязательно должен совпадать с типом группы. 

        {% endnote %}

     * **Путь**: `/`.
  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% note info %}

  Создать группу бэкендов типа gRPC можно в [консоли управления]({{ link-console-main }}) или с помощью {{ TF }}.

  {% endnote %}

  1. Посмотрите описание команды CLI для создания группы бэкендов:
     ```
     yc alb backend-group create --help
     ```

  1. Создайте группу бэкендов, выполнив команду:
     ```
     yc alb backend-group create <имя группы бэкендов>
     ```

     Результат:

     ```
     id: a5dg2cv4ngne8575fb1p
     name: test-backend-group
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

  1. Добавьте в группу бэкенд и проверку состояния. Внутри группы все бэкенды должны быть одного [типа](../concepts/backend-group.md#group-types) — HTTP или Stream.

     {% cut "HTTP-бэкенд" %}    

     Выполните команду:

     ```
     yc alb backend-group add-http-backend \
       --backend-group-name <имя бэкенд группы> \
       --name <имя добавляемого бэкенда> \
       --weight <вес бэкенда> \
       --port <порт бэкенда> \
       --target-group-id=<идентификатор целевой группы> \
       --panic-threshold 90 \
       --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,host=your-host.com,path=/ping
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

     ```
     id: a5dqkr2mk3rr799f1npa
     name: test-backend-group
     folder_id: aoe197919j8elpeg1lkp
     http:
       backends:
       - name: backend1
         backend_weight: "1"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - a5d2iap3nue9s3anblu6
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: your-host.com
             path: /ping
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

     {% endcut %}

     {% cut "Stream-бэкенд" %}

     Выполните команду:

     ```
     yc alb backend-group add-stream-backend \
       --backend-group-name <имя бэкенд группы> \
       --name <имя добавляемого бэкенда> \
       --weight <вес бэкенда> \
       --port <порт бэкенда> \
       --target-group-id=<идентификатор целевой группы> \
       --panic-threshold 90 \
       --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,host=your-host.com,path=/ping
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

     ```
     id: ds77tero4f5h46l4e2gl
     name: test-backend-group
     folder_id: b1gu6g9ielh690at5bm7
     stream:
       backends:
       - name: stream-backend
     backend_weight: "1"
         port: "80"
         target_groups:
           target_group_ids:
           - ds7eof3r2cte9u069p97
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: your-host.com
             path: /ping
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

         * `connection` — режим привязки сессий по IP-адресу (`source_ip`). Также доступны режимы `cookie` и `header`. Должен быть указан только один из режимов. Если группа бэкендов имеет тип Stream (состоит из ресурсов `stream_backend`), то привязка сессий может иметь только режим `connection`.
      
       * `http_backend`, `grpc_backend` и `stream_backend` — [тип бэкенда](../concepts/backend-group.md#group-types). Внутри группы все бэкенды должны быть одного типа — HTTP, gRPC или Stream.
        
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
        * `http_healthcheck` — параметры проверки состояния типа HTTP: 
          * `path` — путь.

      Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Создайте ресурсы:
  
      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc alb backend-group list
      ```

{% endlist %}

## Создание группы бэкендов с бакетом {#with-s3-bucket}

{% include [bucket-availability-note](../_includes_service/bucket-availability-note.md) %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создаваться группа бэкендов.
  1. В списке сервисов выберите **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
  1. Нажмите кнопку **Создать группу бэкендов**.
  1. Введите имя группы бэкендов: `test-backend-group-1`.
  1. Выберите [тип бэкенда](../concepts/backend-group.md#group-types) `HTTP`.
  1. В блоке **Бэкенды** нажмите кнопку **Добавить**. Задайте настройки бэкенда:
      * Введите имя бэкенда: `test-backend-1`.
      * Задайте вес бэкенда: `1`.
      * Выберите тип бэкенда `Бакет`.
      * Выберите бакет {{ objstorage-name }}, который нужно использовать в качестве бэкенда.
  1. Нажмите кнопку **Создать**.

{% endlist %}
